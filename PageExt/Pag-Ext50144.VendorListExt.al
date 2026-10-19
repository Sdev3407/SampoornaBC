pageextension 50144 VendorListExt extends "Vendor List"
{
    layout
    {
        addbefore(VendorDetailsFactBox)
        {
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = All;
                Caption = 'IncomingDocAttachFactBox';
                ShowFilter = false;
            }
        }
        addafter("Location Code")
        {
            field(Address; rec.Address)
            {
                ApplicationArea = all;
            }
            field("Address 2"; rec."Address 2")
            {
                ApplicationArea = all;
            }
            field(City; rec.City)
            {
                ApplicationArea = all;
            }
            field("SFPL_Security Balance"; Rec."SFPL_Security Balance")
            {
                ApplicationArea = all;
            }
        }
        addafter("Phone No.")
        {
            field("TAN No."; rec."TAN No.")
            {
                ApplicationArea = all;

            }
        }
        addafter(Contact)
        {
            field("Net Change"; rec."Net Change")
            {
                ApplicationArea = all;
            }
            field("GST Vendor Type"; rec."GST Vendor Type")
            {
                ApplicationArea = all;
            }
            field("State Code"; rec."State Code")
            {
                ApplicationArea = all;
            }
        }
        addafter("Balance (LCY)")
        {
            field("GST Registration No."; rec."GST Registration No.")
            {
                ApplicationArea = all;
            }
        }
        moveafter("GST Registration No."; "Search Name")

        addafter("Search Name")
        {
            field("E-Mail"; rec."E-Mail")
            {
                ApplicationArea = all;
            }
            field("GST Status"; Rec."GST Status")
            {
                ApplicationArea = All;

            }
            field("P.A.N. No."; rec."P.A.N. No.")
            {
                ApplicationArea = all;
            }
            field("TDS 194Q"; Rec."TDS 194Q")
            {
                ApplicationArea = All;

            }
            field("Debit Amount"; rec."Debit Amount")
            {
                ApplicationArea = All;

            }
            field("Credit Amount"; rec."Credit Amount")
            {
                ApplicationArea = All;
            }
            field(Transporter; rec.Transporter)
            {
                ApplicationArea = All;

            }
            field(Farmer; Rec.Farmer)
            {
                ApplicationArea = All;

            }
            field(Broker; Rec.Broker)
            {
                ApplicationArea = All;

            }
            field(MSME; Rec.MSME)
            {
                ApplicationArea = All;

            }
            field("Type of Enterprise"; Rec."Type of Enterprise")
            {
                ApplicationArea = All;

            }
            field("PAN Link Status"; Rec."PAN Link Status")
            {
                ApplicationArea = all;
                Editable = false;
            }

        }
        modify("Payments (LCY)")
        {
            Visible = false;
        }
        modify("Balance Due (LCY)")
        {
            Visible = false;
        }
    }

    actions
    {
        addafter("Ven&dor")
        {
            group(IncomingDocument)
            {
                Caption = 'Incoming Document';
                Image = Documents;
                action(IncomingDocCard)
                {
                    ApplicationArea = All;
                    Caption = 'View Incoming Document';
                    Enabled = true;
                    Image = ViewOrder;
                    Visible = true;
                    //The property 'ToolTip' cannot be empty.
                    //ToolTip = '';

                    trigger OnAction()
                    var
                        IncomingDocument: Record 130;
                    begin
                        ShowCardFromEntryNo(Rec."Incoming Document Entry No.");
                    end;
                }
            }
        }
        // Add changes to page actions here
        addafter(DiscountLines)
        {
            action("Vendor Agreement")
            {
                ApplicationArea = All;
                Image = ListPage;
                RunObject = Page 50111;
                RunPageLink = "Vendor No." = FIELD("No.");
            }
        }
        addafter("Aged Accounts Payable")
        {
            action("Balance Confirmation")
            {
                ApplicationArea = all;
                Image = "Report";
                RunObject = Report 50031;

                trigger OnAction()
                begin
                    /*
                    Vendor.RESET;
                    Vendor.SETRANGE("No.","No.");
                    REPORT.RUNMODAL(50031,TRUE,TRUE,Vendor);
                    */

                end;

            }
        }
        addafter("Vendor - Detail Trial Balance")
        {
            // action("Send Email(Vendor Statement)")
            // {
            //     Image = SendAsPDF;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     ApplicationArea = all;
            //     trigger OnAction()
            //     begin
            //         CLEAR(VLEAccountStatement);
            //         VLEAccountStatement.SavePDF(TRUE);
            //         VLEAccountStatement.RUN;
            //     end;
            // }
            // action("Save PDF(Vendor Statement)")
            // {
            //     Image = PreviewChecks;
            //     ApplicationArea = all;
            //     trigger OnAction()
            //     begin
            //         CLEAR(VLEAccountStatement);
            //         VLEAccountStatement.SetReportPreview(TRUE);
            //         VLEAccountStatement.RUN;
            //     end;
            // }
            // action("Vendor Statement New")
            // {
            //     Caption = 'Vendor Statement New';
            //     Image = "Report";
            //     ApplicationArea = all;
            //     trigger OnAction()
            //     var
            //         VendorRec: Record 23;
            //     begin
            //         VendorRec.RESET;
            //         VendorRec.SETRANGE("No.", Rec."No.");
            //         IF VendorRec.FINDFIRST THEN
            //             REPORT.RUNMODAL(50015, TRUE, TRUE, VendorRec);
            //     end;
            // }
            action("Send Email(Balance Confirmation)")
            {
                ApplicationArea = all;
                Image = SendAsPDF;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CLEAR(BalanceConfirmation_Vendor);
                    BalanceConfirmation_Vendor.SendEmailAsPdf(TRUE);
                    BalanceConfirmation_Vendor.RUN;
                end;
            }
            // action("Update PAN Link Status")
            // {
            //     ApplicationArea = all;

            //     trigger OnAction()
            //     var
            //         PanLinkVend: Codeunit UpdatePANNo;
            //         Vendpan: Record Vendor;

            //     begin

            //         Vendpan.Reset();
            //         Vendpan.SetFilter("PAN Link Status", '<>%1', Vendor."PAN Link Status"::Operative);
            //         Vendpan.SetRange("P.A.N. Status", Vendor."P.A.N. Status"::" ");
            //         Vendpan.SetRange(Blocked, Vendor.Blocked::" ");
            //         if Vendpan.FindSet() then
            //             repeat
            //                 Vendpan.Validate("P.A.N. No.");
            //                 Vendpan.Modify();
            //             Until Vendpan.Next() = 0;
            //     end;

            // }

        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        //CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);

    end;

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Vendor Master", '%1', UserSetup."Access Vendor Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the record');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Vendor Master", '%1', UserSetup."Access Vendor Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Vendor Master", '%1', UserSetup."Access Vendor Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not modify the record');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Vendor Master", '%1', UserSetup."Access Vendor Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin
        //TRI A.S 19.09.13 START
        Rec.FILTERGROUP(2);
        UserSetup.GET(USERID);
        IF NOT UserSetup."HO Users" THEN
            Rec.SETFILTER("Responsibility Center", '%1|%2', UserSetup."Responsibility Center", '');
        Rec.FILTERGROUP(0);
        // if BaseCodeunit.CheckVendorApprovalsWorkflowEnabled(Rec) Then
        //     Rec.SetFilter(Status, '%1', Rec.Status::Approved);
        //TRI A.S 19.09.13 STOP


        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Vendor Master", '%1', UserSetup."Access Vendor Master"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Vendor Card');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Vendor Master", '%1', UserSetup."Access Vendor Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10

    end;

    procedure ShowCardFromEntryNo(EntryNo: Integer)
    var
        IncomRec: Record "Incoming Document";
    begin
        IF EntryNo = 0 THEN
            EXIT;
        IncomRec.GET(EntryNo);
        IncomRec.SETRECFILTER;
        PAGE.RUN(PAGE::"Incoming Documents", IncomRec);
    end;





    var
        myInt: Integer;
        UserSetup: Record 91;
        Vendor: Record 23;
        Vendorledger: Record "Vendor Ledger Entry";
        VLEAccountStatement: Report 50015;
        BalanceConfirmation_Vendor: Report 50031;
    //BaseCodeunit: Codeunit BaseModificationCodeunit;

}