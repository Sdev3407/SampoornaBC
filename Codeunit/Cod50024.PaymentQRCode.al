codeunit 50024 PaymentQRCode
{
    procedure GetAccessToken(DocNo: Code[20]): Text
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



        //MESSAGE(APIResponse);
        Clear(AccessTok);
        Clear(gResponseMsg);
        gContent.WriteFrom(Body);
        gContent.GetHeaders(gContentHeaders);
        gContentHeaders.Clear();
        gContentHeaders.Add('Content-Type', 'application/json');
        if gHttpClient.Post('https://commonapi.mastersindia.co/oauth/access_token', gContent, gHttpResponseMsg) then begin
            gHttpResponseMsg.Content.ReadAs(Json);
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                // MESSAGE(Json);
                IF (GetResponsesValue(Json, '"access_token', ',', 1) <> '') THEN BEGIN
                    AccessTok := GetResponsesValue(Json, '"access_token', ',', 1);
                    GenerateVertualPayQR(DocNo, AccessTok);
                    exit(AccessTok);
                END
                // ELSE
                //     ERROR('Please see Reason %1', JsonText);
            END;
        END;
    END;

    procedure GenerateVertualPayQR(DocumentNo: Code[30]; AccessTockenKey: Text)
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
        CompanyInformation: Record "Company Information";
        Customer: Record Customer;
        BankAccount: Record "Bank Account";
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        IGST: Decimal;
        CGST: Decimal;
        SGST: Decimal;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        CESS: Decimal;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        Dt: Text;
        InputFile: File;
        InStream: InStream;
        OutStream: OutStream;
        QRCodeFileName: text;
        CUBase64: Codeunit "Base64 Convert";
        TempBlo: Codeunit "Temp Blob";
        Item: Record Item;
        TEn: Record 2000000183;
        ma: Record "Tenant Media";
        item1: Record "Sales Invoice Header";
        media: Record "Tenant Media";
        instr: InStream;
        outstr: OutStream;
        temblob: Codeunit "Temp Blob";
        index: Integer;
        FILEMAn: Codeunit "File Management";
        Txt: Text;
        WebClient: DotNet WebClient;
        //Bytes: DotNet ArrayByte;
        MemStream: DotNet MemoryStream;
        UPIID: Text;
        AccountNo: Text;
        CompanyInfo: Record "Company Information";
    begin
        //  CLEARALL;
        CompanyInfo.Get;
        SalesInvoiceHeader.RESET;
        SalesInvoiceHeader.SETRANGE("No.", DocumentNo);
        IF SalesInvoiceHeader.FINDFIRST THEN BEGIN

            CompanyInformation.GET;
            SalesReceivablesSetup.GET;
            Customer.RESET;
            BankAccount.RESET;
            BankAccount.SETRANGE(BankAccount."No.", SalesInvoiceHeader."Bank Account No.");
            IF BankAccount.FINDFIRST THEN;
            IF Customer.GET(SalesInvoiceHeader."Sell-to Customer No.") THEN;
            DetailedGSTLedgerEntry.RESET;
            DetailedGSTLedgerEntry.SETRANGE(DetailedGSTLedgerEntry."Document No.", SalesInvoiceHeader."No.");
            DetailedGSTLedgerEntry.SETRANGE(DetailedGSTLedgerEntry."Document Type", DetailedGSTLedgerEntry."Document Type"::Invoice);
            IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
                REPEAT
                    IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN
                        IGST += ABS(DetailedGSTLedgerEntry."GST Amount");
                    IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN
                        CGST += ABS(DetailedGSTLedgerEntry."GST Amount");
                    IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN
                        SGST += ABS(DetailedGSTLedgerEntry."GST Amount");
                UNTIL DetailedGSTLedgerEntry.NEXT = 0;
            END;
            CESS := 0;
            Dt := FORMAT(SalesInvoiceHeader."Posting Date", 0, '<Year4>-<Month,2>-<Day,2>');
            if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] Then Begin
                SalesInvoiceHeader.CALCFIELDS(Amount);
                if SalesInvoiceHeader."Shortcut Dimension 1 Code" = 'FEED' Then begin
                    UPIID := 'SFFD01' + SalesInvoiceHeader."Bill-to Customer No." + '@hdfcbank';
                    AccountNo := 'SFFD01' + SalesInvoiceHeader."Bill-to Customer No.";
                end;
                if SalesInvoiceHeader."Shortcut Dimension 1 Code" = 'BREEDER' Then begin
                    UPIID := 'SFBR01' + SalesInvoiceHeader."Bill-to Customer No." + '@hdfcbank';
                    AccountNo := 'SFBR01' + SalesInvoiceHeader."Bill-to Customer No."
                end;
                if SalesInvoiceHeader."Shortcut Dimension 1 Code" = 'CBF' Then begin
                    UPIID := 'SFCB01' + SalesInvoiceHeader."Bill-to Customer No." + '@hdfcbank';
                    AccountNo := 'SFCB01' + SalesInvoiceHeader."Bill-to Customer No."
                end;
                if SalesInvoiceHeader."Shortcut Dimension 1 Code" = 'CATTLE' Then begin
                    UPIID := 'SFCT01' + SalesInvoiceHeader."Bill-to Customer No." + '@hdfcbank';
                    AccountNo := 'SFCT01' + SalesInvoiceHeader."Bill-to Customer No."
                end;
                if SalesInvoiceHeader."Shortcut Dimension 1 Code" = 'HATCH' Then begin
                    UPIID := 'SFHT01' + SalesInvoiceHeader."Bill-to Customer No." + '@hdfcbank';
                    AccountNo := 'SFHT01' + SalesInvoiceHeader."Bill-to Customer No."
                end;
                if SalesInvoiceHeader."Shortcut Dimension 1 Code" = 'SWINE' Then begin
                    UPIID := 'SFSW01' + SalesInvoiceHeader."Bill-to Customer No." + '@hdfcbank';
                    AccountNo := 'SFSW01' + SalesInvoiceHeader."Bill-to Customer No."
                end;
            End Else begin
                UPIID := SalesReceivablesSetup."UPI ID";
            end;


            URL := 'https://pro.mastersindia.co/PaymentApi/create_payment?access_token=' + AccessTockenKey +
            '&supplier_gstin=' + FORMAT(SalesInvoiceHeader."Location GST Reg. No.") +
            '&supplier_upi_id=' + UPIID +
            '&supplier_name=' + FORMAT(CompanyInformation.Name) +
            '&payee_account_number=' + Format(BankAccount."Bank Account No.") +
            '&payee_ifsc=' + FORMAT(BankAccount."IFSC Code") +
            '&invoice_number=' + SalesInvoiceHeader."No." +
            '&invoice_date=' + Dt +
            '&invoice_total_value=' + DELCHR(FORMAT(SalesInvoiceHeader.Amount + CGST + SGST + IGST), '=', ',') +
            '&invoice_cgst=' + DELCHR(FORMAT(CGST), '=', ',') +
            '&invoice_sgst=' + DELCHR(FORMAT(SGST), '=', ',') +
            '&invoice_igst=' + DELCHR(FORMAT(IGST), '=', ',') +
             '&invoice_cess=0' + '';
            //  Message(URL);
            CLEAR(APIResponse);
            Clear(gResponseMsg);
            gContent.GetHeaders(gContentHeaders);
            gContentHeaders.Clear();
            WebClient := WebClient.WebClient;
            // Bytes := WebClient.DownloadData(URL);
            // //message(Format(Bytes.GetValue(1, 2)));
            // MemStream := MemStream.MemoryStream(Bytes);
            //Message('%1', MemStream.Length);
            SalesInvoiceHeader."Payment QR Code".CreateOutStream(OutStream);
            MemStream.WriteTo(OutStream);
            SalesInvoiceHeader."Pay QR Created" := true;
            SalesInvoiceHeader.Modify();
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
        IF NOT (Lstr = 'StatusDate') THEN
            Resp1 := DELCHR(Resp1, '=', ' ');
        Resp1 := DELCHR(Resp1, '=', '"');
        Resp1 := DELCHR(Resp1, '<', ':');
        Resp1 := DELCHR(Resp1, '=', '\');
        EXIT(Resp1);
    END;


    [Scope('OnPrem')]
    LOCAL procedure GetQRCode(QRCodeInput: Text) QRCodeFileName: Text
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


}
