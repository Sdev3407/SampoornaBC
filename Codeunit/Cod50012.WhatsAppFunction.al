codeunit 50012 "WhatsApp Function"
{

    trigger OnRun()
    begin

    end;

    procedure SendSMS(SMSnumber: Text[1024]; SmsMessage: Text[1024]; Description: Text[1024]; AccountNo: Text[1024]; ContentID: Text): Boolean
    var
        Setup: Record 50010;
        Mail: Codeunit 397;
        URL: Text[1024];
        Success: Boolean;
        SmsURL1: Text;
        WebClient: DotNet WebClient;
        len: Integer;
        gResponseMsg: Text;
        gRequestMsg: Text;
        gContent: HttpContent;
        gContentHeaders: HttpHeaders;
        gHttpClient: HttpClient;
        gHttpResponseMsg: HttpResponseMessage;
        Json: Text;
        SalesandRec: Record "Sales & Receivables Setup";
        SMSSetup: Record "Sales & Receivables Setup";
        IMS: Codeunit IMS;
        SMSLog: Record "SMS Log";
    begin
        SalesandRec.Get;
        IF (SMSnumber <> '') AND (SmsMessage <> '') THEN BEGIN
            SMSSetup.GET;
            URL := SMSSetup."SMS HTTP URL" +
            '?username=' + SMSSetup."SMS User" +
            '&password=' + SMSSetup."SMS Password" +
            '&unicode=false' +
            '&from=' + SMSSetup."Sender ID" +
            '&to=' + SMSnumber +
            '&dltContentId=' + ContentID +
            '&dltPrincipalEntityId=' + SMSSetup."Entity ID" +
            '&text=' + SmsMessage;
            //===============================================================       
            Clear(gResponseMsg);
            gContent.GetHeaders(gContentHeaders);
            gContentHeaders.Clear();
            gContentHeaders.Add('Content-Type', 'application/json');

            if gHttpClient.Post(URL, gContent, gHttpResponseMsg) then begin
                gHttpResponseMsg.Content.ReadAs(Json);
                SMSLog.Reset;
                SMSLog.Init();
                SMSLog.Insert(True);
                SMSLog."Mobile No." := SMSnumber;
                SMSLog."Account No." := AccountNo;
                SMSLog."SMS Body" := SmsMessage;
                SMSLog."Error Code" := GetResponsesValue(Json, 'statusCode', ',', 1);
                SMSLog.Status := GetResponsesValue(Json, 'state', ',', 1);
                SMSLog.Description := GetResponsesValue(Json, 'description', ',', 1);
                SMSLog."Sent Date & Time" := CurrentDateTime;
                SMSLog."Transaction ID" := GetResponsesValue(Json, 'transactionId', ',', 1);
                SMSLog.Modify();
                if gHttpResponseMsg.IsSuccessStatusCode then begin
                    Success := TRUE;
                    EXIT(Success);
                end else
                    EXIT(false);
            END;


        END;
    end;

    procedure GetResponsesValue(resp3: Text; Lstr: Text; Strng: Text; Cnt: Integer): Text
    var
        mstr: Text;
        IntPos: Integer;
        i: Integer;
        Resp1: Text;
    begin
        IF STRPOS(resp3, Lstr) = 0 THEN
            EXIT('');
        FOR i := 1 TO Cnt DO BEGIN
            IntPos := STRPOS(resp3, Lstr) + STRLEN(Lstr);
            Resp1 := DELSTR(resp3, 1, IntPos);
            resp3 := Resp1;
        END;
        IF Lstr <> 'error' THEN BEGIN
            IF STRPOS(Resp1, Strng) <> 0 THEN
                Resp1 := COPYSTR(Resp1, 1, STRPOS(Resp1, Strng) - 1)
            ELSE
                Resp1 := COPYSTR(Resp1, 1, STRLEN(Resp1) - 1);
            Resp1 := SELECTSTR(1, Resp1);
        END;
        IF NOT (Lstr = 'StatusDate') THEN
            Resp1 := DELCHR(Resp1, '=', ' ');
        Resp1 := DELCHR(Resp1, '=', '"');
        Resp1 := DELCHR(Resp1, '<', ':');
        Resp1 := DELCHR(Resp1, '=', '\');
        EXIT(Resp1);
    END;

    procedure AirtelWhatssAppAPI(JSONfile: text)
    var
        Companyinfo: Record "Company Information";
        WhatsappURL: Text;
        ErrorCode: Integer;
        MessResponse: Text;
        Results: Text;
        gResponseMsg: Text;
        gContent: HttpContent;
        gContentHeaders: HttpHeaders;
        gHttpResponseMsg: HttpResponseMessage;
        gHttpClient: HttpClient;
        Json: Text;
        Jobject: JsonObject;
    begin
        Companyinfo.Get;
        WhatsappURL := 'https://iqwhatsapp.airtel.in/gateway/airtel-xchange/basic/whatsapp-manager/v1/template/send';

        Clear(ErrorCode);
        Clear(MessResponse);
        Clear(Results);
        if Companyinfo."API Key" <> '' Then begin
            Clear(gResponseMsg);
            gContent.WriteFrom(JSONfile);
            gContent.GetHeaders(gContentHeaders);
            gContentHeaders.Clear();
            gContentHeaders.Add('Content-Type', 'application/json');
            //gContentHeaders.Add('Authorization', 'Basic U2FtcG9vcm5hOlNhbXBvb3JuQDQ0Iw==');
            gHttpClient.DefaultRequestHeaders.Add('Authorization', Companyinfo."API Key");

            if gHttpClient.Post(WhatsappURL, gContent, gHttpResponseMsg) then begin
                gHttpResponseMsg.Content.ReadAs(Json);
                if gHttpResponseMsg.IsSuccessStatusCode then begin
                    Jobject.ReadFrom(Json);
                    // IF (GetResponsesValue(Json, '"ErrorCode', ',', 1) = '') THEN BEGIN
                    //     Jobject.Get('results', JToken);

                END;
            END;
        end;
    end;


    // procedure WhatsAppAPI(JSONfile: Text)
    // var
    //     APIResponse: Text;
    //     EwayJson: Text;
    //     JSONManagement: Codeunit "JSON Management";
    //     gResponseMsg: Text;
    //     gRequestMsg: Text;
    //     Json: Text;
    //     gContent: HttpContent;
    //     gContentHeaders: HttpHeaders;
    //     gHttpClient: HttpClient;
    //     gHttpResponseMsg: HttpResponseMessage;
    //     gHttpRequestMsg: HttpRequestMessage;
    //     WhatsappURL: Text;
    //     ErrorResponse: Text;
    //     Jobject: JsonObject;
    //     Jobject1: JsonObject;
    //     Jobject2: JsonObject;
    //     JToken: JsonToken;
    //     Results: Text;
    //     MessResponse: Text;
    //     ErrorCode: Integer;
    //     ResultToken1: JsonToken;
    //     ResultToken2: JsonToken;
    //     ResultToken3: JsonToken;
    //     EwayURL: Text;
    //     NotJtokenLbl: Label 'JToken is not an object';
    //     Companyinfo: Record "Company Information";
    // begin
    //     Companyinfo.Get;
    //     WhatsappURL := 'https://apis.aisensy.com/project-apis/v1/project/' + Companyinfo."Project ID" + '/messages';

    //     Clear(ErrorCode);
    //     Clear(MessResponse);
    //     Clear(Results);

    //     Clear(gResponseMsg);
    //     gContent.WriteFrom(JSONfile);
    //     gContent.GetHeaders(gContentHeaders);
    //     gContentHeaders.Clear();
    //     gContentHeaders.Add('Content-Type', 'application/json');
    //     gContentHeaders.Add('X-AiSensy-Project-API-Pwd', Companyinfo."API Key");

    //     if gHttpClient.Post(WhatsappURL, gContent, gHttpResponseMsg) then begin
    //         gHttpResponseMsg.Content.ReadAs(Json);
    //         if gHttpResponseMsg.IsSuccessStatusCode then begin
    //             Jobject.ReadFrom(Json);
    //             // IF (GetResponsesValue(Json, '"ErrorCode', ',', 1) = '') THEN BEGIN
    //             //     Jobject.Get('results', JToken);

    //         END;
    //     END;
    // end;

    procedure SendPerformanceReport(MobileNo: Text; FromDate: Date; ToDate: Date; FilePath: Text; FileName: Text) JSONPayload: Text
    Var
        PayloadJson: JsonObject;
        MessageJson: JsonObject;
        MediaAttachmentJson: JsonObject;
        VariablesArray: JsonArray;
        PayloadArray: JsonArray;
        Payload: Text;
    begin
        PayloadJson.Add('templateId', '01kj4zk0f8z5y9tpdjy1zkkkzs');
        PayloadJson.Add('to', MobileNo);
        PayloadJson.Add('from', '9056969873');

        // Message object
        VariablesArray.Add(FromDate);
        VariablesArray.Add(ToDate);

        PayloadArray.Add('123');

        MessageJson.Add('variables', VariablesArray);
        MessageJson.Add('payload', PayloadArray);

        PayloadJson.Add('message', MessageJson);

        // MediaAttachment object
        MediaAttachmentJson.Add('type', 'DOCUMENT');
        MediaAttachmentJson.Add('filename', FileName);
        MediaAttachmentJson.Add('url', FilePath);

        PayloadJson.Add('mediaAttachment', MediaAttachmentJson);
        PayloadJson.WriteTo(Payload);

        exit(Payload);


    End;



    procedure DMR(MobileNo: Text; Date: Date; FilePath: Text; FileName: Text) JSONPayload: Text
    Var
        PayloadJson: JsonObject;
        MessageJson: JsonObject;
        MediaAttachmentJson: JsonObject;
        VariablesArray: JsonArray;
        PayloadArray: JsonArray;
        Payload: Text;
    begin
        PayloadJson.Add('templateId', '01kj4zyez43j66jkgepnbnwx1j');
        PayloadJson.Add('to', MobileNo);
        PayloadJson.Add('from', '9056969873');

        // Message object
        VariablesArray.Add(Date);
        PayloadArray.Add('123');
        MessageJson.Add('variables', VariablesArray);
        MessageJson.Add('payload', PayloadArray);
        PayloadJson.Add('message', MessageJson);
        // MediaAttachment object
        MediaAttachmentJson.Add('type', 'DOCUMENT');
        MediaAttachmentJson.Add('filename', FileName);
        MediaAttachmentJson.Add('url', FilePath);
        PayloadJson.Add('mediaAttachment', MediaAttachmentJson);
        PayloadJson.WriteTo(Payload);

        exit(Payload);
    End;

    procedure WeekwiseMortality(MobileNo: Text; FilePath: Text; FileName: Text; Template: Text) JSONPayload: Text
    Var
        PayloadJson: JsonObject;
        MessageJson: JsonObject;
        MediaAttachmentJson: JsonObject;
        VariablesArray: JsonArray;
        PayloadArray: JsonArray;
        Payload: Text;
    begin
        PayloadJson.Add('templateId', Template);
        PayloadJson.Add('to', MobileNo);
        PayloadJson.Add('from', '9056969873');


        // PayloadArray.Add('123');
        // MessageJson.Add('variables', VariablesArray);
        // MessageJson.Add('payload', PayloadArray);
        // PayloadJson.Add('message', MessageJson);
        // MediaAttachment object
        MediaAttachmentJson.Add('type', 'DOCUMENT');
        MediaAttachmentJson.Add('filename', FileName);
        MediaAttachmentJson.Add('url', FilePath);
        PayloadJson.Add('mediaAttachment', MediaAttachmentJson);
        PayloadJson.WriteTo(Payload);

        exit(Payload)

    End;

    procedure DailyMortality(MobileNo: Text; Date: Date; FilePath: Text; FileName: Text; Template: Text) JSONPayload: Text
    Var
        PayloadJson: JsonObject;
        MessageJson: JsonObject;
        MediaAttachmentJson: JsonObject;
        VariablesArray: JsonArray;
        PayloadArray: JsonArray;
        Payload: Text;
    begin
        PayloadJson.Add('templateId', '01kh3774mdkfxcvtqnkjcdm9zf');
        PayloadJson.Add('to', MobileNo);
        PayloadJson.Add('from', '9056969873');

        // Message object
        VariablesArray.Add(Date);
        PayloadArray.Add('123');
        MessageJson.Add('variables', VariablesArray);
        MessageJson.Add('payload', PayloadArray);
        PayloadJson.Add('message', MessageJson);
        // MediaAttachment object
        MediaAttachmentJson.Add('type', 'DOCUMENT');
        MediaAttachmentJson.Add('filename', FileName);
        MediaAttachmentJson.Add('url', FilePath);
        PayloadJson.Add('mediaAttachment', MediaAttachmentJson);
        PayloadJson.WriteTo(Payload);

        exit(Payload);
    End;



    procedure WhatsAppSOA(MobileNo: Text; Name: Text; FromDate: Date; ToDate: Date; FilePath: Text; FileName: Text) JSONPayload: Text
    Var
        PayloadJson: JsonObject;
        MessageJson: JsonObject;
        MediaAttachmentJson: JsonObject;
        VariablesArray: JsonArray;
        PayloadArray: JsonArray;
        Payload: Text;
    begin
        PayloadJson.Add('templateId', '01khb7pg2xxmyy4dzd3sd4dfav');
        PayloadJson.Add('to', MobileNo);
        PayloadJson.Add('from', '9056969873');

        // Message object
        VariablesArray.Add(Name);
        VariablesArray.Add(FromDate);
        VariablesArray.Add(ToDate);

        PayloadArray.Add('123');

        MessageJson.Add('variables', VariablesArray);
        MessageJson.Add('payload', PayloadArray);

        PayloadJson.Add('message', MessageJson);

        // MediaAttachment object
        MediaAttachmentJson.Add('type', 'DOCUMENT');
        MediaAttachmentJson.Add('filename', FileName);
        MediaAttachmentJson.Add('url', FilePath);

        PayloadJson.Add('mediaAttachment', MediaAttachmentJson);
        PayloadJson.WriteTo(Payload);

        exit(Payload);

    End;

    procedure WhatsAppInvoice(MobileNo: Text; CustName: Text; InvoiceDate: Date; InvoiceNo: Text; FilePath: Text; FileName: Text; Tempate: Text) JSONPayload: Text

    var
        PayloadJson: JsonObject;
        MessageJson: JsonObject;
        MediaAttachmentJson: JsonObject;
        VariablesArray: JsonArray;
        PayloadArray: JsonArray;
        Payload: Text;
    begin
        // Root object
        PayloadJson.Add('templateId', Tempate);
        PayloadJson.Add('to', MobileNo);
        PayloadJson.Add('from', '9056969873');

        // Message object
        VariablesArray.Add(CustName);
        VariablesArray.Add(InvoiceNo);
        VariablesArray.Add(InvoiceDate);

        PayloadArray.Add('123');

        MessageJson.Add('variables', VariablesArray);
        MessageJson.Add('payload', PayloadArray);

        PayloadJson.Add('message', MessageJson);

        // MediaAttachment object
        MediaAttachmentJson.Add('type', 'DOCUMENT');
        MediaAttachmentJson.Add('filename', FileName);
        MediaAttachmentJson.Add('url', FilePath);

        PayloadJson.Add('mediaAttachment', MediaAttachmentJson);
        PayloadJson.WriteTo(Payload);

        exit(Payload);
    end;

    procedure WhatsAppSalesOutstanding(MobileNo: Text; SalesPersonName: Text; FilePath: Text; FileName: Text; Tempate: Text) JSONPayload: Text
    var
        PayloadJson: JsonObject;
        MessageJson: JsonObject;
        MediaAttachmentJson: JsonObject;
        VariablesArray: JsonArray;
        PayloadArray: JsonArray;
        Payload: Text;
    begin
        // Root object
        PayloadJson.Add('templateId', Tempate);
        PayloadJson.Add('to', MobileNo);
        PayloadJson.Add('from', '9056969873');

        // Message object
        VariablesArray.Add(SalesPersonName);


        PayloadArray.Add('123');

        MessageJson.Add('variables', VariablesArray);
        MessageJson.Add('payload', PayloadArray);

        PayloadJson.Add('message', MessageJson);

        // MediaAttachment object
        MediaAttachmentJson.Add('type', 'DOCUMENT');
        MediaAttachmentJson.Add('filename', FileName);
        MediaAttachmentJson.Add('url', FilePath);

        PayloadJson.Add('mediaAttachment', MediaAttachmentJson);
        PayloadJson.WriteTo(Payload);

        exit(Payload);

    end;

    procedure WhatsupSmsforCattleSales(MobileNo: Text; Name: Text; Workdate: Date; Target: Decimal; SalesMT: Decimal; Percentage: Decimal; Template: Text) JSONPayload: Text
    var
        PayloadObj: JsonObject;
        MessageObj: JsonObject;
        VariablesArr: JsonArray;
        PayloadArr: JsonArray;
        ResultText: Text;
    begin
        // Root object
        PayloadObj.Add('templateId', Template);
        PayloadObj.Add('to', MobileNo);
        PayloadObj.Add('from', '9056969873');

        // Message object
        VariablesArr.Add(Workdate);
        VariablesArr.Add(Name);
        VariablesArr.Add(Format(Target));
        VariablesArr.Add(Format(SalesMT));
        VariablesArr.Add(Format(Percentage));


        PayloadArr.Add('5000');
        MessageObj.Add('variables', VariablesArr);
        MessageObj.Add('payload', PayloadArr);
        PayloadObj.Add('message', MessageObj);
        // Convert to text
        PayloadObj.WriteTo(ResultText);
        exit(ResultText);
    end;

    procedure WhatsupSmsforWelcome(MobileNo: Text; MasterCode: Text; Template: Text) JSONPayload: Text
    var
        PayloadObj: JsonObject;
        MessageObj: JsonObject;
        VariablesArr: JsonArray;
        PayloadArr: JsonArray;
        ResultText: Text;
    begin
        // Root object
        PayloadObj.Add('templateId', Template);
        PayloadObj.Add('to', MobileNo);
        PayloadObj.Add('from', '9056969873');

        // Message object
        VariablesArr.Add(MasterCode);

        PayloadArr.Add('5000');
        MessageObj.Add('variables', VariablesArr);
        MessageObj.Add('payload', PayloadArr);
        PayloadObj.Add('message', MessageObj);
        // Convert to text
        PayloadObj.WriteTo(ResultText);
        exit(ResultText);
    end;


    procedure WhatsupLegalCase(CaseNo: Text; HieringDistt: Text; CaseAmount: Decimal; Status: Text; MobileNo: Text; CustMobileNo: Text; TemplateNo: Text) JSONPayload: Text
    var
        PayloadObj: JsonObject;
        MessageObj: JsonObject;
        VariablesArr: JsonArray;
        PayloadArr: JsonArray;
        ResultText: Text;
    begin
        // Root object
        PayloadObj.Add('templateId', TemplateNo);
        PayloadObj.Add('to', CustMobileNo);
        PayloadObj.Add('from', '9056969873');

        // Message object
        VariablesArr.Add(CaseNo);
        VariablesArr.Add(HieringDistt);
        VariablesArr.Add(Format(CaseAmount));
        VariablesArr.Add(Status);
        VariablesArr.Add(MobileNo);

        PayloadArr.Add('5000');
        MessageObj.Add('variables', VariablesArr);
        MessageObj.Add('payload', PayloadArr);
        PayloadObj.Add('message', MessageObj);
        // Convert to text
        PayloadObj.WriteTo(ResultText);
        exit(ResultText);
    end;

    procedure CustomerPaymentQRCODE(MobileNo: Text; CustomerName: Text; FilePath: Text; FileName: Text; BankAccountNo: Text; IFSCCode: text) JSONPayload: Text
    Var
        PayloadJson: JsonObject;
        MessageJson: JsonObject;
        MediaAttachmentJson: JsonObject;
        VariablesArray: JsonArray;
        PayloadArray: JsonArray;
        Payload: Text;
    begin
        PayloadJson.Add('templateId', '01kj9mhamgjxnbs3kgsmqbt2td');
        PayloadJson.Add('to', MobileNo);
        PayloadJson.Add('from', '9056969873');

        // Message object
        VariablesArray.Add(CustomerName);
        VariablesArray.Add(BankAccountNo);
        VariablesArray.Add(IFSCCode);

        PayloadArray.Add('123');

        MessageJson.Add('variables', VariablesArray);
        MessageJson.Add('payload', PayloadArray);

        PayloadJson.Add('message', MessageJson);

        // MediaAttachment object
        MediaAttachmentJson.Add('type', 'IMAGE');
        //MediaAttachmentJson.Add('filename', FileName);
        MediaAttachmentJson.Add('url', FilePath);

        PayloadJson.Add('mediaAttachment', MediaAttachmentJson);
        PayloadJson.WriteTo(Payload);

        exit(Payload);
    End;


    procedure CustomerOutstandingReminder(MobileNo: Text; OutstandingAmt: Text; Date: Text; TemplateNo: Text) JSONPayload: Text
    var
        PayloadObj: JsonObject;
        MessageObj: JsonObject;
        VariablesArr: JsonArray;
        PayloadArr: JsonArray;
        ResultText: Text;
    begin
        // Root object
        PayloadObj.Add('templateId', TemplateNo);
        PayloadObj.Add('to', MobileNo);
        PayloadObj.Add('from', '9056969873');

        // Message object
        VariablesArr.Add(OutstandingAmt);
        VariablesArr.Add(Date);


        PayloadArr.Add('5000');
        MessageObj.Add('variables', VariablesArr);
        MessageObj.Add('payload', PayloadArr);
        PayloadObj.Add('message', MessageObj);
        // Convert to text
        PayloadObj.WriteTo(ResultText);
        exit(ResultText);
    end;



    Var
        JsonObjectRes: JsonObject;
        JsonObjectParameter: JsonObject;
        JsonArrayItem: JsonArray;
}


