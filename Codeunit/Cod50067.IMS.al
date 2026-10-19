codeunit 50067 IMS
{
    trigger OnRun()
    begin

    end;



    procedure GetAccessToken(DocNo: Code[20]; Status: Text): Text
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
        i: Integer;
        Section: Text;
    begin
        CLEARALL;
        CLEAR(APIResponse);
        Body := '{' +
          '"username":"' + 'sumandev@sampoornafeeds.in' + '",' +
          '"password":"' + 'Goodluck@12India' + '"' +
       //'"client_id":"' + 'QKCUuNMLRZnUgNQJJg' + '",' +
       //'"client_secret":"' + 'UGelnP6hP1bbroywvbpNyneL' + '",' +
       //'"grant_type":"' + 'password' + '"' +
       '}';



        //MESSAGE(APIResponse);
        Clear(AccessTok);
        Clear(gResponseMsg);
        gContent.WriteFrom(Body);
        gContent.GetHeaders(gContentHeaders);
        gContentHeaders.Clear();
        gContentHeaders.Add('Content-Type', 'application/json');
        if gHttpClient.Post('https://prod-api.mastersindia.co/api/v1/token-auth/', gContent, gHttpResponseMsg) then begin
            gHttpResponseMsg.Content.ReadAs(Json);
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                // MESSAGE(Json);
                IF (GetResponsesValue(Json, '"token', ',', 1) <> '') THEN BEGIN
                    AccessTok := GetResponsesValue(Json, '"token', ',', 1);
                    // Message(AccessTok);
                    i := 0;
                    repeat
                        i += 1;
                        if i = 1 then
                            Section := 'B2B'
                        else
                            if i = 2 then
                                Section := 'B2BA'
                            Else
                                if i = 3 then
                                    Section := 'CN'
                                Else
                                    if i = 4 then
                                        Section := 'CNA'
                                    Else
                                        if i = 5 then
                                            Section := 'DN'
                                        Else
                                            if i = 6 then
                                                Section := 'DNA'
                                            Else
                                                if i = 7 then
                                                    Section := 'ECOM'
                                                Else
                                                    if i = 8 then
                                                        Section := 'ECOMA';
                        // 'B2B /B2BA/CN/CNA/DN/DNA/ECOM/ECOMA'
                        SendRequest(DocNo, AccessTok, Section, Status);
                    until i = 8;
                    exit(AccessTok);
                END
                // ELSE
                //     ERROR('Please see Reason %1', JsonText);
            END;
        END;
    END;

    procedure SendRequest(Doc: Code[20]; AccessTok: Text; Section: Text; Status: Text)
    var
        APIIntegrationSetup: Record "Sales & Receivables Setup";
        APIResponse: Text;
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
        URL1: Text[200];
        jObject: JsonObject;
        JToke: JsonToken;
        JArray: JsonArray;
        JobjectText: Text;
        JResultObject: JsonObject;
        ElementJsonArray: JsonArray;
        JResultToken: JsonToken;
        i: Integer;
        Jtoken: JsonToken;
        ResponseGstregNo: Record ResponseGstRegistration;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        Clear(jObject);

        jObject.Add('action', 'GETINV');
        jObject.Add('gstin', Doc);
        // jObject.Add('section', 'B2B');
        jObject.Add('section', Section);
        jObject.Add('status', Status);
        jObject.Add('goods_typ', 'ALL_OTH');
        jObject.Add('int_tran_id', 'string');// To discuss
        jObject.Add('token', 'string');// To discuss
        jObject.WriteTo(JobjectText);
        URL := 'https://prod-api.mastersindia.co/api/v1/gstins/' + Doc + '/documents/ims/';
        ClearLastError();
        Clear(gResponseMsg);
        gContent.GetHeaders(gContentHeaders);
        gContent.WriteFrom(JobjectText);
        gContentHeaders.Remove('Content-Type');
        gContentHeaders.Add('Content-Type', 'application/json');
        gHttpClient.DefaultRequestHeaders.add('Authorization', 'JWT ' + AccessTok);
        gHttpRequestMsg.SetRequestUri(URL);
        gHttpRequestMsg.Content := gContent;
        gHttpRequestMsg.Method('GET');
        if gHttpClient.Send(gHttpRequestMsg, gHttpResponseMsg) then begin
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                gHttpResponseMsg.Content.ReadAs(gResponseMsg);
                IF (GetResponsesValue(gResponseMsg, '"message', ',', 1) = 'Success') THEN BEGIN
                    //Message(gRequestMsg);
                    gResponseMsg := GetResponsesValue(gResponseMsg, '"data', ',', 1);

                    // JResultObject.ReadFrom(gResponseMsg);
                    gResponseMsg := Base64Convert.FromBase64(gResponseMsg);

                    JResultObject.ReadFrom(gResponseMsg);
                    if JResultObject.Get('b2b', JResultToken) or JResultObject.Get('b2ba', JResultToken)
                    or JResultObject.Get('b2bdn', JResultToken) or JResultObject.Get('b2bdna', JResultToken)
                    or JResultObject.Get('b2bcn', JResultToken) or JResultObject.Get('b2bcna', JResultToken)
                    or JResultObject.Get('ecom', JResultToken) or JResultObject.Get('ecoma', JResultToken) then begin
                        ElementJsonArray := JResultToken.AsArray();
                        //Message('%1', ElementJsonArray.Count);
                        for i := 0 to ElementJsonArray.Count() - 1 do begin
                            ElementJsonArray.Get(i, Jtoken);
                            JObject := Jtoken.AsObject();
                            JObject.Get('hash', Jtoken);
                            ResponseGstregNo.Reset();
                            if Jtoken.AsValue().AsCode() <> '' then
                                if not ResponseGstregNo.Get(Jtoken.AsValue().AsCode()) then begin
                                    ResponseGstregNo.Init();
                                    ResponseGstregNo.hash := Jtoken.AsValue().AsCode();
                                    ResponseGstregNo.Insert();
                                    JObject.Get('val', Jtoken);
                                    ResponseGstregNo.val := Jtoken.AsValue().AsDecimal();
                                    JObject.Get('samt', Jtoken);
                                    ResponseGstregNo.samt := Jtoken.AsValue().AsDecimal();
                                    JObject.Get('txval', Jtoken);
                                    ResponseGstregNo.txval := Jtoken.AsValue().AsDecimal();
                                    JObject.Get('rtnprd', Jtoken);
                                    ResponseGstregNo.rtnprd := Jtoken.AsValue().AsText();
                                    JObject.Get('camt', Jtoken);
                                    ResponseGstregNo.camt := Jtoken.AsValue().AsDecimal();
                                    If (Section = 'CN') or (Section = 'DN') or (Section = 'CNA') or (Section = 'DNA') Then
                                        JObject.Get('nt_num', Jtoken)
                                    else
                                        JObject.Get('inum', Jtoken);
                                    ResponseGstregNo.inum := Jtoken.AsValue().AsText();

                                    JObject.Get('cess', Jtoken);
                                    ResponseGstregNo.cess := Jtoken.AsValue().AsDecimal();
                                    JObject.Get('srcfilstatus', Jtoken);
                                    ResponseGstregNo.srcfilstatus := Jtoken.AsValue().AsText();
                                    JObject.Get('iamt', Jtoken);
                                    ResponseGstregNo.iamt := Jtoken.AsValue().AsDecimal();
                                    JObject.Get('stin', Jtoken);
                                    ResponseGstregNo.stin := Jtoken.AsValue().AsCode();
                                    JObject.Get('srcform', Jtoken);
                                    ResponseGstregNo.srcform := Jtoken.AsValue().AsText();
                                    If Section <> 'ECOM' Then begin
                                        JObject.Get('inv_typ', Jtoken);
                                        ResponseGstregNo.inv_typ := Jtoken.AsValue().AsText();
                                    end;
                                    JObject.Get('pos', Jtoken);
                                    ResponseGstregNo.pos := Jtoken.AsValue().AsText();
                                    If (Section = 'CN') or (Section = 'DN') or (Section = 'CNA') or (Section = 'DNA') Then
                                        JObject.Get('nt_dt', Jtoken)
                                    Else
                                        JObject.Get('idt', Jtoken);
                                    ResponseGstregNo.idt := Jtoken.AsValue().AsText();
                                    JObject.Get('action', Jtoken);
                                    ResponseGstregNo.action := Jtoken.AsValue().AsText();
                                    JObject.Get('ispendactblocked', Jtoken);
                                    ResponseGstregNo.ispendactblocked := Jtoken.AsValue().AsText();
                                    If (Section = 'B2BA') or (Section = 'ECOMA') Then begin
                                        //or (Section = 'CNA') or (Section = 'DNA') Or
                                        JObject.Get('oinum', Jtoken);
                                        ResponseGstregNo.oinum := Jtoken.AsValue().AsText();
                                        JObject.Get('oidt', Jtoken);
                                        ResponseGstregNo.oidt := Jtoken.AsValue().AsText();
                                    end;
                                    ResponseGstregNo."GST Registation No." := Doc;
                                    If Section = 'B2B' then
                                        ResponseGstregNo.Section := 'b2b'
                                    else
                                        If Section = 'B2BA' then
                                            ResponseGstregNo.Section := 'b2ba'
                                        Else
                                            If Section = 'CN' then
                                                ResponseGstregNo.Section := 'b2bcn'
                                            Else
                                                If Section = 'CNA' then
                                                    ResponseGstregNo.Section := 'b2bcna'
                                                Else
                                                    If Section = 'DN' then
                                                        ResponseGstregNo.Section := 'b2bdn'
                                                    Else
                                                        If Section = 'DNA' then
                                                            ResponseGstregNo.Section := 'b2bdna'
                                                        Else
                                                            If Section = 'ECOM' then
                                                                ResponseGstregNo.Section := 'ecom'
                                                            Else
                                                                If Section = 'ECOMA' then
                                                                    ResponseGstregNo.Section := 'ecoma';

                                    ResponseGstregNo.Modify();
                                end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    procedure SyncGstRegistrationNo(DOC: Code[20])
    var
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
        URL1: Text[200];
        jObject: JsonObject;
        JToke: JsonToken;
        JArray: JsonArray;
        JobjectText: Text;
        JResultObject: JsonObject;
        ElementJsonArray: JsonArray;
        JResultToken: JsonToken;
        i: Integer;
        Jtoken: JsonToken;
        AccessTok: Text;
        invdatajobj: JsonObject;
        b2bjarray: JsonArray;
        Base64: Codeunit "Base64 Convert";
        TransactionrefNn: Text;
        Rec: Record ResponseGstRegistration;

        // Progress Window Variables
        Window: Dialog;
        Counter: Integer;
        TotalCount: Integer;
        ProgressMsg: Label 'Syncing IMS Records...\GSTIN (DOC): #1############\Total Records: #2######\Processed: #3######';
    begin
        Clear(AccessTok);
        AccessTok := GenerateToken();

        Rec.Reset();
        Rec.SetRange(Sync, false);
        Rec.SetFilter("ERP Status", '%1|%2', Rec."ERP Status"::Accepted, Rec."ERP Status"::Pending);
        Rec.SetRange("GST Registation No.", DOC);
        //Rec.SetRange(hash, '69562BB33C57C6A30C77616539DBE551125D60A0CCD4435AF92160FB22129DDD');
        if Rec.FindSet() then begin
            TotalCount := Rec.Count();
            Counter := 0;

            // Open Dialog Box
            Window.Open(ProgressMsg);
            Window.Update(1, DOC);
            Window.Update(2, TotalCount); // Pass the DOC parameter to display in placeholder #3

            repeat
                Counter += 1;
                Window.Update(3, Counter); // Updates live on each record

                Clear(jObject);
                Clear(invdatajobj);
                Clear(b2bjarray);
                createb2bjarray(b2bjarray, DOC, Rec.inum, Rec.hash);

                invdatajobj.Add(Rec.Section, b2bjarray); // To discuss
                jObject.Add('rtin', DOC);
                jObject.Add('reqtyp', 'SAVE');
                jObject.Add('invdata', invdatajobj);
                jObject.WriteTo(JobjectText);
                URL := 'https://prod-api.mastersindia.co/api/v1/gstins/' + DOC + '/documents/ims/?action=SAVE&gstin=' + DOC;

                ClearLastError();
                Clear(gResponseMsg);
                Clear(gContent);
                Clear(gContentHeaders);
                Clear(gHttpClient);
                Clear(gHttpRequestMsg);
                Clear(TransactionrefNn);
                gContent.GetHeaders(gContentHeaders);
                gContent.WriteFrom(JobjectText);
                gContentHeaders.Remove('Content-Type');
                gContentHeaders.Add('Content-Type', 'application/json');
                gHttpClient.DefaultRequestHeaders.add('Authorization', 'JWT ' + AccessTok);
                gHttpRequestMsg.SetRequestUri(URL);
                gHttpRequestMsg.Content := gContent;
                gHttpRequestMsg.Method('PUT');
                if gHttpClient.Send(gHttpRequestMsg, gHttpResponseMsg) then begin
                    if gHttpResponseMsg.IsSuccessStatusCode then begin
                        gHttpResponseMsg.Content.ReadAs(gResponseMsg);
                        IF (GetResponsesValue(gResponseMsg, 'status', ',', 1) = '1') THEN BEGIN
                            TransactionrefNn := Base64.FromBase64(GetResponsesValue(gResponseMsg, 'data', ',', 1));
                            TransactionrefNn := GetResponsesValue(TransactionrefNn, 'reference_id', ',', 1);
                            Rec."Reposne Message" := GetIMSstatus(DOC, AccessTok, TransactionrefNn);
                            Rec."Tran Ref No." := TransactionrefNn;
                            If Rec."Reposne Message" = 'A' then
                                Rec.Sync := True
                            else
                                if Rec."Reposne Message" = 'P' then
                                    Rec.Sync := True;
                            Rec.Modify();

                        end;
                    end;
                end;
                if rec.Sync then
                    Rec.Delete();
            Until Rec.Next() = 0;

            Window.Close();
            //Message('Sync completed successfully for GSTIN %1. Total records processed: %2', DOC, Counter);
        end;
    end;

    // procedure SyncGstRegistrationNo(DOC: Code[20])
    // var
    //     gResponseMsg: Text;
    //     gRequestMsg: Text;
    //     gContent: HttpContent;
    //     gContentHeaders: HttpHeaders;
    //     gHttpClient: HttpClient;
    //     JsonText: Text;
    //     gHttpResponseMsg: HttpResponseMessage;
    //     gHttpRequestMsg: HttpRequestMessage;
    //     URL: Text;
    //     Body2: Text;
    //     Json: Text;
    //     URL1: Text[200];
    //     jObject: JsonObject;
    //     JToke: JsonToken;
    //     JArray: JsonArray;
    //     JobjectText: Text;
    //     JResultObject: JsonObject;
    //     ElementJsonArray: JsonArray;
    //     JResultToken: JsonToken;
    //     i: Integer;
    //     Jtoken: JsonToken;
    //     AccessTok: Text;
    //     invdatajobj: JsonObject;
    //     b2bjarray: JsonArray;
    //     Base64: Codeunit "Base64 Convert";
    //     TransactionrefNn: Text;
    //     Rec: Record ResponseGstRegistration;


    // begin

    //     Clear(AccessTok);
    //     AccessTok := GenerateToken();


    //     Rec.Reset();
    //     Rec.SetRange(Sync, false);
    //     Rec.SetFilter("ERP Status", '%1|%2', Rec."ERP Status"::Accepted, Rec."ERP Status"::Pending);
    //     Rec.SetRange("GST Registation No.", DOC);
    //     //Rec.SetRange(hash, '69562BB33C57C6A30C77616539DBE551125D60A0CCD4435AF92160FB22129DDD');
    //     if Rec.FindSet() then
    //         repeat
    //             Clear(jObject);
    //             Clear(invdatajobj);
    //             Clear(b2bjarray);
    //             createb2bjarray(b2bjarray, DOC, Rec.inum, Rec.hash);

    //             invdatajobj.Add(Rec.Section, b2bjarray); // To discuss
    //             jObject.Add('rtin', DOC);
    //             jObject.Add('reqtyp', 'SAVE');
    //             jObject.Add('invdata', invdatajobj);
    //             jObject.WriteTo(JobjectText);
    //             URL := 'https://prod-api.mastersindia.co/api/v1/gstins/' + DOC + '/documents/ims/?action=SAVE&gstin=' + DOC;

    //             ClearLastError();
    //             Clear(gResponseMsg);
    //             Clear(gContent);
    //             Clear(gContentHeaders);
    //             Clear(gHttpClient);
    //             Clear(gHttpRequestMsg);
    //             Clear(TransactionrefNn);
    //             gContent.GetHeaders(gContentHeaders);
    //             gContent.WriteFrom(JobjectText);
    //             gContentHeaders.Remove('Content-Type');
    //             gContentHeaders.Add('Content-Type', 'application/json');
    //             gHttpClient.DefaultRequestHeaders.add('Authorization', 'JWT ' + AccessTok);
    //             gHttpRequestMsg.SetRequestUri(URL);
    //             gHttpRequestMsg.Content := gContent;
    //             gHttpRequestMsg.Method('PUT');
    //             if gHttpClient.Send(gHttpRequestMsg, gHttpResponseMsg) then begin
    //                 if gHttpResponseMsg.IsSuccessStatusCode then begin
    //                     gHttpResponseMsg.Content.ReadAs(gResponseMsg);
    //                     IF (GetResponsesValue(gResponseMsg, 'status', ',', 1) = '1') THEN BEGIN
    //                         TransactionrefNn := Base64.FromBase64(GetResponsesValue(gResponseMsg, 'data', ',', 1));
    //                         TransactionrefNn := GetResponsesValue(TransactionrefNn, 'reference_id', ',', 1);
    //                         Rec."Reposne Message" := GetIMSstatus(DOC, AccessTok, TransactionrefNn);
    //                         Rec."Tran Ref No." := TransactionrefNn;
    //                         If Rec."Reposne Message" = 'A' then
    //                             Rec.Sync := True
    //                         else
    //                             if Rec."Reposne Message" = 'P' then
    //                                 Rec.Sync := True;
    //                         Rec.Modify();

    //                     end;
    //                 end;
    //             end;
    //             if rec.Sync then
    //                 Rec.Delete();
    //         Until Rec.Next() = 0;
    // end;

    procedure createb2bjarray(var b2bjarray: JsonArray; GSTIN: Code[20]; Invoiceno: Text[20]; HAS: Code[100])
    var
        Rec: Record ResponseGstRegistration;
        jsonobj: JsonObject;
    begin
        Rec.Reset();
        Rec.SetRange(Sync, false);
        Rec.SetFilter("ERP Status", '%1|%2', Rec."ERP Status"::Accepted, Rec."ERP Status"::Pending);
        Rec.SetRange("GST Registation No.", GSTIN);
        Rec.SetRange(hash, HAS);
        //Rec.SetRange(hash, '69562BB33C57C6A30C77616539DBE551125D60A0CCD4435AF92160FB22129DDD');
        Rec.SetRange(inum, Invoiceno);
        if Rec.FindSet() then
            repeat
                Clear(jsonobj);
                if (rec.Section = 'b2b') or (rec.Section = 'b2bcn') or (rec.Section = 'b2bdn') or (rec.Section = 'ecom') Then begin
                    jsonobj.Add('stin', Format(Rec.stin));
                    //jsonobj.Add('itcRedReq', 'Y');
                    If (Rec.Section = 'b2b') or (Rec.Section = 'b2ba') or (Rec.Section = 'ecom') or (Rec.Section = 'ecoma') Then
                        jsonobj.Add('inum', Format(Rec.inum))
                    else
                        jsonobj.Add('nt_num', Format(Rec.inum));
                    jsonobj.Add('inv_typ', Format(Rec.inv_typ));
                    if Rec."ERP Status" = Rec."ERP Status"::Accepted then
                        jsonobj.Add('action', 'A'); // A - approve ,p - ppending
                    if Rec."ERP Status" = Rec."ERP Status"::Pending then
                        jsonobj.Add('action', 'P');
                    jsonobj.Add('srcform', Format(Rec.srcform));
                    jsonobj.Add('rtnprd', Format(Rec.rtnprd));
                    If (Rec.Section = 'b2b') or (Rec.Section = 'b2ba') or (Rec.Section = 'ecom') or (Rec.Section = 'ecoma') Then
                        jsonobj.Add('idt', Format(Rec.idt))
                    else
                        jsonobj.Add('nt_dt', Format(Rec.idt));
                    jsonobj.Add('val', (Rec.val));
                    jsonobj.Add('pos', Format(Rec.pos));
                    jsonobj.Add('txval', (Rec.txval));
                    jsonobj.Add('iamt', (Rec.iamt));
                    jsonobj.Add('camt', (Rec.camt));
                    jsonobj.Add('samt', (Rec.samt));
                    jsonobj.Add('cess', (Rec.cess));
                    jsonobj.Add('prev_status', Format(Rec.action));
                    //jsonobj.Add('remarks', '');
                end else begin
                    jsonobj.Add('oinum', Format(Rec.oinum));
                    jsonobj.Add('oidt', Format(Rec.oidt));
                    jsonobj.Add('stin', Format(Rec.stin));
                    jsonobj.Add('rtnprd', Format(Rec.rtnprd));
                    jsonobj.Add('inum', Format(Rec.inum));
                    if Rec."ERP Status" = Rec."ERP Status"::Accepted then
                        jsonobj.Add('action', 'A'); // A - approve ,p - ppending
                    if Rec."ERP Status" = Rec."ERP Status"::Pending then
                        jsonobj.Add('action', 'P');
                    jsonobj.Add('inv_typ', Format(Rec.inv_typ));
                    jsonobj.Add('srcform', Format(Rec.srcform));
                    jsonobj.Add('idt', Format(Rec.idt));
                    jsonobj.Add('val', (Rec.val));
                    jsonobj.Add('pos', Format(Rec.pos));
                    jsonobj.Add('txval', (Rec.txval));
                    jsonobj.Add('iamt', (Rec.iamt));
                    jsonobj.Add('camt', (Rec.camt));
                    jsonobj.Add('samt', (Rec.samt));
                    jsonobj.Add('cess', (Rec.cess));
                    jsonobj.Add('prev_status', Format(Rec.action));
                    //jsonobj.Add('remarks', '');

                end;


                b2bjarray.Add(jsonobj);
            until Rec.Next() = 0;
    end;

    local procedure RemoveComma(String: Text): Text
    begin
        Exit(DelChr(String, '=', ','));
    end;

    procedure GetIMSstatus(GSTN: Code[20]; Token: Text; TransrefNo: Text): Text
    var
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
        URL1: Text[200];
        jObject: JsonObject;
        JToke: JsonToken;
        JArray: JsonArray;
        JobjectText: Text;
        JResultObject: JsonObject;
        ElementJsonArray: JsonArray;
        JResultToken: JsonToken;
        i: Integer;
        Jtoken: JsonToken;
        AccessTok: Text;
        Base64: Codeunit "Base64 Convert";
        Response: Text;
        ResponseValue: Text;


    Begin
        URL := 'https://prod-api.mastersindia.co/api/v1/gstins/' + GSTN + '/documents/ims/?action=REQSTS&gstin=' + GSTN + '&int_tran_id=' + TransrefNo;


        ClearLastError();
        Clear(gResponseMsg);
        gContent.GetHeaders(gContentHeaders);
        // gContent.WriteFrom(JobjectText);
        gContentHeaders.Remove('Content-Type');
        gContentHeaders.Add('Content-Type', 'application/json');
        gHttpClient.DefaultRequestHeaders.add('Authorization', 'JWT ' + Token);
        gHttpRequestMsg.SetRequestUri(URL);
        gHttpRequestMsg.Content := gContent;
        gHttpRequestMsg.Method('GET');
        if gHttpClient.Send(gHttpRequestMsg, gHttpResponseMsg) then begin
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                gHttpResponseMsg.Content.ReadAs(gResponseMsg);
                IF (GetResponsesValue((gResponseMsg), 'status', ',', 1) = '1') THEN BEGIN
                    Response := Base64.FromBase64(GetResponsesValue(gResponseMsg, 'data', ',', 1));
                    if (GetResponsesValue((Response), 'proc_cnt', ',', 1) = '1') then
                        ResponseValue := GetResponsesValue((Response), 'status_cd', ',', 1);
                    if (GetResponsesValue((Response), 'err_cnt', ',', 1) = '1') then begin
                        ResponseValue := GetResponsesValueForErrror((Response), 'err_msg', ',', 1);

                        if GetResponsesValueForErrror((Response), 'err_msg', ',', 1) = '' then
                            ResponseValue := GetResponsesValueForErrror((Response), 'error_msg', ',', 1);

                    end;
                    exit(ResponseValue)
                    //TransactionrefNn := Base64.FromBase64(GetResponsesValue(TransactionrefNn, 'reference_id', ',', 1));
                    //{"transTypCd":"SAV","proc_cnt":"1","status_cd":"P","err_cnt":"0"}
                End;
            end;
        end;
    end;

    procedure GenerateToken(): Text
    var
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
        APIResponse: Text;
        Body: Text;
        AccessTok: Text;
    begin
        CLEARALL;
        CLEAR(APIResponse);
        Body := '{' +
          '"username":"' + 'sumandev@sampoornafeeds.in' + '",' +
          '"password":"' + 'Goodluck@12India' + '"' +
       //'"client_id":"' + 'QKCUuNMLRZnUgNQJJg' + '",' +
       //'"client_secret":"' + 'UGelnP6hP1bbroywvbpNyneL' + '",' +
       //'"grant_type":"' + 'password' + '"' +
       '}';



        //MESSAGE(APIResponse);
        Clear(AccessTok);
        Clear(gResponseMsg);
        gContent.WriteFrom(Body);
        gContent.GetHeaders(gContentHeaders);
        gContentHeaders.Clear();
        gContentHeaders.Add('Content-Type', 'application/json');
        if gHttpClient.Post('https://prod-api.mastersindia.co/api/v1/token-auth/', gContent, gHttpResponseMsg) then begin
            gHttpResponseMsg.Content.ReadAs(Json);
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                // MESSAGE(Json);
                IF (GetResponsesValue(Json, '"token', ',', 1) <> '') THEN BEGIN
                    AccessTok := GetResponsesValue(Json, '"token', ',', 1);
                    exit(AccessTok);
                END
                // ELSE
                //     ERROR('Please see Reason %1', JsonText);
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

    procedure GetResponsesValueForErrror(resp3: Text; Lstr: Text; Strng: Text; Cnt: Integer): Text
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
            //Resp1 := DELCHR(Resp1, '=');
        Resp1 := DELCHR(Resp1, '=', '"');
        Resp1 := DELCHR(Resp1, '<', ':');
        Resp1 := DELCHR(Resp1, '=', '\');
        EXIT(UpperCase(Resp1));
    END;


    procedure UpdateStatus()
    var
        PostPurchInv: Record "Purch. Inv. Header";
        PostPurchCrMemo: Record "Purch. Cr. Memo Hdr.";
        TransRecheader: Record "Transfer Receipt Header";
        GSTRegresponse: Record ResponseGstRegistration;
    begin
        GSTRegresponse.Reset();
        GSTRegresponse.SetFilter("ERP Status", '<>%1', GSTRegresponse."ERP Status"::Accepted);
        if GSTRegresponse.FindSet() then
            repeat
                PostPurchInv.Reset();
                PostPurchInv.SetRange("Vendor Invoice No.", GSTRegresponse.inum);
                if PostPurchInv.FindFirst() then
                    GSTRegresponse.Validate("ERP Status", GSTRegresponse."ERP Status"::Accepted);

                PostPurchCrMemo.Reset();
                PostPurchCrMemo.SetRange("Vendor Cr. Memo No.", GSTRegresponse.inum);
                if PostPurchCrMemo.FindFirst() then
                    GSTRegresponse.Validate("ERP Status", GSTRegresponse."ERP Status"::Accepted);

                TransRecheader.Reset();
                TransRecheader.SetRange("External Document No.", GSTRegresponse.inum);
                if TransRecheader.FindFirst() then
                    GSTRegresponse.Validate("ERP Status", GSTRegresponse."ERP Status"::Accepted);

                GSTRegresponse.Modify();
            until GSTRegresponse.Next() = 0;
    end;

    procedure OTPReqeust("GSTNo": Code[20]; "UserName": Text)
    Var
        APIResponse: Text;
        Body: Text;

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
        AccessTok: Text;
        OTPDilog: Page "GST OTP Dialog Page";
    begin

        Body2 := '{' +
                  '"action":"' + 'OTPREQUEST' + '",' +
                  '"gst_username":"' + "UserName" + '"' +
               '}';

        URL := 'https://prod-api.mastersindia.co/api/v1/gstins/' + GSTNo + '/otp/';
        ClearLastError();
        Clear(gResponseMsg);
        gContent.GetHeaders(gContentHeaders);
        gContent.WriteFrom(Body2);
        gContentHeaders.Remove('Content-Type');
        gContentHeaders.Add('Content-Type', 'application/json');
        gHttpClient.DefaultRequestHeaders.add('Authorization', 'JWT ' + GenerateToken());
        gHttpRequestMsg.SetRequestUri(URL);
        gHttpRequestMsg.Content := gContent;
        gHttpRequestMsg.Method('POST');
        if gHttpClient.Send(gHttpRequestMsg, gHttpResponseMsg) then begin
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                gHttpResponseMsg.Content.ReadAs(gResponseMsg);
                IF (GetResponsesValue(gResponseMsg, 'message', ',', 1) = 'OTPsentsuccessfully') THEN BEGIN
                    Clear(OtpDilog);
                    OtpDilog.StoreOTP(GSTNo, UserName);
                    OtpDilog.RunModal();
                end else
                    if GetResponsesValueForErrror(gResponseMsg, 'message', ',', 1) <> '' Then
                        Message(GetResponsesValueForErrror(gResponseMsg, 'message', ',', 1))
                    Else
                        Message(GetResponsesValueForErrror(gResponseMsg, 'ErrorMessage', ',', 1))


            end;
        end;

    END;

    procedure OTPVarify("GSTNo": Code[20]; "UserName": Text; OTP: Code[6]): Text
    Var
        APIResponse: Text;
        Body: Text;

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
        AccessTok: Text;
        OTPDilog: Page "GST OTP Dialog Page";
    begin

        Body2 := '{' +
                  '"action":"' + 'OTPVERIFY' + '",' +
                  '"gst_username":"' + "UserName" + '",' +
                  '"otp":"' + "OTP" + '"' +
               '}';

        URL := 'https://prod-api.mastersindia.co/api/v1/gstins/' + GSTNo + '/otp/';
        ClearLastError();
        Clear(gResponseMsg);
        gContent.GetHeaders(gContentHeaders);
        gContent.WriteFrom(Body2);
        gContentHeaders.Remove('Content-Type');
        gContentHeaders.Add('Content-Type', 'application/json');
        gHttpClient.DefaultRequestHeaders.add('Authorization', 'JWT ' + GenerateToken());
        gHttpRequestMsg.SetRequestUri(URL);
        gHttpRequestMsg.Content := gContent;
        gHttpRequestMsg.Method('POST');
        if gHttpClient.Send(gHttpRequestMsg, gHttpResponseMsg) then begin
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                gHttpResponseMsg.Content.ReadAs(gResponseMsg);
                if (GetResponsesValue(gResponseMsg, 'message', ',', 1)) = 'OTPhasverifiedsuccessfully' Then
                    Exit(GetResponsesValue(gResponseMsg, 'message', ',', 1))
                Else
                    Exit(GetResponsesValueForErrror(gResponseMsg, 'message', ',', 1))



            end;
        end;

    END;
}