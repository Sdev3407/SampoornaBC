

codeunit 50019 "Auto Mail Report"
{

    trigger OnRun()
    var
        DimensionValue: Record 349;
        Counter: Integer;
    begin
        SaveCustomerSalesReport;
        DailyCustomerSaleonCredit;
        MESSAGE('Send');
    end;

    var
        Outstr: OutStream;
        Instr: InStream;
        SMTPMailSetup: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        RecRef: RecordRef;
        SMTPMail: Codeunit Email;
        EMAIL: Codeunit Email;
        VLEAccountStatement: Report 50015;
        UserSetup: Record 91;

    local procedure SaveCustomerSalesReport()
    var
        // FileSystemAutomation: Automation;
        FolderName: Text;
        Folder: Text;
        CustLedgerEntry: Record 21;
        ReportPath: Text;
        ReportDate: Date;
    begin
        //   SMTPMailSetup.GET;
        ReportDate := CALCDATE('-1D', WORKDATE);
        SMTPMailSetup.Create('ravisharma@sampoornafeeds.in;pradeep.kumar@sampoornafeeds.com;ritu@sampoornafeeds.com;acctscbf@sampoornafeeds.in;pankaj.bhangalia@sampoornafeeds.in;jeevansingh@sampoornafeeds.in', 'Consolidate Details of outstanding balance of CBF Sales', '', true);
        SMTPMailSetup.AddRecipient(Enum::"Email Recipient Type"::Cc, 'arvind.gupta@sampoornafeeds.com');
        //SMTPMailSetup.AddRecipient(Enum::"Email Recipient Type"::Bcc, 'rdadhwal@sampoornafeeds.com');
        SMTPMailSetup.AppendToBody('Dear All' + ',' + '<BR><BR>');
        SMTPMailSetup.AppendToBody('Please find below customer wise details of outstanding balances of CBF Sales as on date' + ' ' + FORMAT(ReportDate) + '.<BR><BR>');
        //     ReportPath := 'D:\' + 'MSZ Reports\Consolidate Details of outstanding balance of CBF Sales.Pdf';
        CustLedgerEntry.RESET;
        IF CustLedgerEntry.FINDFIRST THEN BEGIN
            RecRef.GetTable(CustLedgerEntry);
            TempBlob.CreateOutStream(Outstr);
            Report.SaveAs(Report::"Consolidate OutstandingDetail", '', ReportFormat::Pdf, Outstr, RecRef);
            TempBlob.CreateInStream(Instr);
            SMTPMailSetup.AddAttachment(CustLedgerEntry."Customer No." + '.pdf', 'PDF', Instr);
        END;
        SMTPMailSetup.AppendToBody('Regards' + ',' + '<BR>' + 'Sampoorna Feeds Pvt. Ltd.' + '<BR><BR>');
        SMTPMailSetup.AppendToBody('This is system generated mail. Please do not reply.<BR><BR>');
        Email.Send(SMTPMailSetup, Enum::"Email Scenario"::Default);
        //MESSAGE(ReportPath);
    end;

    local procedure DailyCustomerSaleonCredit()
    var
        CustLedgerEntry: Record 21;
        DuplicateBranch: Code[10];
        ReportPath: Text;
        CustLeddger: Record 21;
        DimensionValue: Record 349;
        ReportDate: Date;

        FileName: Text;
        FileManagement: Codeunit "File Management";
    begin
        CustLedgerEntry.RESET;
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Global Dimension 1 Code", 'CBF');
        CustLedgerEntry.SETRANGE(CustLedgerEntry."Global Dimension 2 Code", '3000', '4000');
        CustLedgerEntry.SETCURRENTKEY("Global Dimension 2 Code");
        IF CustLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                IF CustLedgerEntry."Global Dimension 2 Code" <> DuplicateBranch THEN BEGIN
                    //   SMTPMailSetup.GET;
                    //Counter += 1;
                    CustLeddger.RESET;
                    CustLeddger.SETRANGE(CustLeddger."Document Type", CustLeddger."Document Type"::Invoice);
                    CustLeddger.SETRANGE(CustLeddger."Global Dimension 1 Code", 'CBF');
                    CustLeddger.SETRANGE(CustLeddger."Global Dimension 2 Code", CustLedgerEntry."Global Dimension 2 Code");
                    CustLeddger.CALCFIELDS("Remaining Amount");
                    CustLeddger.SETFILTER(CustLeddger."Remaining Amount", '<>%1', 0);
                    IF CustLeddger.FINDFIRST THEN BEGIN
                        DimensionValue.RESET;
                        DimensionValue.SETRANGE(DimensionValue."Dimension Code", 'BRANCH');
                        DimensionValue.SETRANGE(DimensionValue.Blocked, FALSE);
                        DimensionValue.SETRANGE(DimensionValue.Code, CustLeddger."Global Dimension 2 Code");
                        //DimensionValue.SETRANGE(DimensionValue.Code,'3000','4000');
                        DimensionValue.SETFILTER(DimensionValue.Email, '<>%1', '');          // Avoid Blank Email
                        IF DimensionValue.FINDFIRST THEN BEGIN
                            ReportDate := CALCDATE('-1D', WORKDATE);
                            Clear(FileName);
                            Clear(FileManagement);
                            FileName := 'D:\MSZ Reports\DespatchReconcilation\' + 'Detail of Outstanding CBF Sales_' + '.xlsx';
                            SMTPMailSetup.Create(DimensionValue.Email, 'Detail of Outstanding CBF Sales', '');
                            SMTPMailSetup.AppendToBody('Dear All' + ',' + '<BR><BR>');
                            SMTPMailSetup.AppendToBody('Please find below customer wise details of outstanding balances of your branch as on date ' + ' ' + FORMAT(ReportDate) + '.<BR><BR>');
                            SMTPMailSetup.AddRecipient(Enum::"Email Recipient Type"::Cc, 'pankaj.bhangalia@sampoornafeeds.in');
                            //SMTPMail.AddBCC('sumandev@sampoornafeeds.in');
                            RecRef.GetTable(CustLeddger);
                            TempBlob.CreateOutStream(Outstr);
                            Report.SaveAs(Report::"Outstanding Sale Detail", '', ReportFormat::Excel, Outstr, RecRef);

                            FileManagement.BLOBExportToServerFile(TempBlob, FileName);

                            FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
                            TempBlob.CreateInStream(Instr);
                            SMTPMailSetup.AddAttachment('Detail of Outstanding CBF Sales_' + '.xlsx', 'Xlsx', Instr);
                            SMTPMailSetup.AppendToBody('Regards' + ',' + '<BR>' + 'Sampoorna Feeds Pvt. Ltd.' + '<BR><BR>');
                            SMTPMailSetup.AppendToBody('This is system generated mail. Please do not reply.<BR><BR>');
                            SMTPMail.Send(SMTPMailSetup, Enum::"Email Scenario"::Default);
                            //MESSAGE('%1,%2',DimensionValue.Name);
                            Erase(FileName);
                        END;
                        //MESSAGE('%1,%2',Counter,CustLeddger."Global Dimension 2 Code");
                    END;
                    DuplicateBranch := CustLedgerEntry."Global Dimension 2 Code";
                END;
            UNTIL CustLedgerEntry.NEXT = 0;
        END;
    end;

    procedure SaveVendorReport(StartDate: Date; EndDate: Date; VendorNo: Code[1024])
    var
        Vendor: Record 23;
        PDFVendor: Record 23;
        VendorLedgerEntry: Record 25;
        VLEAccountStatement: Report 50015;
        ReportPath: Text;
    begin
        Vendor.RESET;
        Vendor.SETFILTER(Vendor."No.", VendorNo);
        IF Vendor.FINDSET THEN BEGIN
            REPEAT
                PDFVendor.RESET;
                PDFVendor.SETRANGE(PDFVendor."No.", Vendor."No.");
                IF PDFVendor.FINDFIRST THEN BEGIN
                    ReportPath := 'D:\MSZ Reports\Vendor Report\' + FORMAT(PDFVendor.Name) + '.PDF';
                    CLEAR(VLEAccountStatement);
                    VLEAccountStatement.SETTABLEVIEW(PDFVendor);
                    VLEAccountStatement.SetReportFilter(StartDate, EndDate);
                    VLEAccountStatement.SAVEASPDF(ReportPath);
                    SendEmail(PDFVendor, StartDate, EndDate);
                END;
            UNTIL Vendor.NEXT = 0;
        END;
    end;

    procedure SendEmail(Vendor: Record 23; StartD: Date; EndD: Date)
    var
        ReportPath: Text;
        PDFVendor: Record Vendor;
        CompanyInfo: Record "Company Information";
    begin
        //MESSAGE(Vendor."E-Mail");
        CompanyInfo.Get;
        UserSetup.RESET;
        IF UserSetup.GET(USERID) THEN
            CLEAR(SMTPMail);
        Clear(SMTPMailSetup);
        SMTPMailSetup.Create(Vendor."E-Mail", 'Account Statement' + '' + ' ' + '(' + Vendor.Name + ')' + '' + ' ' + FORMAT(StartD) + '' + ' ' + 'to' + '' + ' ' + FORMAT(EndD), '', true);
        SMTPMailSetup.AppendToBody('Dear Sir/Madam,' + '<BR><BR>');
        SMTPMailSetup.AppendToBody('Please find attached herewith the statement of account from' + ' ' + FORMAT(StartD) + ' ' + 'to' + '' + '  ' + FORMAT(EndD) + ' ' + '.<BR><BR>');
        SMTPMailSetup.AppendToBody('You are requested to please verify the transaction as per your records and make the entry in your records for any pending transaction (if any). In case any supporting documents required or in case of any other difference'
      + ' ' + 'please contact the concerned Purchase Officer.' + '<BR><BR>');
        if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] Then
            SMTPMailSetup.AddRecipient(Enum::"Email Recipient Type"::Cc, 'purchase@sampoornafeeds.com');
        if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::"Star Foods"] Then
            SMTPMailSetup.AddRecipient(Enum::"Email Recipient Type"::Cc, 'purchase@starfood.co.in');

        SMTPMailSetup.AddRecipient(Enum::"Email Recipient Type"::Cc, UserSetup."E-Mail");

        PDFVendor.RESET;
        PDFVendor.SETRANGE(PDFVendor."No.", Vendor."No.");
        PDFVendor.SetRange("Date Filter", StartD, EndD);
        IF PDFVendor.FINDFIRST THEN BEGIN
            RecRef.GetTable(PDFVendor);
            TempBlob.CreateOutStream(Outstr);
            Report.SaveAs(Report::"VLE Account Statement1", '', ReportFormat::Pdf, Outstr, RecRef);
            TempBlob.CreateInStream(Instr);
            SMTPMailSetup.AddAttachment(FORMAT(PDFVendor.Name) + '.Pdf', 'Pdf', Instr);
            SMTPMailSetup.AppendToBody('With Best Regards' + ',' + '<BR>' + CompanyInfo.Name + '<BR><BR>');
            //SMTPMail.AppendBody('This is system generated mail. Please do not reply.<BR><BR>');
        end;
        SMTPMail.Send(SMTPMailSetup, Enum::"Email Scenario"::Default);
    END;


    procedure SaveCustomerReport(StartDate: Date; EndDate: Date; CustomerNo: Code[1024]; Narration: Boolean)
    var
        Customer: Record 18;
        PDFCustomer: Record 18;
        VendorLedgerEntry: Record 25;
        CustomerStatement_N: Report 50026;
        ReportPath: Text;
    begin
        Customer.RESET;
        Customer.SETFILTER(Customer."No.", CustomerNo);
        IF Customer.FINDSET THEN BEGIN
            REPEAT
                PDFCustomer.RESET;
                PDFCustomer.SETRANGE(PDFCustomer."No.", Customer."No.");
                IF PDFCustomer.FINDFIRST THEN BEGIN
                    ReportPath := 'D:\MSZ Reports\Customer Report\' + FORMAT(PDFCustomer.Name) + '.PDF';
                    CLEAR(CustomerStatement_N);
                    CustomerStatement_N.SETTABLEVIEW(PDFCustomer);
                    CustomerStatement_N.SetReportFilter(StartDate, EndDate);
                    CustomerStatement_N.SAVEASPDF(ReportPath);
                    CustomerSendEmail(PDFCustomer, StartDate, EndDate, Narration);
                END;
            UNTIL Customer.NEXT = 0;
        END;
    end;

    procedure CustomerSendEmail(Customer: Record 18; StartD: Date; EndD: Date; Narration: Boolean)
    //SIM -----Code Added---->>>>>>----------
    var
        ReportPath: Text;
        SalespersonPurchaser: Record 13;
        PDFVendor: Record Customer;
        Rep50026: Report 50026;
    begin
        //MESSAGE(Vendor."E-Mail");
        UserSetup.RESET;
        IF UserSetup.GET(USERID) THEN
            SalespersonPurchaser.RESET;
        IF SalespersonPurchaser.GET(Customer."Salesperson Code") THEN;
        CLEAR(SMTPMail);
        IF Customer."E-Mail" = '' THEN BEGIN
            SMTPMailSetup.Create(SalespersonPurchaser."E-Mail", 'Account Statement' + '' + ' ' + '(' + Customer.Name + ')' + '' + ' ' + FORMAT(StartD) + '' + ' ' + 'to' + '' + ' ' + FORMAT(EndD), '', true);
        END ELSE
            SMTPMailSetup.Create(Customer."E-Mail", 'Account Statement' + '' + ' ' + '(' + Customer.Name + ')' + '' + ' ' + FORMAT(StartD) + '' + ' ' + 'to' + '' + ' ' + FORMAT(EndD), '', true);

        SMTPMailSetup.AppendToBody('Dear Sir/Madam,' + '<BR><BR>');
        SMTPMailSetup.AppendToBody('Please find attached herewith the statement of account from' + ' ' + FORMAT(StartD) + ' ' + 'to' + '' + '  ' + FORMAT(EndD) + ' ' + '.<BR><BR>');
        SMTPMailSetup.AppendToBody('You are requested to please verify the transaction as per your records and make the entry in your records for any pending transaction (if any). In case any supporting documents required or in case of any other difference'
        + ' ' + 'please contact the concerned Sales Officer.' + '<BR><BR>');
        //SMTPMail.AppendBody('In case of any difference, you are requested to either share the reconciliation or furnish the information you may have that will assist us in reconciling the differences.' + '<BR><BR>');
        IF SalespersonPurchaser."E-Mail" <> '' THEN
            SMTPMailSetup.AddRecipient(Enum::"Email Recipient Type"::Cc, SalespersonPurchaser."E-Mail");
        // SMTPMailSetup.AddRecipient(Enum::"Email Recipient Type"::Cc, 'pankaj.bhangalia@sampoornafeeds.in');
        IF UserSetup."E-Mail" <> '' THEN
            SMTPMailSetup.AddRecipient(Enum::"Email Recipient Type"::Cc, UserSetup."E-Mail");
        PDFVendor.RESET;
        PDFVendor.SETRANGE(PDFVendor."No.", Customer."No.");
        PDFVendor.SetRange("Date Filter", StartD, EndD);
        IF PDFVendor.FINDFIRST THEN BEGIN
            RecRef.GetTable(PDFVendor);
            TempBlob.CreateOutStream(Outstr);
            Rep50026.SetReportFilter(StartD, EndD);
            Rep50026.SetNarration(Narration);
            Rep50026.SavePDF(false);
            Rep50026.SaveAs('', ReportFormat::Pdf, Outstr, RecRef);
            // Report.SaveAs(Report::"Customer Statement_N", '', ReportFormat::Pdf, Outstr, RecRef);
            TempBlob.CreateInStream(Instr);
            SMTPMailSetup.AddAttachment(FORMAT(PDFVendor.Name) + '.Pdf', 'Pdf', Instr);
            SMTPMailSetup.AppendToBody('With Best Regards' + ',' + '<BR>' + 'Sampoorna Team' + '<BR><BR>');
            //SMTPMail.AppendBody('This is system generated mail. Please do not reply.<BR><BR>');
        end;
        SMTPMail.Send(SMTPMailSetup, Enum::"Email Scenario"::Default);

        //SIM -----Code Added---->>>>>>----------
    end;


    procedure SaveVendorConfirmationReport(StartDate: Date; EndDate: Date; VendorNo: Code[1024])
    var
        Vendor: Record 23;
        PDFVendor: Record 23;
        VendorLedgerEntry: Record 25;
        VLEAccountStatement: Report 50015;
        ReportPath: Text;
        BalanceConfirmation_Vendor: Report 50031;
    begin
        Vendor.RESET;
        Vendor.SETFILTER(Vendor."No.", VendorNo);
        IF Vendor.FINDSET THEN BEGIN
            REPEAT
                PDFVendor.RESET;
                PDFVendor.SETRANGE(PDFVendor."No.", Vendor."No.");
                IF PDFVendor.FINDFIRST THEN BEGIN
                    ReportPath := 'D:\MSZ Reports\Confirmation Report\' + FORMAT(PDFVendor.Name) + '.PDF';
                    CLEAR(BalanceConfirmation_Vendor);
                    BalanceConfirmation_Vendor.SETTABLEVIEW(PDFVendor);
                    BalanceConfirmation_Vendor.SetReportFilter(StartDate, EndDate);
                    BalanceConfirmation_Vendor.SAVEASPDF(ReportPath);
                    SendEmailConfirmation(PDFVendor, StartDate, EndDate);
                END;
            UNTIL Vendor.NEXT = 0;
        END;
    end;

    procedure SendEmailConfirmation(Vendor: Record 23; StartD: Date; EndD: Date)
    var
        ReportPath: Text;
        PDFVendor: Record Vendor;
    begin
        //MESSAGE(Vendor."E-Mail");
        UserSetup.RESET;
        IF UserSetup.GET(USERID) THEN
            CLEAR(SMTPMail);
        SMTPMailSetup.Create(Vendor."E-Mail", 'Balance Confirmation' + '' + ' ' + '(' + Vendor.Name + ')' + '' + ' ' + 'as on' + '' + ' ' + FORMAT(EndD), '', true);
        SMTPMailSetup.AppendToBody('Dear Sir/Madam,' + '<BR><BR>');
        SMTPMailSetup.AppendToBody('Please find herewith Tagged the Balance confirmation letter as at' + '  ' + FORMAT(EndD) + ' ' + '.<BR><BR>');
        SMTPMailSetup.AppendToBody('Kindly revert, at the earliest, with duly filled,stamped and signed (also mention Pan No) in confirmation, on the tagged Letter.'
        + ' ' + 'In case of any difference please share duly stamped and signed statement of account for reconciliation and necessary action.' + '<BR><BR>');
        SMTPMailSetup.AppendToBody('Ensure to make CC to our Statutory Auditor : @ balanceconfirmationvpvijh@gmail.com' + '<BR><BR>');
        SMTPMailSetup.AddRecipient(Enum::"Email Recipient Type"::Cc, 'purchase@sampoornafeeds.com');
        SMTPMailSetup.AddRecipient(Enum::"Email Recipient Type"::Cc, 'Vishwajeetbehl@sampoornafeeds.in');
        SMTPMailSetup.AddRecipient(Enum::"Email Recipient Type"::Cc, UserSetup."E-Mail");
        PDFVendor.RESET;
        PDFVendor.SETRANGE(PDFVendor."No.", Vendor."No.");
        PDFVendor.SetRange("Date Filter", StartD, EndD);
        IF PDFVendor.FINDFIRST THEN BEGIN
            RecRef.GetTable(PDFVendor);
            TempBlob.CreateOutStream(Outstr);
            Report.SaveAs(Report::"Balance Confirmation_Vendor", '', ReportFormat::Pdf, Outstr, RecRef);
            TempBlob.CreateInStream(Instr);
            SMTPMailSetup.AddAttachment(FORMAT(PDFVendor.Name) + '.Pdf', 'Pdf', Instr);
            //SMTPMailSetup.AppendToBody('With Best Regards' + ',' + '<BR>' + 'Sampoorna Team' + '<BR><BR>');
            //SMTPMail.AppendBody('This is system generated mail. Please do not reply.<BR><BR>');
        end;
        SMTPMailSetup.AppendToBody('With Best Regards' + ',' + '<BR>' + 'Sampoorna Team' + '<BR><BR>');
        //SMTPMailSetup.AppendToBody('This is system generated mail. Please do not reply.<BR><BR>');
        SMTPMail.Send(SMTPMailSetup, Enum::"Email Scenario"::Default);
    end;

}
