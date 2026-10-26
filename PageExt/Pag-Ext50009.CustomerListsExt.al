pageextension 50009 CustomerListsExt extends "Customer List"
{
    layout
    {
        addafter("No.")
        {
            field("Created From Vendor No."; Rec."Created From Vendor No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        modify("No.")
        {
            Style = Unfavorable;
            StyleExpr = ColourCondition;
        }
        modify(Name)
        {
            Style = Unfavorable;
            StyleExpr = ColourCondition;
        }
        modify("Credit Limit (LCY)")
        {
            Visible = DisableOnFeedPlant;
        }
        // modify("Customer Price Group")
        // {
        //     Visible = true;
        // }
        modify("Location Code")
        {
            Visible = DisableOnFeedPlant;
        }
        modify("Post Code")
        {
            Visible = DisableOnFeedPlant;
        }
        modify("Phone No.")
        {
            Visible = DisableOnFeedPlant;
        }
        modify("Salesperson Code")
        {
            Visible = DisableOnFeedPlant;
        }
        modify("Customer Posting Group")
        {
            Visible = DisableOnFeedPlant;
        }
        modify("Customer Disc. Group")
        {
            Visible = DisableOnFeedPlant;
        }
        modify("Payment Terms Code")
        {
            Visible = DisableOnFeedPlant;
        }
        modify("Ship-to Code")
        {
            Visible = DisableOnFeedPlant;
        }

        addbefore("Attached Documents")
        {
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = All;
                Caption = 'IncomingDocAttachFactBox';
                ShowFilter = false;
            }
        }
        modify("Balance (LCY)")
        {
            Visible = DisableOnFeedPlant;
        }


        addafter("Location Code")
        {
            // field("Remaining Credit Limit"; Rec."Remaining Credit Limit")
            // {
            //     ApplicationArea = All;
            //     Style = Unfavorable;
            //     Visible = DisableOnFeedPlant;
            //     StyleExpr = ColourCondition;


            // }

            field("Shipped Not Invoiced"; rec."Shipped Not Invoiced")
            {
                ApplicationArea = all;
                Style = Unfavorable;
                StyleExpr = ColourCondition;
            }

            field(Address; rec.Address)
            {
                ApplicationArea = all;
                Style = Unfavorable;
                StyleExpr = ColourCondition;
                Visible = DisableOnFeedPlant;
            }
            field("CDS Credit Limit"; rec."CDS Credit Limit")
            {
                ApplicationArea = all;
                Style = Unfavorable;
                StyleExpr = ColourCondition;
                Visible = DisableOnFeedPlant;
            }
            field("Address 2"; rec."Address 2")
            {
                ApplicationArea = all;
                Style = Unfavorable;
                StyleExpr = ColourCondition;
                Visible = DisableOnFeedPlant;

            }
            field(City; rec.City)
            {
                ApplicationArea = all;
                Style = Unfavorable;
                StyleExpr = ColourCondition;
                Visible = DisableOnFeedPlant;
            }
            field("Net Change"; rec."Net Change")
            {
                ApplicationArea = all;
                Style = Unfavorable;
                StyleExpr = ColourCondition;
                Visible = DisableOnFeedPlant;
            }
            field("Freight Term"; Rec."Freight Term")
            {
                ApplicationArea = all;
                Style = Unfavorable;
                StyleExpr = ColourCondition;
                Visible = DisableOnFeedPlant;
            }
            field("PAN Link Status"; Rec."PAN Link Status")
            {
                ApplicationArea = all;
                Editable = false;
                Visible = DisableOnFeedPlant;
            }
            field("State Code"; rec."State Code")
            {
                ApplicationArea = all;
                Style = Unfavorable;
                StyleExpr = ColourCondition;
                Visible = DisableOnFeedPlant;
            }
            field("P.A.N. No."; rec."P.A.N. No.")
            {
                ApplicationArea = all;
                Style = Unfavorable;
                StyleExpr = ColourCondition;
                Visible = DisableOnFeedPlant;
            }
            field("GST Registration No."; rec."GST Registration No.")
            {
                ApplicationArea = all;
                Style = Unfavorable;
                StyleExpr = ColourCondition;
                Visible = DisableOnFeedPlant;
            }
            field("Customer Location"; Rec."Customer Location")
            {
                ApplicationArea = all;
                Visible = DisableOnFeedPlant;
            }
            field("TCS Sec 206"; rec."TCS Sec 206")
            {
                ApplicationArea = all;
                Style = Unfavorable;
                StyleExpr = ColourCondition;
                Visible = DisableOnFeedPlant;
            }
            field("gst Customer Type"; Rec."gst Customer Type")
            {
                ApplicationArea = All;
                Style = Unfavorable;
                StyleExpr = ColourCondition;
                Visible = DisableOnFeedPlant;

            }
            field("Debit Amount"; rec."Debit Amount")
            {
                ApplicationArea = All;
                Visible = DisableOnFeedPlant;

            }
            field("Credit Amount"; rec."Credit Amount")
            {
                ApplicationArea = all;
                Visible = DisableOnFeedPlant;
            }

        }
        moveafter("State Code"; "Phone No.")
        moveafter("Credit Amount"; Contact)
        addafter(Contact)
        {
            field("Customer Status"; rec."Customer Status")
            {
                ApplicationArea = all;
                Visible = DisableOnFeedPlant;
            }
            field("Customer Type"; rec."Customer Type")
            {
                ApplicationArea = all;
                Visible = DisableOnFeedPlant;
            }
        }
        moveafter("Customer Type"; "Balance (LCY)")
        moveafter("Balance (LCY)"; "Search Name")
        addafter("Search Name")
        {
            field("GST Status"; rec."GST Status")
            {
                ApplicationArea = all;
                Visible = DisableOnFeedPlant;
            }
            field("Team Code"; Rec."Team Code")
            {
                ApplicationArea = All;
                Visible = DisableOnFeedPlant;

            }
            field("Team Type"; Rec."Team Type")
            {
                ApplicationArea = All;
                Visible = DisableOnFeedPlant;

            }

        }
        modify("Balance Due (LCY)")
        {
            Visible = false;

        }
        modify("Sales (LCY)")
        {
            Visible = false;
        }
        modify("Payments (LCY)")
        {
            Visible = false;
        }
    }
    actions
    {
        modify(Sales_InvoiceDiscounts)
        {
            Visible = DisableOnFeedPlant;
        }
        modify(Sales_Prices)
        {
            Visible = DisableOnFeedPlant;
        }
        modify(Sales_LineDiscounts)
        {
            Visible = DisableOnFeedPlant;
        }
        modify(Prices_InvoiceDiscounts)
        {
            Visible = DisableOnFeedPlant;
        }
        modify(PriceLists)
        {
            Visible = DisableOnFeedPlant;
        }
        addafter("&Customer")
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
        addafter(ShipToAddresses)
        {
            action("Change Log")
            {
                ApplicationArea = All;
                Image = Log;
                RunObject = Page 595;
                RunPageLink = "Primary Key Field 1 Value" = FIELD("No.");
            }
        }
        addafter("Cash Receipt Journal")
        {
            group(History1)
            {
                Caption = 'History';
                action("Customer Scheme Detail")
                {
                    ApplicationArea = All;
                    Image = ListPage;
                    RunObject = Page 50113;
                    RunPageLink = "Customer Code" = FIELD("No.");
                    RunPageMode = View;
                }
                action("Bank Guarantee")
                {
                    ApplicationArea = All;
                    Image = ListPage;
                    Visible = DisableOnFeedPlant;
                    RunObject = Page "Guarantee Detail";
                    RunPageLink = "Customer Code" = FIELD("No.");
                    RunPageMode = View;
                }
                action(TemporaryCreditLimit)
                {
                    ApplicationArea = All;
                    Image = ListPage;
                    Visible = DisableOnFeedPlant;
                    RunObject = Page "Temporary Credit Limit";
                    RunPageLink = "Customer No" = FIELD("No.");
                }
            }
        }
        addafter("Customer - Order Summary")
        {
            action("Customer Ageing")
            {
                ApplicationArea = All;
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report 50033;
            }
        }
        addafter("Customer/Item Sales")
        {
            action("Customer/Item Sales New")
            {
                ApplicationArea = All;
                Image = "Report";
                RunObject = Report 50010;
            }
        }
        addafter(Statement)
        {
            action("Customer Statement New")
            {
                Caption = '<Customer Statement>';

                Applicationarea = All;
                trigger OnAction()
                begin
                    Customer.RESET;
                    Customer.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(50025, TRUE, TRUE, Customer);
                end;
            }
            action(Customer_Confirmation)
            {
                Caption = 'Balance Confirmation';
                Image = "Report";
                RunObject = Report 50030;
                Visible = true;

                Applicationarea = All;
                trigger OnAction()
                begin
                    /*
                    Customer.RESET;
                    Customer.SETRANGE("No.","No.");
                    REPORT.RUNMODAL(50030,TRUE,TRUE,Customer);
                    */

                end;
            }
            action("Customer Statement CBF")
            {
                Image = "Report";
                RunObject = Report "Customer Statement_N";

                Applicationarea = All;
                trigger OnAction()
                begin
                    Customer.RESET;
                    Customer.SETRANGE("No.", Rec."No.");
                    REPORT.RUNMODAL(50081, TRUE, TRUE, Customer);
                end;
            }

            action("Customer Statement_N")
            {
                Applicationarea = All;
                Image = "Report";
                RunObject = Report "Customer Statement_N";
            }
            action("Save PDF(Customer Statement_N)")
            {

                Applicationarea = All;
                trigger OnAction()
                var
                    CustomerStatement_N: Report "Customer Statement_N";
                begin
                    CLEAR(CustomerStatement_N);
                    CustomerStatement_N.SetReportPreview(TRUE);
                    CustomerStatement_N.RUN;
                end;
            }
            action("Send Email(Customer Statement_N)")
            {
                Caption = 'Send Email(Customer Statement_N)';
                Image = Email;
                Visible = false;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Applicationarea = All;
                trigger OnAction()
                var
                    CustomerStatement_N: Report "Customer Statement_N";
                begin
                    CLEAR(CustomerStatement_N);
                    CustomerStatement_N.SavePDF(TRUE);
                    CustomerStatement_N.RUN;
                end;
            }
            action("Sales Invoice Report")
            {
                Image = "Report";
                RunObject = Report 50066;
                Applicationarea = All;
            }
            // // action("Update PAN Link Status")
            // // {
            // //     ApplicationArea = all;

            // //     trigger OnAction()
            // //     var
            // //         PanLinkCust: Codeunit UpdatePANNo;
            // //         Custpan: Record Customer;

            // //     begin
            // //         Custpan.Reset();
            // //         Custpan.SetFilter("PAN Link Status", '<>%1', Customer."PAN Link Status"::Operative);
            // //         Custpan.SetRange("P.A.N. Status", Customer."P.A.N. Status"::" ");
            // //         Custpan.SetRange(Blocked, Customer.Blocked::" ");
            // //         //Vendpan.SetRange("No.", 'EMP0002|EMP0003');
            // //         if Custpan.FindSet() then
            // //             repeat
            // //                 Custpan.Validate("P.A.N. No.");
            // //                 Custpan.Modify();
            // //             //PanLinkCust.UpdateCustomer(Custpan."No.", Custpan."P.A.N. No.");

            // //             Until Custpan.Next() = 0;

            // //     end;
            // }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateColour;
        //SetSocialListeningFactboxVisibility;

    end;

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Customer Master", '%1', UserSetup."Access Customer Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the customer');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Customer Master", '%1', UserSetup."Access Customer Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Customer Master", '%1', UserSetup."Access Customer Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not modify the customer');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Customer Master", '%1', UserSetup."Access Customer Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    var
        CRMIntegrationManagement: Codeunit 5330;
        Customer_T: Record 18;
        Customer_T1: Record 18;
        Customer_T2: Record 18;
        Customer_Temp: Record 18 temporary;
        TextChr: Text[5000];
        TotalLenth: Integer;
        CopyLenth: Text;
    begin
        Companyinfo.Get();
        UserSetup.GET(USERID);
        //TRI A.S 19.09.13 START
        if not UserSetup."Sales Team Leader" Then
            Rec.FILTERGROUP(2);

        IF NOT UserSetup."HO Users" THEN BEGIN
            if not UserSetup."Sales Team Leader" Then begin
                Rec.SETFILTER("Responsibility Center", '%1|%2', UserSetup."Responsibility Center", '');

                IF UserSetup."Salesperson User" THEN BEGIN
                    Rec.FILTERGROUP(2);
                    Rec.SETFILTER("Salesperson Code", UserSetup."Sales Person Code");
                END;

            end else begin
                Rec.FilterGroup(2);
                Rec.SetRange("Responsibility Center", UserSetup."Responsibility Center");
                Rec.SetRange("Team Code", UserSetup."Sales Team Code");
                // Rec.FilterGroup(0);
            end;
        END;
        DisableOnFeedPlant := True;
        if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] then
            if UserSetup."User Type" = UserSetup."User Type"::"Feed Plant" then
                DisableOnFeedPlant := False;


        //TRI A.S 19.09.13 STOP


        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Customer Master", '%1', UserSetup."Access Customer Master"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Customer Master');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Customer Master", '%1', UserSetup."Access Customer Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup.Department, '%1', UserSetup.Department::Production);
        IF UserSetup.FINDFIRST THEN
            BalanceView := FALSE
        ELSE
            BalanceView := TRUE;
        //PRU_DD 1.10

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETRANGE(Department, UserSetup.Department::Accounts);
        UserSetup.SETRANGE("HO Users", TRUE);
        IF UserSetup.FINDFIRST THEN
            VisibleStatics := TRUE
        ELSE
            VisibleStatics := FALSE;

        // If BaseCodeunit.CheckCustomerApprovalsWorkflowEnabled(Rec) Then
        //     Rec.SetFilter(Status, '%1', Rec.Status::Approved);
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

    local procedure UpdateColour()
    begin
        IF Rec."Customer Status" = Rec."Customer Status"::"Suit Filed Cases" THEN
            ColourCondition := TRUE
        ELSE
            ColourCondition := FALSE;
    end;


    var
        myInt: Integer;
        UserSetup: Record "User Setup";
        ColourCondition: Boolean;
        Customer: Record 18;
        BalanceView: Boolean;
        VisibleStatics: Boolean;

        DisableOnFeedPlant: Boolean;
        Companyinfo: Record "Company Information";
}