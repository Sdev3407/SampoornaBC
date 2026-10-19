codeunit 50004 "Update User Setup"
{
    SingleInstance = true;

    trigger OnRun()
    var
        T91: Record 91;
        Customer: Record Customer;
        Companyinfo: Record "Company Information";
        Webuser: Record WebUsers;
    begin
        Companyinfo.Get;

        T91.RESET;
        T91.SETFILTER(T91."Date Freeze", '<>%1', TRUE);
        T91.SETFILTER("User ID", '<>%1', 'JOBQUEUE');
        IF T91.FINDSET THEN
            REPEAT
                T91."Allow Posting From" := (TODAY - T91."Day Aceess");
                T91."Allow Posting To" := TODAY;
                T91."Tax Details Permission" := False;
                T91.MODIFY;
            UNTIL T91.NEXT = 0;
        if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::"Star Foods"] then begin
            T91.RESET;
            T91.SETFilter("User ID", '%1|%2', 'STF21030', 'STF21029');
            IF T91.FINDSET THEN
                REPEAT
                    T91."Allow Posting From" := (TODAY - T91."Day Aceess");
                    T91."Allow Posting To" := (TODAY + 1);
                    T91.MODIFY;
                UNTIL T91.NEXT = 0;
        end;

        Webuser.Reset();
        Webuser.SetFilter("User Name", '<>%1', 'JOBQUEUE');
        Webuser.SetRange("Sales Person", false);
        Webuser.SetRange("Sales Team", false);
        Webuser.SetRange("Date Freeze", false);
        if Webuser.FindFirst() then
            repeat
                Webuser."Allow Posting From" := (Today - Webuser."Days Access");
                Webuser."Allow Posting To" := Today;
                Webuser.Modify();
            Until Webuser.Next() = 0;
        // if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] Then
        //     ExpiredPO();
        InventHRMSGETEmployee();

    end;





    procedure ExpiredPO()
    var
        PurhHeader: record "Purchase Header";
        PurchLine: Record "Purchase Line";
        Time: Time;
    begin
        PurhHeader.Reset();
        PurhHeader.SetRange("Document Type", PurhHeader."Document Type"::Order);
        //PurhHeader.SetRange(Status, PurhHeader.Status::Released);
        PurhHeader.SetFilter("PO Expiration Date", '..%1', (WorkDate() - 1));
        PurhHeader.SetRange("Document Type", PurhHeader."Document Type"::Order);
        PurhHeader.SetRange("PO Type", PurhHeader."PO Type"::Goods);
        if PurhHeader.FindFirst() Then
            repeat
                PurchLine.Reset();
                PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
                PurchLine.SetRange("Document No.", PurhHeader."No.");
                PurchLine.SetRange("Item Category Code", 'RM');
                if PurchLine.FindFirst() Then begin
                    PurhHeader.Status := PurhHeader.Status::Expired;
                    PurhHeader.Modify();
                end;
            Until PurhHeader.Next() = 0;
        // Time := DT2Time(CurrentDateTime);
        // If Format(Time) = '10:00 AM' Then
        PurhHeader.Reset();
        PurhHeader.SetRange("Document Type", PurhHeader."Document Type"::Order);
        PurhHeader.SetRange(Status, PurhHeader.Status::Open);
        PurhHeader.SetRange("Document Type", PurhHeader."Document Type"::Order);
        PurhHeader.SetFilter("Vendor Posting Group", '<>%1', 'INTER BRANCH TRANSFE');
        PurhHeader.SetRange("Order Date", WorkDate() - 1);
        if PurhHeader.FindFirst() Then
            repeat
                PurhHeader.Block := True;
                PurhHeader.Status := PurhHeader.Status::Expired;
                PurhHeader.Modify();
            until PurhHeader.Next() = 0;

    end;

    procedure InventHRMSGETEmployee()
    var
        URL: text;
        gResponseMsg: Text;
        gRequestMsg: Text;
        gContent: HttpContent;
        gContentHeaders: HttpHeaders;
        gHttpClient: HttpClient;
        gHttpResponseMsg: HttpResponseMessage;
        gHttpRequestMsg: HttpRequestMessage;
        Jobject: JsonObject;
        Json: Text;
        JResultObject: JsonObject;
        Companyinfo: Record "Company Information";
        CompCode: Text;
    Begin
        Companyinfo.Get;
        if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] then
            CompCode := 'SAM'
        else
            CompCode := 'STF';


        URL := 'https://sampoorna.inventhrms.com/custom-api/employee-master.php?status=active&join_date_from=' + Format((WorkDate() - 30), 0, '<Year4>-<Month,2>-<Day,2>') + '&company=' + CompCode;

        gHttpRequestMsg.Method := 'GET';
        gHttpRequestMsg.SetRequestUri(URL);
        // Set headers

        gContent.GetHeaders(gContentHeaders);

        gContentHeaders.Clear();
        gContentHeaders.Add('X-API-KEY', 'c611d0888b6d78e218e5e274a19a2ff40346687bfe91a87896378e8a6c329f19');

        //gContent.GetHeaders(gContentHeaders);
        gHttpRequestMsg.Content := gContent;
        // Send request
        if gHttpClient.Send(gHttpRequestMsg, gHttpResponseMsg) then begin
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                gHttpResponseMsg.Content.ReadAs(Json);
                ProcessJsonAndInsertIntoTableInvent(json);
                //ProcessJsonAndInsertIntoTable(GetResponsesValue(Json, '"data', ':', 1));

            end;
        end;


    End;



    // This is the main function you'd call after receiving the JSON response
    procedure ProcessJsonAndInsertIntoTableInvent(JsonText: Text)
    var
        JsonTok: JsonToken;
        JsonObj: JsonObject;
        JsonArr: JsonArray;
        EmployeeRecord: Record "Dimension Value";
        EmployeeJsonObj: JsonObject;
        LoopToken: JsonToken;
        TempText: Text;
        TempDate: Date;
        Companyinfo: record "Company Information";

    begin
        Companyinfo.Get;
        // 1. Read the root JSON object
        if not JsonObj.ReadFrom(JsonText) then begin
            Error('Invalid JSON format for root object.');
        end;

        // 2. Get the "data" array
        if not JsonObj.Get('data', JsonTok) then begin
            Error('JSON does not contain a "data" array.');
        end;

        if not JsonTok.IsArray() then begin
            Error('The "data" element in JSON is not an array.');
        end;

        JsonArr := JsonTok.AsArray();

        // 3. Iterate through each employee object in the "data" array
        foreach LoopToken in JsonArr do begin
            if not LoopToken.IsObject() then begin
                Error('Array element is not a JSON object.');
            end;

            EmployeeJsonObj := LoopToken.AsObject();

            // Clear the record to prepare for new data (or modify existing)


            // 4. Extract data and populate the record
            // EmpID - Required for primary key, so check for existence
            EmployeeRecord.Reset();
            if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] then
                EmployeeRecord.SetRange("Dimension Code", 'EMPLOYEE')
            else
                EmployeeRecord.SetRange("Dimension Code", 'EMPLOYEES');
            EmployeeRecord.SetRange("Global Dimension No.", 4);
            if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] then begin
                if EmployeeJsonObj.Get('empid', JsonTok) and JsonTok.IsValue() then
                    EmployeeRecord.SetRange(Code, DelChr(CopyStr(JsonTok.AsValue().AsText(), 1, MaxStrLen(EmployeeRecord.Code)), '=', '-'));
                if not EmployeeRecord.Get('EMPLOYEE', DelChr(CopyStr(JsonTok.AsValue().AsText(), 1, MaxStrLen(EmployeeRecord.Code)), '=', '-')) then begin
                    EmployeeRecord.Init();
                    EmployeeRecord."Dimension Code" := 'EMPLOYEE';
                    EmployeeRecord."Global Dimension No." := 4;
                    // Check if record already exists, then modify; otherwise, insert.
                    if EmployeeJsonObj.Get('empid', JsonTok) and JsonTok.IsValue() then
                        EmployeeRecord.Code := DelChr(CopyStr(JsonTok.AsValue().AsText(), 1, MaxStrLen(EmployeeRecord.Code)), '=', '-');
                    // Name
                    if EmployeeJsonObj.Get('name', JsonTok) and JsonTok.IsValue() then
                        EmployeeRecord.Name := CopyStr(JsonTok.AsValue().AsText(), 1, MaxStrLen(EmployeeRecord.Name));

                    EmployeeRecord.Insert()
                end;
            end else begin
                if EmployeeJsonObj.Get('empid', JsonTok) and JsonTok.IsValue() then
                    EmployeeRecord.SetRange(Code, DelStr(CopyStr(JsonTok.AsValue().AsText(), 1, MaxStrLen(EmployeeRecord.Code)), 1, 4));
                if not EmployeeRecord.Get('EMPLOYEES', DelStr(CopyStr(JsonTok.AsValue().AsText(), 1, MaxStrLen(EmployeeRecord.Code)), 1, 4)) then begin
                    EmployeeRecord.Init();
                    EmployeeRecord."Dimension Code" := 'EMPLOYEES';
                    EmployeeRecord."Global Dimension No." := 4;
                    // Check if record already exists, then modify; otherwise, insert.
                    if EmployeeJsonObj.Get('empid', JsonTok) and JsonTok.IsValue() then
                        EmployeeRecord.Code := Delstr(CopyStr(JsonTok.AsValue().AsText(), 1, MaxStrLen(EmployeeRecord.Code)), 1, 4);
                    // Name
                    if EmployeeJsonObj.Get('name', JsonTok) and JsonTok.IsValue() then
                        EmployeeRecord.Name := CopyStr(JsonTok.AsValue().AsText(), 1, MaxStrLen(EmployeeRecord.Name));

                    EmployeeRecord.Insert()
                end;

            end

        end;
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

    var
        RecUserSetup: Record 91;
        IMS: Codeunit IMS;
}

