codeunit 50025 EInvoicing
{
    Permissions = tabledata "G/L Entry" = rm,
     tabledata "Sales Invoice Header" = rm,
     tabledata "Transfer Shipment Header" = rm,
     tabledata "Sales Cr.Memo Header" = rm;

    Var
        Body1: Text;

    procedure GenerateSalesEInvoice(SalesInvoiceHeader: Record "Sales Invoice Header")
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
        Json: Text;
        blnValidateGST: Boolean;
        recDetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        decInvoiceValue: array[10] of Decimal;
        decInvoiceValue1: array[10] of Decimal;
        recSalesInvoiceLines: Record "Sales Invoice Line";
        blnExportWithoutPayment: Boolean;
        TknNo: Text;
        txtRoundingGLAccounts: Text;
        recCustomerPostingGroup: Record "Customer Posting Group";
        txtRoundingAccount: Text;
        recLocation: Record Location;
        recCustomer: Record Customer;
        recGSTLedgerEntry: Record "GST Ledger Entry";
        intSrNo: Integer;
        recState: Record State;
        cdEInvoiceNo: Code[70];
        cdEinvoiceDate: DateTime;
        SalesInvoiceHeader2: Record "Sales Invoice Header";
        txtQRCode: Text;
        recUnitOfMeasure: Record "Unit of Measure";
        txtFileName: Text;
        recShipToAddress: Record "Ship-to Address";
        recGSTRegistrationNos: Record "GST Registration Nos.";
        SalesSetup: Record "Sales & Receivables Setup";
        CompanyInfo: Record "Company Information";
        MainJsonObject: JsonObject;
        JsonArrayData: JsonArray;
        JItem: JsonObject;
        GSTPer: Decimal;
        TDSEntry: Record "TCS Entry";
        TDSAmt: Decimal;
        QRCodeInput: Text[300];
        QRCodeFileName: text[300];
        TempBlob: Codeunit "Temp Blob";
        QRFieldRef: FieldRef;
        QRRecRef: RecordRef;
        InputFile: File;
        InStream: InStream;
        OutStream: OutStream;
        proOrder: Record "Production Order";
        SalesPost: Codeunit 80;
        SalesInvoice: Record "Sales Invoice Line";
        IMS: Codeunit IMS;


    begin
        CLEAR(APIResponse);

        blnValidateGST := FALSE;
        IF SalesInvoiceHeader."Currency Code" = '' THEN BEGIN
            blnValidateGST := TRUE;
            recDetailedGSTLedgerEntry.RESET;
            recDetailedGSTLedgerEntry.SETRANGE("Document No.", SalesInvoiceHeader."No.");
            recDetailedGSTLedgerEntry.FINDFIRST;
            recDetailedGSTLedgerEntry.TESTFIELD("Buyer/Seller Reg. No.");
        END;

        CLEAR(decInvoiceValue);

        SalesSetup.GET;
        SalesInvoiceHeader.TESTFIELD("E-Invoice Status", SalesInvoiceHeader."E-Invoice Status"::Open);

        txtRoundingGLAccounts := '';
        recCustomerPostingGroup.RESET;
        recCustomerPostingGroup.SetRange(Code, SalesInvoiceHeader."Customer Posting Group");
        if recCustomerPostingGroup.FINDFIRST then
            REPEAT
                IF txtRoundingGLAccounts = '' THEN
                    txtRoundingGLAccounts := '<>' + recCustomerPostingGroup."Invoice Rounding Account"
                ELSE
                    txtRoundingGLAccounts := txtRoundingGLAccounts + '&<>' + recCustomerPostingGroup."Invoice Rounding Account";

                IF txtRoundingAccount = '' THEN
                    txtRoundingAccount := recCustomerPostingGroup."Invoice Rounding Account"
                ELSE
                    txtRoundingAccount := txtRoundingAccount + '|' + recCustomerPostingGroup."Invoice Rounding Account";
            UNTIL recCustomerPostingGroup.NEXT = 0;

        recLocation.GET(SalesInvoiceHeader."Location Code");
        recGSTRegistrationNos.GET(recLocation."GST Registration No.");
        recGSTRegistrationNos.TESTFIELD("E-Invoicing User Name");
        recGSTRegistrationNos.TESTFIELD("E-Invoicing User Password");
        recCustomer.GET(SalesInvoiceHeader."Bill-to Customer No.");
        CompanyInfo.GET;

        CLEAR(decInvoiceValue);
        recSalesInvoiceLines.RESET;
        recSalesInvoiceLines.SETRANGE("Document No.", SalesInvoiceHeader."No.");
        recSalesInvoiceLines.SETFILTER("No.", txtRoundingGLAccounts);
        recSalesInvoiceLines.SETFILTER(Quantity, '<>%1', 0);
        IF recSalesInvoiceLines.FINDFIRST THEN
            REPEAT
                decInvoiceValue[1] += ROUND(recSalesInvoiceLines.Quantity * recSalesInvoiceLines."Unit Price", 0.01);
                decInvoiceValue[2] += recSalesInvoiceLines."Line Discount Amount";
                decInvoiceValue[3] += recSalesInvoiceLines."Line Amount";
                decInvoiceValue[4] += recSalesInvoiceLines.Amount;
            UNTIL recSalesInvoiceLines.NEXT = 0;
        /*
    Clear(GSTPer);
    recSalesInvoiceLines.RESET;
    recSalesInvoiceLines.SETRANGE("Document No.", SalesInvoiceHeader."No.");
    recSalesInvoiceLines.SETFILTER("No.", txtRoundingGLAccounts);
    recSalesInvoiceLines.SETFILTER(Quantity, '<>%1', 0);
    IF recSalesInvoiceLines.FINDFIRST THEN
        REPEAT
            recDetailedGSTLedgerEntry.Reset();
            recDetailedGSTLedgerEntry.SetRange("Document No.", SalesInvoiceHeader."No.");
            recDetailedGSTLedgerEntry.SetRange("Document Line No.", recSalesInvoiceLines."Line No.");
            if recDetailedGSTLedgerEntry.FindFirst() then
                repeat
                    GSTPer += recDetailedGSTLedgerEntry."GST %";
                until recDetailedGSTLedgerEntry.Next() = 0;
        until recSalesInvoiceLines.Next() = 0;
        */
        recDetailedGSTLedgerEntry.RESET;
        recDetailedGSTLedgerEntry.SETRANGE("Document No.", recSalesInvoiceLines."Document No.");
        //recDetailedGSTLedgerEntry.SetRange("Document Line No.", recSalesInvoiceLines."Line No.");
        IF recDetailedGSTLedgerEntry.FindSet() THEN
            REPEAT
                SalesInvoice.Reset();
                SalesInvoice.SetRange("Document No.", recDetailedGSTLedgerEntry."Document No.");
                SalesInvoice.SetRange("Line No.", recDetailedGSTLedgerEntry."Document Line No.");
                SalesInvoice.SetRange(FOC, False);
                If SalesInvoice.FindFirst() Then Begin
                    IF recDetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN
                        decInvoiceValue[5] += -recDetailedGSTLedgerEntry."GST Amount"
                    ELSE
                        IF recDetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN
                            decInvoiceValue[6] += -recDetailedGSTLedgerEntry."GST Amount"
                        ELSE
                            IF recDetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN
                                decInvoiceValue[7] += -recDetailedGSTLedgerEntry."GST Amount";
                End;
            UNTIL recDetailedGSTLedgerEntry.NEXT = 0;
        decInvoiceValue[10] := decInvoiceValue[5] + decInvoiceValue[6] + decInvoiceValue[7];
        IF blnValidateGST THEN BEGIN
            IF decInvoiceValue[5] + decInvoiceValue[6] + decInvoiceValue[7] = 0 THEN
                ERROR('GST must be calculated to generate E-Invoice.');
        END ELSE BEGIN
            IF decInvoiceValue[5] + decInvoiceValue[6] + decInvoiceValue[7] = 0 THEN
                blnExportWithoutPayment := TRUE
            ELSE
                blnExportWithoutPayment := FALSE;
        END;
        Clear(TDSAmt);
        TDSEntry.Reset();
        TDSEntry.SetRange("Document No.", SalesInvoiceHeader."No.");
        if TDSEntry.FindFirst() then
            repeat
                TDSAmt += TDSEntry."TCS Amount";
            until TDSEntry.Next() = 0;
        recSalesInvoiceLines.RESET;
        recSalesInvoiceLines.SETRANGE("Document No.", SalesInvoiceHeader."No.");
        recSalesInvoiceLines.SETFILTER("No.", txtRoundingAccount);
        recSalesInvoiceLines.SETFILTER(Quantity, '<>%1', 0);
        IF recSalesInvoiceLines.FINDFIRST THEN
            REPEAT
                decInvoiceValue[8] += recSalesInvoiceLines."Line Amount";
            UNTIL recSalesInvoiceLines.NEXT = 0;
        decInvoiceValue[4] := decInvoiceValue[4] + decInvoiceValue[8] + decInvoiceValue[5] + decInvoiceValue[6] + decInvoiceValue[7];

        intSrNo := 0;
        recSalesInvoiceLines.RESET;
        recSalesInvoiceLines.SETRANGE("Document No.", SalesInvoiceHeader."No.");
        recSalesInvoiceLines.SETFILTER("No.", txtRoundingGLAccounts);
        recSalesInvoiceLines.SETFILTER(Quantity, '<>%1', 0);
        IF recSalesInvoiceLines.FINDFIRST THEN BEGIN
            repeat
                Clear(GSTPer);
                Clear(decInvoiceValue1);
                recDetailedGSTLedgerEntry.Reset();
                recDetailedGSTLedgerEntry.SetRange("Document No.", recSalesInvoiceLines."Document No.");
                recDetailedGSTLedgerEntry.SetRange("Document Line No.", recSalesInvoiceLines."Line No.");
                if recDetailedGSTLedgerEntry.FindFirst() then
                    repeat
                        SalesInvoice.Reset();
                        SalesInvoice.SetRange("Document No.", recDetailedGSTLedgerEntry."Document No.");
                        SalesInvoice.SetRange("Line No.", recDetailedGSTLedgerEntry."Document Line No.");
                        SalesInvoice.SetRange(FOC, False);
                        if SalesInvoice.FindFirst() Then Begin
                            GSTPer += recDetailedGSTLedgerEntry."GST %";
                            IF recDetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN
                                decInvoiceValue1[5] += ABS(recDetailedGSTLedgerEntry."GST Amount")
                            ELSE
                                IF recDetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN
                                    decInvoiceValue1[6] += ABS(recDetailedGSTLedgerEntry."GST Amount")
                                ELSE
                                    IF recDetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN
                                        decInvoiceValue1[7] += ABS(recDetailedGSTLedgerEntry."GST Amount");
                        End;
                    until recDetailedGSTLedgerEntry.Next() = 0;
                Clear(JItem);
                //    JItem.Add('GSTIN', '29AAACW3775F000');
                JItem.Add('GSTIN', recLocation."GST Registration No.");
                JItem.Add('Version', '1.01');
                JItem.Add('Tran_TaxSch', 'GST');

                IF SalesInvoiceHeader."Currency Code" = '' THEN
                    JItem.Add('Tran_SupTyp', 'B2B')
                ELSE
                    IF blnExportWithoutPayment THEN
                        JItem.Add('Tran_SupTyp', 'EXPWOP')
                    ELSE
                        JItem.Add('Tran_SupTyp', 'EXPWP');

                JItem.Add('Tran_RegRev', 'N');

                IF SalesInvoiceHeader."Ship-to Code" <> '' THEN
                    JItem.Add('Tran_Typ', 'SHP')
                ELSE
                    JItem.Add('Tran_Typ', 'REG');

                JItem.Add('Doc_Typ', 'INV');
                JItem.Add('Doc_No', SalesInvoiceHeader."No.");
                JItem.Add('Doc_Dt', ConvertDateToTextDDMMYYYY(SalesInvoiceHeader."Posting Date"));
                //JItem.Add('BillFrom_Gstin', '29AAACW3775F000');
                JItem.Add('BillFrom_Gstin', recLocation."GST Registration No.");
                JItem.Add('BillFrom_LglNm', CompanyInfo.Name);
                JItem.Add('BillFrom_TrdNm', CompanyInfo.Name);
                JItem.Add('BillFrom_Addr1', recLocation.Address);
                JItem.Add('BillFrom_Loc', recLocation.City);
                // JItem.Add('BillFrom_Pin', '562160');
                JItem.Add('BillFrom_Pin', recLocation."Post Code");
                //562160
                recState.GET(recLocation."State Code");
                //JItem.Add('BillFrom_Stcd', '29');
                JItem.Add('BillFrom_Stcd', recState."State Code (GST Reg. No.)");
                // JItem.Add('BillTo_Gstin', '07AAACW3775F1Z8');
                JItem.Add('BillTo_Gstin', recCustomer."GST Registration No.");
                JItem.Add('BillTo_LglNm', recCustomer.Name);
                JItem.Add('BillTo_TrdNm', recCustomer.Name);

                IF SalesInvoiceHeader."Currency Code" = '' THEN BEGIN
                    recState.GET(SalesInvoiceHeader."GST Bill-to State Code");
                    recState.TESTFIELD("State Code (GST Reg. No.)");
                    JItem.Add('BillTo_Pos', recState."State Code (GST Reg. No.)");
                END ELSE BEGIN
                    JItem.Add('BillTo_Pos', '96');
                END;
                JItem.Add('BillTo_Addr1', SalesInvoiceHeader."Bill-to Address");
                JItem.Add('BillTo_Loc', SalesInvoiceHeader."Bill-to City");
                //JItem.Add('BillTo_Pin', '110008');
                JItem.Add('BillTo_Pin', SalesInvoiceHeader."Bill-to Post Code");
                JItem.Add('BillTo_State', recState.Description);
                //JItem.Add('BillTo_Stcd', '07');
                JItem.Add('BillTo_Stcd', recState."State Code (GST Reg. No.)");

                IF SalesInvoiceHeader."Ship-to Code" <> '' THEN BEGIN
                    recShipToAddress.GET(SalesInvoiceHeader."Sell-to Customer No.", SalesInvoiceHeader."Ship-to Code");
                    JItem.Add('ShipTo_Gstin', recShipToAddress."GST Registration No.");
                    JItem.Add('ShipTo_LglNm', recShipToAddress.Name);
                    JItem.Add('ShipTo_TrdNm', recShipToAddress.Name);
                    JItem.Add('ShipTo_Addr1', recShipToAddress.Address);
                    JItem.Add('ShipTo_Addr2', recShipToAddress."Address 2");
                    JItem.Add('ShipTo_Loc', recShipToAddress.City);
                    JItem.Add('ShipTo_Pin', recShipToAddress."Post Code");
                    recState.GET(recShipToAddress.State);
                    JItem.Add('ShipTo_Stcd', recState."State Code (GST Reg. No.)");
                END;

                intSrNo += 1;
                JItem.Add('Item_SlNo', intSrNo);
                JItem.Add('Item_PrdDesc', recSalesInvoiceLines.Description);
                IF recSalesInvoiceLines."GST Group Type" = recSalesInvoiceLines."GST Group Type"::Goods THEN
                    JItem.Add('Item_IsServc', 'N')
                ELSE
                    JItem.Add('Item_IsServc', 'Y');

                //JItem.Add('Item_IsServc', 'Y');
                /*
                IF STRLEN(recSalesInvoiceLines."HSN/SAC Code") > 4 THEN
                    JItem.Add('Item_HsnCd', COPYSTR(recSalesInvoiceLines."HSN/SAC Code", 1, 8))
                ELSE
                */
                JItem.Add('Item_HsnCd', recSalesInvoiceLines."HSN/SAC Code");
                JItem.Add('Item_Qty', recSalesInvoiceLines.Quantity);

                IF recUnitOfMeasure.GET(recSalesInvoiceLines."Unit of Measure Code") THEN BEGIN
                    IF recUnitOfMeasure."E-Invoicing UOM Code" <> '' THEN
                        JItem.Add('Item_Unit', recUnitOfMeasure."E-Invoicing UOM Code")
                    ELSE
                        JItem.Add('Item_Unit', recSalesInvoiceLines."Unit of Measure Code");
                END;

                JItem.Add('Item_UnitPrice', ROUND(recSalesInvoiceLines."Unit Price", 0.001));
                JItem.Add('Item_TotAmt', ROUND(recSalesInvoiceLines.Quantity * recSalesInvoiceLines."Unit Price", 0.01));
                JItem.Add('Item_Discount', recSalesInvoiceLines."Line Discount Amount");
                JItem.Add('Item_AssAmt', recSalesInvoiceLines."Line Amount");

                JItem.Add('Item_GstRt', ROUND(GSTPer, 1));
                JItem.Add('Item_OthChrg', (TDSAmt));

                IF decInvoiceValue1[5] <> 0 THEN BEGIN
                    JItem.Add('Item_IgstAmt', decInvoiceValue1[5]);
                END ELSE BEGIN
                    JItem.Add('Item_CgstAmt', ROUND(decInvoiceValue1[6], 0.01));
                    JItem.Add('Item_SgstAmt', ROUND(decInvoiceValue1[7], 0.01));
                END;

                JItem.Add('Item_TotItemVal', recSalesInvoiceLines.Amount + decInvoiceValue1[5] + decInvoiceValue1[6] + decInvoiceValue1[7] + TDSAmt);
                JItem.Add('Val_AssVal', decInvoiceValue[3]);

                JItem.Add('Val_CgstVal', decInvoiceValue[6]);
                JItem.Add('Val_SgstVal', decInvoiceValue[7]);
                JItem.Add('Val_IgstVal', decInvoiceValue[5]);
                JItem.Add('Val_CesVal', 0);
                JItem.Add('Val_StCesVal', 0);
                JItem.Add('Val_RndOffAmt', decInvoiceValue[8]);
                JItem.Add('Val_CesNonAdVal', '0');
                JItem.Add('Val_TotInvVal', decInvoiceValue[4] + (TDSAmt));

                IF SalesInvoiceHeader."Currency Code" <> '' THEN BEGIN
                    JItem.Add('Exp_ForCur', SalesInvoiceHeader."Currency Code");
                END;

                JItem.Add('CDKey', '1690165');
                JItem.Add('EInvUserName', recGSTRegistrationNos."E-Invoicing User Name");
                JItem.Add('EInvPassword', recGSTRegistrationNos."E-Invoicing User Password");
                JItem.Add('EFUserName', '9DDF892A-B93D-40A0-A179-8A19E0F2B7FB');
                JItem.Add('EFPassword', '59666FB2-F035-45EA-B4C8-73EAA51A76E0');
                /*
    JItem.Add('CDKey', '1000687');
    JItem.Add('EInvUserName', '29AAACW3775F000');
    JItem.Add('EInvPassword', 'Admin!23..');
    JItem.Add('EFUserName', '29AAACW3775F000');
    JItem.Add('EFPassword', 'Admin!23..');
    */
                JsonArrayData.Add(JItem);
                TDSAmt := 0;
            until recSalesInvoiceLines.Next() = 0;
            MainJsonObject.Add('Data', JsonArrayData);
            clear(Body1);
            Body := '{' +
            '"Push_Data_List":';
            MainJsonObject.WriteTo(Body1);
            Body += Body1 + '}';
            MESSAGE(Body);
            //MESSAGE(APIResponse);


            Clear(gResponseMsg);
            gContent.WriteFrom(Body);
            gContent.GetHeaders(gContentHeaders);
            gContentHeaders.Clear();
            gContentHeaders.Add('Content-Type', 'application/json');
            //  http://einvsandbox.webtel.in/v1.03/GenIRN
            //Test  if gHttpClient.Post('http://einvsandbox.webtel.in/v1.03/GenIRN', gContent, gHttpResponseMsg) then begin
            if gHttpClient.Post('http://einvlive.webtel.in/v1.03/GenIRN', gContent, gHttpResponseMsg) then begin
                gHttpResponseMsg.Content.ReadAs(Json);
                if gHttpResponseMsg.IsSuccessStatusCode then begin
                    MESSAGE(Json);
                    IF (GetResponsesValue(Json, '"ErrorCode', ',', 1) = '') THEN BEGIN
                        cdEInvoiceNo := GetResponsesValue(Json, '"Irn', ',', 1);
                        cdEinvoiceDate := ConvertTextToDate(GetResponsesValue(Json, '"AckDate', ',', 1));
                        COMMIT;
                        IF cdEInvoiceNo <> '' THEN BEGIN
                            SalesInvoiceHeader2.GET(SalesInvoiceHeader."No.");
                            SalesInvoiceHeader2."E-Invoice Status" := SalesInvoiceHeader2."E-Invoice Status"::Generated;
                            SalesInvoiceHeader2."E-Invoice No." := cdEInvoiceNo;
                            QRCodeFileName := GetQRCode(GetResponsesValue(Json, '"SignedQRCode', ',', 1));
                            InputFile.Open(QRCodeFileName);
                            InputFile.CreateInStream(InStream);
                            SalesInvoiceHeader2."E-Invoice QR Code".CreateOutStream(OutStream);
                            CopyStream(OutStream, InStream);
                            InputFile.Close;
                            IF ERASE(QRCodeFileName) THEN;

                            SalesInvoiceHeader2."E-Invoice Date" := cdEinvoiceDate;
                            SalesInvoiceHeader2.MODIFY;
                            MESSAGE('E-Invoice Generated');
                        END;
                    END ELSE
                        ERROR('%1 Please share this request ID for support %2', IMS.GetResponsesValueForErrror(Json, '"ErrorMessage', ',', 1), IMS.GetResponsesValueForErrror(Json, '"ErrorCode', ',', 1));
                END;
            END;

        END;
    END;

    LOCAL procedure ConvertDateToTextDDMMYYYY(PostingDate: Date) TextDate: Text
    var
        txtTemp: Text;
    begin
        txtTemp := FORMAT(DATE2DMY(PostingDate, 1));
        IF STRLEN(txtTemp) = 2 THEN
            TextDate := txtTemp + '/'
        ELSE
            TextDate := '0' + txtTemp + '/';

        txtTemp := FORMAT(DATE2DMY(PostingDate, 2));
        IF STRLEN(txtTemp) = 1 THEN
            TextDate := TextDate + '0' + txtTemp + '/'
        ELSE
            TextDate := TextDate + txtTemp + '/';

        txtTemp := FORMAT(DATE2DMY(PostingDate, 3));
        IF STRLEN(txtTemp) = 2 THEN
            TextDate := TextDate + '20' + txtTemp
        ELSE
            TextDate := TextDate + txtTemp;
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
        IF NOT (Lstr = 'StatusDate') THEN
            Resp1 := DELCHR(Resp1, '=', ' ');
        Resp1 := DELCHR(Resp1, '=', '"');
        Resp1 := DELCHR(Resp1, '<', ':');
        Resp1 := DELCHR(Resp1, '=', '\');
        EXIT(Resp1);
    END;

    [Scope('OnPrem')]
    LOCAL procedure GetQRCode(QRCodeInput: Text[2995]) QRCodeFileName: Text[2024]
    var
        IBarCodeProvider: DotNet QRCodeProvider;
    begin
        GetBarCodeProvider(IBarCodeProvider);
        QRCodeFileName := IBarCodeProvider.GetBarcode(QRCodeInput);

    end;

    [Scope('OnPrem')]
    procedure GetBarCodeProvider(VAR IBarCodeProvider: DotNet QRCodeProvider)
    var
        QRCodeProvider: dotnet QRCodeProvider;
    begin
        IF ISNULL(IBarCodeProvider) THEN
            IBarCodeProvider := QRCodeProvider.QRCodeProvider;
    end;

    LOCAL procedure ConvertTextToDate(txtInputDateTime: Text) DateTime: DateTime
    var
        intDay: Integer;
        intMonth: Integer;
        intYear: Integer;
        dtTempDate: Date;
        dtTempTime: Time;
    begin
        //'2020-02-07 15:24:00'
        EVALUATE(intDay, COPYSTR(txtInputDateTime, 9, 2));
        EVALUATE(intMonth, COPYSTR(txtInputDateTime, 6, 2));
        EVALUATE(intYear, COPYSTR(txtInputDateTime, 1, 4));
        dtTempDate := DMY2DATE(intDay, intMonth, intYear);
        EVALUATE(dtTempTime, COPYSTR(txtInputDateTime, 12));

        DateTime := CREATEDATETIME(dtTempDate, dtTempTime);
    END;


    procedure CheckGST(Docno: Code[20]): Boolean
    var
        recTransferLines: Record "Transfer Shipment Line";
        decInvoiceValue: Decimal;
        recDetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin
        CLEAR(decInvoiceValue);
        recTransferLines.RESET;
        recTransferLines.SETRANGE("Document No.", Docno);
        recTransferLines.SETFILTER(Quantity, '<>%1', 0);
        recTransferLines.FINDFIRST;
        REPEAT
            recDetailedGSTLedgerEntry.Reset();
            recDetailedGSTLedgerEntry.SetRange("Document No.", recTransferLines."Document No.");
            recDetailedGSTLedgerEntry.SetRange("Document Line No.", recTransferLines."Line No.");
            if recDetailedGSTLedgerEntry.FindFirst() then
                repeat
                    decInvoiceValue += recDetailedGSTLedgerEntry."GST Amount";
                until recDetailedGSTLedgerEntry.Next() = 0;
        UNTIL recTransferLines.NEXT = 0;
        IF decInvoiceValue <> 0 THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    END;

    procedure GenerateTransferEInvoice(TransferShipment: Record "Transfer Shipment Header")
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
        Json: Text;
        blnValidateGST: Boolean;
        recDetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        decInvoiceValue: array[10] of Decimal;
        decInvoiceValue1: array[10] of Decimal;
        recSalesInvoiceLines: Record "Sales Invoice Line";
        blnExportWithoutPayment: Boolean;
        TknNo: Text;
        txtRoundingGLAccounts: Text;
        recCustomerPostingGroup: Record "Customer Posting Group";
        txtRoundingAccount: Text;
        recLocation: Record Location;
        recCustomer: Record Customer;
        recGSTLedgerEntry: Record "GST Ledger Entry";
        intSrNo: Integer;
        recState: Record State;
        cdEInvoiceNo: Code[70];
        cdEinvoiceDate: DateTime;
        SalesInvoiceHeader2: Record "Transfer Shipment Header";
        txtQRCode: Text;
        recUnitOfMeasure: Record "Unit of Measure";
        txtFileName: Text;
        recShipToAddress: Record "Ship-to Address";
        recGSTRegistrationNos: Record "GST Registration Nos.";
        SalesSetup: Record "Sales & Receivables Setup";
        CompanyInfo: Record "Company Information";
        MainJsonObject: JsonObject;
        JsonArrayData: JsonArray;
        JItem: JsonObject;
        GSTPer: Decimal;
        TDSEntry: Record "TCS Entry";
        TDSAmt: Decimal;
        QRCodeInput: Text[300];
        QRCodeFileName: text[300];
        TempBlob: Codeunit "Temp Blob";
        QRFieldRef: FieldRef;
        QRRecRef: RecordRef;
        InputFile: File;
        InStream: InStream;
        OutStream: OutStream;
        proOrder: Record "Production Order";
        recToLocation: Record Location;
        recTransferLines: Record "Transfer Shipment Line";
        IMS: Codeunit IMS;
    begin

        recToLocation.GET(TransferShipment."Transfer-to Code");
        recToLocation.TESTFIELD("GST Registration No.");
        blnValidateGST := TRUE;



        CLEAR(decInvoiceValue);
        Clear(GSTPer);
        recTransferLines.RESET;
        recTransferLines.SETRANGE("Document No.", TransferShipment."No.");
        recTransferLines.SETFILTER(Quantity, '<>%1', 0);
        if recTransferLines.FINDFIRST then
            REPEAT
                recDetailedGSTLedgerEntry.Reset();
                recDetailedGSTLedgerEntry.SetRange("Document No.", recTransferLines."Document No.");
                recDetailedGSTLedgerEntry.SetRange("Document Line No.", recTransferLines."Line No.");
                if recDetailedGSTLedgerEntry.FindFirst() then
                    repeat
                        //   GSTPer += recDetailedGSTLedgerEntry."GST %";
                        decInvoiceValue[10] += Abs(recDetailedGSTLedgerEntry."GST Amount");
                    until recDetailedGSTLedgerEntry.Next() = 0;
            //     decInvoiceValue[10] += recTransferLines."Total GST Amount";
            UNTIL recTransferLines.NEXT = 0;

        IF blnValidateGST THEN BEGIN
            IF decInvoiceValue[10] = 0 THEN
                ERROR('GST must be calculated to generate E-Invoice.');
        END ELSE BEGIN
            IF decInvoiceValue[10] = 0 THEN
                blnExportWithoutPayment := TRUE
            ELSE
                blnExportWithoutPayment := FALSE;
        END;

        TransferShipment.TESTFIELD("E-Invoice Status", TransferShipment."E-Invoice Status"::Open);
        recLocation.GET(TransferShipment."Transfer-from Code");
        recGSTRegistrationNos.GET(recLocation."GST Registration No.");
        recGSTRegistrationNos.TESTFIELD("E-Invoicing User Name");
        recGSTRegistrationNos.TESTFIELD("E-Invoicing User Password");
        CompanyInfo.GET;

        CLEAR(decInvoiceValue);
        recTransferLines.RESET;
        recTransferLines.SETRANGE("Document No.", TransferShipment."No.");
        recTransferLines.SETFILTER(Quantity, '<>%1', 0);
        IF recTransferLines.FINDFIRST THEN
            REPEAT
                decInvoiceValue[1] += ROUND(recTransferLines.Quantity * recTransferLines."Unit Price", 0.01);
                decInvoiceValue[2] += 0;//recTransferLines."Line Discount Amount";
                decInvoiceValue[3] += ROUND(recTransferLines.Quantity * recTransferLines."Unit Price", 0.01);
            //    decInvoiceValue[4] += ROUND(recTransferLines.Quantity * recTransferLines."Unit Price", 0.01) + recTransferLines."Total GST Amount";
            UNTIL recTransferLines.NEXT = 0;

        recGSTLedgerEntry.RESET;
        recGSTLedgerEntry.SETRANGE("Document No.", TransferShipment."No.");
        IF recGSTLedgerEntry.FINDFIRST THEN
            REPEAT
                IF recGSTLedgerEntry."GST Component Code" = 'IGST' THEN
                    decInvoiceValue[5] += recGSTLedgerEntry."GST Amount"  // Remove- Suman
                ELSE
                    IF recGSTLedgerEntry."GST Component Code" = 'CGST' THEN
                        decInvoiceValue[6] += recGSTLedgerEntry."GST Amount"  // Remove- Suman
                    ELSE
                        IF recGSTLedgerEntry."GST Component Code" = 'SGST' THEN
                            decInvoiceValue[7] += recGSTLedgerEntry."GST Amount";  // Remove- Suman
            UNTIL recGSTLedgerEntry.NEXT = 0;
        decInvoiceValue[4] := decInvoiceValue[1] + decInvoiceValue[5] + decInvoiceValue[6] + decInvoiceValue[7];
        decInvoiceValue[10] := decInvoiceValue[5] + decInvoiceValue[6] + decInvoiceValue[7];
        intSrNo := 0;

        recTransferLines.RESET;
        recTransferLines.SETRANGE("Document No.", TransferShipment."No.");
        recTransferLines.SETFILTER(Quantity, '<>%1', 0);
        IF recTransferLines.FINDFIRST THEN BEGIN
            //   MainJsonObject.Add('Push_Data_List', '');
            REPEAT
                Clear(GSTPer);
                Clear(decInvoiceValue1);
                recDetailedGSTLedgerEntry.Reset();
                recDetailedGSTLedgerEntry.SetRange("Document No.", recTransferLines."Document No.");
                recDetailedGSTLedgerEntry.SetRange("Document Line No.", recTransferLines."Line No.");
                if recDetailedGSTLedgerEntry.FindFirst() then
                    repeat
                        GSTPer += recDetailedGSTLedgerEntry."GST %";
                        IF recDetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN
                            decInvoiceValue1[5] += ABS(recDetailedGSTLedgerEntry."GST Amount")
                        ELSE
                            IF recDetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN
                                decInvoiceValue1[6] += ABS(recDetailedGSTLedgerEntry."GST Amount")
                            ELSE
                                IF recDetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN
                                    decInvoiceValue1[7] += ABS(recDetailedGSTLedgerEntry."GST Amount");

                    until recDetailedGSTLedgerEntry.Next() = 0;
                Clear(JItem);
                //   JItem.Add('GSTIN', '29AAACW3775F000');
                JItem.Add('GSTIN', recLocation."GST Registration No.");
                JItem.Add('Version', '1.01');
                JItem.Add('Tran_TaxSch', 'GST');
                JItem.Add('Tran_SupTyp', 'B2B');
                JItem.Add('Tran_RegRev', 'N');
                JItem.Add('Tran_Typ', 'REG');
                JItem.Add('Doc_Typ', 'INV');
                JItem.Add('Doc_No', TransferShipment."No.");
                JItem.Add('Doc_Dt', ConvertDateToTextDDMMYYYY(TransferShipment."Posting Date"));
                // JItem.Add('BillFrom_Gstin', '29AAACW3775F000');
                JItem.Add('BillFrom_Gstin', recLocation."GST Registration No.");
                JItem.Add('BillFrom_LglNm', CompanyInfo.Name);
                JItem.Add('BillFrom_TrdNm', CompanyInfo.Name);
                JItem.Add('BillFrom_Addr1', recLocation.Address);
                JItem.Add('BillFrom_Loc', recLocation.City);
                //JItem.Add('BillFrom_Pin', '562160');
                JItem.Add('BillFrom_Pin', recLocation."Post Code");

                recState.GET(recLocation."State Code");
                //JItem.Add('BillFrom_Stcd', '29');
                JItem.Add('BillFrom_Stcd', recState."State Code (GST Reg. No.)");
                //JItem.Add('BillTo_Gstin', '07AAACW3775F1Z8');
                JItem.Add('BillTo_Gstin', recToLocation."GST Registration No.");
                JItem.Add('BillTo_LglNm', CompanyInfo.Name);
                JItem.Add('BillTo_TrdNm', CompanyInfo.Name);

                recState.GET(recToLocation."State Code");
                recState.TESTFIELD("State Code (GST Reg. No.)");
                //JItem.Add('BillTo_Pos', '07');
                JItem.Add('BillTo_Pos', recState."State Code (GST Reg. No.)");

                JItem.Add('BillTo_Addr1', TransferShipment."Transfer-to Address");
                JItem.Add('BillTo_Loc', TransferShipment."Transfer-to City");

                // JItem.Add('BillTo_Pin', '110008');
                JItem.Add('BillTo_Pin', TransferShipment."Transfer-to Post Code");
                JItem.Add('BillTo_State', recState.Description);

                // JItem.Add('BillTo_Stcd', '07');
                JItem.Add('BillTo_Stcd', recState."State Code (GST Reg. No.)");

                intSrNo += 1;
                JItem.Add('Item_SlNo', intSrNo);
                JItem.Add('Item_PrdDesc', recTransferLines.Description);
                JItem.Add('Item_IsServc', 'N');
                //JItem.Add('Item_IsServc', 'Y');
                /*
                IF STRLEN(recTransferLines."HSN/SAC Code") > 4 THEN
                    JItem.Add('Item_HsnCd', COPYSTR(recTransferLines."HSN/SAC Code", 1, 4))
                ELSE
                */
                JItem.Add('Item_HsnCd', recTransferLines."HSN/SAC Code");
                JItem.Add('Item_Qty', ROUND(recTransferLines.Quantity, 0.01));

                IF recUnitOfMeasure.GET(recTransferLines."Unit of Measure Code") THEN BEGIN
                    IF recUnitOfMeasure."E-Invoicing UOM Code" <> '' THEN
                        JItem.Add('Item_Unit', recUnitOfMeasure."E-Invoicing UOM Code")
                    ELSE
                        JItem.Add('Item_Unit', recTransferLines."Unit of Measure Code");
                END;

                //"GST%" := ROUND(recTransferLines."GST %", 0.1);
                JItem.Add('Item_UnitPrice', ROUND(recTransferLines."Unit Price", 0.001));
                JItem.Add('Item_TotAmt', ROUND(recTransferLines.Quantity * recTransferLines."Unit Price", 0.01));
                JItem.Add('Item_AssAmt', ROUND(recTransferLines.Quantity * recTransferLines."Unit Price", 0.01));
                JItem.Add('Item_GstRt', ROUND(GSTPer, 1));
                JItem.Add('Item_OthChrg', TDSAmt);

                IF recLocation."State Code" <> recToLocation."State Code" THEN BEGIN
                    JItem.Add('Item_IgstAmt', decInvoiceValue1[5]);
                END ELSE BEGIN
                    JItem.Add('Item_CgstAmt', decInvoiceValue1[6]);
                    JItem.Add('Item_SgstAmt', decInvoiceValue1[7]);
                END;

                JItem.Add('Item_TotItemVal', ROUND(recTransferLines.Quantity * recTransferLines."Unit Price", 0.01) + decInvoiceValue1[5] + decInvoiceValue1[6] + decInvoiceValue1[7] + TDSAmt);
                JItem.Add('Val_AssVal', decInvoiceValue[3]);

                JItem.Add('Val_CgstVal', decInvoiceValue[6]);
                JItem.Add('Val_SgstVal', decInvoiceValue[7]);
                JItem.Add('Val_IgstVal', decInvoiceValue[5]);
                JItem.Add('Val_CesVal', 0);
                JItem.Add('Val_StCesVal', 0);
                JItem.Add('Val_RndOffAmt', decInvoiceValue[8]);
                JItem.Add('Val_CesNonAdVal', '0');
                JItem.Add('Val_TotInvVal', decInvoiceValue[4]);

                JItem.Add('CDKey', '1690165');
                JItem.Add('EInvUserName', recGSTRegistrationNos."E-Invoicing User Name");
                JItem.Add('EInvPassword', recGSTRegistrationNos."E-Invoicing User Password");
                JItem.Add('EFUserName', '9DDF892A-B93D-40A0-A179-8A19E0F2B7FB');
                JItem.Add('EFPassword', '59666FB2-F035-45EA-B4C8-73EAA51A76E0');
                /*Test
JItem.Add('CDKey', '1000687');
JItem.Add('EInvUserName', '29AAACW3775F000');
JItem.Add('EInvPassword', 'Admin!23..');
JItem.Add('EFUserName', '29AAACW3775F000');
JItem.Add('EFPassword', 'Admin!23..');
*/
                JsonArrayData.Add(JItem);
            UNTIL recTransferLines.NEXT = 0;
        END;
        MainJsonObject.Add('Data', JsonArrayData);
        clear(Body1);
        Body := '{' +
        '"Push_Data_List":';
        MainJsonObject.WriteTo(Body1);
        Body += Body1 + '}';
        MESSAGE(Body);



        Clear(gResponseMsg);
        gContent.WriteFrom(Body);
        gContent.GetHeaders(gContentHeaders);
        gContentHeaders.Clear();
        gContentHeaders.Add('Content-Type', 'application/json');
        //   if gHttpClient.Post('http://einvsandbox.webtel.in/v1.03/GenIRN', gContent, gHttpResponseMsg) then begin
        if gHttpClient.Post('http://einvlive.webtel.in/v1.03/GenIRN', gContent, gHttpResponseMsg) then begin
            gHttpResponseMsg.Content.ReadAs(Json);
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                //    MESSAGE(Json);
                IF (GetResponsesValue(Json, '"ErrorCode', ',', 1) = '') THEN BEGIN
                    cdEInvoiceNo := GetResponsesValue(Json, '"Irn', ',', 1);
                    cdEinvoiceDate := ConvertTextToDate(GetResponsesValue(Json, '"AckDate', ',', 1));
                    COMMIT;
                    IF cdEInvoiceNo <> '' THEN BEGIN
                        SalesInvoiceHeader2.GET(TransferShipment."No.");
                        SalesInvoiceHeader2."E-Invoice Status" := SalesInvoiceHeader2."E-Invoice Status"::Generated;
                        SalesInvoiceHeader2."E-Invoice No." := cdEInvoiceNo;
                        QRCodeFileName := GetQRCode(GetResponsesValue(Json, '"SignedQRCode', ',', 1));
                        InputFile.Open(QRCodeFileName);
                        InputFile.CreateInStream(InStream);
                        SalesInvoiceHeader2."E-Invoice QR Code".CreateOutStream(OutStream);
                        CopyStream(OutStream, InStream);
                        InputFile.Close;
                        IF ERASE(QRCodeFileName) THEN;

                        SalesInvoiceHeader2."E-Invoice Date" := cdEinvoiceDate;
                        SalesInvoiceHeader2.MODIFY;
                        MESSAGE('E-Invoice Generated');
                    END;
                END ELSE
                    MESSAGE('%1 Please share this request ID for support %2', IMS.GetResponsesValueForErrror(Json, '"ErrorMessage', ',', 1), IMS.GetResponsesValueForErrror(Json, '"ErrorCode', ',', 1));
            END;
        END;


    END;


    procedure CancelTransferEInvoice(TransferShipment: Record "Transfer Shipment Header")
    var

        APIIntegrationSetup: Record "Sales & Receivables Setup";
        APIResponse: Text;

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
        recLocation: Record Location;
        txtStatus: Text;
        dtCanDate: DateTime;
        SalesInvoiceHeader2: Record "Transfer Shipment Header";
        txtFileName: Text;
        recGSTRegistrationNos: Record "GST Registration Nos.";
    begin
        TransferShipment.TESTFIELD("E-Invoice Status", TransferShipment."E-Invoice Status"::Generated);
        recLocation.GET(TransferShipment."Transfer-from Code");
        recGSTRegistrationNos.GET(recLocation."GST Registration No.");
        recGSTRegistrationNos.TESTFIELD("E-Invoicing User Name");
        recGSTRegistrationNos.TESTFIELD("E-Invoicing User Password");
        Body := '{' +
          '"Push_Data_List": {"Data": [{' +
          '"Irn":"' + TransferShipment."E-Invoice No." + '",' +
             //     '"GSTIN":"' + '29AAACW3775F000' + '",' +
             '"GSTIN":"' + recLocation."GST Registration No." + '",' +
          '"CnlRsn":"1",' +
          '"CnlRem":"Remarks",' +

             '"CDKey":"' + '1690165' + '",' +
             '"EFUserName":"' + '9DDF892A-B93D-40A0-A179-8A19E0F2B7FB' + '",' +
             '"EFPassword":"' + '59666FB2-F035-45EA-B4C8-73EAA51A76E0' + '",' +
             '"EInvUserName":"' + recGSTRegistrationNos."E-Invoicing User Name" + '",' +
             '"EInvPassword":"' + recGSTRegistrationNos."E-Invoicing User Password" + '"' +
          /*Test
          '"CDKey":"' + '1000687' + '",' +
       '"EFUserName":"' + '29AAACW3775F000' + '",' +
       '"EFPassword":"' + 'Admin!23..' + '",' +
       '"EInvUserName":"' + '29AAACW3775F000' + '",' +
       '"EInvPassword":"' + 'Admin!23..' + '"' +
       */
          '}]}}';
        //   MESSAGE(Body);
        Clear(gResponseMsg);
        gContent.WriteFrom(Body);
        gContent.GetHeaders(gContentHeaders);
        gContentHeaders.Clear();
        gContentHeaders.Add('Content-Type', 'application/json');
        // if gHttpClient.Post('http://einvsandbox.webtel.in/v1.03/CanIRN', gContent, gHttpResponseMsg) then begin
        if gHttpClient.Post('http://Einvlive.webtel.in/v1.03/CanIRN', gContent, gHttpResponseMsg) then begin
            gHttpResponseMsg.Content.ReadAs(JsonText);
            //    Message(JsonText);
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                IF (UPPERCASE(GetResponsesValue(JsonText, '"CancelDate":', ',', 1)) <> '') THEN BEGIN
                    dtCanDate := CREATEDATETIME(0D, 0T);
                    dtCanDate := ConvertTextToDate(UPPERCASE(GetResponsesValue(JsonText, '"CancelDate":', ',', 1)));
                    SalesInvoiceHeader2.GET(TransferShipment."No.");
                    SalesInvoiceHeader2."E-Invoice Status" := SalesInvoiceHeader2."E-Invoice Status"::Cancelled;
                    SalesInvoiceHeader2."E-Invoice Cancel Date" := dtCanDate;
                    SalesInvoiceHeader2.MODIFY;
                    MESSAGE('E-Invoice has been cancelled');
                END
                // ELSE
                //     ERROR('Please see Reason %1', JsonText);
            END;
        END;
    END;


    procedure CancelSalesEInvoice(SalesInvoiceHeader: Record "Sales Invoice Header")
    var

        APIIntegrationSetup: Record "Sales & Receivables Setup";
        APIResponse: Text;

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
        recLocation: Record Location;
        txtStatus: Text;
        dtCanDate: DateTime;
        SalesInvoiceHeader2: Record "Sales Invoice Header";
        txtFileName: Text;
        recGSTRegistrationNos: Record "GST Registration Nos.";
    begin
        SalesInvoiceHeader.TESTFIELD("E-Invoice Status", SalesInvoiceHeader."E-Invoice Status"::Generated);
        recLocation.GET(SalesInvoiceHeader."Location Code");
        recGSTRegistrationNos.GET(recLocation."GST Registration No.");
        recGSTRegistrationNos.TESTFIELD("E-Invoicing User Name");
        recGSTRegistrationNos.TESTFIELD("E-Invoicing User Password");
        Body := '{' +
          '"Push_Data_List": {"Data": [{' +
          '"Irn":"' + SalesInvoiceHeader."E-Invoice No." + '",' +
             //'"GSTIN":"' + '29AAACW3775F000' + '",' +
             '"GSTIN":"' + recLocation."GST Registration No." + '",' +
          '"CnlRsn":"1",' +
          '"CnlRem":"Remarks",' +

           '"CDKey":"' + '1690165' + '",' +
           '"EFUserName":"' + '9DDF892A-B93D-40A0-A179-8A19E0F2B7FB' + '",' +
           '"EFPassword":"' + '59666FB2-F035-45EA-B4C8-73EAA51A76E0' + '",' +
           '"EInvUserName":"' + recGSTRegistrationNos."E-Invoicing User Name" + '",' +
           '"EInvPassword":"' + recGSTRegistrationNos."E-Invoicing User Password" + '"' +
          /*
          '"CDKey":"' + '1000687' + '",' +
         '"EFUserName":"' + '29AAACW3775F000' + '",' +
         '"EFPassword":"' + 'Admin!23..' + '",' +
         '"EInvUserName":"' + '29AAACW3775F000' + '",' +
         '"EInvPassword":"' + 'Admin!23..' + '"' +
         */
          '}]}}';
        //    MESSAGE(Body);
        Clear(gResponseMsg);
        gContent.WriteFrom(Body);
        gContent.GetHeaders(gContentHeaders);
        gContentHeaders.Clear();
        gContentHeaders.Add('Content-Type', 'application/json');
        //    http://einvsandbox.webtel.in/v1.03/CanIRN
        //if gHttpClient.Post('http://einvsandbox.webtel.in/v1.03/CanIRN', gContent, gHttpResponseMsg) then begin
        if gHttpClient.Post('http://Einvlive.webtel.in/v1.03/CanIRN', gContent, gHttpResponseMsg) then begin
            gHttpResponseMsg.Content.ReadAs(JsonText);
            //   Message(JsonText);
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                IF (UPPERCASE(GetResponsesValue(JsonText, '"CancelDate":', ',', 1)) <> '') THEN BEGIN
                    dtCanDate := CREATEDATETIME(0D, 0T);
                    dtCanDate := ConvertTextToDate(UPPERCASE(GetResponsesValue(JsonText, '"CancelDate":', ',', 1)));
                    SalesInvoiceHeader2.GET(SalesInvoiceHeader."No.");
                    SalesInvoiceHeader2."E-Invoice Status" := SalesInvoiceHeader2."E-Invoice Status"::Cancelled;
                    SalesInvoiceHeader2."E-Invoice Cancel Date" := dtCanDate;
                    SalesInvoiceHeader2.MODIFY;
                    MESSAGE('E-Invoice has been cancelled');
                END
                // ELSE
                //     ERROR('Please see Reason %1', JsonText);
            END;
        END;
    END;


    procedure CancelSalesCrMemoEInvoice(SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var

        APIIntegrationSetup: Record "Sales & Receivables Setup";
        APIResponse: Text;

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
        recLocation: Record Location;
        txtStatus: Text;
        dtCanDate: DateTime;
        SalesInvoiceHeader2: Record "Sales Cr.Memo Header";
        txtFileName: Text;
        recGSTRegistrationNos: Record "GST Registration Nos.";
    begin
        SalesCrMemoHeader.TESTFIELD("E-Invoice Status", SalesCrMemoHeader."E-Invoice Status"::Generated);
        recLocation.GET(SalesCrMemoHeader."Location Code");
        recGSTRegistrationNos.GET(recLocation."GST Registration No.");
        recGSTRegistrationNos.TESTFIELD("E-Invoicing User Name");
        recGSTRegistrationNos.TESTFIELD("E-Invoicing User Password");
        Body := '{' +
          '"Push_Data_List": {"Data": [{' +
          '"Irn":"' + SalesCrMemoHeader."E-Invoice No." + '",' +
                    //'"GSTIN":"' + '29AAACW3775F000' + '",' +
                    '"GSTIN":"' + recLocation."GST Registration No." + '",' +
          '"CnlRsn":"1",' +
          '"CnlRem":"Remarks",' +

             '"CDKey":"' + '1690165' + '",' +
             '"EFUserName":"' + '9DDF892A-B93D-40A0-A179-8A19E0F2B7FB' + '",' +
             '"EFPassword":"' + '59666FB2-F035-45EA-B4C8-73EAA51A76E0' + '",' +
             '"EInvUserName":"' + recGSTRegistrationNos."E-Invoicing User Name" + '",' +
             '"EInvPassword":"' + recGSTRegistrationNos."E-Invoicing User Password" + '"' +
          /*
          '"CDKey":"' + '1000687' + '",' +
       '"EFUserName":"' + '29AAACW3775F000' + '",' +
       '"EFPassword":"' + 'Admin!23..' + '",' +
       '"EInvUserName":"' + '29AAACW3775F000' + '",' +
       '"EInvPassword":"' + 'Admin!23..' + '"' +
       */
          '}]}}';
        //   MESSAGE(Body);
        Clear(gResponseMsg);
        gContent.WriteFrom(Body);
        gContent.GetHeaders(gContentHeaders);
        gContentHeaders.Clear();
        gContentHeaders.Add('Content-Type', 'application/json');
        //if gHttpClient.Post('http://einvsandbox.webtel.in/v1.03/CanIRN', gContent, gHttpResponseMsg) then begin
        if gHttpClient.Post('http://Einvlive.webtel.in/v1.03/CanIRN', gContent, gHttpResponseMsg) then begin
            gHttpResponseMsg.Content.ReadAs(JsonText);
            //    Message(JsonText);
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                IF (UPPERCASE(GetResponsesValue(JsonText, '"CancelDate":', ',', 1)) <> '') THEN BEGIN
                    dtCanDate := CREATEDATETIME(0D, 0T);
                    dtCanDate := ConvertTextToDate(UPPERCASE(GetResponsesValue(JsonText, '"CancelDate":', ',', 1)));
                    SalesInvoiceHeader2.GET(SalesCrMemoHeader."No.");
                    SalesInvoiceHeader2."E-Invoice Status" := SalesInvoiceHeader2."E-Invoice Status"::Cancelled;
                    SalesInvoiceHeader2."E-Invoice Cancel Date" := dtCanDate;
                    SalesInvoiceHeader2.MODIFY;
                    MESSAGE('E-Invoice has been cancelled');
                END
                // ELSE
                //     ERROR('Please see Reason %1', JsonText);
            END;
        END;
    END;



    procedure GenerateSalesCrMemoEInvoice(SalesCrMemoHeader: Record "Sales Cr.Memo Header")
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
        Json: Text;
        blnValidateGST: Boolean;
        recDetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        decInvoiceValue: array[10] of Decimal;
        decInvoiceValue1: array[10] of Decimal;
        recSalesInvoiceLines: Record "Sales Invoice Line";
        blnExportWithoutPayment: Boolean;
        TknNo: Text;
        txtRoundingGLAccounts: Text;
        recCustomerPostingGroup: Record "Customer Posting Group";
        txtRoundingAccount: Text;
        recLocation: Record Location;
        recCustomer: Record Customer;
        recGSTLedgerEntry: Record "GST Ledger Entry";
        intSrNo: Integer;
        recState: Record State;
        cdEInvoiceNo: Code[70];
        cdEinvoiceDate: DateTime;
        SalesInvoiceHeader2: Record "Sales Cr.Memo Header";
        txtQRCode: Text;
        recUnitOfMeasure: Record "Unit of Measure";
        txtFileName: Text;
        recShipToAddress: Record "Ship-to Address";
        recGSTRegistrationNos: Record "GST Registration Nos.";
        SalesSetup: Record "Sales & Receivables Setup";
        CompanyInfo: Record "Company Information";
        MainJsonObject: JsonObject;
        JsonArrayData: JsonArray;
        JItem: JsonObject;
        GSTPer: Decimal;
        TDSEntry: Record "TCS Entry";
        TDSAmt: Decimal;
        QRCodeInput: Text[300];
        QRCodeFileName: text[300];
        TempBlob: Codeunit "Temp Blob";
        QRFieldRef: FieldRef;
        QRRecRef: RecordRef;
        InputFile: File;
        InStream: InStream;
        OutStream: OutStream;
        proOrder: Record "Production Order";
        SalesPost: Codeunit 80;
        recSalesCrMemoLines: Record "Sales Cr.Memo Line";
    begin

        blnValidateGST := FALSE;
        IF SalesCrMemoHeader."Currency Code" = '' THEN BEGIN
            blnValidateGST := TRUE;
            recDetailedGSTLedgerEntry.RESET;
            recDetailedGSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoHeader."No.");
            recDetailedGSTLedgerEntry.FINDFIRST;
            recDetailedGSTLedgerEntry.TESTFIELD("Buyer/Seller Reg. No.");
        END;

        Clear(TDSAmt);
        TDSEntry.Reset();
        TDSEntry.SetRange("Document No.", SalesCrMemoHeader."No.");
        if TDSEntry.FindFirst() then
            repeat
                TDSAmt += ABS(TDSEntry."TCS Amount");
            until TDSEntry.Next() = 0;

        CLEAR(decInvoiceValue);
        recSalesCrMemoLines.RESET;
        recSalesCrMemoLines.SETRANGE("Document No.", SalesCrMemoHeader."No.");
        recSalesCrMemoLines.SETFILTER(Quantity, '<>%1', 0);
        recSalesCrMemoLines.FINDFIRST;
        REPEAT
            recDetailedGSTLedgerEntry.Reset();
            recDetailedGSTLedgerEntry.SetRange("Document No.", recSalesCrMemoLines."Document No.");
            recDetailedGSTLedgerEntry.SetRange("Document Line No.", recSalesCrMemoLines."Line No.");
            if recDetailedGSTLedgerEntry.FindFirst() then
                repeat
                    decInvoiceValue[10] += recDetailedGSTLedgerEntry."GST %";
                until recDetailedGSTLedgerEntry.Next() = 0;
        //    decInvoiceValue[10] += recSalesCrMemoLines."Total GST Amount";
        UNTIL recSalesCrMemoLines.NEXT = 0;

        IF blnValidateGST THEN BEGIN
            IF decInvoiceValue[10] = 0 THEN
                ERROR('GST must be calculated to generate E-Invoice.');
        END ELSE BEGIN
            IF decInvoiceValue[10] = 0 THEN
                blnExportWithoutPayment := TRUE
            ELSE
                blnExportWithoutPayment := FALSE;
        END;

        SalesCrMemoHeader.TESTFIELD("E-Invoice Status", SalesCrMemoHeader."E-Invoice Status"::Open);

        txtRoundingGLAccounts := '';
        recCustomerPostingGroup.RESET;
        recCustomerPostingGroup.SetRange(Code, SalesCrMemoHeader."Customer Posting Group");
        if recCustomerPostingGroup.FINDFIRST then
            repeat
                IF txtRoundingGLAccounts = '' THEN
                    txtRoundingGLAccounts := '<>' + recCustomerPostingGroup."Invoice Rounding Account"
                ELSE
                    txtRoundingGLAccounts := txtRoundingGLAccounts + '&<>' + recCustomerPostingGroup."Invoice Rounding Account";

                IF txtRoundingAccount = '' THEN
                    txtRoundingAccount := recCustomerPostingGroup."Invoice Rounding Account"
                ELSE
                    txtRoundingAccount := txtRoundingAccount + '|' + recCustomerPostingGroup."Invoice Rounding Account";
            UNTIL recCustomerPostingGroup.NEXT = 0;

        recLocation.GET(SalesCrMemoHeader."Location Code");
        recGSTRegistrationNos.GET(recLocation."GST Registration No.");
        recGSTRegistrationNos.TESTFIELD("E-Invoicing User Name");
        recGSTRegistrationNos.TESTFIELD("E-Invoicing User Password");
        recCustomer.GET(SalesCrMemoHeader."Bill-to Customer No.");
        CompanyInfo.GET;

        CLEAR(decInvoiceValue);
        recSalesCrMemoLines.RESET;
        recSalesCrMemoLines.SETRANGE("Document No.", SalesCrMemoHeader."No.");
        recSalesCrMemoLines.SETFILTER("No.", txtRoundingGLAccounts);
        recSalesCrMemoLines.SETFILTER(Quantity, '<>%1', 0);
        IF recSalesCrMemoLines.FINDFIRST THEN
            REPEAT
                decInvoiceValue[1] += ROUND(recSalesCrMemoLines.Quantity * recSalesCrMemoLines."Unit Price", 0.01);
                decInvoiceValue[2] += recSalesCrMemoLines."Line Discount Amount";
                decInvoiceValue[3] += recSalesCrMemoLines."Line Amount";
            //   decInvoiceValue[4] += recSalesCrMemoLines."Amount To Customer";
            UNTIL recSalesCrMemoLines.NEXT = 0;
        /*
                Clear(GSTPer);
                recSalesCrMemoLines.RESET;
                recSalesCrMemoLines.SETRANGE("Document No.", SalesCrMemoHeader."No.");
                recSalesCrMemoLines.SETFILTER("No.", txtRoundingGLAccounts);
                recSalesCrMemoLines.SETFILTER(Quantity, '<>%1', 0);
                IF recSalesCrMemoLines.FINDFIRST THEN
                    REPEAT
                        recDetailedGSTLedgerEntry.Reset();
                        recDetailedGSTLedgerEntry.SetRange("Document No.", recSalesCrMemoLines."Document No.");
                        recDetailedGSTLedgerEntry.SetRange("Document Line No.", recSalesCrMemoLines."Line No.");
                        if recDetailedGSTLedgerEntry.FindFirst() then
                            repeat
                                GSTPer += recDetailedGSTLedgerEntry."GST %";
                            until recDetailedGSTLedgerEntry.Next() = 0;
                    until recSalesCrMemoLines.Next() = 0;
                    */
        recGSTLedgerEntry.RESET;
        recGSTLedgerEntry.SETRANGE("Document No.", SalesCrMemoHeader."No.");
        IF recGSTLedgerEntry.FINDFIRST THEN
            REPEAT
                IF recGSTLedgerEntry."GST Component Code" = 'IGST' THEN
                    decInvoiceValue[5] += ABS(recGSTLedgerEntry."GST Amount")
                ELSE
                    IF recGSTLedgerEntry."GST Component Code" = 'CGST' THEN
                        decInvoiceValue[6] += ABS(recGSTLedgerEntry."GST Amount")
                    ELSE
                        IF recGSTLedgerEntry."GST Component Code" = 'SGST' THEN
                            decInvoiceValue[7] += ABS(recGSTLedgerEntry."GST Amount");
            UNTIL recGSTLedgerEntry.NEXT = 0;
        //decInvoiceValue[4] := decInvoiceValue[1] + decInvoiceValue[5] + decInvoiceValue[6] + decInvoiceValue[7];// Suman
        decInvoiceValue[4] := decInvoiceValue[3] + decInvoiceValue[5] + decInvoiceValue[6] + decInvoiceValue[7] + TDSAmt;
        decInvoiceValue[10] := decInvoiceValue[5] + decInvoiceValue[6] + decInvoiceValue[7];

        recSalesCrMemoLines.RESET;
        recSalesCrMemoLines.SETRANGE("Document No.", SalesCrMemoHeader."No.");
        recSalesCrMemoLines.SETFILTER("No.", txtRoundingAccount);
        recSalesCrMemoLines.SETFILTER(Quantity, '<>%1', 0);
        IF recSalesCrMemoLines.FINDFIRST THEN
            REPEAT
                decInvoiceValue[8] += recSalesCrMemoLines."Line Amount";
            UNTIL recSalesCrMemoLines.NEXT = 0;
        decInvoiceValue[4] := decInvoiceValue[4] + decInvoiceValue[8];

        intSrNo := 0;

        recSalesCrMemoLines.RESET;
        recSalesCrMemoLines.SETRANGE("Document No.", SalesCrMemoHeader."No.");
        recSalesCrMemoLines.SETFILTER("No.", txtRoundingGLAccounts);
        recSalesCrMemoLines.SETFILTER(Quantity, '<>%1', 0);
        IF recSalesCrMemoLines.FINDFIRST THEN BEGIN
            repeat
                Clear(GSTPer);
                Clear(decInvoiceValue1);
                recDetailedGSTLedgerEntry.Reset();
                recDetailedGSTLedgerEntry.SetRange("Document No.", recSalesCrMemoLines."Document No.");
                recDetailedGSTLedgerEntry.SetRange("Document Line No.", recSalesCrMemoLines."Line No.");
                if recDetailedGSTLedgerEntry.FindFirst() then
                    repeat
                        GSTPer += recDetailedGSTLedgerEntry."GST %";
                        IF recDetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN
                            decInvoiceValue1[5] += ABS(recDetailedGSTLedgerEntry."GST Amount")

                        ELSE
                            IF recDetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN
                                decInvoiceValue1[6] += ABS(recDetailedGSTLedgerEntry."GST Amount")
                            ELSE
                                IF recDetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN
                                    decInvoiceValue1[7] += ABS(recDetailedGSTLedgerEntry."GST Amount");

                    until recDetailedGSTLedgerEntry.Next() = 0;
                Clear(JItem);
                //   JItem.Add('GSTIN', '29AAACW3775F000');
                JItem.Add('GSTIN', recLocation."GST Registration No.");
                JItem.Add('Version', '1.01');
                JItem.Add('Tran_TaxSch', 'GST');

                IF SalesCrMemoHeader."Currency Code" = '' THEN
                    JItem.Add('Tran_SupTyp', 'B2B')
                ELSE
                    IF blnExportWithoutPayment THEN
                        JItem.Add('Tran_SupTyp', 'EXPWOP')
                    ELSE
                        JItem.Add('Tran_SupTyp', 'EXPWP');

                JItem.Add('Tran_RegRev', 'N');
                JItem.Add('Tran_Typ', 'REG');
                JItem.Add('Doc_Typ', 'CRN');

                IF STRLEN(SalesCrMemoHeader."No.") > 16 THEN
                    JItem.Add('Doc_No', COPYSTR(SalesCrMemoHeader."No.", STRPOS(SalesCrMemoHeader."No.", '-') + 1, 16))
                ELSE
                    JItem.Add('Doc_No', SalesCrMemoHeader."No.");
                JItem.Add('Doc_Dt', ConvertDateToTextDDMMYYYY(SalesCrMemoHeader."Posting Date"));
                //JItem.Add('BillFrom_Gstin', '29AAACW3775F000');
                JItem.Add('BillFrom_Gstin', recLocation."GST Registration No.");
                JItem.Add('BillFrom_LglNm', CompanyInfo.Name);
                JItem.Add('BillFrom_TrdNm', CompanyInfo.Name);
                JItem.Add('BillFrom_Addr1', recLocation.Address);
                JItem.Add('BillFrom_Loc', recLocation.City);
                //JItem.Add('BillFrom_Pin', '562160');
                JItem.Add('BillFrom_Pin', recLocation."Post Code");

                recState.GET(recLocation."State Code");
                // JItem.Add('BillFrom_Stcd', '29');
                JItem.Add('BillFrom_Stcd', recState."State Code (GST Reg. No.)");

                // JItem.Add('BillTo_Gstin', '07AAACW3775F1Z8');
                JItem.Add('BillTo_Gstin', recCustomer."GST Registration No.");
                JItem.Add('BillTo_LglNm', recCustomer.Name);
                JItem.Add('BillTo_TrdNm', recCustomer.Name);

                IF SalesCrMemoHeader."Currency Code" = '' THEN BEGIN
                    recState.GET(SalesCrMemoHeader."GST Bill-to State Code");
                    recState.TESTFIELD("State Code (GST Reg. No.)");
                    JItem.Add('BillTo_Pos', recState."State Code (GST Reg. No.)");
                END ELSE BEGIN
                    JItem.Add('BillTo_Pos', '96');
                END;

                //JItem.Add('BillTo_Pos', '07');
                JItem.Add('BillTo_Addr1', SalesCrMemoHeader."Bill-to Address");
                JItem.Add('BillTo_Loc', SalesCrMemoHeader."Bill-to City");

                //   JItem.Add('BillTo_Pin', '110008');
                JItem.Add('BillTo_Pin', SalesCrMemoHeader."Bill-to Post Code");
                JItem.Add('BillTo_State', recState.Description);

                //        JItem.Add('BillTo_Stcd', '07');
                JItem.Add('BillTo_Stcd', recState."State Code (GST Reg. No.)");

                IF SalesCrMemoHeader."Ship-to Code" <> '' THEN BEGIN
                    recShipToAddress.GET(SalesCrMemoHeader."Sell-to Customer No.", SalesCrMemoHeader."Ship-to Code");
                    JItem.Add('ShipTo_Gstin', recShipToAddress."GST Registration No.");
                    JItem.Add('ShipTo_LglNm', recShipToAddress.Name);
                    JItem.Add('ShipTo_TrdNm', recShipToAddress.Name);
                    JItem.Add('ShipTo_Addr1', recShipToAddress.Address);
                    JItem.Add('ShipTo_Addr2', recShipToAddress."Address 2");
                    JItem.Add('ShipTo_Loc', recShipToAddress.City);
                    JItem.Add('ShipTo_Pin', recShipToAddress."Post Code");
                    recState.GET(recShipToAddress.State);
                    JItem.Add('ShipTo_Stcd', recState."State Code (GST Reg. No.)");
                END;

                intSrNo += 1;
                JItem.Add('Item_SlNo', intSrNo);
                JItem.Add('Item_PrdDesc', recSalesCrMemoLines.Description);

                IF recSalesCrMemoLines."GST Group Type" = recSalesCrMemoLines."GST Group Type"::Goods THEN
                    JItem.Add('Item_IsServc', 'N')
                ELSE
                    JItem.Add('Item_IsServc', 'Y');

                //JItem.Add('Item_IsServc', 'N');
                //JItem.Add('Item_IsServc', 'Y');
                //IF STRLEN(recSalesCrMemoLines."HSN/SAC Code") > 4 THEN
                //  JItem.Add('Item_HsnCd', COPYSTR(recSalesCrMemoLines."HSN/SAC Code", 1, 4))
                //ELSE
                JItem.Add('Item_HsnCd', recSalesCrMemoLines."HSN/SAC Code");
                JItem.Add('Item_Qty', recSalesCrMemoLines.Quantity);

                IF recUnitOfMeasure.GET(recSalesCrMemoLines."Unit of Measure Code") THEN BEGIN
                    IF recUnitOfMeasure."E-Invoicing UOM Code" <> '' THEN
                        JItem.Add('Item_Unit', recUnitOfMeasure."E-Invoicing UOM Code")
                    ELSE
                        JItem.Add('Item_Unit', recSalesCrMemoLines."Unit of Measure Code");
                END;

                JItem.Add('Item_UnitPrice', ROUND(recSalesCrMemoLines."Unit Price", 0.001));
                JItem.Add('Item_TotAmt', ROUND(recSalesCrMemoLines.Quantity * recSalesCrMemoLines."Unit Price", 0.01));
                JItem.Add('Item_Discount', recSalesCrMemoLines."Line Discount Amount");
                JItem.Add('Item_AssAmt', recSalesCrMemoLines."Line Amount");

                JItem.Add('Item_GstRt', GSTPer);
                JItem.Add('Item_OthChrg', TDSAmt);

                IF recSalesCrMemoLines."GST Jurisdiction Type" = recSalesCrMemoLines."GST Jurisdiction Type"::Interstate THEN BEGIN
                    JItem.Add('Item_IgstAmt', decInvoiceValue1[5]);
                END ELSE BEGIN
                    JItem.Add('Item_CgstAmt', decInvoiceValue1[6]);
                    JItem.Add('Item_SgstAmt', decInvoiceValue1[6]);
                END;

                JItem.Add('Item_TotItemVal', TDSAmt + recSalesCrMemoLines.Amount + decInvoiceValue1[6] + decInvoiceValue1[6] + decInvoiceValue1[5]);
                JItem.Add('Val_AssVal', decInvoiceValue[3]);

                JItem.Add('Val_CgstVal', decInvoiceValue[6]);
                JItem.Add('Val_SgstVal', decInvoiceValue[7]);
                JItem.Add('Val_IgstVal', decInvoiceValue[5]);
                JItem.Add('Val_CesVal', 0);
                JItem.Add('Val_StCesVal', 0);
                JItem.Add('Val_RndOffAmt', decInvoiceValue[8]);
                JItem.Add('Val_CesNonAdVal', '0');
                JItem.Add('Val_TotInvVal', decInvoiceValue[4]);

                IF SalesCrMemoHeader."Currency Code" <> '' THEN BEGIN
                    JItem.Add('Exp_ForCur', SalesCrMemoHeader."Currency Code");
                END;

                JItem.Add('CDKey', '1690165');
                JItem.Add('EInvUserName', recGSTRegistrationNos."E-Invoicing User Name");
                JItem.Add('EInvPassword', recGSTRegistrationNos."E-Invoicing User Password");
                JItem.Add('EFUserName', '9DDF892A-B93D-40A0-A179-8A19E0F2B7FB');
                JItem.Add('EFPassword', '59666FB2-F035-45EA-B4C8-73EAA51A76E0');

                /*
                JItem.Add('CDKey', '1000687');
                JItem.Add('EInvUserName', '29AAACW3775F000');
                JItem.Add('EInvPassword', 'Admin!23..');
                JItem.Add('EFUserName', '29AAACW3775F000');
                JItem.Add('EFPassword', 'Admin!23..');
                */
                JsonArrayData.Add(JItem);
                TDSAmt := 0;
            UNTIL recSalesCrMemoLines.NEXT = 0;
        END;
        MainJsonObject.Add('Data', JsonArrayData);
        clear(Body1);
        Body := '{' +
        '"Push_Data_List":';
        MainJsonObject.WriteTo(Body1);
        Body += Body1 + '}';
        MESSAGE(Body);
        //MESSAGE(APIResponse);

        Clear(gResponseMsg);
        gContent.WriteFrom(Body);
        gContent.GetHeaders(gContentHeaders);
        gContentHeaders.Clear();
        gContentHeaders.Add('Content-Type', 'application/json');
        //if gHttpClient.Post('http://einvsandbox.webtel.in/v1.03/GenIRN', gContent, gHttpResponseMsg) then begin
        if gHttpClient.Post('http://einvlive.webtel.in/v1.03/GenIRN', gContent, gHttpResponseMsg) then begin
            gHttpResponseMsg.Content.ReadAs(Json);
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                //MESSAGE(Json);
                IF (GetResponsesValue(Json, '"ErrorCode', ',', 1) = '') THEN BEGIN
                    cdEInvoiceNo := GetResponsesValue(Json, '"Irn', ',', 1);
                    cdEinvoiceDate := ConvertTextToDate(GetResponsesValue(Json, '"AckDate', ',', 1));
                    COMMIT;
                    IF cdEInvoiceNo <> '' THEN BEGIN
                        SalesInvoiceHeader2.GET(SalesCrMemoHeader."No.");
                        SalesInvoiceHeader2."E-Invoice Status" := SalesInvoiceHeader2."E-Invoice Status"::Generated;
                        SalesInvoiceHeader2."E-Invoice No." := cdEInvoiceNo;
                        QRCodeFileName := GetQRCode(GetResponsesValue(Json, '"SignedQRCode', ',', 1));
                        InputFile.Open(QRCodeFileName);
                        InputFile.CreateInStream(InStream);
                        SalesInvoiceHeader2."E-Invoice QR Code".CreateOutStream(OutStream);
                        CopyStream(OutStream, InStream);
                        InputFile.Close;
                        IF ERASE(QRCodeFileName) THEN;

                        SalesInvoiceHeader2."E-Invoice Date" := cdEinvoiceDate;
                        SalesInvoiceHeader2.MODIFY;
                        MESSAGE('E-Invoice Generated');
                    END;
                END ELSE
                    ERROR('%1 Please share this request ID for support %2', GetResponsesValue(Json, '"ErrorMessage', ',', 1), GetResponsesValue(Json, '"ErrorCode', ',', 1));
            END;
        END;

    END;
    //   END;
}