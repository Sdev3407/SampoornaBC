codeunit 50023 UpdateGSTReg
{
    var
        AccessTockenKey: Text;

    procedure UpdateVendor(VendorNo: Code[30]; GSTNo: Text; var Status: Text; var Lastdate: Date; var GSTName: Text; var GSTAddr: Text; var GStAddr2: Text; var GSTStCode: Code[40]; var GStpCode: Code[20]; var ENDDate: Date)
    var
        Vendor: Record Vendor;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        IF (VendorNo <> '') AND (GSTNo <> '') THEN BEGIN
            Vendor.RESET;
            IF Vendor.GET(VendorNo) THEN BEGIN
                SalesReceivablesSetup.GET;
                IF SalesReceivablesSetup."GST Tocken" <> '' THEN BEGIN
                    IF SalesReceivablesSetup."Tocken Date" <> TODAY THEN BEGIN
                        AccessTockenKey := GetAccessToken;
                        SendGSTSearchRequest(GSTNo, GSTName, GSTAddr, GStAddr2, GSTStCode, GStpCode, Status);
                        ENDDate := Today;
                    END ELSE begin
                        SendGSTSearchRequest(GSTNo, GSTName, GSTAddr, GStAddr2, GSTStCode, GStpCode, Status);
                        ENDDate := Today;
                    end;
                END ELSE BEGIN
                    AccessTockenKey := GetAccessToken;
                    //SalesReceivablesSetup."Tocken Date" := TODAY;
                    //SalesReceivablesSetup.MODIFY;
                    SendGSTSearchRequest(GSTNo, GSTName, GSTAddr, GStAddr2, GSTStCode, GStpCode, Status);
                    ENDDate := Today;
                END;

            END;
        END ELSE BEGIN
            GSTName := '';
            GSTAddr := '';
            GStAddr2 := '';
            GStpCode := '';
            GSTStCode := '';
            Status := '';
            Lastdate := 0D;
            //MESSAGE('Invalid GST No.');
        END;
    END;

    procedure GetAccessToken(): Text
    var

        APIIntegrationSetup: Record "Sales & Receivables Setup";
        APIResponse: Text;
        PostedSalesInv: Record "Sales Invoice Header";

        Month1: Integer;
        Year1: Integer;
        SalesInvHead: Record "Sales Invoice Header";
        lreLocation: Record Location;
        Body: Text;
        JSONManagement: Codeunit "JSON Management";
        gResponseMsg: Text;
        gRequestMsg: Text;
        gContent: HttpContent;
        gContentHeaders: HttpHeaders;
        gHttpClient: HttpClient;
        JsonText: Text;
        gHttpResponseMsg: HttpResponseMessage;
        gHttpRequestMsg: HttpRequestMessage;
        URL: Text;
        Body2: Text;
        Json: Text;
        SH: Record "Sales Invoice Header";
        URL1: Text[200];
        SCM: Record "Sales Cr.Memo Header";
        AccessTok: Text;
    begin
        CLEARALL;
        CLEAR(APIResponse);

        Body := '{' +
          '"username":"' + 'sumandev@sampoornafeeds.in' + '",' +
          '"password":"' + 'Goodluck@12India' + '",' +
          '"client_id":"' + 'QKCUuNMLRZnUgNQJJg' + '",' +
          '"client_secret":"' + 'UGelnP6hP1bbroywvbpNyneL' + '",' +
           '"grant_type":"' + 'password' + '"' +
       '}';
        /*
Body := '{' +
  '"username":"' + 'sampletest@mastersindia.co' + '",' +
  '"password":"' + 'Test@12345' + '",' +
  '"client_id":"' + 'NASgLPiRQYlYt0E4dW' + '",' +
  '"client_secret":"' + 'BMUR179a3jv1d24UgE0Osqw23' + '",' +
   '"grant_type":"' + 'password' + '"' +
'}';
*/

        //  MESSAGE(Body);
        //MESSAGE(APIResponse);
        Clear(AccessTok);
        Clear(gResponseMsg);
        gContent.WriteFrom(Body);
        gContent.GetHeaders(gContentHeaders);
        gContentHeaders.Clear();
        gContentHeaders.Add('Content-Type', 'application/json');
        // URL:https://commonapi.mastersindia.co/oauth/access_token
        //Live https://commonapi.mastersindia.co/oauth/access_token
        if gHttpClient.Post('https://commonapi.mastersindia.co/oauth/access_token', gContent, gHttpResponseMsg) then begin
            gHttpResponseMsg.Content.ReadAs(Json);
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                //MESSAGE(Json);
                IF (GetResponsesValue(Json, '"access_token', ',', 1) <> '') THEN BEGIN
                    AccessTok := GetResponsesValue(Json, '"access_token', ',', 1);
                    exit(AccessTok);
                END ELSE
                    exit('');
            END;
        END;
    END;

    procedure SendGSTSearchRequest(GSTN: Code[30]; var GSTName: Text; var GSTAddr: Text; var GStAddr2: Text; var GSTStCode: Code[40]; var GStpCode: Code[20]; var Status: Text)
    var

        APIIntegrationSetup: Record "Sales & Receivables Setup";
        APIResponse: Text;
        PostedSalesInv: Record "Sales Invoice Header";

        Month1: Integer;
        Year1: Integer;
        SalesInvHead: Record "Sales Invoice Header";
        lreLocation: Record Location;
        Body: Text;
        JSONManagement: Codeunit "JSON Management";
        gResponseMsg: Text;
        gRequestMsg: Text;
        gContent: HttpContent;
        gContentHeaders: HttpHeaders;
        gHttpClient: HttpClient;
        JsonText: Text;
        gHttpResponseMsg: HttpResponseMessage;
        gHttpRequestMsg: HttpRequestMessage;
        URL: Text;
        Body2: Text;
        Json: Text;
        SH: Record "Sales Invoice Header";
        URL1: Text[200];
        SCM: Record "Sales Cr.Memo Header";
        AccessTok: Text;
        JToken: JsonToken;
        ResultToken1: JsonToken;
        ResultToken2: JsonToken;
        ResultToken3: JsonToken;
        ResultToken4: JsonToken;
        ResultToken5: JsonToken;
        ResultToken6: JsonToken;
        ResultToken7: JsonToken;
        ResultToken8: JsonToken;
        ResultToken9: JsonToken;
        ResultToken10: JsonToken;

        ResultTok1: Text[1000];
        ResultTok2: Text[1000];
        ResultTok3: Text[1000];
        ResultTok4: Text[1000];
        ResultTok5: Text[1000];
        ResultTok6: Text[1000];
        ResultTok7: Text[1000];
        ResultTok8: Text[1000];
        ResultTok9: Text[1000];
    begin
        //  CLEARALL;
        CLEAR(APIResponse);
        Clear(gResponseMsg);
        Clear(ResultTok1);
        Clear(ResultTok2);
        Clear(ResultTok3);
        Clear(ResultTok4);
        Clear(ResultTok5);
        Clear(ResultTok6);
        Clear(ResultTok7);
        Clear(ResultTok8);
        Clear(ResultTok9);

        gContent.GetHeaders(gContentHeaders);
        gContentHeaders.Clear();
        gHttpClient.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + AccessTockenKey);
        gHttpClient.DefaultRequestHeaders.Add('client_id', 'QKCUuNMLRZnUgNQJJg');

        if gHttpClient.Get('https://commonapi.mastersindia.co/commonapis/searchgstin?gstin=' + GSTN, gHttpResponseMsg) then begin
            gHttpResponseMsg.Content.ReadAs(Json);
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                //    MESSAGE(Json);
                //IF (GetResponsesValue(Json, '"sts', ',', 1) = 'Active') THEN BEGIN
                AccessTok := GetResponsesValue(Json, '"access_token', ',', 1);
                /*
                   GSTName := GetResponsesValue(Json, '"tradeNam', ',', 1);
                   GSTAddr := GetResponsesValue(Json, '"st"', ',', 1) + ' ' + GetResponsesValue(Json, '"loc', ',', 1) + ' ' + GetResponsesValue(Json, '"city', ',', 1);
                   //        Message('%1..%2..%3', GetResponsesValue(Json, '"st"', ',', 1), GetResponsesValue(Json, '"loc', ',', 1), GetResponsesValue(Json, '"city', ',', 1));
                   GStAddr2 := GetResponsesValue(Json, '"bno', ',', 1) + ' ' + GetResponsesValue(Json, '"dst', ',', 1);
                   GStpCode := GetResponsesValue(Json, '"pncd', ',', 1);
                   GSTStCode := GetResponsesValue(Json, '"stcd', ',', 1);
                   Status := GetResponsesValue(Json, '"sts', ',', 1);
                   */
                //  JToken.SelectToken()

                JToken.ReadFrom(Json);
                if JToken.SelectToken(('data.tradeNam'), ResultToken1) then
                    if Not ResultToken1.AsValue().IsNull then
                        ResultTok1 := ResultToken1.AsValue().AsText();
                if JToken.SelectToken(('data.pradr.addr.st'), ResultToken2) then
                    if Not ResultToken2.AsValue().IsNull then
                        ResultTok2 := ResultToken2.AsValue().AsText();
                if JToken.SelectToken(('data.pradr.addr.loc'), ResultToken3) then
                    if Not ResultToken3.AsValue().IsNull then
                        ResultTok3 := ResultToken3.AsValue().AsText();
                if JToken.SelectToken(('data.pradr.addr.city'), ResultToken4) then begin
                    //Message('%1', (JToken.SelectToken(('data.pradr.addr.city'), ResultToken4)));
                    if Not ResultToken4.AsValue().IsNull then
                        ResultTok4 := ResultToken4.AsValue().AsText();
                END;
                if JToken.SelectToken(('data.pradr.addr.bno'), ResultToken5) then
                    if Not ResultToken5.AsValue().IsNull then
                        ResultTok5 := ResultToken5.AsValue().AsText();
                if JToken.SelectToken(('data.pradr.addr.dst'), ResultToken6) then
                    if Not ResultToken6.AsValue().IsNull then
                        ResultTok6 := ResultToken6.AsValue().AsText();
                if JToken.SelectToken(('data.pradr.addr.pncd'), ResultToken7) then
                    if Not ResultToken7.AsValue().IsNull then
                        ResultTok7 := ResultToken7.AsValue().AsText();
                if JToken.SelectToken(('data.pradr.addr.stcd'), ResultToken8) then
                    if Not ResultToken8.AsValue().IsNull then
                        ResultTok8 := ResultToken8.AsValue().AsText();
                if JToken.SelectToken(('data.sts'), ResultToken9) then
                    if Not ResultToken9.AsValue().IsNull then
                        ResultTok9 := ResultToken9.AsValue().AsText();
                if ResultTok9 <> 'Cancelled' then begin
                    GSTName := ResultTok1;
                    GSTAddr := ResultTok2 + ' ' + ResultTok3 + ' ' + ResultTok4;
                    //        Message('%1..%2..%3', GetResponsesValue(Json, '"st"', ',', 1), GetResponsesValue(Json, '"loc', ',', 1), GetResponsesValue(Json, '"city', ',', 1));
                    GStAddr2 := ResultTok5 + ' ' + ResultTok6;
                    GStpCode := ResultTok7;
                    GSTStCode := ResultTok8;
                    Status := ResultTok9;
                END;

                /*
                  END ELSE begin
                      JToken.ReadFrom(Json);
                      JToken.SelectToken(('data.sts'), ResultToken9);
                      Status := ResultToken9.AsValue().AsText();
                  end;
                  */
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



    procedure UpdateCustomer(CustomerNo: Code[30]; GSTNo: Text; VAR Status: Text; VAR Lastdate: Date; VAR GSTName: Text; VAR GSTAddr: Text; VAR GStAddr2: Text; VAR GSTStCode: text[50]; VAR GStpCode: Code[20]; Manual: Boolean)
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        Customer: Record Customer;
        GSTStCode1: Code[50];
    begin
        IF (GSTNo <> '') THEN BEGIN
            Customer.RESET;
            IF Customer.GET(CustomerNo) THEN BEGIN
                SalesReceivablesSetup.GET;
                IF SalesReceivablesSetup."GST Tocken" <> '' THEN BEGIN
                    IF SalesReceivablesSetup."Tocken Date" <> TODAY THEN BEGIN
                        AccessTockenKey := GetAccessToken;
                        //    SalesReceivablesSetup."Tocken Date" := TODAY;
                        //    SalesReceivablesSetup.MODIFY;
                        SendGSTSearchRequest(GSTNo, GSTName, GSTAddr, GStAddr2, GSTStCode1, GStpCode, Status);
                        GSTStCode := GSTStCode1;
                        Lastdate := Today;
                    END ELSE begin
                        SendGSTSearchRequest(GSTNo, GSTName, GSTAddr, GStAddr2, GSTStCode1, GStpCode, Status);
                        GSTStCode := GSTStCode1;
                        Lastdate := Today;
                    END;
                END ELSE BEGIN
                    AccessTockenKey := GetAccessToken;
                    //SalesReceivablesSetup."Tocken Date" := TODAY;
                    //SalesReceivablesSetup.MODIFY;
                    SendGSTSearchRequest(GSTNo, GSTName, GSTAddr, GStAddr2, GSTStCode1, GStpCode, Status);
                    GSTStCode := GSTStCode1;
                    Lastdate := Today;
                END;
            END;
        END ELSE BEGIN
            GSTName := '';
            GSTAddr := '';
            GStAddr2 := '';
            GStpCode := '';
            GSTStCode := '';
            Status := '';
            Lastdate := 0D;
            //MESSAGE('Invalid GST No.');
        END;
    END;

    LOCAL procedure UpdateAllVendor(VendNo: Code[20])
    var
        Vendor1: Record Vendor;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        Status: Text;
        Lastdate: Date;
        GSTName: Text;
        GSTAddr: Text;
        GStAddr2: Text;
        GSTStCode: Code[40];
        GStpCode: Code[20];
    begin
        Vendor1.RESET;
        Vendor1.SETRANGE(Vendor1."GST Vendor Type", Vendor1."GST Vendor Type"::Registered);
        IF VendNo <> '' THEN
            Vendor1.SETRANGE(Vendor1."No.", VendNo);
        IF Vendor1.FINDSET THEN BEGIN
            REPEAT
                SalesReceivablesSetup.RESET;
                SalesReceivablesSetup.GET;
                IF SalesReceivablesSetup."GST Tocken" = '' THEN BEGIN
                    AccessTockenKey := GetAccessToken;
                    //SalesReceivablesSetup."Tocken Date" := TODAY;
                    //SalesReceivablesSetup.MODIFY;
                END;
                SendGSTSearchRequest(Vendor1."GST Registration No.", GSTName, GSTAddr, GStAddr2, GSTStCode, GStpCode, Status);

                Vendor1."GST Name" := GSTName;
                Vendor1."GST Address" := GSTAddr;
                Vendor1."GST Address 2" := GStAddr2;
                Vendor1."GST Post Code" := GStpCode;
                Vendor1."GST State Code" := GSTStCode;
                Vendor1."GST Status" := Status;
                Vendor1."Last Updated Date" := TODAY;
                Vendor1.MODIFY;
            UNTIL Vendor1.NEXT = 0;
        END;
    END;
}