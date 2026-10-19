pageextension 50092 PurchaseOrderListExt extends "Purchase Order List"
{
    layout
    {

        modify("Buy-from Vendor No.")
        {
            Visible = true;
        }
        modify("Buy-from Vendor Name")
        {
            Visible = true;
        }
        modify("Vendor Authorization No.")
        {
            Visible = true;
        }


        moveafter("No."; "Buy-from Vendor No.")
        moveafter("Buy-from Vendor No."; "Buy-from Vendor Name")
        moveafter("Buy-from Vendor Name"; "Vendor Authorization No.")

        addbefore("Location Code")
        {
            field("PO Type"; Rec."PO Type")
            {
                ApplicationArea = All;
            }
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = all;
            }
            field("P.A.N No."; rec."P.A.N No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Location Code")
        {
            field("Completely Received"; Rec."Completely Received")
            {
                ApplicationArea = all;
            }

        }

    }

    actions
    {
        // Add changes to page actions here
        modify(Print)
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                //Rec.TestField(Status, Rec.Status::Released);
            end;
        }
        addafter(Print)
        {
            action("PO Print")
            {
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunPageOnRec = false;

                Applicationarea = All;
                trigger OnAction()
                begin
                    PurchaseHeader.RESET;
                    PurchaseHeader.SETRANGE("No.", Rec."No.");
                    PurchaseHeader.SetRange(Status, rec.Status::Released);
                    IF PurchaseHeader.FINDFIRST THEN
                        REPORT.RUNMODAL(50002, TRUE, FALSE, PurchaseHeader);
                end;
            }
        }
        modify(Release)
        {
            trigger OnBeforeAction()
            begin
                if rec."PO Type" in [Rec."PO Type"::Goods] Then begin
                    Rec.TESTFIELD("Brokerage Code");//PRU-VG1.0
                    Rec.TESTFIELD("Payment Terms Code");//PRU-VG1.0
                    Rec.TESTFIELD("Rate Basis");//PRU-VG1.0
                    if rec.Status = Rec.Status::Expired then
                        Error('You Can not Release the Document if it is Expired');
                end;
            end;
        }
        modify(Reopen)
        {
            trigger OnAfterAction()
            begin
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::"Receive & Invoice");
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to Reopen the Purchase Order');

                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::Invoice);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to Reopen the Purchase Order');

                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::Receive);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to Reopen the Purchase Order');

                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to Reopen the Purchase Order');

            end;

            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                if rec.Status = Status::Expired then
                    Error('You Can not Re-open the Document if it is Expired')

            end;
        }
        modify(Approvals)
        {
            trigger OnBeforeAction()
            begin
                if rec."PO Type" in [Rec."PO Type"::Goods] Then begin
                    Rec.TESTFIELD("Brokerage Code");//PRU-VG1.0
                    Rec.TESTFIELD("Payment Terms Code");//PRU-VG1.0
                    Rec.TESTFIELD("Rate Basis");//PRU-VG1.0
                end;
            end;
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You can not post the Purchase Order');
                //PRU_DD 1.10

                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You can not post the Purchase Order');
                //PRU_DD 1.10
                if rec."PO Type" in [Rec."PO Type"::Goods] Then begin
                    Rec.TESTFIELD("Brokerage Code");//PRU-VG1.0
                    Rec.TESTFIELD("Payment Terms Code");//PRU-VG1.0
                    Rec.TESTFIELD("Rate Basis");//PRU-VG1.0
                end;
                IF "Creditors Type" = 0 THEN
                    ERROR('Please enter the creditor type');
            end;
        }
        modify(Preview)
        {
            trigger OnBeforeAction()
            begin
                if rec."PO Type" in [Rec."PO Type"::Goods] Then begin
                    Rec.TESTFIELD("Brokerage Code");//PRU-VG1.0
                    Rec.TESTFIELD("Payment Terms Code");//PRU-VG1.0
                    Rec.TESTFIELD("Rate Basis");//PRU-VG1.0
                end;
            end;
        }
        modify(PostAndPrint)
        {
            trigger OnAfterAction()
            begin
                Rec.TESTFIELD("Brokerage Code");//PRU-VG1.0
                Rec.TESTFIELD("Payment Terms Code");//PRU-VG1.0
                Rec.TESTFIELD("Rate Basis");//PRU-VG1.0
                IF "Creditors Type" = 0 THEN
                    ERROR('Please enter the creditor type');
            end;
        }
        modify(PostBatch)
        {
            trigger OnBeforeAction()
            begin
                if rec."PO Type" in [Rec."PO Type"::Goods] Then begin
                    Rec.TESTFIELD("Brokerage Code");//PRU-VG1.0
                    Rec.TESTFIELD("Payment Terms Code");//PRU-VG1.0
                    Rec.TESTFIELD("Rate Basis");//PRU-VG1.0
                end;
                IF "Creditors Type" = 0 THEN
                    ERROR('Please enter the creditor type');
            end;
        }
    }
    trigger OnDeleteRecord(): Boolean
    begin
        //UserSetup.RESET;
        //UserSetup.SETRANGE("User ID", USERID);
        //UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
        //IF UserSetup.FINDFIRST THEN
        If UserId <> 'JOBQUEUE' then
            ERROR('You can not delete the Purchase Order');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not modify the Purchase Order');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    var
        PurchasesPayablesSetup: Record 312;
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to view Purchase Order');
        //PRU_DD 1.10

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10


        ///SetSecurityFilterOnRespCenter;

        /////JobQueueActive := PurchasesPayablesSetup.JobQueueActive;
        //<<PRU_RC

        UserSetup.GET(USERID);
        If UserSetup."Access Purchase Order" <> UserSetup."Access Purchase Order"::Edit then begin
            Rec.FILTERGROUP(2);
            Rec.SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
            IF NOT UserSetup."HO Users" THEN
                Rec.SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
            Rec.SETFILTER("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
            Rec.FILTERGROUP(0);
        end;
        ///MESSAGE('%1',COUNT);
        //>>RPU_RC
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
        PurchaseHeader: Record 38;
}