namespace Sampoorna_BC.Sampoorna_BC;
using System.Text;
using Microsoft.Purchases.Vendor;
using Microsoft.Finance.GST.Sales;
using Microsoft.Inventory.Transfer;
using Microsoft.Inventory.Location;
using Microsoft.Finance.GST.Base;
using Microsoft.Purchases.History;
using Microsoft.Sales.History;

codeunit 50061 EwayBill
{
    Permissions = tabledata "Sales Invoice Header" = rm,
    tabledata "Purch. Cr. Memo Hdr." = rm,
    tabledata "Transfer Shipment Header" = rm;

    procedure GetSetToken(Token: Text);
    var
        AccessTokenKey: Text;
        MessResponse: Text;
    begin
        //GetAccessToken(AccessTokenKey);
        //if AccessTokenKey <> '' then
        SetToken(Token, '5ee9d201fe82fd275e884cc46ca5be2032ce2aac', DataScope::Module);
    end;

    [NonDebuggable]
    procedure SetToken(KeyTxt: Text; Token: Text; Scope: DataScope)
    var
        FailedToSaveErr: Label 'Failed to save Token!';
    begin
        if not IsolatedStorage.Set(KeyTxt, Token, Scope) then
            Error(FailedToSaveErr);
    end;

    [NonDebuggable]
    procedure GetInfo(KeyTxt: Text; Scope: DataScope) Token: Text
    var
        NotFoundErr: Label 'Token %1 not found!', Comment = '%1= token';
    begin
        if IsolatedStorage.Contains(KeyTxt, Scope) then
            IsolatedStorage.Get(KeyTxt, Scope, Token);
        // else
        // Error(NotFoundErr, KeyTxt);
    end;

    procedure GetAccessToken(var AccessTok: Text)
    var
        Body: Text;
        JSONManagement: Codeunit "JSON Management";
        gResponseMsg: Text;
        gRequestMsg: Text;
        gContent: HttpContent;
        gContentHeaders: HttpHeaders;
        gHttpClient: HttpClient;
        gHttpResponseMsg: HttpResponseMessage;
        gHttpRequestMsg: HttpRequestMessage;
        URL: Text;
        Body2: Text;
        Json: Text;
        WebURL: Label 'https://pro.mastersindia.co/oauth/access_token/';
    begin
        CLEARALL;

        Body := '{' +
          '"username":"' + 'sumandev@sampoornafeeds.in' + '",' +
          '"password":"' + 'Goodluck@12India' + '",' +
          '"client_id":"' + 'QKCUuNMLRZnUgNQJJg' + '",' +
          '"client_secret":"' + 'UGelnP6hP1bbroywvbpNyneL' + '",' +
           '"grant_type":"' + 'password' + '"' +
       '}';

        Clear(AccessTok);
        // Clear(ExpiresIn);
        Clear(gResponseMsg);
        gContent.WriteFrom(Body);
        gContent.GetHeaders(gContentHeaders);
        gContentHeaders.Clear();
        gContentHeaders.Add('Content-Type', 'application/json');
        if gHttpClient.Post(WebURL, gContent, gHttpResponseMsg) then begin
            gHttpResponseMsg.Content.ReadAs(Json);
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                //MESSAGE(Json);
                IF (GetResponsesValue(Json, '"access_token', ',', 1) <> '') THEN BEGIN
                    //AccessTok := GetResponsesValue(Json, '"access_token', ',', 1);
                    AccessTok := '5ee9d201fe82fd275e884cc46ca5be2032ce2aac';
                    // Evaluate(ExpiresIn, GetResponsesValue(Json, '"expires_in', ',', 1));
                END;
            END;
        END;
    END;

    LOCAL procedure GetResponsesValue(resp3: Text; Lstr: Text; Strng: Text; Cnt: Integer): Text
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
        //IF NOT (Lstr = 'StatusDate') THEN
        //   Resp1 := DELCHR(Resp1, '=', ' ');
        Resp1 := DELCHR(Resp1, '=', '"');
        Resp1 := DELCHR(Resp1, '<', ':');
        Resp1 := DELCHR(Resp1, '=', '\');
        EXIT(Resp1);
    END;

    procedure GenerateEwayBill(RecVariant: Variant; Var EwayBillNo: Text; var EwayBillDate: DateTime; var validUpto: DateTime)
    var
        APIResponse: Text;
        EwayJson: Text;
        JSONManagement: Codeunit "JSON Management";
        gResponseMsg: Text;
        gRequestMsg: Text;
        gContent: HttpContent;
        gContentHeaders: HttpHeaders;
        gHttpClient: HttpClient;
        gHttpResponseMsg: HttpResponseMessage;
        gHttpRequestMsg: HttpRequestMessage;
        Json: Text;
        //url
        WebURL: Label 'https://pro.mastersindia.co/ewayBillsGenerate';
        ErrorResponse: Text;
        Jobject: JsonObject;
        Jobject1: JsonObject;
        Jobject2: JsonObject;
        JToken: JsonToken;
        Results: Text;
        MessResponse: Text;
        ErrorCode: Integer;
        ResultToken1: JsonToken;
        ResultToken2: JsonToken;
        ResultToken3: JsonToken;
        EwayURL: Text;
        NotJtokenLbl: Label 'JToken is not an object';
        IMS: Codeunit IMS;
        RecRef: RecordRef;
        SalesInvHdr: Record "Sales Invoice Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        TransferShptHdr: Record "Transfer Shipment Header";
        TranshptLine: Record "Transfer Shipment Line";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
    begin
        Clear(EwayURL);
        Clear(EwayBillDate);
        Clear(EwayBillNo);
        Clear(validUpto);
        Clear(ErrorCode);
        Clear(MessResponse);
        Clear(Results);
        //  CLEARALL;
        // if RecVariant.;
        GetSetToken('MIEWAY');
        Clear(EwayJson);

        GetEwayJson(EwayJson, RecVariant);
        Message(EwayJson);
        if EwayJson = '' then
            exit;

        Clear(gResponseMsg);
        gContent.WriteFrom(EwayJson);
        gContent.GetHeaders(gContentHeaders);
        gContentHeaders.Clear();
        gContentHeaders.Add('Content-Type', 'application/json');

        if gHttpClient.Post(WebURL, gContent, gHttpResponseMsg) then begin
            gHttpResponseMsg.Content.ReadAs(Json);
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                Jobject.ReadFrom(Json);
                IF (GetResponsesValue(Json, '"ErrorCode', ',', 1) = '') THEN BEGIN
                    Jobject.Get('results', JToken);
                    if JToken.IsObject then begin
                        JToken.WriteTo(Results);
                        JObject1.ReadFrom(Results);
                        //GetCode from Response
                        JObject1.Get('code', ResultToken1);
                        if Not ResultToken1.AsValue().IsNull then
                            ErrorCode := ResultToken1.AsValue().AsInteger();
                        //GetCode from Response

                        Jobject1.Get('message', ResultToken2);

                        if ResultToken2.IsObject then begin
                            ResultToken2.WriteTo(MessResponse);
                            Clear(JToken);
                            JToken.ReadFrom(MessResponse);

                            Clear(ResultToken3);
                            if JToken.SelectToken(('ewayBillNo'), ResultToken3) then
                                if Not ResultToken3.AsValue().IsNull then
                                    EwayBillNo := ResultToken3.AsValue().AsText();
                            Clear(ResultToken3);

                            
                            if JToken.SelectToken(('ewayBillDate'), ResultToken3) then
                                if Not ResultToken3.AsValue().IsNull then
                                    Evaluate(EwayBillDate, ResultToken3.AsValue().AsText());
                            Clear(ResultToken3);
                            if JToken.SelectToken(('validUpto'), ResultToken3) then
                                if Not ResultToken3.AsValue().IsNull then
                                    Evaluate(validUpto, ResultToken3.AsValue().AsText());
                            Clear(ResultToken3);
                            if JToken.SelectToken(('url'), ResultToken3) then
                                if Not ResultToken3.AsValue().IsNull then
                                    EwayURL := ResultToken3.AsValue().AsText();
                            Clear(ResultToken3);
                            if JToken.SelectToken(('alert'), ResultToken3) then
                                if Not ResultToken3.AsValue().IsNull then
                                    ErrorResponse := ResultToken3.AsValue().AsText();
                        end else
                            if Not ResultToken2.AsValue().IsNull then
                                ErrorResponse := ResultToken2.AsValue().AsText();

                        if EwayURL <> '' then begin
                            Savelink(EwayURL, RecVariant);
                            Hyperlink(EwayURL);
                        end;
                        if EwayBillNo <> '' then
                            Message('Part A generated');
                        if ErrorResponse <> '' then
                            Message(ErrorResponse);

                        RecRef.GETTABLE(RecVariant);

                        CASE RecRef.NUMBER OF
                            DATABASE::"Sales Invoice Header":
                                BEGIN
                                    SalesInvHdr := RecVariant;

                                    SalesInvHdr."E-Way Bill No." := EwayBillNo;
                                    SalesInvHdr."E-Way Generated Date" := EwayBillDate;
                                    SalesInvHdr.Modify();
                                END;
                            DATABASE::"Purch. Cr. Memo Hdr.":
                                begin
                                    PurchCrMemoHdr := RecVariant;

                                    PurchCrMemoHdr."E-Way Bill No." := EwayBillNo;
                                    PurchCrMemoHdr."E-Way Generated Date" := EwayBillDate;
                                    PurchCrMemoHdr.Modify();

                                end;

                            DATABASE::"Transfer Shipment Header":
                                begin
                                    TransferShptHdr := RecVariant;

                                    TransferShptHdr."E-Way Bill No." := EwayBillNo;
                                    TransferShptHdr."E-Way Generated Date" := EwayBillDate;
                                    TransferShptHdr.Modify();

                                end;
                        END;
                    end;

                end else
                    Message(NotJtokenLbl);
            end else
                ERROR('%1 Please share this request ID for support %2', IMS.GetResponsesValueForErrror(Json, '"ErrorMessage', ',', 1), IMS.GetResponsesValueForErrror(Json, '"ErrorCode', ',', 1));
        END;

    END;

    //SIM -----Code Added---->>>>>>----------
    procedure UpdateVehicleDetails(DocNo: Code[50]; eway_bill_number: Text; TransporterDetails: Boolean)
    var
        JsonObjectRes: JsonObject;
        Transporter: Record Vendor;
        userGstin: Text;
        JsonBody: Text;
        JSONManagement: Codeunit "JSON Management";
        gResponseMsg: Text;
        gRequestMsg: Text;
        gContent: HttpContent;
        gContentHeaders: HttpHeaders;
        gHttpClient: HttpClient;
        gHttpResponseMsg: HttpResponseMessage;
        gHttpRequestMsg: HttpRequestMessage;
        Json: Text;
        WebURL: Label 'https://pro.mastersindia.co/updateVehicleNumber/';
        WebURL2: Label 'https://pro.mastersindia.co/transporterIdUpdate/';
        ErrorResponse: Text;
        Jobject: JsonObject;
        Jobject1: JsonObject;
        Jobject2: JsonObject;
        JToken: JsonToken;
        Results: Text;
        MessResponse: Text;
        ErrorCode: Integer;
        ResultToken1: JsonToken;
        ResultToken2: JsonToken;
        ResultToken3: JsonToken;
        NotJtokenLbl: Label 'JToken is not an object';
        CU50062: Codeunit 50062;
    begin

        JsonBody := CU50062.UpdateVehicleJson(DocNo, eway_bill_number, TransporterDetails);

        if JsonBody = '' then
            exit;
        Clear(gResponseMsg);
        gContent.WriteFrom(JsonBody);
        gContent.GetHeaders(gContentHeaders);
        gContentHeaders.Clear();
        gContentHeaders.Add('Content-Type', 'application/json');
        if not TransporterDetails then
            gHttpClient.Post(WebURL, gContent, gHttpResponseMsg)
        else
            gHttpClient.Post(WebURL2, gContent, gHttpResponseMsg);
        gHttpResponseMsg.Content.ReadAs(Json);
        if gHttpResponseMsg.IsSuccessStatusCode then begin
            Jobject.ReadFrom(Json);
            Jobject.Get('results', JToken);
            if JToken.IsObject then begin
                JToken.WriteTo(Results);
                JObject1.ReadFrom(Results);
                //GetCode from Response
                JObject1.Get('code', ResultToken1);
                if Not ResultToken1.AsValue().IsNull then
                    ErrorCode := ResultToken1.AsValue().AsInteger();
                //GetCode from Response

                Jobject1.Get('message', ResultToken2);

                if not ResultToken2.IsObject then begin
                    if Not ResultToken2.AsValue().IsNull then
                        ErrorResponse := ResultToken2.AsValue().AsText();
                End;
                if ErrorCode <> 200 then begin
                    if ErrorResponse <> '' then
                        Error(ErrorResponse);
                end else
                    if not TransporterDetails then
                        Message('Part B generated')
                    else
                        Message('Transported Details Updated');
            end else
                Message(NotJtokenLbl);
        END;
        // END;
    end;

    procedure GetEwayJson(Var EwayJson: Text; Variant: Variant)
    var
        GenerateEwayJson: Codeunit 50062;
        GenerateEwayJson2: Codeunit EwayBillJsonHandlerShpt;
        RecRef: RecordRef;
        SalesInvHdr: Record "Sales Invoice Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        TransferShptHdr: Record "Transfer Shipment Header";
        TranshptLine: Record "Transfer Shipment Line";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        Loc: Record Location;
        Loc2: Record Location;
    begin
        RecRef.GETTABLE(Variant);

        CASE RecRef.NUMBER OF
            DATABASE::"Sales Invoice Header":
                BEGIN
                    SalesInvHdr := Variant;

                    // if SalesInvHdr."Invoice Type" <> SalesInvHdr."Invoice Type"::Taxable then
                    //     exit;
                    //SalesInvHdr.TestField("Vehicle No.");
                    if SalesInvHdr."E-Way Bill No." = '' then
                        EwayJson := GenerateEwayJson.GetRequestJson(SalesInvHdr."No.", 1)
                    else
                        Message('Eway Bill Already generated');
                END;
            DATABASE::"Purch. Cr. Memo Hdr.":
                begin
                    //PurchCrMemoHdr.TestField("Vehicle No.");
                    PurchCrMemoHdr := Variant;
                    PurchCrMemoLine.Reset();
                    PurchCrMemoLine.SetRange("Document No.", PurchCrMemoHdr."No.");
                    //PurchCrMemoLine.SetRange(Exempted, false);
                    if PurchCrMemoLine.FindFirst() then
                        if PurchCrMemoHdr."E-Way Bill No." = '' then
                            EwayJson := GenerateEwayJson.GetRequestJson(PurchCrMemoHdr."No.", 3)
                        else
                            Message('Eway Bill Already generated');
                end;

            DATABASE::"Transfer Shipment Header":
                begin
                    //TransferShptHdr.TestField("Vehicle No.");
                    TransferShptHdr := Variant;
                    loc.Get(TransferShptHdr."Transfer-from Code");
                    Loc2.Get(TransferShptHdr."Transfer-to Code");
                    TranshptLine.Reset();
                    TranshptLine.SetRange("Document No.", TransferShptHdr."No.");
                    TranshptLine.SetRange(Exempted, false);
                    if TranshptLine.FindFirst() then
                        if TransferShptHdr."E-Way Bill No." = '' then
                            if Loc."State Code" <> Loc2."State Code" then
                                EwayJson := GenerateEwayJson.GetRequestJson(TransferShptHdr."No.", 2)
                            else
                                EwayJson := GenerateEwayJson2.GetRequestJson(TransferShptHdr."No.", 2)
                        else
                            Message('Eway Bill Already generated');
                end;
        END;
    end;

    procedure CalculateDistance(FromPinCode: Code[20]; ToPinCode: Code[20]): Decimal
    var
        Body: Text;
        JSONManagement: Codeunit "JSON Management";
        gResponseMsg: Text;
        gRequestMsg: Text;
        gContent: HttpContent;
        gContentHeaders: HttpHeaders;
        gHttpClient: HttpClient;
        gHttpResponseMsg: HttpResponseMessage;
        gHttpRequestMsg: HttpRequestMessage;
        Json: Text;
        WebURL: Label 'http://pro.mastersindia.co/distance?access_token=';

        FromPinCodeURL: Label '&fromPincode=';
        ToPinCodeURL: Label '&toPincode=';
        Distance: Decimal;
        Jobject: JsonObject;
        NewJObject: JsonObject;
        JToken: JsonToken;
        ResultToken1: JsonToken;
        ResultToken2: JsonToken;
        APIResult: Text[1024];
        Results: Text;
    begin
        CLEARALL;
        Clear(Distance);
        Clear(gResponseMsg);
        Clear(gContent);
        Clear(gContentHeaders);
        Clear(gHttpClient);
        gContent.GetHeaders(gContentHeaders);
        gContentHeaders.Clear();
        if gHttpClient.Get(WebURL + GetInfo('MIEWAY', DataScope::Module) + FromPinCodeURL + FromPinCode + ToPinCodeURL + ToPinCode, gHttpResponseMsg) then begin
            // Message(WebURL + GetInfo('MIEWAY', DataScope::Module) + FromPinCodeURL + FromPinCode + ToPinCodeURL + ToPinCode);
            //Message(gHttpResponseMsg);
            gHttpResponseMsg.Content.ReadAs(Json);
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                Jobject.ReadFrom(Json);
                Jobject.Get('results', JToken);
                if JToken.IsObject then begin
                    JToken.WriteTo(Results);
                    NewJObject.ReadFrom(Results);
                    NewJObject.Get('distance', ResultToken1);
                    if Not ResultToken1.AsValue().IsNull then
                        Distance := ResultToken1.AsValue().AsDecimal();
                end else
                    Message('JToken is not an object');
            END;
        END;
        exit(Distance);
    END;

    procedure Savelink(Var URL: Text; Variant: Variant)
    var

        RecRef: RecordRef;
        SalesInvHdr: Record "Sales Invoice Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        TransferShptHdr: Record "Transfer Shipment Header";
    begin
        RecRef.GETTABLE(Variant);
        RecRef.AddLink(URL, 'EwayBill Download');

    end;

    procedure CancelEwayBill(RecVariant: Variant; eway_bill_number: Text; CancelReason: Enum "Eway Cancel Reason"; CancelRemark: Text[100]; LocGSTRegNo: Code[15]; var cancelDate: DateTime)
    var
        myInt: Integer;
        WebURL: Label 'https://pro.mastersindia.co/ewayBillCancel/';
        CU50062: Codeunit 50062;
        Body: Text;
        JSONManagement: Codeunit "JSON Management";
        gResponseMsg: Text;
        gRequestMsg: Text;
        gContent: HttpContent;
        gContentHeaders: HttpHeaders;
        gHttpClient: HttpClient;
        MessResponse: Text;
        gHttpResponseMsg: HttpResponseMessage;
        gHttpRequestMsg: HttpRequestMessage;
        Json: Text;
        Results: Text;
        Jobject: JsonObject;
        JObject1: JsonObject;
        JToken: JsonToken;
        ResultToken1: JsonToken;
        ResultToken2: JsonToken;
        ResultToken3: JsonToken;
        ErrorCode: Integer;
        ErrorResponse: Text;
        NotJtokenLbl: Label 'JToken is not an object';
        RecRef: RecordRef;
        SalesInvHdr: Record "Sales Invoice Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        TransferShptHdr: Record "Transfer Shipment Header";
        TranshptLine: Record "Transfer Shipment Line";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
    begin
        CLEARALL;
        GetSetToken('MIEWAY');
        //LocGSTRegNo := '05AAABC0181E1ZE';//For Testing
        Body := CU50062.WriteCancellationJSON(eway_bill_number,
        CancelReason,
        CancelRemark,
        LocGSTRegNo);

        Clear(gResponseMsg);
        gContent.WriteFrom(Body);
        gContent.GetHeaders(gContentHeaders);
        gContentHeaders.Clear();
        gContentHeaders.Add('Content-Type', 'application/json');
        if gHttpClient.Post(WebURL, gContent, gHttpResponseMsg) then begin
            gHttpResponseMsg.Content.ReadAs(Json);
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                Jobject.ReadFrom(Json);
                Jobject.Get('results', JToken);
                if JToken.IsObject then begin
                    JToken.WriteTo(Results);
                    JObject1.ReadFrom(Results);
                    //GetCode from Response
                    JObject1.Get('code', ResultToken1);
                    if Not ResultToken1.AsValue().IsNull then
                        ErrorCode := ResultToken1.AsValue().AsInteger();
                    //GetCode from Response

                    Jobject1.Get('message', ResultToken2);

                    if ResultToken2.IsObject then begin
                        ResultToken2.WriteTo(MessResponse);
                        Clear(JToken);
                        JToken.ReadFrom(MessResponse);
                        Clear(ResultToken3);
                        // if JToken.SelectToken(('ewayBillNo'), ResultToken3) then
                        //     if Not ResultToken3.AsValue().IsNull then
                        //         EwayBillNo := ResultToken3.AsValue().AsText();
                        Clear(ResultToken3);
                        if JToken.SelectToken(('cancelDate'), ResultToken3) then
                            if Not ResultToken3.AsValue().IsNull then
                                Evaluate(cancelDate, ResultToken3.AsValue().AsText());

                        CASE RecRef.NUMBER OF
                            DATABASE::"Sales Invoice Header":
                                BEGIN
                                    SalesInvHdr := RecVariant;

                                    SalesInvHdr."E-Way Cancelled Date" := cancelDate;
                                    SalesInvHdr."E-Way Bill No." := '';
                                    SalesInvHdr."E-Way Generated Date" := 0DT;
                                    SalesInvHdr.Modify();
                                END;
                            DATABASE::"Purch. Cr. Memo Hdr.":
                                begin
                                    PurchCrMemoHdr := RecVariant;

                                    PurchCrMemoHdr."E-Way Cancelled Date" := cancelDate;
                                    PurchCrMemoHdr."E-Way Bill No." := '';
                                    PurchCrMemoHdr."E-Way Generated Date" := 0DT;
                                    PurchCrMemoHdr.Modify();

                                end;

                            DATABASE::"Transfer Shipment Header":
                                begin
                                    TransferShptHdr := RecVariant;
                                    TransferShptHdr."E-Way Cancelled Date" := cancelDate;
                                    TransferShptHdr."E-Way Bill No." := '';
                                    TransferShptHdr."E-Way Generated Date" := 0DT;
                                    TransferShptHdr.Modify();

                                end;
                        END;
                    end else
                        if Not ResultToken2.AsValue().IsNull then
                            ErrorResponse := ResultToken2.AsValue().AsText();
                    if ErrorResponse <> '' then
                        Error(ErrorResponse);
                end else
                    Message(NotJtokenLbl);
            END;
        END;
    end;

    procedure RejectEwayBill(eway_bill_number: Text; LocGSTRegNo: Code[15]; var ewbRejectedDate: DateTime)
    var

        WebURL: Label 'https://pro.mastersindia.co/ewayBillReject';
        CU50062: Codeunit 50062;
        Body: Text;
        JSONManagement: Codeunit "JSON Management";
        gResponseMsg: Text;
        gRequestMsg: Text;
        gContent: HttpContent;
        gContentHeaders: HttpHeaders;
        gHttpClient: HttpClient;
        MessResponse: Text;
        gHttpResponseMsg: HttpResponseMessage;
        gHttpRequestMsg: HttpRequestMessage;
        Json: Text;
        Results: Text;
        Jobject: JsonObject;
        JObject1: JsonObject;
        JToken: JsonToken;
        ResultToken1: JsonToken;
        ResultToken2: JsonToken;
        ResultToken3: JsonToken;
        ErrorCode: Integer;
        ErrorResponse: Text;
        NotJtokenLbl: Label 'JToken is not an object';
    begin
        CLEARALL;
        GetSetToken('MIEWAY');
        LocGSTRegNo := '05AAABC0181E1ZE';//For Testing

        Body := '{' +
                  '"access_token":"' + GetInfo('MIEWAY', DataScope::Module) + '",' +
                  '"userGstin":"' + LocGSTRegNo + '",' +
                  '"eway_bill_number":"' + eway_bill_number + '",' +
                   '"data_source":"' + 'erp' + '"' +
               '}';

        Clear(gResponseMsg);
        gContent.WriteFrom(Body);
        gContent.GetHeaders(gContentHeaders);
        gContentHeaders.Clear();
        gContentHeaders.Add('Content-Type', 'application/json');
        if gHttpClient.Post(WebURL, gContent, gHttpResponseMsg) then begin
            gHttpResponseMsg.Content.ReadAs(Json);
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                Jobject.ReadFrom(Json);
                Jobject.Get('results', JToken);
                if JToken.IsObject then begin
                    JToken.WriteTo(Results);
                    JObject1.ReadFrom(Results);
                    //GetCode from Response
                    JObject1.Get('code', ResultToken1);
                    if Not ResultToken1.AsValue().IsNull then
                        ErrorCode := ResultToken1.AsValue().AsInteger();
                    //GetCode from Response

                    Jobject1.Get('message', ResultToken2);

                    if ResultToken2.IsObject then begin
                        ResultToken2.WriteTo(MessResponse);
                        Clear(JToken);
                        JToken.ReadFrom(MessResponse);
                        Clear(ResultToken3);
                        // if JToken.SelectToken(('ewayBillNo'), ResultToken3) then
                        //     if Not ResultToken3.AsValue().IsNull then
                        //         EwayBillNo := ResultToken3.AsValue().AsText();
                        Clear(ResultToken3);
                        if JToken.SelectToken(('ewbRejectedDate'), ResultToken3) then
                            if Not ResultToken3.AsValue().IsNull then
                                Evaluate(ewbRejectedDate, ResultToken3.AsValue().AsText());
                    end else
                        if Not ResultToken2.AsValue().IsNull then
                            ErrorResponse := ResultToken2.AsValue().AsText();
                    if ErrorResponse <> '' then
                        Error(ErrorResponse);
                end else
                    Message(NotJtokenLbl);
            END;
        END;
    end;

    // procedure LoginBusinessUnit(GSTIN: Code[20])
    // var
    //     Body: Text;
    //     JSONManagement: Codeunit "JSON Management";
    //     gResponseMsg: Text;
    //     gRequestMsg: Text;
    //     gContent: HttpContent;
    //     gContentHeaders: HttpHeaders;
    //     gHttpClient: HttpClient;
    //     gHttpResponseMsg: HttpResponseMessage;
    //     gHttpRequestMsg: HttpRequestMessage;
    //     URL: Text;
    //     Body2: Text;
    //     Json: Text;
    //     WebURL: Label 'https://clientbasic.mastersindia.co/';
    //     GSTRegNo: Record "GST Registration Nos.";
    //     ErrorCode: Code[50];
    //     RespMessage: Text;
    // begin
    //     GSTRegNo.Get(GSTIN);
    //     CLEARALL;
    //     Clear(ErrorCode);
    //     Clear(RespMessage);

    //     Body := '{' +
    //       '"access_token":"' + GetInfo('MIEWAY', DataScope::Module) + '",' +
    //       '"gstin_number":"' + GSTIN + '",' +
    //       '"eway_userName":"' + GSTRegNo."E-Way Bill User Name" + '",' +
    //       '"eway_password":"' + GSTRegNo."E-Way User Password" + '",' +
    //    '}';

    //     // Clear(ExpiresIn);
    //     Clear(gResponseMsg);
    //     gContent.WriteFrom(Body);
    //     gContent.GetHeaders(gContentHeaders);
    //     gContentHeaders.Clear();
    //     gContentHeaders.Add('Content-Type', 'application/json');
    //     if gHttpClient.Post(WebURL, gContent, gHttpResponseMsg) then begin
    //         gHttpResponseMsg.Content.ReadAs(Json);
    //         if gHttpResponseMsg.IsSuccessStatusCode then begin
    //             //MESSAGE(Json);
    //             IF (GetResponsesValue(Json, '"code', ',', 1) <> '') THEN BEGIN
    //                 ErrorCode := GetResponsesValue(Json, '"code', ',', 1);

    //             END;
    //             IF (GetResponsesValue(Json, '"message', ',', 1) <> '') THEN BEGIN
    //                 RespMessage := GetResponsesValue(Json, '"message', ',', 1);

    //             END;
    //             if ErrorCode <> '200' then
    //                 Message(RespMessage);
    //         END;
    //     END;
    // END;
}




