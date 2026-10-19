codeunit 50005 "Farm Location Expire"
{

    trigger OnRun()
    var
        SMSdetail: Codeunit "SMS Details";
    begin
        Companyinfo.Get;
        GeneralLedgerSetup.GET;
        If Companyinfo.SFPLCompany = Companyinfo.SFPLCompany::Vetadd Then begin
            CreateAttachmentReportForTeamLeader();
            SendAgedAccountsPayableReport();
            if System.Date2DWY(WorkDate(), 1) = 1 then
                CreateItemStockDetailsVetadd();

        end;

        If Companyinfo.SFPLCompany <> Companyinfo.SFPLCompany::Vetadd Then
            IF GeneralLedgerSetup."Location Agr. Exp Email" = TRUE THEN BEGIN
                AgreementEndDateEmail;
            END;
        // If Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] Then Begin
        //     DispatchReconcilationReport;//GK02062021
        //     DailyOutstandingQuantity;
        // End;
        If Companyinfo.SFPLCompany <> Companyinfo.SFPLCompany::Vetadd Then
            CreateattachmentforPerformancereport();
        If Companyinfo.SFPLCompany <> Companyinfo.SFPLCompany::Vetadd Then
            PerformanceReportForAll();

        If Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] Then
            if System.Date2DWY(WorkDate(), 1) = 1 then begin
                SMSdetail.SendStockReporttoPresedent();
                SMSdetail.SendStockReporttoDr();
            end;
        If Companyinfo.SFPLCompany <> Companyinfo.SFPLCompany::Vetadd Then
            if System.Date2DWY(WorkDate(), 1) = 1 then begin
                PerformanceReportForLast05Flock();
                MortalityWeekwise();

            end;
        If Companyinfo.SFPLCompany <> Companyinfo.SFPLCompany::Vetadd Then begin
            DailyMortality();
            CaseAlert();
        End;
        If Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] Then
            TempCreditLimitnotification()

    end;

    var
        Companyinfo: Record "Company Information";
        GeneralLedgerSetup: Record 98;
        UserSetup: Record 91;
        SMTPMail: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        RecRef: RecordRef;
        EmailR: Codeunit Email;
        Outstr: OutStream;
        Instr: InStream;


    local procedure AgreementEndDateEmail()
    var

        SMTPMail: Codeunit "Email Message";
        Subject: Text;
        T_14: Record 14;
        Email: Codeunit Email;
        recRegion: Record Region;
    begin
        //PRU_NEELESH
        T_14.RESET;
        T_14.SETFILTER("Agreement End Date", '<>%1', 0D);
        T_14.SETRANGE(Block, FALSE);
        T_14.SETFILTER("E-Mail", '<>%1', '');
        T_14.SETRANGE("Responsibility Center", 'CBF');
        IF T_14.FINDSET THEN
            REPEAT
                IF ((T_14."Agreement End Date" - TODAY) <= 60) AND ((T_14."Agreement End Date" - TODAY) >= 0) THEN BEGIN
                    If T_14."Region Code" <> '' then
                        recRegion.Get(T_14."Region Code");
                    Subject := 'Email For the location Expiration';

                    //    SMTPMail.CreateMessage('Agreement End Date Expired', SMTPMailSetup."User ID", '', Subject, '', TRUE);
                    if T_14."Location Mail ID" <> '' THEN
                        SMTPMail.Create(T_14."Location Mail ID" + ';' + T_14."E-Mail", 'Agreement End Date Expired -' + T_14.Code, Subject, true)
                    else
                        if T_14."E-Mail" <> '' then
                            SMTPMail.Create(T_14."E-Mail", 'Agreement End Date Expired', Subject, true);
                    If T_14."Region Code" <> '' then
                        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, recRegion."Email ID");
                    SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'mukul@sampoornafeeds.in');

                    SMTPMail.AppendToBody('<br><br>');
                    SMTPMail.AppendToBody('Dear Sir,');
                    SMTPMail.AppendToBody('<br><br>');
                    SMTPMail.AppendToBody('This is to inform all of you that agreement of Farm Name ');
                    SMTPMail.AppendToBody(T_14.Name);
                    SMTPMail.AppendToBody(' and Farm Code ');
                    SMTPMail.AppendToBody(T_14.Code);
                    SMTPMail.AppendToBody(',Will Expire on ');
                    SMTPMail.AppendToBody(FORMAT(T_14."Agreement End Date"));
                    SMTPMail.AppendToBody(' You are requested to start renewal process of the said agreement on priority, in case of expiry of agreement, the said farm will be blocked.” ');
                    SMTPMail.AppendToBody('<br><br>');
                    SMTPMail.AppendToBody('This is a system generated mail., kindly do not reply on this email IDs, if you have any queries please contact dealing desk');
                    SMTPMail.AppendToBody('<br><br>');
                    SMTPMail.AppendToBody('Thanks & Regards, ');
                    SMTPMail.AppendToBody('<br><br>');
                    SMTPMail.AppendToBody('Team Sampoorna ');
                    Email.Send(SMTPMail, Enum::"Email Scenario"::Default);
                    //MESSAGE('Mail send');
                    SLEEP(200);
                END;
            UNTIL T_14.NEXT = 0;
        //PRU_NEELESH
    end;

    local procedure DispatchReconcilationReport()
    var
        SalesShipmentHeader: Record 110;
        DuplicateBranch: Code[10];
        ReportPath: Text;
        SalesShipment: Record 110;
        DimensionValue: Record 349;
        ReportDate: Date;
        txtFilterValue: Text;
        FileManagement: Codeunit "File Management";
        FileName: Text;
        ReportDispatchReconcilation: Report "Dispatch Reconcilation";
    begin
        ReportDate := CALCDATE('-1D', WORKDATE);
        SalesShipmentHeader.RESET;
        SalesShipmentHeader.SETCURRENTKEY("Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        SalesShipmentHeader.SETRANGE(SalesShipmentHeader."Posting Date", ReportDate);
        SalesShipmentHeader.SETFilter(SalesShipmentHeader."Shortcut Dimension 1 Code", '%1|%2|%3', 'FEED', 'CATTLE', 'SWINE');
        SalesShipmentHeader.SETFILTER("Shortcut Dimension 2 Code", '%1..%2', '1001', '1999');
        //SalesShipmentHeader.SETCURRENTKEY("Shortcut Dimension 2 Code");
        IF SalesShipmentHeader.FINDSET THEN BEGIN
            REPEAT
                IF SalesShipmentHeader."Shortcut Dimension 2 Code" <> DuplicateBranch THEN BEGIN
                    //    SMTPMailSetup.GET;
                    SalesShipment.RESET;
                    SalesShipment.SETFILTER(SalesShipment."Shortcut Dimension 1 Code", '%1|%2|%3', 'FEED', 'CATTLE', 'SWINE');
                    //SalesShipment.SETFILTER("Shortcut Dimension 2 Code", '%1..%2|%3','1001','1012','1013');
                    SalesShipment.SETRANGE(SalesShipment."Shortcut Dimension 2 Code", SalesShipmentHeader."Shortcut Dimension 2 Code");
                    //CustLeddger.CALCFIELDS("Amt. to Customer");
                    //CustLeddger.SETFILTER(CustLeddger."Amt. to Customer",'<>%1',0);
                    IF SalesShipment.FINDFIRST THEN BEGIN
                        //MESSAGE('%1',CustLeddger."Shortcut Dimension 2 Code");
                        DimensionValue.RESET;
                        DimensionValue.SETRANGE(DimensionValue."Dimension Code", 'BRANCH');
                        DimensionValue.SETRANGE(DimensionValue.Blocked, FALSE);
                        DimensionValue.SETFILTER(DimensionValue.Email, '<>%1', '');
                        DimensionValue.SETRANGE(DimensionValue.Code, SalesShipment."Shortcut Dimension 2 Code");
                        IF DimensionValue.FINDFIRST THEN BEGIN
                            //ReportDate := CALCDATE('-1D',WORKDATE);
                            Clear(FileName);
                            Clear(FileManagement);
                            Clear(ReportDispatchReconcilation);
                            FileName := 'D:\MSZ Reports\DespatchReconcilation\' + 'DispatchReconcilation' + DimensionValue.Name + '.xlsx';
                            SMTPMail.Create(DimensionValue.Email, 'Dispatch Reconcilation' + '' + DimensionValue.Name, '', true);
                            //SMTPMail.Create('sumandev@sampoornafeeds.com', 'Dispatch Reconcilation' + '' + DimensionValue.Name, '', true);
                            SMTPMail.AppendToBody('Dear All' + ',' + '<BR><BR>');
                            SMTPMail.AppendToBody('Please find below Dispatch Reconcilation as on date ' + ' ' + FORMAT(ReportDate) + '.<BR><BR>');
                            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Bcc, 'Pankaj@sampoornafeeds.Com');
                            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Bcc, 'bhupesh.kumar@sampoornafeeds.in');
                            //SMTPMail.AddBCC('gaurav.kumar@sampoornafeeds.in;sumandev@sampoornafeeds.in');
                            RecRef.GetTable(SalesShipment);
                            TempBlob.CreateOutStream(Outstr);
                            ReportDispatchReconcilation.SetTableView(SalesShipment);
                            ReportDispatchReconcilation.SaveAsExcel(FileName);
                            //Report.SaveAs(Report::"Dispatch Reconcilation", '', ReportFormat::Excel, Outstr, RecRef);
                            //FileManagement.BLOBExportToServerFile(TempBlob, FileName);

                            FileManagement.BLOBImportFromServerFile(TempBlob, FileName);

                            TempBlob.CreateInStream(Instr);
                            SMTPMail.AddAttachment(FORMAT(DimensionValue.Name) + '.xlsx', 'xlsx', Instr);

                            SMTPMail.AppendToBody('Regards' + ',' + '<BR>' + 'Sampoorna Feeds Pvt. Ltd.' + '<BR><BR>');
                            SMTPMail.AppendToBody('This is system generated mail. Please do not reply.<BR><BR>');
                            EmailR.Send(SMTPMail, Enum::"Email Scenario"::Default);
                            Erase(FileName);
                        END;
                    END;

                    DuplicateBranch := SalesShipmentHeader."Shortcut Dimension 2 Code";
                END;
            UNTIL SalesShipmentHeader.NEXT = 0;
        END;

    end;

    local procedure DailyOutstandingQuantity()
    var
        DuplicateBranch: Code[10];
        ReportPath: Text;
        DimensionValue: Record 349;
        ReportDate: Date;
        txtFilterValue: Text;
        SalesLine: Record 37;
        salesLine1: Record 37;
        FileName: Text;
        FileManagement: Codeunit "File Management";
        ReportOutstandingSalesOrder: Report "Outstanding Sales Order";

    begin
        ReportDate := CALCDATE('-1D', WORKDATE);
        SalesLine.RESET;
        SalesLine.SETCURRENTKEY("Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        SalesLine.SETFILTER("Outstanding Quantity", '<>%1', 0);
        SalesLine.SETFILTER("No.", '<>%1', '');
        SalesLine.SETFilter(SalesLine."Shortcut Dimension 1 Code", '%1|%2|3', 'FEED', 'CATTLE', 'SWINE');
        //SalesLine.SETFILTER("Shortcut Dimension 2 Code", '%1|%2|%3|%4|%5|%6|%7', '1001', '1002', '1004', '1006', '1007', '1010', '1011');
        IF SalesLine.FINDSET THEN BEGIN
            REPEAT
                IF SalesLine."Shortcut Dimension 2 Code" <> DuplicateBranch THEN BEGIN
                    // SMTPMailSetup.GET;
                    //ReportDate := CALCDATE('-1D',WORKDATE);
                    salesLine1.RESET;
                    //salesLine1.SETRANGE(salesLine1."Shortcut Dimension 1 Code", 'FEED');
                    salesLine1.SETRANGE(salesLine1."Shortcut Dimension 2 Code", SalesLine."Shortcut Dimension 2 Code");
                    IF salesLine1.FINDFIRST THEN BEGIN
                        DimensionValue.RESET;
                        DimensionValue.SETRANGE(DimensionValue."Dimension Code", 'BRANCH');
                        DimensionValue.SETRANGE(DimensionValue.Blocked, FALSE);
                        //IF DimensionValue.Email <> '' THEN
                        DimensionValue.SETFILTER(DimensionValue.Email, '<>%1', '');
                        DimensionValue.SETRANGE(DimensionValue.Code, salesLine1."Shortcut Dimension 2 Code");
                        IF DimensionValue.FINDFIRST THEN BEGIN
                            Clear(FileName);
                            Clear(FileManagement);
                            Clear(ReportOutstandingSalesOrder);
                            FileName := 'D:\MSZ Reports\' + 'Outstanding Sales Order_' + DimensionValue.Name + '.xlsx';
                            SMTPMail.Create(DimensionValue.Email, 'Outstanding Sales Order' + '  ' + DimensionValue.Name, '', true);
                            SMTPMail.AppendToBody('Dear All' + ',' + '<BR><BR>');
                            SMTPMail.AppendToBody('Please find the Attached  Outstanding Sales Order as on date ' + ' ' + FORMAT(ReportDate) + '.<BR><BR>');
                            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Bcc, 'Pankaj@sampoornafeeds.Com');
                            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Bcc, 'bhupesh.kumar@sampoornafeeds.in');

                            //SMTPMail.AddBCC('gaurav.kumar@sampoornafeeds.in;sumandev@sampoornafeeds.in');

                            RecRef.GetTable(salesLine1);
                            TempBlob.CreateOutStream(Outstr);
                            ReportOutstandingSalesOrder.SetTableView(salesLine1);
                            ReportOutstandingSalesOrder.SaveAsExcel(FileName);
                            //Report.SaveAs(Report::"Outstanding Sales Order", '', ReportFormat::Excel, Outstr, RecRef);
                            //FileManagement.BLOBExportToServerFile(TempBlob, FileName);

                            FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
                            TempBlob.CreateInStream(Instr);
                            SMTPMail.AddAttachment('Outstanding Sales Order_' + FORMAT(DimensionValue.Name) + '.xlsx', 'xlsx', Instr);
                            SMTPMail.AppendToBody('Regards' + ',' + '<BR>' + 'Sampoorna Feeds Pvt. Ltd.' + '<BR><BR>');
                            SMTPMail.AppendToBody('This is system generated mail. Please do not reply.<BR><BR>');
                            EmailR.Send(SMTPMail, Enum::"Email Scenario"::Default);
                            If FileManagement.ServerFileExists(FileName) Then
                                Erase(FileName);
                            //MESSAGE('%1,%2',CustLeddger."Shortcut Dimension 2 Code");
                        END;
                    END;

                    DuplicateBranch := SalesLine."Shortcut Dimension 2 Code";
                END;
            UNTIL SalesLine.NEXT = 0;
        END;

    end;

    local procedure AgedAccountReciable()
    var
        DuplicateBranch: Code[30];
        ReportPath: Text;
        SalespersonPurchaser: Record 13;
        ReportDate: Date;
        txtFilterValue: Text;
        Customer: Record 18;
        Customer18: Record 18;
        SalesHeader: Record 36;
        OrderDate: Date;
        ABC: Boolean;
        SalesCode: Text;
        SalesCode1: Text;
        EndingDate: Date;
        CustLedgerEntry: Record 21;
        AMT: Decimal;
        AsOnDate_gDte: Date;
        Flag: Boolean;
        SalesPersonCode: Code[20];

        FileName: Text;
        FileManagement: Codeunit "File Management";
    begin
        //AsOnDate_gDte := CALCDATE('-2D',WORKDATE);
        Customer.RESET;
        Customer.SETCURRENTKEY("Salesperson Code");
        Customer.SETRANGE("Team Type", Customer18."Team Type"::Poultry);
        //Customer.SETFILTER("Salesperson Code",'<>%1|<>%2','SAM02822','SAM1508');
        IF Customer.FINDSET THEN BEGIN
            REPEAT
                IF Customer."Salesperson Code" <> DuplicateBranch THEN BEGIN
                    //    SMTPMailSetup.GET;
                    //AsOnDate_gDte := CALCDATE('-2D',WORKDATE);
                    Customer18.RESET;
                    Customer18.SETRANGE(Customer18."Salesperson Code", Customer."Salesperson Code");
                    IF Customer18.FINDFIRST THEN BEGIN
                        SalespersonPurchaser.RESET;
                        SalespersonPurchaser.SETFILTER(SalespersonPurchaser."E-Mail", '<>%1', '');
                        SalespersonPurchaser.SETRANGE(SalespersonPurchaser.Blocked, FALSE);
                        SalespersonPurchaser.SETRANGE(SalespersonPurchaser.Code, Customer18."Salesperson Code");
                        IF SalespersonPurchaser.FINDFIRST THEN BEGIN
                            Clear(FileName);
                            Clear(FileManagement);
                            FileName := 'D:\MSZ Reports\DespatchReconcilation\' + 'Sales Outstanding Details_' + SalespersonPurchaser.Name + '.xlsx';
                            SMTPMail.Create('sumandev@sampoornafeeds.in', 'Sampoorna Feeds Pvt. Ltd.', 'Sales Outstanding Details', true);
                            SMTPMail.AppendToBody('Dear All' + ',' + '<BR><BR>');
                            SMTPMail.AppendToBody('Please find the Attached  Sales Outstanding Details as on date ' + ' ' + FORMAT(WORKDATE) + '.<BR><BR>');
                            //SMTPMail.AddRecipients(SalespersonPurchaser."E-Mail");
                            //SMTPMail.AddCC('gaurav.kumar@sampoornafeeds.in');
                            //SMTPMail.AddBCC('sumandev@sampoornafeeds.in');
                            RecRef.GetTable(Customer18);
                            TempBlob.CreateOutStream(Outstr);
                            Report.SaveAs(Report::"Sales Outstanding Report", '', ReportFormat::Excel, Outstr, RecRef);
                            FileManagement.BLOBExportToServerFile(TempBlob, FileName);

                            FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
                            TempBlob.CreateInStream(Instr);
                            SMTPMail.AddAttachment('Sales Outstanding Details_' + SalespersonPurchaser.Name + '.xlsx', 'xlsx', Instr);

                            SMTPMail.AppendToBody('Regards' + ',' + '<BR>' + 'Sampoorna Feeds Pvt. Ltd.' + '<BR><BR>');
                            SMTPMail.AppendToBody('This is system generated mail. Please do not reply.<BR><BR>');
                            EmailR.Send(SMTPMail, Enum::"Email Scenario"::Default);
                            Erase(FileName);
                        END;
                    END;

                    DuplicateBranch := Customer."Salesperson Code";
                END;
            UNTIL Customer.NEXT = 0;
        END;


    end;

    local procedure AgedAccountReciableTeam()
    var
        DuplicateBranch: Code[10];
        ReportPath: Text;
        SalespersonPurchaser: Record 13;
        ReportDate: Date;
        txtFilterValue: Text;
        Customer: Record 18;
        Customer18: Record 18;
        SalesHeader: Record 36;
        OrderDate: Date;
        ABC: Boolean;
        Team: Record 5083;
        TeamCode: Code[10];
        TeamSalesperson: Record 5084;
        AsonDate: Date;

        FileName: Text;
        FileManagement: Codeunit "File Management";
    begin
        AsonDate := WORKDATE;
        Customer.RESET;
        Customer.SETCURRENTKEY("Team Code");
        //Customer.SETFILTER("Team Code",'%1|%2|%3|%4|%5|%6|%7','ASSAM','BIHAR','MD SIR','PUNJAB','RC SINGH','SHAILESH','SUBODH');
        IF Customer.FINDSET THEN BEGIN
            REPEAT
                IF Customer."Team Code" <> DuplicateBranch THEN BEGIN
                    // SMTPMailSetup.GET;
                    AsonDate := WORKDATE;
                    Customer18.RESET;
                    Customer18.SETRANGE("Team Code", Customer."Team Code");
                    IF Customer18.FINDFIRST THEN BEGIN
                        Team.RESET;
                        Team.SETFILTER(Team."E-Mail", '<>%1', '');
                        Team.SETFILTER(Team.Name, '<>%1', '');
                        Team.SETRANGE(Code, Customer18."Team Code");
                        Team.SETRANGE("Team Type", Team."Team Type"::Poultry);
                        IF Team.FINDFIRST THEN BEGIN
                            Clear(FileName);
                            Clear(FileManagement);
                            FileName := 'D:\MSZ Reports\DespatchReconcilation\' + 'Sales Outstanding Details_' + Team.Name + '.xlsx';
                            SMTPMail.Create(Team."E-Mail", 'Sampoorna Feeds Pvt. Ltd.', 'Sales Outstanding Details', true);
                            SMTPMail.AppendToBody('Dear All' + ',' + '<BR><BR>');
                            SMTPMail.AppendToBody('Please find the Attached  Sales Outstanding Details as on date ' + ' ' + FORMAT(AsonDate) + '.<BR><BR>');
                            //SMTPMail.AddRecipients('sumandev@sampoornafeeds.in');
                            //SMTPMail.AddCC('gaurav.kumar@sampoornafeeds.in');
                            //SMTPMail.AddBCC('sumandev@sampoornafeeds.in');
                            RecRef.GetTable(Customer18);
                            TempBlob.CreateOutStream(Outstr);
                            Report.SaveAs(Report::"Sales Outstanding Report", '', ReportFormat::Pdf, Outstr, RecRef);
                            FileManagement.BLOBExportToServerFile(TempBlob, FileName);

                            FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
                            TempBlob.CreateInStream(Instr);
                            SMTPMail.AddAttachment('Sales Outstanding Details_' + Team.Name + '.pdf', 'pdf', Instr);

                            SMTPMail.AppendToBody('Regards' + ',' + '<BR>' + 'Sampoorna Feeds Pvt. Ltd.' + '<BR><BR>');
                            SMTPMail.AppendToBody('This is system generated mail. Please do not reply.<BR><BR>');
                            EmailR.Send(SMTPMail, Enum::"Email Scenario"::Default);
                            Erase(FileName);
                        END;
                    END;

                    DuplicateBranch := Customer."Team Code";
                END;
            UNTIL Customer.NEXT = 0;
        END;
    end;


    local procedure AgedAccountReciableTeamType()
    var
        DuplicateBranch: Option ,Cattle,Poultry;
        ReportPath: Text;
        SalespersonPurchaser: Record 13;
        ReportDate: Date;
        txtFilterValue: Text;
        Customer: Record 18;
        Customer18: Record 18;
        SalesHeader: Record 36;
        OrderDate: Date;
        ABC: Boolean;
        Team: Record 5083;
        TeamCode: Code[10];
        TeamSalesperson: Record 5084;
        EndingDate: Date;
        OptionField: Option ,Cattle,Poultry;
        AsonDate: Date;
    begin
        AsonDate := WORKDATE;
        Customer.RESET;
        Customer.SETCURRENTKEY("Team Type");
        Customer.SETRANGE("Team Type", Team."Team Type"::Poultry);
        IF Customer.FINDSET THEN BEGIN
            REPEAT
                IF Customer."Team Type" <> DuplicateBranch THEN BEGIN
                    //  SMTPMailSetup.GET;
                    AsonDate := WORKDATE;
                    Customer18.RESET;
                    Customer18.SETRANGE("Team Type", Customer."Team Type");
                    Customer18.SETRANGE("Team Type", Customer."Team Type"::Poultry);
                    IF Customer18.FINDFIRST THEN BEGIN
                        Team.RESET;
                        Team.SETFILTER(Team."E-Mail", '<>%1', '');
                        Team.SETFILTER(Team.Name, '<>%1', '');
                        Team.SETRANGE("Team Type", Customer18."Team Type");
                        Team.SETRANGE("Team Type", Customer18."Team Type"::Poultry);

                        IF Team.FINDFIRST THEN BEGIN
                            SMTPMail.Create('deepak.dhapke@sampoornafeeds.in', 'Sampoorna Feeds Pvt. Ltd.', 'Sales Outstanding Details', true);
                            SMTPMail.AppendToBody('Dear All' + ',' + '<BR><BR>');
                            SMTPMail.AppendToBody('Please find the Attached  Sales Outstanding Details of Poultry Feeds as on date ' + ' ' + FORMAT(AsonDate) + '.<BR><BR>');
                            //SMTPMail.AddRecipients(Team."E-Mail");
                            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'arvind.gupta@sampoornafeeds.com');


                            //SMTPMail.AddBCC('sumandev@sampoornafeeds.in');
                            //SMTPMail.AddBCC('gaurav.kumar@sampoornafeeds.in;sumandev@sampoornafeeds.in');

                            RecRef.GetTable(Customer18);
                            TempBlob.CreateOutStream(Outstr);
                            Report.SaveAs(Report::"Customer Outstanding Details", '', ReportFormat::Pdf, Outstr, RecRef);
                            TempBlob.CreateInStream(Instr);
                            SMTPMail.AddAttachment('Sales Outstanding Details_' + FORMAT(Team."Team Type") + '.pdf', 'pdf', Instr);

                            SMTPMail.AppendToBody('Regards' + ',' + '<BR>' + 'Sampoorna Feeds Pvt. Ltd.' + '<BR><BR>');
                            SMTPMail.AppendToBody('This is system generated mail. Please do not reply.<BR><BR>');
                            EmailR.Send(SMTPMail, Enum::"Email Scenario"::Default);
                        END;
                    END;
                    DuplicateBranch := Customer."Team Type";
                END;
            UNTIL Customer.NEXT = 0;
        END;
        //
        EndingDate := TODAY;
        Customer.RESET;
        Customer.SETCURRENTKEY("Team Type");
        Customer.SETRANGE("Team Type", Team."Team Type"::Cattle);
        IF Customer.FINDSET THEN BEGIN
            REPEAT
                IF Customer."Team Type" <> DuplicateBranch THEN BEGIN
                    //   SMTPMailSetup.GET;
                    EndingDate := CALCDATE('-2D', WORKDATE);
                    Customer18.RESET;
                    Customer18.SETRANGE("Team Type", Customer."Team Type");
                    IF Customer18.FINDFIRST THEN BEGIN
                        Team.RESET;
                        Team.SETRANGE("Team Type", Customer18."Team Type");
                        IF Team.FINDFIRST THEN BEGIN
                            SMTPMail.Create('sunilkapoor@sampoornafeeds.com', 'Sampoorna Feeds Pvt. Ltd.', 'Sales Outstanding Details', true);
                            SMTPMail.AppendToBody('Dear All' + ',' + '<BR><BR>');
                            SMTPMail.AppendToBody('Please find the Attached  Sales Outstanding Details as on date ' + ' ' + FORMAT(EndingDate) + '.<BR><BR>');
                            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'arvind.gupta@sampoornafeeds.com');
                            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Bcc, 'ritu@sampoornafeeds.com');
                            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Bcc, 'sumandev@sampoornafeeds.in');
                            RecRef.GetTable(Customer18);
                            TempBlob.CreateOutStream(Outstr);
                            Report.SaveAs(Report::"Customer Outstanding Details", '', ReportFormat::Pdf, Outstr, RecRef);
                            TempBlob.CreateInStream(Instr);
                            SMTPMail.AddAttachment('Sales Outstanding Details_' + FORMAT(Team."Team Type") + '.pdf', 'pdf', Instr);
                            SMTPMail.AppendToBody('Regards' + ',' + '<BR>' + 'Sampoorna Feeds Pvt. Ltd.' + '<BR><BR>');
                            SMTPMail.AppendToBody('This is system generated mail. Please do not reply.<BR><BR>');
                            EmailR.Send(SMTPMail, Enum::"Email Scenario"::Default);
                        END;
                    END;
                    DuplicateBranch := Customer."Team Type";
                END;
            UNTIL Customer.NEXT = 0;
        END;
    end;

    procedure CreateAttachmentReportForSalesPerson()
    var
        SalespersonPurchaser: Record 13;
        Customer: Record 18;
        FileName: Text;
        FileURL: Label 'http://sfplwhatsapp.sampoornafeeds.in/';
        DummyDate: Date;
        filepath: Text;
        NumberList: List of [Text];
        Number: Text;
    begin
        Clear(WhatsApp);
        SalespersonPurchaser.RESET;
        SalespersonPurchaser.SETRANGE(SalespersonPurchaser.Blocked, FALSE);
        SalespersonPurchaser.SETFILTER(SalespersonPurchaser."Phone No.", '<>%1', '');
        //SalespersonPurchaser.SETFILTER(Code, 'SAM5481');
        IF SalespersonPurchaser.FINDSET THEN
            REPEAT
                Clear(FileName);
                Clear(filepath);
                Customer.RESET;
                Customer.SETRANGE("Salesperson Code", SalespersonPurchaser.Code);
                //Customer.SetFilter("No.", '%1&%2', '<>*SFC05465*', '<>*SFC07141*');
                Customer.SETFILTER("Net Change", '<>%1', 0);
                IF Customer.FINDSET THEN BEGIN
                    FileName := 'D:\Whatsapp\' + DelChr(SalespersonPurchaser.Code) + DelChr(Format(WorkDate()), '=', '/\-') + '.pdf';
                    FilePath := 'https://sfplwhatsapp.sampoornafeeds.in/' + DelChr(SalespersonPurchaser.Code) + DelChr(Format(WorkDate()), '=', '/\-') + '.pdf';
                    REPORT.SAVEASPDF(REPORT::"Sales Outstanding Report", FileName, Customer);
                    //WhatsApp.WhatsAppAPI(WhatsApp.WhatsAppSalesOutstanding(SalespersonPurchaser."Phone No.", FilePath, SalespersonPurchaser.Name + DelChr(Format(WorkDate()), '=', '/\-'), 'salesoutstandingnew'));
                    NumberList := SalespersonPurchaser."Phone No.".Split(',');
                    foreach Number in NumberList do begin
                        WhatsApp.AirtelWhatssAppAPI(WhatsApp.WhatsAppSalesOutstanding(Number, SalespersonPurchaser.Name, FilePath, SalespersonPurchaser.Name + DelChr(Format(WorkDate()), '=', '/\-'), '01kjpmekfqymr1k1yrp64wtq64'));
                        //SendWhatsAppAttachment(SalespersonPurchaser."Phone No.", DelChr(SalespersonPurchaser.Code) + '.pdf', 'Sales Outstanding Report' + ' ' + Format(Today()));
                    END;
                END;
            UNTIL SalespersonPurchaser.NEXT = 0;

    end;


    procedure CreateAttachmentReportForTeamLeader()
    var
        Customer: Record 18;
        FileName: Text;
        TeamSalesperson: Record 5084;
        Team: Record 5083;
        FileURL: Label 'http://sfplwhatsapp.sampoornafeeds.in/';
        DummyDate: Date;
        FilePath: Text;
        NumberList: List of [Text];
        Number: Text;
    begin
        Clear(WhatsApp);
        Team.RESET;
        Team.SetRange(Blocked, false);
        IF Team.FINDSET THEN
            REPEAT
                Clear(FileName);
                Clear(FilePath);
                Customer.RESET;
                Customer.SETRANGE("Team Code", Team.Code);
                Customer.SETFILTER("Net Change", '<>%1', 0);
                IF Customer.FINDSET THEN BEGIN
                    FileName := 'D:\Whatsapp\' + DelChr(Team.Code) + DelChr(Format(WorkDate()), '=', '/\-') + '.pdf';
                    FilePath := 'https://sfplwhatsapp.sampoornafeeds.in/' + DelChr(Team.Code) + DelChr(Format(WorkDate()), '=', '/\-') + '.pdf';
                    REPORT.SAVEASPDF(REPORT::"Sales Outstanding Report", FileName, Customer);

                    NumberList := Team."Team Phone No.".Split(',');
                    foreach Number in NumberList do begin
                        WhatsApp.AirtelWhatssAppAPI(WhatsApp.WhatsAppSalesOutstanding(Number, Team.Name, FilePath, Team.Name + DelChr(Format(WorkDate()), '=', '/\-'), '01kjpmekfqymr1k1yrp64wtq64'));
                        //SendWhatsAppAttachment(Team."Team Phone No.", DelChr(Team.Code) + '.pdf', 'Sales Outstanding Report' + ' ' + Format(Today()));
                    END;
                END;
            UNTIL Team.NEXT = 0;
    end;


    procedure SendWhatsAppAttachment(MobNo: Text; FileName1: Text; Message: Text): Text
    var
        HttpClient: DotNet HttpClient;
        HttpResponseMessage: DotNet HttpResponseMessage;
        URI: DotNet Uri;
        HttpWebResponseText: Text;
        URL: Label 'https://web.cloudwhatsapp.com/wapp/api/send?';
        APIKEY: Label 'apikey=7bf2c8462d67493e8a79cbd09cc7523e';
        MobileNo: Label '&mobile=';
        WhatsappMessage: Label '&msg=';
        WhatsappAttachment: Label '&pdf=';
        GetUrl: Text;
        FileURL: Label 'http://sfplwhatsapp.sampoornafeeds.in/';
    begin
        GetUrl := '';
        GetUrl := URL + APIKEY + MobileNo + MobNo + WhatsappMessage + Message + '' + WhatsappAttachment + FileURL + FileName1;
        HttpClient := HttpClient.HttpClient();
        HttpClient.BaseAddress := URI.Uri(GetUrl);
        HttpResponseMessage := HttpClient.GetAsync('').Result;
        HttpWebResponseText := HttpResponseMessage.Content.ReadAsStringAsync().Result;
        EXIT(HttpWebResponseText);
    end;


    procedure ERASEFiles()
    var
        SalespersonPurchaser: Record 13;
        Customer: Record 18;
        FileName: Text;
        TeamSalesperson: Record 5084;
        Team: Record 5083;
        FileURL: Label 'http://sfplwhatsapp.sampoornafeeds.in/';
    begin
        SalespersonPurchaser.RESET;
        SalespersonPurchaser.SETRANGE(SalespersonPurchaser.Blocked, FALSE);
        SalespersonPurchaser.SETFILTER(SalespersonPurchaser."Phone No.", '<>%1', '');
        IF SalespersonPurchaser.FINDSET THEN
            REPEAT
                Customer.RESET;
                Customer.SETRANGE("Salesperson Code", SalespersonPurchaser.Code);
                IF Customer.FINDSET THEN BEGIN
                    FileName := 'D:\Whatsapp\' + SalespersonPurchaser."Phone No." + 'S.pdf';
                    ERASE(FileName);
                END;
            UNTIL SalespersonPurchaser.NEXT = 0;
        Team.RESET;
        Team.SetRange(Blocked, false);
        IF Team.FINDSET THEN
            REPEAT
                Customer.RESET;
                Customer.SETRANGE("Team Code", Team.Code);
                IF Customer.FINDSET THEN BEGIN
                    FileName := 'D:\Whatsapp\' + Team."Team Phone No." + 'T.pdf';
                    ERASE(FileName);
                END;
            UNTIL Team.NEXT = 0;
    end;

    procedure CreateattachmentforPerformancereport()
    var
        PReport: Report "Performance Report Auto";
        FileName: Text;
        GCStatement: Record "GC Statement";
        RecRegion: Record Region;
        Name: text;

        FilePath: Text;
        Payload: Text;
        NumberList: List of [Text];
        Number: Text;


    begin
        Companyinfo.Get;
        RecRegion.Reset();
        RecRegion.SetFilter("MobileNo.", '<>%1', '');
        if RecRegion.FindSet() then begin
            repeat
                Name := RecRegion."Region Name";
                Clear(PReport);
                Clear(FileName);
                Clear(FilePath);
                clear(Payload);
                PReport.SetTableView(GCStatement);

                //GCStatement.Reset();

                GCStatement.Reset();
                GCStatement.SetRange("Liquidation Date", CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1);
                GCStatement.SetRange(Region, RecRegion."Region Code");
                GCStatement.SetRange(Posted, true);
                if GCStatement.FindFirst() Then begin
                    PReport.SetReportFilter(CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, RecRegion."Region Code");
                    //PReport.SetReportFilter(20240601D, 20240630D);
                    if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] Then begin
                        FileName := 'D:\Whatsapp\' + 'PerformanceReportSFPL' + DELCHR(RecRegion."Region Name") + DelChr(Format(WorkDate()), '=', '/\-') + '.pdf';
                        FilePath := 'https://sfplwhatsapp.sampoornafeeds.in/PerformanceReportSFPL' + DELCHR(RecRegion."Region Name") + DelChr(Format(WorkDate()), '=', '/\-') + '.pdf';
                        //DelChr(VehicleNo, '=', '/\-. ')
                        //PReport.SAVEASPDF('', FileName, GCStatement);
                        PReport.SaveAsPdf(FileName);
                        // SendWhatsAppAttachment(RecRegion."MobileNo.", 'PerformanceReportSFPL' + DELCHR(RecRegion."Region Name") + Format(Date2DMY(WorkDate(), 1)) + '.pdf', 'Performance Report of' + ' ' + RecRegion."Region Name" + ' from ' + Format(CalcDate('-CM', WorkDate())) + ' To ' + Format(WorkDate() - 1));
                        // SendWhatsAppAttachment('7527020415', 'PerformanceReportSFPL' + DELCHR(RecRegion."Region Name") + Format(Date2DMY(WorkDate(), 1)) + '.pdf', 'Performance Report of' + ' ' + RecRegion."Region Name" + ' from ' + Format(CalcDate('-CM', WorkDate())) + ' To ' + Format(WorkDate() - 1));
                        // SendWhatsAppAttachment('9759785217', 'PerformanceReportSFPL' + DELCHR(RecRegion."Region Name") + Format(Date2DMY(WorkDate(), 1)) + '.pdf', 'Performance Report of' + ' ' + RecRegion."Region Name" + ' from ' + Format(CalcDate('-CM', WorkDate())) + ' To ' + Format(WorkDate() - 1));
                        // SendWhatsAppAttachment('9988212588', 'PerformanceReportSFPL' + DELCHR(RecRegion."Region Name") + Format(Date2DMY(WorkDate(), 1)) + '.pdf', 'Performance Report of' + ' ' + RecRegion."Region Name" + ' from ' + Format(CalcDate('-CM', WorkDate())) + ' To ' + Format(WorkDate() - 1));
                        // SendWhatsAppAttachment('9876608880', 'PerformanceReportSFPL' + DELCHR(RecRegion."Region Name") + Format(Date2DMY(WorkDate(), 1)) + '.pdf', 'Performance Report of' + ' ' + RecRegion."Region Name" + ' from ' + Format(CalcDate('-CM', WorkDate())) + ' To ' + Format(WorkDate() - 1));
                        // SendWhatsAppAttachment('7087071000', 'PerformanceReportSFPL' + DELCHR(RecRegion."Region Name") + Format(Date2DMY(WorkDate(), 1)) + '.pdf', 'Performance Report of' + ' ' + RecRegion."Region Name" + ' from ' + Format(CalcDate('-CM', WorkDate())) + ' To ' + Format(WorkDate() - 1));
                        //================New API ===============================================
                        WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('7527020415', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Performance Report' + DelChr(Format(WorkDate()), '=', '/\') + ' ' + DELCHR(RecRegion."Region Name")));
                        WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('9759785217', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Performance Report' + DelChr(Format(WorkDate()), '=', '/\') + ' ' + DELCHR(RecRegion."Region Name")));
                        WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('9988212588', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Performance Report' + DelChr(Format(WorkDate()), '=', '/\') + ' ' + DELCHR(RecRegion."Region Name")));
                        WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('9876608880', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Performance Report' + DelChr(Format(WorkDate()), '=', '/\') + ' ' + DELCHR(RecRegion."Region Name")));
                        WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('7087071000', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Performance Report' + DelChr(Format(WorkDate()), '=', '/\') + ' ' + DELCHR(RecRegion."Region Name")));
                        WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('7300000016', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Performance Report' + DelChr(Format(WorkDate()), '=', '/\') + ' ' + DELCHR(RecRegion."Region Name"))); // Riya Gupta
                        WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('7023022755', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Performance Report' + DelChr(Format(WorkDate()), '=', '/\') + ' ' + DELCHR(RecRegion."Region Name"))); // SS Rathore
                        NumberList := RecRegion."MobileNo.".Split(',');
                        foreach Number in NumberList do begin
                            WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport(Number, CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Performance Report' + DelChr(Format(WorkDate()), '=', '/\') + ' ' + DELCHR(RecRegion."Region Name")));
                        END;
                        //ERASE(FileName);
                    end else begin
                        if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::"Star Foods"] Then begin
                            FileName := 'D:\Whatsapp\' + 'PerformanceReportSTAR' + DELCHR(RecRegion."Region Name") + DelChr(Format(WorkDate()), '=', '/\-') + '.pdf';
                            FilePath := 'https://sfplwhatsapp.sampoornafeeds.in/PerformanceReportSTAR' + DELCHR(RecRegion."Region Name") + DelChr(Format(WorkDate()), '=', '/\-') + '.pdf';
                            //DelChr(VehicleNo, '=', '/\-. ')
                            //PReport.SAVEASPDF('', FileName, GCStatement);
                            PReport.SaveAsPdf(FileName);
                            // SendWhatsAppAttachment(RecRegion."MobileNo.", 'PerformanceReportSTAR' + DELCHR(RecRegion."Region Name") + Format(Date2DMY(WorkDate(), 1)) + '.pdf', 'Performance Report of' + ' ' + RecRegion."Region Name" + ' from ' + Format(CalcDate('-CM', WorkDate())) + ' To ' + Format(WorkDate() - 1));
                            // SendWhatsAppAttachment('7527020415', 'PerformanceReportSTAR' + DELCHR(RecRegion."Region Name") + Format(Date2DMY(WorkDate(), 1)) + '.pdf', 'Performance Report of' + ' ' + RecRegion."Region Name" + ' from ' + Format(CalcDate('-CM', WorkDate())) + ' To ' + Format(WorkDate() - 1));
                            // SendWhatsAppAttachment('9759785217', 'PerformanceReportSTAR' + DELCHR(RecRegion."Region Name") + Format(Date2DMY(WorkDate(), 1)) + '.pdf', 'Performance Report of' + ' ' + RecRegion."Region Name" + ' from ' + Format(CalcDate('-CM', WorkDate())) + ' To ' + Format(WorkDate() - 1));
                            // SendWhatsAppAttachment('9988212588', 'PerformanceReportSTAR' + DELCHR(RecRegion."Region Name") + Format(Date2DMY(WorkDate(), 1)) + '.pdf', 'Performance Report of' + ' ' + RecRegion."Region Name" + ' from ' + Format(CalcDate('-CM', WorkDate())) + ' To ' + Format(WorkDate() - 1));
                            // SendWhatsAppAttachment('9876608880', 'PerformanceReportSTAR' + DELCHR(RecRegion."Region Name") + Format(Date2DMY(WorkDate(), 1)) + '.pdf', 'Performance Report of' + ' ' + RecRegion."Region Name" + ' from ' + Format(CalcDate('-CM', WorkDate())) + ' To ' + Format(WorkDate() - 1));
                            // SendWhatsAppAttachment('7087071000', 'PerformanceReportSTAR' + DELCHR(RecRegion."Region Name") + Format(Date2DMY(WorkDate(), 1)) + '.pdf', 'Performance Report of' + ' ' + RecRegion."Region Name" + ' from ' + Format(CalcDate('-CM', WorkDate())) + ' To ' + Format(WorkDate() - 1));
                            //===============New API =====================
                            WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('7527020415', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Performance Report' + DelChr(Format(WorkDate()), '=', '/\') + ' ' + DELCHR(RecRegion."Region Name")));
                            WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport(RecRegion."MobileNo.", CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Performance Report' + DelChr(Format(WorkDate()), '=', '/\') + ' ' + DELCHR(RecRegion."Region Name")));
                            WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('9759785217', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Performance Report' + DelChr(Format(WorkDate()), '=', '/\') + ' ' + DELCHR(RecRegion."Region Name")));
                            WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('9988212588', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Performance Report' + DelChr(Format(WorkDate()), '=', '/\') + ' ' + DELCHR(RecRegion."Region Name")));
                            WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('9876608880', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Performance Report' + DelChr(Format(WorkDate()), '=', '/\') + ' ' + DELCHR(RecRegion."Region Name")));
                            WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('7087071000', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Performance Report' + DelChr(Format(WorkDate()), '=', '/\') + ' ' + DELCHR(RecRegion."Region Name")));
                            WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('7300000016', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Performance Report' + DelChr(Format(WorkDate()), '=', '/\') + ' ' + DELCHR(RecRegion."Region Name"))); // Riya Gupta
                            WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('7023022755', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Performance Report' + DelChr(Format(WorkDate()), '=', '/\') + ' ' + DELCHR(RecRegion."Region Name"))); // SS Rathore

                            NumberList := RecRegion."MobileNo.".Split(',');
                            foreach Number in NumberList do begin
                                WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport(Number, CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Performance Report' + DelChr(Format(WorkDate()), '=', '/\') + ' ' + DELCHR(RecRegion."Region Name")));
                            End;

                            //ERASE(FileName);

                        end;
                    end;
                end;
            Until RecRegion.Next() = 0;
        end;
    end;

    procedure PerformanceReportForAll()
    var
        PReport: Report "Performance Report Auto";
        FileName: Text;
        GCStatement: Record "GC Statement";
        RecRegion: Record Region;
        Name: text;
        WhatsApp: Codeunit "WhatsApp Function";
        FilePath: Text;
        Payload: Text;

    Begin
        Companyinfo.Get;
        Clear(PReport);
        Clear(FileName);
        Clear(FilePath);
        PReport.SetTableView(GCStatement);

        //GCStatement.Reset();

        GCStatement.Reset();
        GCStatement.SetRange("Liquidation Date", CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1);
        GCStatement.SetRange(Posted, true);
        if GCStatement.FindFirst() Then begin
            PReport.SetReportFilter(CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, '');
            //PReport.SetReportFilter(20240601D, 20240630D);
            if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] Then Begin
                FileName := 'D:\Whatsapp\' + 'PerformanceReportAllRegionSFPL' + DelChr(Format(WorkDate()), '=', '/\-') + '.pdf';
                FilePath := 'https://sfplwhatsapp.sampoornafeeds.in/' + 'PerformanceReportAllRegionSFPL' + DelChr(Format(WorkDate()), '=', '/\-') + '.pdf';
                //DelChr(VehicleNo, '=', '/\-. ')

                //PReport.SAVEASPDF('', FileName, GCStatement);
                PReport.SaveAsPdf(FileName);
                // SendWhatsAppAttachment('9988212588,9876608880,7087071000', 'PerformanceReportAllRegionSFPL' + Format(Date2DMY(WorkDate(), 1)) + '.pdf', 'Sampoorna Performance Report from ' + Format(CalcDate('-CM', WorkDate())) + ' To ' + Format(WorkDate() - 1));
                // SendWhatsAppAttachment('7023022755,7527020415', 'PerformanceReportAllRegionSFPL' + Format(Date2DMY(WorkDate(), 1)) + '.pdf', 'Sampoorna Performance Report from ' + Format(CalcDate('-CM', WorkDate())) + ' To ' + Format(WorkDate() - 1));
                // SendWhatsAppAttachment('9759785217,9450392498,9357333856', 'PerformanceReportAllRegionSFPL' + Format(Date2DMY(WorkDate(), 1)) + '.pdf', 'Sampoorna Performance Report from ' + Format(CalcDate('-CM', WorkDate())) + ' To ' + Format(WorkDate() - 1));
                // //SendWhatsAppAttachment('9759785217,9450392498,9357333856', 'PerformanceReportAllRegionSFPL' + Format(Date2DMY(WorkDate(), 1)) + '.pdf', 'Performance Report from ' + Format(CalcDate('-CM', WorkDate())) + ' To ' + Format(WorkDate() - 1));
                //=================New API ==========================
                WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('9988212588', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'SFPL Performance Report All Region' + DelChr(Format(WorkDate()), '=', '/\-')));
                WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('9876608880', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'SFPL Performance Report All Region' + DelChr(Format(WorkDate()), '=', '/\-')));
                WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('7087071000', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'SFPL Performance Report All Region' + DelChr(Format(WorkDate()), '=', '/\-')));
                WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('7023022755', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'SFPL Performance Report All Region' + DelChr(Format(WorkDate()), '=', '/\-')));
                WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('7527020415', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'SFPL Performance Report All Region' + DelChr(Format(WorkDate()), '=', '/\-')));
                WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('9759785217', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'SFPL Performance Report All Region' + DelChr(Format(WorkDate()), '=', '/\-')));
                WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('9357333856', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'SFPL Performance Report All Region' + DelChr(Format(WorkDate()), '=', '/\-')));// Pankaj Mehrotra
                WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('9569949996', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'SFPL Performance Report All Region' + DelChr(Format(WorkDate()), '=', '/\-')));// Parveen Kumar
                WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('9450392498', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'SFPL Performance Report All Region' + DelChr(Format(WorkDate()), '=', '/\-')));// Santosh Partap
                WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('7300000016', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'SFPL Performance Report All Region' + DelChr(Format(WorkDate()), '=', '/\-')));// Riya Gupta
                //ERASE(FileName);
            End else begin
                if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::"Star Foods"] Then Begin
                    FileName := 'D:\Whatsapp\' + 'PerformanceReportAllRegionSTAR' + DelChr(Format(WorkDate()), '=', '/\-') + '.pdf';
                    FilePath := 'https://sfplwhatsapp.sampoornafeeds.in/' + 'PerformanceReportAllRegionSTAR' + DelChr(Format(WorkDate()), '=', '/\-') + '.pdf';
                    //DelChr(VehicleNo, '=', '/\-. ')

                    //PReport.SAVEASPDF('', FileName, GCStatement);
                    PReport.SaveAsPdf(FileName);
                    // SendWhatsAppAttachment('9988212588,9876608880,7087071000', 'PerformanceReportAllRegionSTAR' + DelChr(Format(WorkDate()), '=', '/\-') + '.pdf', 'Star Foods Performance Report from ' + Format(CalcDate('-CM', WorkDate())) + ' To ' + Format(WorkDate() - 1));
                    // SendWhatsAppAttachment('7023022755,7527020415', 'PerformanceReportAllRegionSTAR' + DelChr(Format(WorkDate()), '=', '/\-') + '.pdf', 'Star Foods Performance Report from ' + Format(CalcDate('-CM', WorkDate())) + ' To ' + Format(WorkDate() - 1));
                    // SendWhatsAppAttachment('9759785217,9450392498,9357333856', 'PerformanceReportAllRegionSTAR' + DelChr(Format(WorkDate()), '=', '/\-') + '.pdf', 'Star Foods Performance Report from ' + Format(CalcDate('-CM', WorkDate())) + ' To ' + Format(WorkDate() - 1));
                    // //SendWhatsAppAttachment('9759785217', 'PerformanceReportAllRegionSTAR' + DelChr(Format(WorkDate()), '=', '/\-') + '.pdf', 'Performance Report from ' + Format(CalcDate('-CM', WorkDate())) + ' To ' + Format(WorkDate() - 1));
                    //============== New API ===========================
                    WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('9988212588', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Star Foods Performance Report All Region' + DelChr(Format(WorkDate()), '=', '/\-')));
                    WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('9876608880', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Star Foods Performance Report All Region' + DelChr(Format(WorkDate()), '=', '/\-')));
                    WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('7087071000', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Star Foods Performance Report All Region' + DelChr(Format(WorkDate()), '=', '/\-')));
                    WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('7023022755', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Star Foods Performance Report All Region' + DelChr(Format(WorkDate()), '=', '/\-')));
                    WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('7527020415', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Star Foods Performance Report All Region' + DelChr(Format(WorkDate()), '=', '/\-')));
                    WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('9759785217', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Star Foods Performance Report All Region' + DelChr(Format(WorkDate()), '=', '/\-')));
                    WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('9357333856', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Star Foods Performance Report All Region' + DelChr(Format(WorkDate()), '=', '/\-')));// Pankaj Mehrotra
                    WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('9569949996', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Star Foods Performance Report All Region' + DelChr(Format(WorkDate()), '=', '/\-')));// Parveen Kumar
                    WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('9450392498', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Star Foods Performance Report All Region' + DelChr(Format(WorkDate()), '=', '/\-')));// Santosh Partap
                    WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('9692100037', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Star Foods Performance Report All Region' + DelChr(Format(WorkDate()), '=', '/\-')));// Niraj Malik
                    WhatsApp.AirtelWhatssAppAPI(WhatsApp.SendPerformanceReport('7300000016', CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1, FilePath, 'Star Foods Performance Report All Region' + DelChr(Format(WorkDate()), '=', '/\-')));// Riya Gupta
                    //ERASE(FileName);
                End;
            end;
        end;
    End;

    procedure PerformanceReportForLast05Flock()
    var
        PReport: Report Last05FlockPerformance;
        FileName: Text;
        GCStatement: Record "GC Statement";
        RecRegion: Record Region;
        Name: text;
        WhatsApp: Codeunit "WhatsApp Function";
        FilePath: Text;
        Payload: Text;
        FileManagement: Codeunit "File Management";
    Begin
        Companyinfo.Get;
        Clear(PReport);
        Clear(FileName);
        Clear(FilePath);

        GCStatement.Reset();
        GCStatement.SetRange("Liquidation Date", CalcDate('-CM', (WorkDate() - 1)), WorkDate() - 1);
        GCStatement.SetRange(Posted, true);
        if GCStatement.FindFirst() Then begin
            //GCStatement.Reset();
            FilePath := 'D:\Whatsapp\' + 'Last05FlockPerformanceReport' + DelChr(Format(WorkDate() - 1), '=', '/\-') + '.xlsx';

            SMTPMail.Create('riya@sampoornafeeds.com', 'Performance Report For last 05 Flock', ' ', true);
            SMTPMail.AppendToBody('Dear All' + ',' + '<BR><BR>');
            SMTPMail.AppendToBody('Please find the attached Last 05 Flock Performance Report From ' + Format(CalcDate('-CM', (WorkDate() - 1))) + ' to ' + Format((WorkDate() - 1)) + '.<BR><BR>');
            PReport.SetTableView(GCStatement);

            PReport.SaveAsExcel(FilePath);
            RecRef.GetTable(GCStatement);
            TempBlob.CreateOutStream(Outstr);

            FileManagement.BLOBImportFromServerFile(TempBlob, FilePath);
            TempBlob.CreateInStream(Instr);
            SMTPMail.AddAttachment('Last05FlockPerformanceReport' + '.xlsx', 'xlsx', Instr);
            SMTPMail.AppendToBody('Regards' + ',' + '<BR>' + Companyinfo.Name + '<BR><BR>');
            SMTPMail.AppendToBody('This is system generated mail. Please do not reply.<BR><BR>');
            EmailR.Send(SMTPMail, Enum::"Email Scenario"::Default);
            Erase(FilePath);


        End;
    end;


    procedure CreateattachmentforDMR()
    var
        PReport: Report "Purch Sales Summary";
        FileName: Text;
        FilePath: Text;
        WhatsApp: Codeunit "WhatsApp Function";
    //GCStatement: Record "GC Statement";
    begin
        Clear(PReport);
        Clear(FileName);
        Clear(WhatsApp);
        Clear(FilePath);
        //PReport.SetTableView(GCStatement);
        //GCStatement.Reset();
        //PReport.SetReportFilter(CalcDate('-CM', WorkDate()), WorkDate() - 1);
        //PReport.SetReportFilter(20240601D, 20240630D);
        FilePath := 'D:\Whatsapp\' + 'DailyManagementReport' + DelChr(Format(WorkDate()), '=', '/\-') + '.pdf';
        FileName := 'https://sfplwhatsapp.sampoornafeeds.in/' + 'DailyManagementReport' + DelChr(Format(WorkDate()), '=', '/\-') + '.pdf';
        //DelChr(VehicleNo, '=', '/\-. ')
        //PReport.SAVEASPDF('', FileName, GCStatement);
        PReport.SaveAsPdf(FilePath);
        // SendWhatsAppAttachment('9988212588,7087071000,9876608880', 'DailyManagementReport' + Format(Date2DMY(WorkDate(), 1)) + '.pdf', 'Daily Management Report' + ' ' + Format(WorkDate() - 1));
        // SendWhatsAppAttachment('9759785217,7837651813', 'DailyManagementReport' + Format(Date2DMY(WorkDate(), 1)) + '.pdf', 'Daily Management Report' + ' ' + Format(WorkDate() - 1));
        // SendWhatsAppAttachment('9357351406,9569949996', 'DailyManagementReport' + Format(Date2DMY(WorkDate(), 1)) + '.pdf', 'Daily Management Report' + ' ' + Format(WorkDate() - 1));

        WhatsApp.AirtelWhatssAppAPI(WhatsApp.DMR('9988212588', WorkDate() - 1, FileName, 'Daily Management Report' + DelChr(Format(WorkDate()), '=', '/\-')));
        WhatsApp.AirtelWhatssAppAPI(WhatsApp.DMR('7087071000', WorkDate() - 1, FileName, 'Daily Management Report' + DelChr(Format(WorkDate()), '=', '/\-')));
        WhatsApp.AirtelWhatssAppAPI(WhatsApp.DMR('9876608880', WorkDate() - 1, FileName, 'Daily Management Report' + DelChr(Format(WorkDate()), '=', '/\-')));
        WhatsApp.AirtelWhatssAppAPI(WhatsApp.DMR('9759785217', WorkDate() - 1, FileName, 'Daily Management Report' + DelChr(Format(WorkDate()), '=', '/\-')));
        WhatsApp.AirtelWhatssAppAPI(WhatsApp.DMR('7837651813', WorkDate() - 1, FileName, 'Daily Management Report' + DelChr(Format(WorkDate()), '=', '/\-')));
        WhatsApp.AirtelWhatssAppAPI(WhatsApp.DMR('9569949996', WorkDate() - 1, FileName, 'Daily Management Report' + DelChr(Format(WorkDate()), '=', '/\-'))); // Praveen CA
        WhatsApp.AirtelWhatssAppAPI(WhatsApp.DMR('9357351406', WorkDate() - 1, FileName, 'Daily Management Report' + DelChr(Format(WorkDate()), '=', '/\-'))); // Arvind Gupta
        WhatsApp.AirtelWhatssAppAPI(WhatsApp.DMR('7300000016', WorkDate() - 1, FileName, 'Daily Management Report' + DelChr(Format(WorkDate()), '=', '/\-'))); // Riya Gupta

    end;

    procedure MortalityWeekwise()
    var
        ReportPath: Text;
        ReportDate: Date;
        txtFilterValue: Text;
        ProductionOrder: Record "Production Order";
        ReportMortality: Report "Weekly Mortality % Branch Wise";
        FileNameSFPL: Text;
        FilePathSFPL: Text;
        FileNameSTAR: Text;
        FilePathSTAR: Text;
        WhatsApp: Codeunit "WhatsApp Function";
        FileName: Text;
        FileManagement: Codeunit "File Management";
    begin

        Companyinfo.Get;
        If Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] Then begin
            Clear(FileName);
            Clear(FileManagement);
            FileName := 'D:\MSZ Reports\DespatchReconcilation\' + 'Weekly Mortality % Branch Wise' + '.xlsx';
            SMTPMail.Create('ssrathore@sampoornafeeds.com', 'Mortality Report Week Wise', ' ', true);
            SMTPMail.AppendToBody('Dear All' + ',' + '<BR><BR>');
            SMTPMail.AppendToBody('Please find the attached Mortality report week wise as on date ' + '.<BR><BR>');
            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'Pradeep.kumar@sampoornafeeds.com');
            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'drmohit.kumar@sampoornafeeds.in');
            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'Saleem.khan@sampoornafeeds.in');
            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'Rishabh.gupta@sampoornafeeds.in');
            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'Vasu@sampoornafeeds.com');
            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'Ritu@sampoornafeeds.com');

            //SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Bcc, 'bhupesh.kumar@sampoornafeeds.in');
            //SMTPMail.AddBCC('gaurav.kumar@sampoornafeeds.in;sumandev@sampoornafeeds.in');
            ProductionOrder.Reset();
            ProductionOrder.SetRange("Shortcut Dimension 2 Code", '3000', '4000');
            RecRef.GetTable(ProductionOrder);
            TempBlob.CreateOutStream(Outstr);
            Report.SaveAs(Report::"Weekly Mortality % Branch Wise", '', ReportFormat::Excel, Outstr, RecRef);
            FileManagement.BLOBExportToServerFile(TempBlob, FileName);

            FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
            TempBlob.CreateInStream(Instr);
            SMTPMail.AddAttachment('WeeklyMortalityBranchWiseSFPL' + '.xlsx', 'xlsx', Instr);
            SMTPMail.AppendToBody('Regards' + ',' + '<BR>' + Companyinfo.Name + '<BR><BR>');
            SMTPMail.AppendToBody('This is system generated mail. Please do not reply.<BR><BR>');
            EmailR.Send(SMTPMail, Enum::"Email Scenario"::Default);
            Erase(FileName);
            Clear(ReportMortality);
            Clear(FileNameSFPL);
            Clear(FilePathSFPL);
            Clear(WhatsApp);


            FilePathSFPL := 'D:\Whatsapp\' + 'WeekWiseMortalitySFPL' + DelChr(Format(WorkDate()), '=', '/\-') + '.pdf';
            FileNameSFPL := 'https://sfplwhatsapp.sampoornafeeds.in/' + 'WeekWiseMortalitySFPL' + DelChr(Format(WorkDate()), '=', '/\-') + '.pdf';

            ReportMortality.SetTableView(ProductionOrder);
            ReportMortality.SaveAsPdf(FilePathSFPL);

            WhatsApp.AirtelWhatssAppAPI(WhatsApp.WeekwiseMortality('7023022755', FileNameSFPL, 'WeekWiseMortalitySFPL' + DelChr(Format(WorkDate()), '=', '/\-'), '01kh5mnt4sjwsw71z7xr3qf4ax'));// Dr. Rathor
            WhatsApp.AirtelWhatssAppAPI(WhatsApp.WeekwiseMortality('9759785217', FileNameSFPL, 'WeekWiseMortalitySFPL' + DelChr(Format(WorkDate()), '=', '/\-'), '01kh5mnt4sjwsw71z7xr3qf4ax'))
        end else begin
            Clear(FileName);
            Clear(FileManagement);
            FileName := 'D:\MSZ Reports\DespatchReconcilation\' + 'Weekly Mortality % Branch Wise' + '.xlsx';
            SMTPMail.Create('ssrathore@sampoornafeeds.com', 'Mortality Report Week Wise', ' ', true);
            SMTPMail.AppendToBody('Dear All' + ',' + '<BR><BR>');
            SMTPMail.AppendToBody('Please find the attached Mortality report week wise as on date ' + '.<BR><BR>');
            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'Pradeep.kumar@sampoornafeeds.com');
            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'drmohit.kumar@sampoornafeeds.in');
            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'Saleem.khan@sampoornafeeds.in');
            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'Rishabh.gupta@sampoornafeeds.in');
            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'Vasu@sampoornafeeds.com');
            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'Ritu@sampoornafeeds.com');
            //SMTPMail.AddBCC('gaurav.kumar@sampoornafeeds.in;sumandev@sampoornafeeds.in');
            ProductionOrder.Reset();
            ProductionOrder.SetRange("Shortcut Dimension 2 Code", '2000', '2100');
            RecRef.GetTable(ProductionOrder);
            TempBlob.CreateOutStream(Outstr);
            Report.SaveAs(Report::"Weekly Mortality % Branch Wise", '', ReportFormat::Excel, Outstr, RecRef);
            FileManagement.BLOBExportToServerFile(TempBlob, FileName);

            FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
            TempBlob.CreateInStream(Instr);
            SMTPMail.AddAttachment('WeeklyMortalityBranchWiseSTAR' + '.xlsx', 'xlsx', Instr);
            SMTPMail.AppendToBody('Regards' + ',' + '<BR>' + Companyinfo.Name + '<BR><BR>');
            SMTPMail.AppendToBody('This is system generated mail. Please do not reply.<BR><BR>');
            EmailR.Send(SMTPMail, Enum::"Email Scenario"::Default);
            Erase(FileName);
            Clear(ReportMortality);
            Clear(FileNameSTAR);
            Clear(FilePathSTAR);
            Clear(WhatsApp);


            FilePathSTAR := 'D:\Whatsapp\' + 'WeekWiseMortalitySTAR' + DelChr(Format(WorkDate()), '=', '/\-') + '.pdf';
            FileNameSTAR := 'https://sfplwhatsapp.sampoornafeeds.in/' + 'WeekWiseMortalitySTAR' + DelChr(Format(WorkDate()), '=', '/\-') + '.pdf';

            ReportMortality.SetTableView(ProductionOrder);
            ReportMortality.SaveAsPdf(FilePathSFPL);
            WhatsApp.AirtelWhatssAppAPI(WhatsApp.WeekwiseMortality('7023022755', FileNameSTAR, 'WeekWiseMortalitySTAR' + DelChr(Format(WorkDate()), '=', '/\-'), '01kh5mhngef2fet9sq31gd4ak9'));//Dr. Rathor
            WhatsApp.AirtelWhatssAppAPI(WhatsApp.WeekwiseMortality('9759785217', FileNameSTAR, 'WeekWiseMortalitySTAR' + DelChr(Format(WorkDate()), '=', '/\-'), '01kh5mhngef2fet9sq31gd4ak9'))

        end;
    end;

    procedure DailyMortality()
    var
        ReportPath: Text;
        ReportDate: Date;
        txtFilterValue: Text;
        ProductionOrder: Record "Production Order";
        DailyMortality: Report "Daily Mortality";
        FileNameSFPL: Text;
        FilePathSFPL: Text;
        FileNameSTAR: Text;
        FilePathSTAR: Text;
        WhatsApp: Codeunit "WhatsApp Function";
        FileName: Text;
        FileManagement: Codeunit "File Management";
    begin

        Companyinfo.Get;

        If Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] Then begin
            Clear(FileName);
            Clear(FileManagement);
            FileName := 'D:\MSZ Reports\DespatchReconcilation\' + 'DailyMortalitySF' + '.xlsx';

            //SMTPMail.Create('ssrathore@sampoornafeeds.com', 'Mortality Report Week Wise', ' ', true);
            SMTPMail.Create('ssrathore@sampoornafeeds.com', 'Daily Mortality Report', ' ', true);
            SMTPMail.AppendToBody('Dear All' + ',' + '<BR><BR>');
            SMTPMail.AppendToBody('Please find the attached Daily Mortality report for more than 0.2% on Date  ' + Format((WorkDate() - 1)) + '.<BR><BR>');
            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'Pradeep.kumar@sampoornafeeds.com');
            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'drmohit.kumar@sampoornafeeds.in');
            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'Saleem.khan@sampoornafeeds.in');
            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'Rishabh.gupta@sampoornafeeds.in');
            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'Vasu@sampoornafeeds.com');
            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'Ritu@sampoornafeeds.com');
            //SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Bcc, 'bhupesh.kumar@sampoornafeeds.in');
            //SMTPMail.AddBCC('gaurav.kumar@sampoornafeeds.in;sumandev@sampoornafeeds.in');
            Clear(DailyMortality);
            ProductionOrder.Reset();
            ProductionOrder.SetRange("Shortcut Dimension 2 Code", '3000', '4000');
            RecRef.GetTable(ProductionOrder);
            TempBlob.CreateOutStream(Outstr);
            DailyMortality.SetReportFilter((WorkDate() - 1));
            //DailyMortality.SaveAs('', ReportFormat::Excel, Outstr, RecRef);
            DailyMortality.SaveAsExcel(FileName);

            //FileManagement.BLOBExportToServerFile(TempBlob, FileName);

            FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
            //Report.SaveAs(Report::"Weekly Mortality % Branch Wise", '', ReportFormat::Excel, Outstr, RecRef);
            TempBlob.CreateInStream(Instr);
            SMTPMail.AddAttachment('DailyMortalitySFPL' + '.xlsx', 'xlsx', Instr);
            SMTPMail.AppendToBody('Regards' + ',' + '<BR>' + Companyinfo.Name + '<BR><BR>');
            SMTPMail.AppendToBody('This is system generated mail. Please do not reply.<BR><BR>');
            EmailR.Send(SMTPMail, Enum::"Email Scenario"::Default);
            Erase(FileName);
            Clear(DailyMortality);
            Clear(FileNameSFPL);
            Clear(WhatsApp);
            Clear(FilePathSFPL);

            FilePathSFPL := 'D:\Whatsapp\' + 'DailyMortalitySF' + DelChr(Format(WorkDate() - 1), '=', '/\-') + '.pdf';
            FileNameSFPL := 'https://sfplwhatsapp.sampoornafeeds.in/' + 'DailyMortalitySF' + DelChr(Format(WorkDate() - 1), '=', '/\-') + '.pdf';

            DailyMortality.SetTableView(ProductionOrder);
            DailyMortality.SetReportFilter(WorkDate() - 1);
            DailyMortality.SaveAsPdf(FilePathSFPL);


            WhatsApp.AirtelWhatssAppAPI(WhatsApp.DailyMortality('7023022755', (WorkDate() - 1), FileNameSFPL, 'DailyMortalitySFPL' + DelChr(Format(WorkDate() - 1), '=', '/\-'), '01kh3774mdkfxcvtqnkjcdm9zf'));// Dr. Rathor
            WhatsApp.AirtelWhatssAppAPI(WhatsApp.DailyMortality('9759785217', (WorkDate() - 1), FileNameSFPL, 'DailyMortalitySFPL' + DelChr(Format(WorkDate() - 1), '=', '/\-'), '01kh3774mdkfxcvtqnkjcdm9zf'))
        end else begin
            Clear(FileName);
            Clear(FileManagement);
            FileName := 'D:\MSZ Reports\DespatchReconcilation\' + 'DailyMortalitySTAR' + '.xlsx';
            SMTPMail.Create('ssrathore@sampoornafeeds.com', 'Daily Mortality Report', ' ', true);
            SMTPMail.AppendToBody('Dear All' + ',' + '<BR><BR>');
            SMTPMail.AppendToBody('Please find the attached Daily Mortality report for more than 0.2% on Date  ' + Format((WorkDate() - 1)) + '.<BR><BR>');
            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'Pradeep.kumar@sampoornafeeds.com');
            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'drmohit.kumar@sampoornafeeds.in');
            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'Saleem.khan@sampoornafeeds.in');
            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'Rishabh.gupta@sampoornafeeds.in');
            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'Vasu@sampoornafeeds.com');
            SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'Ritu@sampoornafeeds.com');
            //SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Bcc, 'bhupesh.kumar@sampoornafeeds.in');
            //SMTPMail.AddBCC('gaurav.kumar@sampoornafeeds.in;sumandev@sampoornafeeds.in');

            ProductionOrder.Reset();
            ProductionOrder.SetRange("Shortcut Dimension 2 Code", '2000', '2100');
            RecRef.GetTable(ProductionOrder);
            TempBlob.CreateOutStream(Outstr);
            DailyMortality.SetReportFilter((WorkDate() - 1));
            DailyMortality.SaveAsExcel(FileName);
            // DailyMortality.SaveAs('', ReportFormat::Excel, Outstr, RecRef);
            // FileManagement.BLOBExportToServerFile(TempBlob, FileName);

            FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
            //Report.SaveAs(Report::"Weekly Mortality % Branch Wise", '', ReportFormat::Excel, Outstr, RecRef);
            TempBlob.CreateInStream(Instr);
            SMTPMail.AddAttachment('DailyMortalitySTAR' + '.xlsx', 'xlsx', Instr);
            SMTPMail.AppendToBody('Regards' + ',' + '<BR>' + Companyinfo.Name + '<BR><BR>');
            SMTPMail.AppendToBody('This is system generated mail. Please do not reply.<BR><BR>');
            EmailR.Send(SMTPMail, Enum::"Email Scenario"::Default);
            Erase(FileName);
            Clear(DailyMortality);
            Clear(FileNameSTAR);
            Clear(WhatsApp);
            Clear(FilePathSTAR);

            FilePathSTAR := 'D:\Whatsapp\' + 'DailyMortalitySTAR' + DelChr(Format(WorkDate() - 1), '=', '/\-') + '.pdf';
            FileNameSTAR := 'https://sfplwhatsapp.sampoornafeeds.in/' + 'DailyMortalitySTAR' + DelChr(Format(WorkDate() - 1), '=', '/\-') + '.pdf';

            DailyMortality.SetTableView(ProductionOrder);
            DailyMortality.SetReportFilter(WorkDate() - 1);
            DailyMortality.SaveAsPdf(FilePathSTAR);
            WhatsApp.AirtelWhatssAppAPI(WhatsApp.DailyMortality('7023022755', (WorkDate() - 1), FileNameSTAR, 'DailyMortalitySTAR' + DelChr(Format(WorkDate() - 1), '=', '/\-'), '01khavsdhwq177vm47sgc23gnj'));//Dr. Rathor
            WhatsApp.AirtelWhatssAppAPI(WhatsApp.DailyMortality('9759785217', (WorkDate() - 1), FileNameSTAR, 'DailyMortalitySTAR' + DelChr(Format(WorkDate() - 1), '=', '/\-'), '01khavsdhwq177vm47sgc23gnj'))

        end;
    end;

    procedure CaseAlert()
    var
        CaseDetail: Record "Legal Case Detail";
        CaseSMSBody: Text;
        SendSMS: Codeunit "SMS functions";

    Begin
        SalesandRec.Get;
        CaseDetail.Reset();
        CaseDetail.SetRange("Next Date Of Hearing", (WorkDate() + 15));
        If CaseDetail.FindFirst() then
            repeat
                Clear(CaseSMSBody);

                CaseSMSBody := 'https://pgapi.vispl.in/fe/api/v1/multiSend?username=samprnpg.trans&password=' + SalesandRec."SMS Password" + '&unicode=false&from=' + SalesandRec."Sender ID" + '&to=' + CaseDetail."Phone No." + '&text=Dear Customer,' + ' ' +
                               FORMAT('Information alert') + ' ' + 'Case number' + ' ' + FORMAT(CaseDetail."Case No.") + ' ' + 'running in civil/criminal court at ' + FORMAT(CaseDetail."Hearing Distt.") + ' ' + 'for amount of Rs ' + ' ' + FORMAT(CaseDetail."Case Amount;") + ' ' + 'status of case ' +
                               FORMAT(CaseDetail."Stage Of the Case") + ' ' + ' against you. please clear your outstanding amount as soon as possible. ' + ' Sampoorna Feeds Pvt. Ltd.' + ' 9878099957 / 9770660166' + '&dltContentId=1307174616235967967&dltPrincipalEntityId=' + SalesandRec."Entity ID";
                SendSMS.SendSMSByURL(CaseSMSBody);
                WhatsApp.AirtelWhatssAppAPI(WhatsApp.WhatsupLegalCase(CaseDetail."Case No.", CaseDetail."Hearing Distt.", CaseDetail."Case Amount;", CaseDetail."Stage Of the Case", '9878099957 / 9770660166', CaseDetail."Phone No.", '01khaw0mntm45qxwp97fsvgyf2'));

            until CaseDetail.Next() = 0;

    End;

    procedure FlockPerformanceReport()
    var
        PReport: Report "Flock performance reports";
        FileName: Text;
        ProductionOrder: Record "Production Order";
        Name: text;
        FilePath: Text;
        Payload: Text;
        FileManagement: Codeunit "File Management";
        Dimension: Record "Dimension Value";
        itemledger: Record "Item Ledger Entry";
    Begin
        Companyinfo.Get;
        Clear(PReport);
        Clear(FileName);
        Clear(FilePath);

        SMTPMail.Create('rishabh.gupta@sampoornafeeds.in', 'Flock Performance Report ' + Format(WorkDate() - 1), ' ', true);
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'riya@sampoornafeeds.com');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'ssrathore@sampoornafeeds.com');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'drmohit.kumar@sampoornafeeds.in');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'Saleem.khan@sampoornafeeds.in');
        SMTPMail.AppendToBody('Dear All' + ',' + '<BR><BR>');
        SMTPMail.AppendToBody('Please find the attached Flock Performance Report Report as on  ' + Format((WorkDate() - 1)) + '.<BR><BR>');

        Dimension.Reset();
        Dimension.SetRange("Dimension Code", 'BRANCH');
        Dimension.SetFilter("Mobile No", '<>%1', '');
        Dimension.SetRange(Code, '3000', '4000');
        if Dimension.FindSet() then
            repeat

                itemledger.Reset();
                itemledger.SetRange("Global Dimension 2 Code", Dimension.Code);
                itemledger.Setfilter("Remaining Quantity", '<>%1', 0);
                itemledger.SetRange("Item Type", itemledger."Item Type"::Chick);
                if itemledger.FindFirst() then begin
                    FilePath := 'D:\Whatsapp\' + 'FlockPerformanceReport' + Dimension.Name + '.xlsx';
                    Clear(PReport);
                    ProductionOrder.Reset();
                    ProductionOrder.SetRange("Date Filter", (WorkDate() - 1));
                    ProductionOrder.SetRange(Status, ProductionOrder.Status::Released);
                    if ProductionOrder.FindFirst() Then begin
                        RecRef.GetTable(ProductionOrder);
                        TempBlob.CreateOutStream(Outstr);
                        PReport.SetReportFilter(Dimension.Code);
                        PReport.SaveAsExcel(FilePath);
                        FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
                        SMTPMail.AddAttachment('FlockPerformanceReport' + Dimension.Name + '.xlsx', 'xlsx', Instr);
                    End;
                end;

            until Dimension.Next() = 0;
        SMTPMail.AppendToBody('Regards' + ',' + '<BR>' + Companyinfo.Name + '<BR><BR>');
        SMTPMail.AppendToBody('This is system generated mail. Please do not reply.<BR><BR>');
        EmailR.Send(SMTPMail, Enum::"Email Scenario"::Default);

    end;

    local procedure TempCreditLimitnotification()
    var
        SMTPMail: Codeunit "Email Message";
        Subject: Text;
        Email: Codeunit Email;
        recRegion: Record Region;
        TempoCreditLimit: Record "Temporary Credit Limit";
        Cust: Record Customer;
        SalesPerson: Record "Salesperson/Purchaser";
        recUser: Record User;
        CurrentTeamCode: Code[20];
        TeamTotalAmount: Decimal;
        GrandTotalAmount: Decimal;
        IsFirstRecord: Boolean;
    begin
        Subject := 'Yesterday Temporary Credit Limit Allowed';
        SMTPMail.Create('parveen.k@sampoornafeeds.com', Subject, '', true);
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'sale.coordinator3@sampoornafeeds.in');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'deepak.dhapke@sampoornafeeds.in');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'ritu@sampoornafeeds.com');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'vasu@sampoornafeeds.com');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'rishabh.gupta@sampoornafeeds.in');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Bcc, 'sumandev@sampoornafeeds.com');

        SMTPMail.AppendToBody('Dear Sir,<br><br>');
        SMTPMail.AppendToBody('Please find the below details which credit limit has increased temporarily on dated ' + Format(WorkDate() - 1) + ',');

        SMTPMail.AppendToBody('<style>');
        SMTPMail.AppendToBody('table { border-collapse: collapse; width: 100%; font-family: Arial, sans-serif; font-size: 13px; }');
        SMTPMail.AppendToBody('th, td { border: 1px solid #dddddd; text-align: left; padding: 6px; }');
        SMTPMail.AppendToBody('th { background-color: #f2f2f2; }');
        SMTPMail.AppendToBody('.team-subtotal { background-color: #d9edf7; font-weight: bold; }');
        SMTPMail.AppendToBody('.grand-total { background-color: #dff0d8; font-weight: bold; }');
        SMTPMail.AppendToBody('</style>');

        SMTPMail.AppendToBody('<table>');
        SMTPMail.AppendToBody('<tr>');
        SMTPMail.AppendToBody('<th>Date</th>');
        SMTPMail.AppendToBody('<th>Customer Code</th>');
        SMTPMail.AppendToBody('<th>Customer Name</th>');
        SMTPMail.AppendToBody('<th>Responsibility Centre</th>');
        SMTPMail.AppendToBody('<th>Team Code</th>');
        SMTPMail.AppendToBody('<th>Salesperson Code</th>');
        SMTPMail.AppendToBody('<th>Salesperson Name</th>');
        SMTPMail.AppendToBody('<th>Outstanding</th>');
        SMTPMail.AppendToBody('<th>Credit Limit</th>');
        SMTPMail.AppendToBody('<th>Extra Credit Limit Demanded</th>');
        SMTPMail.AppendToBody('<th>Commitment Date/Remarks/Comment</th>');
        SMTPMail.AppendToBody('<th>Employee ID</th>');
        SMTPMail.AppendToBody('<th>Time</th>');
        SMTPMail.AppendToBody('</tr>');

        TempoCreditLimit.Reset();
        TempoCreditLimit.SetRange(SystemCreatedAt, CreateDateTime(WorkDate() - 1, 000000T), CreateDateTime(WorkDate() - 1, 235959.999T));

        IsFirstRecord := true;
        TeamTotalAmount := 0;
        GrandTotalAmount := 0;
        CurrentTeamCode := '';

        if TempoCreditLimit.FindSet() then begin
            repeat
                // Get Customer details to fetch Team Code
                if Cust.Get(TempoCreditLimit."Customer No") then;
                Cust.CalcFields("Balance (LCY)");

                // Check if Team Code has changed
                if (Cust."Team Code" <> CurrentTeamCode) then begin
                    // Append Subtotal for the previous team (if not the first record)
                    if not IsFirstRecord then begin
                        SMTPMail.AppendToBody('<tr class="team-subtotal">');
                        SMTPMail.AppendToBody('<td colspan="9" align="right">Total for Team (' + CurrentTeamCode + '):</td>');
                        SMTPMail.AppendToBody('<td align="left">' + Format(TeamTotalAmount, 0, '<Precision,2:2><Standard Format,0>') + '</td>');
                        SMTPMail.AppendToBody('<td colspan="3"></td>');
                        SMTPMail.AppendToBody('</tr>');
                    end;

                    // Set new Team Code and reset team subtotal
                    CurrentTeamCode := Cust."Team Code";
                    TeamTotalAmount := 0;
                    IsFirstRecord := false;
                end;

                // Fetch Salesperson
                Clear(SalesPerson);
                if Cust."Salesperson Code" <> '' then
                    if SalesPerson.Get(Cust."Salesperson Code") then;

                // Fetch User details safely
                Clear(recUser);
                if recUser.Get(TempoCreditLimit.SystemCreatedBy) then;

                // Accumulate totals
                TeamTotalAmount += TempoCreditLimit.Amount;
                GrandTotalAmount += TempoCreditLimit.Amount;

                // Append Row
                SMTPMail.AppendToBody('<tr>');
                SMTPMail.AppendToBody('<td>' + Format(WorkDate() - 1) + '</td>');
                SMTPMail.AppendToBody('<td>' + Format(TempoCreditLimit."Customer No") + '</td>');
                SMTPMail.AppendToBody('<td>' + Format(TempoCreditLimit."Customer Name") + '</td>');
                SMTPMail.AppendToBody('<td>' + Format(Cust."Responsibility Center") + '</td>');
                SMTPMail.AppendToBody('<td>' + Format(Cust."Team Code") + '</td>');
                SMTPMail.AppendToBody('<td>' + Format(Cust."Salesperson Code") + '</td>');
                SMTPMail.AppendToBody('<td>' + Format(SalesPerson.Name) + '</td>');
                SMTPMail.AppendToBody('<td>' + Format(Round(Cust."Balance (LCY)"), 0, '<Precision,2:2><Standard Format,0>') + '</td>');
                SMTPMail.AppendToBody('<td>' + Format(Round(Cust."Credit Limit (LCY)"), 0, '<Precision,2:2><Standard Format,0>') + '</td>');
                SMTPMail.AppendToBody('<td>' + Format(Round(TempoCreditLimit.Amount), 0, '<Precision,2:2><Standard Format,0>') + '</td>');
                SMTPMail.AppendToBody('<td>' + Format(TempoCreditLimit.Remark) + '</td>');
                SMTPMail.AppendToBody('<td>' + Format(recUser."Full Name") + '</td>');
                SMTPMail.AppendToBody('<td>' + Format(DT2Time(TempoCreditLimit.SystemCreatedAt)) + '</td>');
                SMTPMail.AppendToBody('</tr>');

            until TempoCreditLimit.Next() = 0;

            // Subtotal for the final team
            SMTPMail.AppendToBody('<tr class="team-subtotal">');
            SMTPMail.AppendToBody('<td colspan="9" align="right">Total for Team (' + CurrentTeamCode + '):</td>');
            SMTPMail.AppendToBody('<td align="left">' + Format(Round(TeamTotalAmount), 0, '<Precision,2:2><Standard Format,0>') + '</td>');
            SMTPMail.AppendToBody('<td colspan="3"></td>');
            SMTPMail.AppendToBody('</tr>');

            // Overall Grand Total
            SMTPMail.AppendToBody('<tr class="grand-total">');
            SMTPMail.AppendToBody('<td colspan="9" align="right">Grand Total:</td>');
            SMTPMail.AppendToBody('<td align="left">' + Format(Round(GrandTotalAmount), 0, '<Precision,2:2><Standard Format,0>') + '</td>');
            SMTPMail.AppendToBody('<td colspan="3"></td>');
            SMTPMail.AppendToBody('</tr>');
        end;

        SMTPMail.AppendToBody('</table>');
        SMTPMail.AppendToBody('<br><br>');
        SMTPMail.AppendToBody('This is a system generated mail, kindly do not reply to this email ID. If you have any queries please contact the dealing desk.<br><br>');

        Email.Send(SMTPMail, Enum::"Email Scenario"::Default);
        Sleep(100);
    end;


    procedure CreateItemStockDetailsVetadd()
    var
        Item: Record Item;
        EmailBody: TextBuilder;
        StockAmount: Decimal;
        Location: Record Location;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
    begin
        EmailBody.AppendLine('<html>');
        EmailBody.AppendLine('<body style="margin:0;padding:0;background:#f4f6fb;font-family:Arial,sans-serif;">');
        EmailBody.AppendLine('<div style="max-width:620px;margin:0 auto;background:#ffffff;border:1px solid #dfe7f5;border-radius:8px;overflow:hidden;">');
        EmailBody.AppendLine('<div style="background:#1f5fd0;padding:12px 16px;color:#ffffff;font-size:18px;font-weight:bold;">Item Stock Details</div>');
        EmailBody.AppendLine('<div style="padding:10px 12px 6px 12px;font-size:12px;color:#475467;">Current inventory Stock by location</div>');
        EmailBody.AppendLine('<table role="presentation" width="100%" cellpadding="6" cellspacing="0" border="0" style="border-collapse:collapse;font-family:Arial,sans-serif;font-size:12px;color:#1f2937;">');
        EmailBody.AppendLine('<thead>');
        EmailBody.AppendLine('<tr>');
        EmailBody.AppendLine('<th align="left" style="background:#eef4ff;padding:8px 6px;border-bottom:1px solid #dfe7f5;font-size:11px;font-weight:bold;color:#1f2937;">Item</th>');
        EmailBody.AppendLine('<th align="left" style="background:#eef4ff;padding:8px 6px;border-bottom:1px solid #dfe7f5;font-size:11px;font-weight:bold;color:#1f2937;">Description</th>');
        EmailBody.AppendLine('<th align="left" style="background:#eef4ff;padding:8px 6px;border-bottom:1px solid #dfe7f5;font-size:11px;font-weight:bold;color:#1f2937;">Loc</th>');
        EmailBody.AppendLine('<th align="left" style="background:#eef4ff;padding:8px 6px;border-bottom:1px solid #dfe7f5;font-size:11px;font-weight:bold;color:#1f2937;">UOM</th>');
        EmailBody.AppendLine('<th align="right" style="background:#eef4ff;padding:8px 6px;border-bottom:1px solid #dfe7f5;font-size:11px;font-weight:bold;color:#1f2937;">Qty</th>');
        EmailBody.AppendLine('<th align="right" style="background:#eef4ff;padding:8px 6px;border-bottom:1px solid #dfe7f5;font-size:11px;font-weight:bold;color:#1f2937;">Amount</th>');
        EmailBody.AppendLine('</tr>');
        EmailBody.AppendLine('</thead>');
        EmailBody.AppendLine('<tbody>');

        if Location.FindSet() then
            repeat
                Item.Reset();
                Item.SetRange("Location Filter", Location.Code);
                Item.CalcFields(Inventory);
                Item.SetFilter(Inventory, '<>%1', 0);
                if Item.FindSet() then
                    repeat
                        Item.CalcFields(Inventory);
                        Item.CalcFields("Stock Value");
                        StockAmount := Item."Stock Value";

                        EmailBody.AppendLine('<tr>');
                        EmailBody.AppendLine('<td style="padding:8px 6px;border-bottom:1px solid #edf2f7;">' + Format(Item."No.") + '</td>');
                        EmailBody.AppendLine('<td style="padding:8px 6px;border-bottom:1px solid #edf2f7;">' + Format(Item.Description) + '</td>');
                        EmailBody.AppendLine('<td style="padding:8px 6px;border-bottom:1px solid #edf2f7;">' + Format(Location.Code) + '</td>');
                        EmailBody.AppendLine('<td style="padding:8px 6px;border-bottom:1px solid #edf2f7;">' + Format(Item."Base Unit of Measure") + '</td>');
                        EmailBody.AppendLine('<td align="right" style="padding:8px 6px;border-bottom:1px solid #edf2f7;">' + Format(Item.Inventory) + '</td>');
                        EmailBody.AppendLine('<td align="right" style="padding:8px 6px;border-bottom:1px solid #edf2f7;color:#0f766e;font-weight:bold;">' + Format(StockAmount) + '</td>');
                        EmailBody.AppendLine('</tr>');
                    until Item.Next() = 0;
            until Location.Next() = 0;

        EmailBody.AppendLine('</tbody>');
        EmailBody.AppendLine('</table>');
        EmailBody.AppendLine('</div>');
        EmailBody.AppendLine('</body></html>');

        EmailMessage.Create('arvind.gupta@vetadd.in', 'Item Stock Details', EmailBody.ToText(), true);
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);


    end;

    procedure SendAgedAccountsPayableReport(): Boolean
    var
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        InStream: InStream;
        OutStream: OutStream;
        Subject: Text[250];
        Body: Text;
        FileName: Text[250];
        AgedAccountsPayableReport: Report "Aged Accounts Payable";
        PeriodLength: DateFormula;
    begin
        // 1. Initialize the report with the supplied date and options.
        Evaluate(PeriodLength, '<1M>');
        AgedAccountsPayableReport.InitializeRequest(
            WorkDate(),
            1,
            PeriodLength,
            false,
            false,
            1,
            false);

        // 2. Save the report output to OutStream as a PDF.
        TempBlob.CreateOutStream(OutStream);
        AgedAccountsPayableReport.SaveAs('', ReportFormat::Pdf, OutStream);

        // 3. Prepare Email Details.
        Subject := StrSubstNo('Aged Accounts Payable as of %1', WorkDate());
        Body := 'Please find the attached Aged Accounts Payable report.';
        FileName := StrSubstNo('Aged Accounts Payable %1.pdf', Format(WorkDate(), 0, '<Year4><Month,2><Day,2>'));

        // 4. Create Email Message. The sender is handled by Business Central email setup.
        TempBlob.CreateInStream(InStream);
        EmailMessage.Create('arvind.gupta@vetadd.in', Subject, Body, true);
        EmailMessage.AddAttachment(FileName, 'application/pdf', InStream);

        // 5. Send through the default email scenario.
        exit(Email.Send(EmailMessage, Enum::"Email Scenario"::Default));
    end;





    var
        WhatsApp: Codeunit "WhatsApp Function";
        SalesandRec: Record "Sales & Receivables Setup";
}


