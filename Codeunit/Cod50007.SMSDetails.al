codeunit 50007 "SMS Details"
{
    // /// New Codeunit Created : PRU_AS 21 NOV 2019
    // /// Created function SMSSendAtInvoice() : PRU_AS 21 NOV 2019
    // /// Created function BankReceiptVoucherDetailsSMS() : PRU_AS 21 NOV 2019
    // /// Created function BankCustomerReFundDetailsSMS() : PRU_AS 21 NOV 2019
    // //Old LInk 'http://sms.globalweb.net.in/api/sendmsg.php?user=sampoornafeeds&pass=123456&sender=SAMPOO&phone=


    trigger OnRun()
    begin
    end;

    var
        SMSfunctions: Codeunit 50018;
        CompanyInfo: Record "Company Information";



    procedure SMSSendAtInvoice(var ParaSaleInvHeader: Record 112)
    var
        CustomerPhone: Text;
        ShiptoAdd: Record 222;
        TotalQuantity: Decimal;
        TotalAmount: Decimal;
        TotalUnitPrice: Decimal;
        TotalLineAmt: Decimal;
        SMSBody: Text[1024];
        CustomerInfo: Record 18;
        ParaSalesInvLine: Record 113;
        SMSTxt: Label 'A/c  "%1" purchased live birds from SFPL against DC - %2 , %3  %4  "@" Rs. %5/%6 Amount Rs. %7 and Birds %8 %9. Thank you.&priority=ndnd&stype=normal';
        Checkbool: Boolean;
        CompanyInfo: Record "Company Information";
        SaleandRec: Record "Sales & Receivables Setup";
    begin
        CustomerPhone := '';
        SaleandRec.Get;
        CompanyInfo.Get;
        IF CustomerInfo.GET(ParaSaleInvHeader."Sell-to Customer No.") THEN BEGIN
            IF CustomerInfo."Phone No." <> '' THEN BEGIN
                CustomerPhone := CustomerInfo."Phone No.";
            END ELSE BEGIN
                //ERROR('Customer Phone no. not found for %1', CustomerInfo.Name);
            END;
        END;

        TotalQuantity := 0;
        TotalAmount := 0;
        TotalUnitPrice := 0;
        TotalLineAmt := 0;

        ParaSalesInvLine.RESET;
        ParaSalesInvLine.SETRANGE("Document No.", ParaSaleInvHeader."No.");
        ParaSalesInvLine.SETFILTER(Quantity, '<>%1', 0);
        ParaSalesInvLine.SETRANGE("Shortcut Dimension 1 Code", 'CBF');
        IF ParaSalesInvLine.FINDSET THEN BEGIN
            REPEAT
                IF ParaSalesInvLine.Type = ParaSalesInvLine.Type::Item THEN BEGIN
                    TotalQuantity := ParaSalesInvLine.Quantity;
                    TotalUnitPrice := ParaSalesInvLine."Unit Price";
                    TotalLineAmt := ParaSalesInvLine."Line Amount";
                    IF CustomerPhone <> '' THEN BEGIN
                        SMSBody := 'https://pgapi.vispl.in/fe/api/v1/multiSend?username=samprnpg.trans&password=' + SaleandRec."SMS Password" + '&unicode=false&from=' + SaleandRec."Sender ID" + '&to=' + CustomerPhone + '&text=A/C' + ' ' + FORMAT(ParaSaleInvHeader."Sell-to Customer No.") + ' ' +
    'purchased live birds from SFPL against DC -' + FORMAT(ParaSaleInvHeader."External Document No.") + ', ' + FORMAT(TotalQuantity) + ' ' + FORMAT(ParaSalesInvLine."Unit of Measure Code") + ' ' + '(Rs ' + FORMAT(TotalUnitPrice) + '/' +
    FORMAT(ParaSalesInvLine."Unit of Measure Code") + ') Amount Rs. ' + FORMAT(TotalLineAmt) + ' and Birds - ' + FORMAT(ParaSalesInvLine."Alternate Quantity") + ' ' + FORMAT(ParaSalesInvLine."Alternate UOM") + ' ,Sampoorna Feeds Pvt Ltd.' +
    '&dltContentId=1307165932681769800&dltPrincipalEntityId=' + SaleandRec."Entity ID";
                        /*
                            SMSBody := 'A/C' + ' ' + FORMAT(ParaSaleInvHeader."Sell-to Customer No.") + ' ' +
    'purchased live birds from SFPL against DC -' + FORMAT(ParaSaleInvHeader."External Document No.") + ', ' + FORMAT(TotalQuantity) + ' ' + FORMAT(ParaSalesInvLine."Unit of Measure Code") + ' ' + '(Rs ' + FORMAT(TotalUnitPrice) + '/' +
    FORMAT(ParaSalesInvLine."Unit of Measure Code") + ') Amount Rs. ' + FORMAT(TotalLineAmt) + ' and Birds - ' + FORMAT(ParaSalesInvLine."Alternate Quantity") + ' ' + FORMAT(ParaSalesInvLine."Alternate UOM") + ' ,Sampoorna Feeds Pvt Ltd.'
                        */
                        //HYPERLINK(SMSBody);
                        if CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                            SMSfunctions.SendSMSByURL(SMSBody);    // SKS MSZ     //PRU SH 25082022
                    END;
                END;
            UNTIL ParaSalesInvLine.NEXT = 0;
            //MESSAGE('Message has been sent to the customer');
        END;
    end;


    procedure BankCustomerReceiptVoucherDetailsSMS(DocNo: Code[20])
    var
        CustomerPhone: Text;
        TotalLineAmt: Decimal;
        SMSBody: Text[1024];
        CustomerInfo: Record 18;
        GLERec: Record 17;
        CheckBool: Boolean;
        CustomerInfo1: Record 18;
        Saleandrec: Record "Sales & Receivables Setup";
        WhatsApp: Codeunit "WhatsApp Function";
    begin
        CompanyInfo.Get;
        Saleandrec.Get;
        CustomerPhone := '';
        CLEAR(CheckBool);
        GLERec.RESET;
        //GLERec.SETFILTER("Global Dimension 1 Code",'%1|%2','CBF','FEED');
        GLERec.SETRANGE("Document Type", GLERec."Document Type"::Payment);
        GLERec.SETRANGE("Document No.", DocNo);
        GLERec.SETRANGE("Bal. Account Type", GLERec."Bal. Account Type"::Customer);
        GLERec.SETRANGE("Source Code", 'BANKRCPTV');////
        IF GLERec.FINDFIRST THEN BEGIN
            IF GLERec."Bal. Account Type" = GLERec."Bal. Account Type"::Customer THEN BEGIN
                CustomerInfo.GET(GLERec."Bal. Account No.");
                IF CustomerInfo."Phone No." <> '' THEN
                    CustomerPhone := CustomerInfo."Phone No."
                ELSE
                    ERROR('Customer Phone no. not found for %1', CustomerInfo.Name);
            END;
        END;

        GLERec.RESET;
        //GLERec.SETFILTER("Global Dimension 1 Code",'%1|%2','CBF','FEED');
        GLERec.SETRANGE("Document Type", GLERec."Document Type"::Payment);
        GLERec.SETRANGE("Document No.", DocNo);
        GLERec.SETRANGE("Bal. Account Type", GLERec."Bal. Account Type"::Customer);
        GLERec.SETRANGE("Source Code", 'BANKRCPTV');////
        IF GLERec.FINDFIRST THEN BEGIN
            CustomerInfo1.GET(GLERec."Bal. Account No.");

            CustomerInfo1.CALCFIELDS("Credit Amount (LCY)");
            IF (CustomerInfo1."Phone No." <> '') THEN BEGIN
                CustomerPhone := CustomerInfo."Phone No.";
                IF (CustomerInfo1."Credit Amount (LCY)" <> 0) THEN BEGIN
                    //SMSBody := 'https://bulksmsapi.vispl.in/?username=sampoornatrn&password=samp@9274&messageType=text&mobile=' + CustomerPhone + '&senderId=SFPLCO&ContentID=1307162142450867763&EntityID=1001300642555063725&message=A/C ' +
                    //SMSBody := 'https://pgapi.vispl.in/fe/api/v1/multiSend?username=samprnpg.trans&password=' + SaleandRec."SMS Password" + '&unicode=false&from=' + SaleandRec."Sender ID" + '&to=' + CustomerPhone + '&dltContentId=1307162142450867763&dltPrincipalEntityId=' + Saleandrec."Entity ID" + '&text=A/C ' +
                    //FORMAT(CustomerInfo."No.") + ' ' + 'Credited Rs. ' + FORMAT(ABS(GLERec.Amount)) + ' ' + 'through Bank transfer in SFPL. Thank You';
                    SMSBody := 'A/C ' + FORMAT(CustomerInfo."No.") + ' ' + 'Credited Rs. ' + FORMAT(ABS(GLERec.Amount)) + ' ' + 'through Bank transfer in SFPL. Thank You';
                    //HYPERLINK(SMSBody);
                    if CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                        //SMSfunctions.SendSMSByURL(SMSBody);
                        //WhatsApp.SendSMS(CustomerPhone, SMSBody, '', CustomerInfo."No.", '1307162142450867763'); // SKS MSZ    //PRU SH 25082022
                        CheckBool := TRUE;
                END
                ELSE
                    ERROR('Credit Amount Limit (LCY) is 0 for %1', CustomerInfo.Name);
            END
            ELSE
                ERROR('Customer Phone No. not found for %1', CustomerInfo.Name);
        END;

        //IF CheckBool = TRUE THEN
        //  MESSAGE('Message has been sent to the customer');
    end;


    procedure BankCustomerReFundDetailsSMS(DocNo: Code[20])
    var
        CustomerPhone: Text;
        TotalLineAmt: Decimal;
        SMSBody: Text[1024];
        CustomerInfo: Record 18;
        GLERec: Record 17;
        CheckBool: Boolean;
        CustomerInfo1: Record 18;
        SalesandReceival: Record "Sales & Receivables Setup";
    begin
        SalesandReceival.Get;
        CustomerPhone := '';
        CLEAR(CheckBool);

        GLERec.RESET;
        GLERec.SETFILTER("Global Dimension 1 Code", '%1|%2', 'CBF', 'FEED');
        GLERec.SETRANGE("Document Type", GLERec."Document Type"::Refund);
        GLERec.SETRANGE("Document No.", DocNo);
        GLERec.SETRANGE("Bal. Account Type", GLERec."Bal. Account Type"::Customer);
        GLERec.SETRANGE("Source Code", 'BANKPYMTV');///
        IF GLERec.FINDFIRST THEN BEGIN
            IF GLERec."Bal. Account Type" = GLERec."Bal. Account Type"::Customer THEN BEGIN
                CustomerInfo.GET(GLERec."Bal. Account No.");
                IF CustomerInfo."Phone No." <> '' THEN
                    CustomerPhone := CustomerInfo."Phone No."
                ELSE
                    ERROR('Customer Phone no. not found for %1', CustomerInfo.Name);
            END;
        END;

        ///new

        GLERec.RESET;
        GLERec.SETFILTER("Global Dimension 1 Code", '%1|%2', 'CBF', 'FEED');
        GLERec.SETRANGE("Document Type", GLERec."Document Type"::Refund);
        GLERec.SETRANGE("Document No.", DocNo);
        GLERec.SETRANGE("Bal. Account Type", GLERec."Bal. Account Type"::Customer);
        GLERec.SETRANGE("Source Code", 'BANKPYMTV');///
        IF GLERec.FINDFIRST THEN BEGIN
            IF GLERec."Bal. Account Type" = GLERec."Bal. Account Type"::Customer THEN BEGIN
                CustomerInfo1.GET(GLERec."Bal. Account No.");

                CustomerInfo1.CALCFIELDS("Debit Amount (LCY)");
                IF (CustomerInfo1."Phone No." <> '') THEN BEGIN
                    CustomerPhone := CustomerInfo."Phone No.";
                    IF (CustomerInfo1."Debit Amount (LCY)" <> 0) THEN BEGIN
                        //SMSBody := 'https://bulksmsapi.vispl.in/?username=sampoornatrn&password=samp@9274&messageType=text&mobile=' + CustomerPhone + '&senderId=SFPLCO&ContentID=1307162142439872786&EntityID=1001300642555063725&message=A/C ' +
                        SMSBody := 'https://pgapi.vispl.in/fe/api/v1/multiSend?username=samprnpg.trans&password=' + SalesandReceival."SMS Password" + '&unicode=false&from=' + SalesandReceival."Sender ID" + '&to=' + CustomerPhone + '&dltContentId=1307165932660917134&dltPrincipalEntityId=' + SalesandReceival."Entity ID" + '&text=A/C ' +
                        FORMAT(CustomerInfo."No.") + ' ' +
                         'Debited Rs.' + ' ' + FORMAT(ABS(GLERec.Amount)) + ' ' + 'through Bank transfer in Sampoorna Feeds Pvt Ltd. Thank You';
                        //HYPERLINK(SMSBody);
                        //  SMSfunctions.SendSMSByURL(SMSBody);   // SKS MSZ    //PRU SH 25082022
                        CheckBool := TRUE;
                    END
                    ELSE
                        ERROR('Debit Amount Limit (LCY) is 0 for %1', CustomerInfo.Name);
                END
                ELSE
                    ERROR('Customer Phone No. not found for %1', CustomerInfo1.Name);
            END;
        END;

        //IF CheckBool = TRUE THEN
        //  MESSAGE('Message has been sent to the customer');
    end;


    procedure BlankDocCustomerReceiptVoucherDetailsSMS(DocNo: Code[20])
    var
        CustomerPhone: Text;
        TotalLineAmt: Decimal;
        SMSBody: Text[1024];
        CustomerInfo: Record 18;
        GLERec: Record 17;
        CheckBool: Boolean;
        CustomerInfo1: Record 18;
        SalesRec: Record "Sales & Receivables Setup";
    begin
        SalesRec.Get;
        CustomerPhone := '';
        CLEAR(CheckBool);

        GLERec.RESET;
        GLERec.SETFILTER("Global Dimension 1 Code", '%1|%2', 'CBF', 'FEED');
        GLERec.SETRANGE("Document Type", GLERec."Document Type"::" ");
        GLERec.SETRANGE("Document No.", DocNo);
        GLERec.SETRANGE("Bal. Account Type", GLERec."Bal. Account Type"::Customer);
        GLERec.SETFILTER("Source Code", '%1|%2', 'BANKRCPTV', 'BANKPYMTV');////
        IF GLERec.FINDFIRST THEN BEGIN
            IF GLERec."Bal. Account Type" = GLERec."Bal. Account Type"::Customer THEN BEGIN
                CustomerInfo.GET(GLERec."Bal. Account No.");
                IF CustomerInfo."Phone No." <> '' THEN
                    CustomerPhone := CustomerInfo."Phone No."
                ELSE
                    ERROR('Customer Phone no. not found for %1', CustomerInfo.Name);
            END;
        END;

        GLERec.RESET;
        GLERec.SETFILTER("Global Dimension 1 Code", '%1|%2', 'CBF', 'FEED');
        GLERec.SETRANGE("Document Type", GLERec."Document Type"::" ");
        GLERec.SETRANGE("Document No.", DocNo);
        GLERec.SETRANGE("Bal. Account Type", GLERec."Bal. Account Type"::Customer);
        GLERec.SETFILTER("Source Code", '%1|%2', 'BANKRCPTV', 'BANKPYMTV');////
        IF GLERec.FINDFIRST THEN BEGIN
            CustomerInfo1.GET(GLERec."Bal. Account No.");

            CustomerInfo1.CALCFIELDS("Credit Amount (LCY)");
            IF (CustomerInfo1."Phone No." <> '') THEN BEGIN
                CustomerPhone := CustomerInfo."Phone No.";
                IF (CustomerInfo1."Credit Amount (LCY)" <> 0) THEN BEGIN
                    //SMSBody := 'https://bulksmsapi.vispl.in/?username=sampoornatrn&password=samp@9274&messageType=text&mobile=' + CustomerPhone + '&senderId=SFPLCO&ContentID=1307162142450867763&EntityID=1001300642555063725&message=A/C' + ' ' +

                    SMSBody := 'https://pgapi.vispl.in/fe/api/v1/multiSend?username=samprnpg.trans&password=' + SalesRec."SMS Password" + '&unicode=false&from=' + SalesRec."Sender ID" + '&to=' + CustomerPhone + '&dltContentId=1307162142450867763&dltPrincipalEntityId=' + SalesRec."Entity ID" + '&text=A/C ' + ' ' +
                     FORMAT(CustomerInfo."No.") + ' ' +
                      'Credited Rs.' + ' ' + FORMAT(ABS(GLERec.Amount)) + ' ' + 'through Bank transfer in SFPL. Thank You';                    //HYPERLINK(SMSBody);
                    SMSfunctions.SendSMSByURL(SMSBody);  // SKS MSZ    //PRU SH 25082022
                    CheckBool := TRUE;
                END
                ELSE
                    ERROR('Credit Amount Limit (LCY) is 0 for %1', CustomerInfo.Name);
            END
            ELSE
                ERROR('Customer Phone No. not found for %1', CustomerInfo.Name);
        END;

        //IF CheckBool = TRUE THEN
        //  MESSAGE('Message has been sent to the customer');
    end;


    procedure ReversalEntryPaymentDetailsSMS(DocNo: Code[20])
    var
        CustomerPhone: Text;
        TotalLineAmt: Decimal;
        SMSBody: Text[1024];
        CustomerInfo: Record 18;
        GLERec: Record 17;
        CheckBool: Boolean;
        CustomerInfo1: Record 18;
        Salerec: record "Sales & Receivables Setup";
    begin
        Salerec.Get;
        CustomerPhone := '';
        CLEAR(CheckBool);


        GLERec.RESET;
        GLERec.SETRANGE("Document No.", DocNo);
        GLERec.SETFILTER("Source Code", '%1|%2', 'BANKRCPTV', 'BANKPYMTV');
        GLERec.SETRANGE("Bal. Account Type", GLERec."Bal. Account Type"::Customer);
        IF GLERec.FINDFIRST THEN BEGIN
            IF GLERec."Bal. Account Type" = GLERec."Bal. Account Type"::Customer THEN BEGIN
                CustomerInfo.GET(GLERec."Bal. Account No.");
                IF CustomerInfo."Phone No." <> '' THEN
                    CustomerPhone := CustomerInfo."Phone No."
                ELSE
                    ERROR('Customer Phone no. not found for %1', CustomerInfo.Name);
            END;
        END;

        GLERec.RESET;
        GLERec.SETRANGE("Document No.", DocNo);
        GLERec.SETFILTER("Source Code", '%1|%2', 'BANKRCPTV', 'BANKPYMTV');
        GLERec.SETRANGE("Bal. Account Type", GLERec."Bal. Account Type"::Customer);
        IF GLERec.FINDFIRST THEN BEGIN
            CustomerInfo1.GET(GLERec."Bal. Account No.");
            CustomerInfo1.CALCFIELDS("Debit Amount (LCY)");
            IF (CustomerInfo1."Phone No." <> '') THEN BEGIN
                CustomerPhone := CustomerInfo."Phone No.";
                IF (CustomerInfo1."Debit Amount (LCY)" <> 0) THEN BEGIN
                    // SMSBody := 'https://bulksmsapi.vispl.in/?username=sampoornatrn&password=samp@9274&messageType=text&mobile=' + CustomerPhone + '&senderId=SFPLCO&ContentID=1307162142439872786&EntityID=1001300642555063725&message=A/C' + ' ' +
                    SMSBody := 'https://pgapi.vispl.in/fe/api/v1/multiSend?username=samprnpg.trans&password=' + Salerec."SMS Password" + '&unicode=false&from=' + Salerec."Sender ID" + '&to=' + CustomerPhone + '&dltContentId=1307165932660917134&&dltPrincipalEntityId=' + Salerec."Entity ID" + 'text=A/C ' + ' ' +
                     FORMAT(CustomerInfo."No.") + ' ' + 'Debited Rs.' + ' ' + FORMAT(ABS(GLERec.Amount)) + ' ' + 'through Bank transfer in Sampoorna Feeds Pvt Ltd. Thank You';
                    //HYPERLINK(SMSBody);
                    SMSfunctions.SendSMSByURL(SMSBody);   // SKS MSZ    //PRU SH 25082022
                    CheckBool := TRUE;
                END
                ELSE
                    MESSAGE('Debit Amount Limit (LCY) is 0 for %1', CustomerInfo.Name);
            END
            ELSE
                ERROR('Customer Phone No. not found for %1', CustomerInfo.Name);
        END;

        //IF CheckBool = TRUE THEN
        //  MESSAGE('Message has been sent to the customer');
    end;

    procedure SendStockReporttoPresedent()
    var
        Items: Record Item;
        EmailBody: Text;
        SMTPMail: Codeunit "Email Message";
        RecRef: RecordRef;
        RecRef1: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Email: Codeunit Email;
        Outstr: OutStream;
        Instr: InStream;
        Outstr1: OutStream;
        Instr1: InStream;
        ILE: record "Item Ledger Entry";
        FileName: Text;
        FileManagement: Codeunit "File Management";
        StockAdditives: Report StockAdditives;

    Begin
        Clear(FileName);
        Clear(FileManagement);
        Clear(StockAdditives);
        FileName := 'D:\MSZ Reports\DespatchReconcilation\' + 'Stock Additives' + '.xlsx';
        Clear(SMTPMail);
        Clear(Email);
        EmailBody := ('Dear Sir' + ',');
        EmailBody += ('<br><br>');
        EmailBody += ('Please find enclosed herewith Stock report for medicine and, Feed Additives and Vitamins and feed Stock ageing');
        EmailBody += ('<br><br>');
        SMTPMail.Create('suchismita.dey@sampoornafeeds.in', 'Stock Reports', EmailBody, true);
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'sanjay.tiwari@sampoornafeeds.in');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'parveen.k@sampoornafeeds.com');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'amitdas100@gmail.com');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'ssrathore@sampoornafeeds.com');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'ashwani@sampoornafeeds.com');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'nand.kishore@sampoornafeeds.in');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Bcc, 'sumandev@sampoornafeeds.com');
        Items.Reset();
        Items.Setfilter(Items."Item Category Code", '%1|%2|%3', 'MEDICINE', 'Feed Additive', 'VITAMIN');
        RecRef.GetTable(Items);
        TempBlob.CreateOutStream(Outstr);
        StockAdditives.SetTableView(Items);
        StockAdditives.SaveAsExcel(FileName);
        // Report.SaveAs(Report::StockAdditives, '', ReportFormat::Excel, Outstr, RecRef);
        // FileManagement.BLOBExportToServerFile(TempBlob, FileName);

        FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
        TempBlob.CreateInStream(Instr);
        SMTPMail.AddAttachment('Stock Additives' + '.xlsx', 'xlsx', Instr);

        ILE.Reset();
        ILE.Setfilter(ILE."Item Category Code", '%1|%2', 'POULTRY FD', 'CATTLE FD');
        ILE.SetRange("Posting Date", 0D, CalcDate('-15D', WorkDate()));
        Clear(FileName);
        FileName := 'D:\MSZ Reports\DespatchReconcilation\' + 'Stock Ageing' + '.xlsx';
        RecRef1.GetTable(ILE);
        TempBlob.CreateOutStream(Outstr1);
        Report.SaveAs(Report::"Stock Ageing Report", '', ReportFormat::Excel, Outstr1, RecRef1);
        FileManagement.BLOBExportToServerFile(TempBlob, FileName);

        FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
        TempBlob.CreateInStream(Instr1);
        SMTPMail.AddAttachment('Stock Ageing' + '.xlsx', 'xlsx', Instr1);



        //  SMTPMail.AddAttachment(ReportPath, 'Invoice_' + DELCHR(SalesInvoiceHeader1."No.", '=', '/') + '.pdf');
        SMTPMail.AppendToBody('With best regards!' + ',');
        SMTPMail.AppendToBody('<BR>');
        SMTPMail.AppendToBody('Sampoorna Team');
        SMTPMail.AppendToBody('<BR><BR>');
        SMTPMail.AppendToBody('Note : This is computer generated mail, please do-not reply on this.<BR><BR>');
        Email.Send(SMTPMail, Enum::"Email Scenario"::Default);

        Erase('D:\MSZ Reports\DespatchReconcilation\' + 'Stock Ageing' + '.xlsx');
        Erase('D:\MSZ Reports\DespatchReconcilation\' + 'Stock Additives' + '.xlsx')

    END;

    procedure SendStockReporttoDr()
    var
        Items: Record "Item Ledger Entry";
        EmailBody: Text;
        SMTPMail: Codeunit "Email Message";
        RecRef: RecordRef;
        RecRef1: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Email: Codeunit Email;
        Outstr: OutStream;
        Instr: InStream;
        Outstr1: OutStream;
        Instr1: InStream;
        ILE: record "Item Ledger Entry";
        FileName: Text;
        FileManagement: Codeunit "File Management";
        StockAdtivesLOB: Report "StockAdtivesLOB";

    Begin
        Clear(FileName);
        Clear(FileManagement);
        FileName := 'D:\MSZ Reports\DespatchReconcilation\' + 'Stock Additives LOB Wise' + '.xlsx';
        Clear(SMTPMail);
        Clear(Email);
        EmailBody := ('Dear Sir' + ',');
        EmailBody += ('<br><br>');
        EmailBody += ('Please find enclosed herewith Stock report for medicine and, Feed Additives and Vitamins and feed Stock ageing');
        EmailBody += ('<br><br>');
        SMTPMail.Create('ssrathore@sampoornafeeds.com', 'Stock Additives LOB Wise', EmailBody, true);
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Bcc, 'sumandev@sampoornafeeds.com');
        Items.Reset();
        Items.Setfilter(Items."Item Category Code", '%1|%2|%3', 'MEDICINE', 'Feed Additive', 'VITAMIN');
        RecRef.GetTable(Items);
        TempBlob.CreateOutStream(Outstr);
        StockAdtivesLOB.SetTableView(Items);
        StockAdtivesLOB.SaveAsExcel(FileName);
        // Report.SaveAs(Report::StockAdtivesLOB, '', ReportFormat::Excel, Outstr, RecRef);
        // FileManagement.BLOBExportToServerFile(TempBlob, FileName);

        FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
        TempBlob.CreateInStream(Instr);
        SMTPMail.AddAttachment('Stock Additives LOB Wise' + '.xlsx', 'xlsx', Instr);


        //  SMTPMail.AddAttachment(ReportPath, 'Invoice_' + DELCHR(SalesInvoiceHeader1."No.", '=', '/') + '.pdf');
        SMTPMail.AppendToBody('With best regards!' + ',');
        SMTPMail.AppendToBody('<BR>');
        SMTPMail.AppendToBody('Sampoorna Team');
        SMTPMail.AppendToBody('<BR><BR>');
        SMTPMail.AppendToBody('Note : This is computer generated mail, please do-not reply on this.<BR><BR>');
        Email.Send(SMTPMail, Enum::"Email Scenario"::Default);
        Erase(FileName);
    END;

    procedure APISMSSingalNo(SMSnumber: Text[1024]; SmsMessage: Text[1024]; Description: Text[1024]; AccountNo: Text[1024]; ContentID: Text): Boolean
    var
        SalesandRece: Record "Sales & Receivables Setup";
        Payload: Text;
        gContent: HttpContent;
        gContentHeaders: HttpHeaders;
        gHttpClient: HttpClient;
        gHttpResponseMsg: HttpResponseMessage;
        Companyinfo: Record "Company Information";
        Json: Text;
        Jobject: JsonObject;
        gResponseMsg: Text;
        JsonDoc: JsonObject;
        JsonToken: JsonToken;
        JsonObject: JsonObject;
        JsonArray: JsonArray;
        i: Integer; // Loop counter for arrays
        TempGuid: Guid; // To store GUIDs
        SMSLog: Record "SMS Log";
        Success: Boolean;
    begin
        SalesandRece.Get;
        Clear(Payload);
        Clear(gResponseMsg);

        //JsonObject.Add('customerId', SalesandRece."Customer ID");
        JsonObject.Add('customerId', 'Sampoorna__R6A6d0KhTjJF0UqzwRdp');
        JsonObject.Add('destinationAddress', SMSnumber);
        JsonObject.Add('message', SmsMessage);
        JsonObject.Add('sourceAddress', SalesandRece."Sender ID");
        JsonObject.Add('messageType', 'SERVICE_IMPLICIT');
        JsonObject.Add('dltTemplateId', ContentID);
        JsonObject.Add('entityId', SalesandRece."Entity ID");
        JsonObject.WriteTo(Payload);
        Companyinfo.Get;
        gContent.WriteFrom(Payload);
        gContent.GetHeaders(gContentHeaders);
        gContentHeaders.Clear();
        gContentHeaders.Add('Content-Type', 'application/json');
        //gContentHeaders.Add('Authorization', 'Basic U2FtcG9vcm5hX19SNkE2ZDBLaFRqSkYwVXF6d1JkcDpCaGF2aml0OUtvbmdAMzM=');
        gHttpClient.DefaultRequestHeaders.Add('Authorization', 'Basic U2FtcG9vcm5hX19SNkE2ZDBLaFRqSkYwVXF6d1JkcDppOFJqKTxKQERrRiZIRkkkRFQweQ==');
        if gHttpClient.Post('https://iqsms.airtel.in/api/v1/send-sms', gContent, gHttpResponseMsg) then begin
            gHttpResponseMsg.Content.ReadAs(Json);
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                Success := TRUE;
                EXIT(Success);
            end else
                EXIT(false);
            // JsonDoc.ReadFrom(Json);
            // SMSLog.Init();
            // SMSLog.Insert(True);
            // SMSLog."Account No." := AccountNo;
            // SMSLog.Description := Description;
            // if JsonDoc.Get('messageRequestId', JsonToken) then
            //     SMSLog."Transaction ID" := CopyStr(JsonToken.AsValue().AsText(), 1, MaxStrLen(SMSLog."Transaction ID"));
            // if JsonDoc.Get('message', JsonToken) then
            //     SMSLog."SMS Body" := CopyStr(JsonToken.AsValue().AsText(), 1, MaxStrLen(SMSLog."SMS Body"));
            // if JsonDoc.Get('destinationAddress', JsonToken) and JsonToken.IsArray then begin
            //     JsonArray := JsonToken.AsArray(); // Get the destinationAddress array
            //     for i := 0 to JsonArray.Count - 1 do begin
            //         if JsonArray.Get(i, JsonToken) then begin
            //             SMSLog."Mobile No." := CopyStr(JsonToken.AsValue().AsText(), 1, MaxStrLen(SMSLog."Mobile No."));
            //         end;
            //     end;
            //     SMSLog.Modify();
        end;
    END;

    procedure APISMSMultipleNo(PhoneNo1: Text; PhoneNo2: Text; PhoneNo3: Text; PhoneNo4: Text; PhoneNo5: Text; PhoneNo6: Text; PhoneNo7: Text; SmsMessage: Text[1024]; Description: Text[1024]; AccountNo: Text[1024]; ContentID: Text)
    var
        SalesandRece: Record "Sales & Receivables Setup";
        Payload: Text;
        gContent: HttpContent;
        gContentHeaders: HttpHeaders;
        gHttpClient: HttpClient;
        gHttpResponseMsg: HttpResponseMessage;
        Companyinfo: Record "Company Information";
        Json: Text;
        Jobject: JsonObject;
        gResponseMsg: Text;
        JsonDoc: JsonObject;
        JsonToken: JsonToken;
        JsonObject: JsonObject;
        JsonArray: JsonArray;
        i: Integer; // Loop counter for arrays
        TempGuid: Guid; // To store GUIDs
        SMSLog: Record "SMS Log";
        DestinationArray: JsonArray;
        URL: Text;
    begin
        SalesandRece.Get;
        Clear(Payload);
        Clear(gResponseMsg);

        URL := 'https://iqsms.airtel.in/api/v1/send-sms-multi?customerId=' + 'Sampoorna__R6A6d0KhTjJF0UqzwRdp';
        //URL := 'https://iqsms.airtel.in/api/v1/send-sms-multi?customerId=' + SalesandRece."Customer ID";
        if PhoneNo1 <> '' Then
            DestinationArray.Add(PhoneNo1);
        if PhoneNo2 <> '' Then
            DestinationArray.Add(PhoneNo2);
        if PhoneNo3 <> '' Then
            DestinationArray.Add(PhoneNo3);
        if PhoneNo4 <> '' Then
            DestinationArray.Add(PhoneNo4);
        if PhoneNo5 <> '' Then
            DestinationArray.Add(PhoneNo5);
        if PhoneNo6 <> '' Then
            DestinationArray.Add(PhoneNo6);
        if PhoneNo7 <> '' Then
            DestinationArray.Add(PhoneNo7);

        JsonObject.Add('customerId', 'Sampoorna__R6A6d0KhTjJF0UqzwRdp');
        //JsonObject.Add('customerId', SalesandRece."Customer ID");
        JsonObject.Add('destinationAddress', DestinationArray);
        JsonObject.Add('message', SmsMessage);
        JsonObject.Add('sourceAddress', SalesandRece."Sender ID");
        JsonObject.Add('messageType', 'SERVICE_IMPLICIT');
        JsonObject.Add('dltTemplateId', ContentID);
        JsonObject.Add('entityId', SalesandRece."Entity ID");
        JsonObject.WriteTo(Payload);
        Companyinfo.Get;
        gContent.WriteFrom(Payload);
        gContent.GetHeaders(gContentHeaders);
        gContentHeaders.Clear();
        gContentHeaders.Add('Content-Type', 'application/json');
        gContentHeaders.Add('customerId', SalesandRece."Customer ID");
        gContentHeaders.Add('Cookie', '15d2c5434f86ba5d0edd66af061187e2=40c6cec9f311afc117450ad38533c0c7');
        gHttpClient.DefaultRequestHeaders.Add('Authorization', 'Basic U2FtcG9vcm5hX19SNkE2ZDBLaFRqSkYwVXF6d1JkcDppOFJqKTxKQERrRiZIRkkkRFQweQ==');
        if gHttpClient.Post(URL, gContent, gHttpResponseMsg) then begin
            gHttpResponseMsg.Content.ReadAs(Json);
            if gHttpResponseMsg.IsSuccessStatusCode then begin

            end;
        END;
    END;


    var
        JsonObject: JsonObject;
        DestinationArray: JsonArray;


}

