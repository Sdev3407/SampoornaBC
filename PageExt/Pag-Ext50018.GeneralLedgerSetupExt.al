pageextension 50018 GeneralLedgerSetupExt extends "General Ledger Setup"
{
    layout
    {

        addafter("Register Time")
        {
            field("St Dt"; Rec."St Dt")
            {
                ApplicationArea = all;
            }
            field("Parameter No"; Rec."Parameter No")
            {
                ApplicationArea = All;

            }
            field("Parameter Template No"; Rec."Parameter Template No")
            {
                ApplicationArea = All;

            }
            field("Breed Code"; Rec."Breed Code")
            {
                ApplicationArea = All;

            }
            field("Data Sheet Nos"; Rec."Data Sheet Nos")
            {
                ApplicationArea = All;

            }
            field("Hatchery Nos"; Rec."Hatchery Nos")
            {
                ApplicationArea = All;

            }
            field("Liquidation Date Formula"; Rec."Liquidation Date Formula")
            {
                ApplicationArea = All;

            }
            field("Company Setup"; Rec."Company Setup")
            {
                ApplicationArea = All;

            }
            field("Run SMS"; Rec."Run SMS")
            {
                ApplicationArea = All;

            }
            field("Location Agr. Exp Email"; Rec."Location Agr. Exp Email")
            {
                ApplicationArea = All;

            }
            field("Stop Blocked Dupl. PAN No."; Rec."Stop Blocked Dupl. PAN No.")
            {
                ApplicationArea = All;

            }
            field("Before Expiry Days"; Rec."Before Expiry Days")
            {
                ApplicationArea = All;

            }
            field("Tax Invoice Mail"; Rec."Tax Invoice Mail")
            {
                ApplicationArea = All;


            }
        }
        addafter("Job Queue Category Code")
        {
            field("FTx ID"; Rec."FTx ID")
            {
                ApplicationArea = all;
            }
            field("FTx Password"; Rec."FTx Password")
            {
                ApplicationArea = all;
            }
            field("Certificate No."; Rec."Certificate No.")
            {
                ApplicationArea = all;
            }
        }

    }
    actions
    {
        addafter("Change Payment &Tolerance")
        {
            action(SendSMS)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SendMail;


                trigger OnAction()
                var
                    ProductionOrder: Record "Production Order";
                    RecRef: RecordRef;
                    TempBlob: Codeunit "Temp Blob";
                    Outstr: OutStream;
                    Instr: InStream;
                    DailyMortality: Report "Daily Mortality";
                    FileManagement: Codeunit "File Management";
                    FileName: Text;
                    SMTPMail: Codeunit "Email Message";
                    EmailR: Codeunit Email;
                begin
                    ProductionOrder.Reset();
                    ProductionOrder.SetRange("Shortcut Dimension 2 Code", '3000', '4000');
                    RecRef.GetTable(ProductionOrder);
                    TempBlob.CreateOutStream(Outstr);
                    DailyMortality.SetReportFilter((WorkDate() - 1));
                    //DailyMortality.SaveAs('', ReportFormat::Excel, Outstr, RecRef);
                    DailyMortality.SaveAsExcel('D:\Mortality.xlsx');
                    //FileManagement.BLOBExportToServerFile(TempBlob, 'D:\Mortality.xlsx');

                    FileManagement.BLOBImportFromServerFile(TempBlob, 'D:\Mortality.xlsx');
                    //Report.SaveAs(Report::"Weekly Mortality % Branch Wise", '', ReportFormat::Excel, Outstr, RecRef);
                    TempBlob.CreateInStream(Instr);

                    SMTPMail.AddAttachment('Mortality' + '.xlsx', 'xlsx', Instr);
                    //SMTPMail.AppendToBody('Regards' + ',' + '<BR>' + Companyinfo.Name + '<BR><BR>');
                    SMTPMail.AppendToBody('This is system generated mail. Please do not reply.<BR><BR>');
                    Emailr.Send(SMTPMail, Enum::"Email Scenario"::Default);
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access GL Setup", '%1', UserSetup."Access GL Setup"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to delete general ledger setup');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access GL Setup", '%1', UserSetup."Access GL Setup"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access GL Setup", '%1', UserSetup."Access GL Setup"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to Modify general ledger setup');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access GL Setup", '%1', UserSetup."Access GL Setup"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin
        Rec.RESET;

        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access GL Setup", '%1', UserSetup."Access GL Setup"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open GL Setup');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access GL Setup", '%1', UserSetup."Access GL Setup"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    var
        UserSetup: Record 91;
}