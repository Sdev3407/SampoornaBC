pageextension 50120 SalesOrderSubformExt extends "Sales Order Subform"
{
    layout
    {

        modify(Type)
        {
            trigger OnAfterValidate()
            begin
                Enablecontrol();
            end;
        }
        modify("Unit Price")
        {
            Editable = UnitPriceEditable;
        }
        modify(Description)
        {
            trigger OnBeforeValidate()
            begin
                Enablecontrol()
            end;
        }

        modify(Quantity)
        {
            trigger OnBeforeValidate()
            var
                QTYShip: Decimal;
                SalesLineG1: Record "Sales Line";
            begin
                //GK

                CompanyInfo.Get;
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna Then Begin
                    CLEAR(qty);
                    Clear(QTYShip);
                    SalesLineG.RESET;
                    SalesLineG.SetFilter("Line No.", '<>%1', Rec."Line No.");
                    SalesLineG.SETRANGE("Document No.", "Document No.");
                    SalesLineG.CALCSUMS(Quantity);
                    SalesLineG.CALCSUMS("Quantity Shipped");
                    QTYShip := SalesLineG."Quantity Shipped" + rec."Quantity Shipped";
                    qty := SalesLineG.Quantity;
                    qty := SalesLineG.Quantity + rec.Quantity;

                    CLEAR(Headerqty);
                    UserSetup.GET(USERID);
                    //IF UserSetup."Salesperson User" THEN BEGIN
                    IF (("Shortcut Dimension 1 Code" = 'FEED')) THEN BEGIN
                        ApprovalEntry.RESET;
                        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", "Document No.");
                        ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Approved);
                        IF ApprovalEntry.FindLast() THEN
                            CLEAR(Headerqty);
                        Headerqty := ApprovalEntry."Order Qty";// - QTYShip;
                        IF ApprovalEntry.Status = ApprovalEntry.Status::Approved THEN BEGIN
                            IF qty > Headerqty THEN
                                ERROR('You can not change order quantity more then %1', ApprovalEntry."Order Qty");
                        END;
                    END;
                END;
            end;
        }

        modify("No.")
        {
            //   ApplicationArea = Advanced;
            trigger OnAfterValidate()
            begin
                Enablecontrol();
            end;


        }
        //  moveafter("No."; "Line Discount Amount")
        addbefore("Location Code")
        {
            field(MRP; Rec.MRP)
            {
                ApplicationArea = all;
            }
            field("MRP Price"; Rec."MRP Price")
            {
                ApplicationArea = all;
                Visible = true;
            }

        }
        addafter(Quantity)
        {
            field("Total MRP"; Rec."Total MRP")
            {
                Editable = false;
            }
        }
        addafter(Description)
        {
            field("Price Discount"; Rec."Price Discount")
            {
                ApplicationArea = All;
                Visible = true;

            }
            field("Item Type"; Rec."Item Type")
            {
                ApplicationArea = All;
                Visible = true;

            }
            field("Item Category Code"; Rec."Item Category Code")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
        moveafter("Item Category Code"; "Line Discount %")
        addafter("Line Discount %")
        {
            field("Freight Reimbursment Discount"; Rec."Freight Reimbursment Discount")
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
        moveafter("Freight Reimbursment Discount"; "Location Code")
        addafter(Quantity)
        {
            field("Total MRP Price"; Rec."Total MRP Price")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
        modify("Qty. to Assemble to Order")
        {
            Visible = false;
        }
        modify("Reserved Quantity")
        {
            Visible = false;
        }
        modify("GST Assessable Value (LCY)")
        {
            Visible = false;
        }
        addafter("GST Assessable Value (LCY)")
        {
            field("Bird Type"; Rec."Bird Type")
            {
                ApplicationArea = All;
                Visible = false;

            }
            field("Flock No."; Rec."Flock No.")
            {
                ApplicationArea = All;
                Visible = true;

            }
            field("Male Brid Qty."; Rec."Male Brid Qty.")
            {
                ApplicationArea = All;
                Visible = false;

            }
            field("Female Bird Qty."; Rec."Female Bird Qty.")
            {
                ApplicationArea = All;
                Visible = false;

            }
            field("Location State Code"; Rec."Location State Code")
            {
                ApplicationArea = All;
                Visible = true;

            }

        }
        modify("Line Discount Amount")
        {
            Visible = true;
        }
        modify(FOC)
        {
            //Visible = false;

            trigger OnAfterValidate()

            var
            begin
                if not Rec.FOC then begin
                    Rec.Validate("Line Discount %", 0);
                    rec.Validate("Line Discount Amount");
                end
            end;
        }

        addafter("No.")
        {

            field("Chicks Item"; Rec."Chicks Item")
            {
                ApplicationArea = All;

            }
            field("Alternate UOM"; Rec."Alternate UOM")
            {
                ApplicationArea = All;

            }
            field("Alternate Quantity"; Rec."Alternate Quantity")
            {
                ApplicationArea = All;

            }

            field("Non-GST Line"; "Non-GST Line")
            {
                ApplicationArea = All;
            }

            field("Short Closed"; Rec."Short Closed")
            {
                ApplicationArea = All;

            }
            field("Amt. to Customer"; Rec."Amt. to Customer")
            {
                ApplicationArea = All;

            }
            field("Shipment Amount"; Rec."Shipment Amount")
            {
                ApplicationArea = All;

            }


        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("Item Availability by")
        {
            action("Co&mments1")
            {
                ApplicationArea = all;
                Caption = 'Co&mments';
                Image = ViewComments;

                trigger OnAction()
                begin
                    Rec.ShowLineComments;
                end;
            }
            action("To Get Stock")
            {
                ApplicationArea = All;

                trigger OnAction()

                begin
                    InternalMovment();
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin


        IF Rec."No." = '' THEN
            Rec.SelectItemCatCode; //Pru171220#P0272
        //GK25072021

        IF Rec.Type = Rec.Type::Item THEN
            Bool := FALSE
        ELSE
            Bool := TRUE;

        Enablecontrol();

    end;

    trigger OnAfterGetRecord()
    var
        SHRec: Record "Sales Header";
    begin

        IF Rec."No." = '' THEN
            Rec.SelectItemCatCode; //Pru171220#P0272

        //VALIDATE("Qty. to Invoice",0);//GK17052021
        CLEAR(QuantitynotInvoiced);
        QuantitynotInvoiced := Rec."Quantity Shipped" - Rec."Quantity Invoiced";

        IF Rec."Quantity Shipped" <> 0 THEN
            Rec.VALIDATE("Qty. to Invoice", QuantitynotInvoiced);
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReserveSalesLine: Codeunit 99000832;
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to delete new sales order');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to insert new sales order');
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to modify new sales order');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to insert new sales order');
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Sales Order');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Order", '%1', UserSetup."Access Sales Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10

        GeneralLedgerSetup.GET;
        //PRU-VG
        /*IF GeneralLedgerSetup."Company Setup" = GeneralLedgerSetup."Company Setup"::SampoornaFeeds THEN
          SampVisible := TRUE
        ELSE
          SampVisible := FALSE;
        //PRU-VG
        */

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETRANGE("Salesperson User", TRUE);
        IF UserSetup.FINDFIRST THEN
            Editable := FALSE
        ELSE
            Editable := TRUE;
        /*
        SalesHeader.RESET;
        SalesHeader.SETRANGE("No.","Document No.");
        SalesHeader.SETFILTER("Responsibility Center",'%1','FEED');
        IF SalesHeader.FINDFIRST THEN
          DiscountEdit := TRUE
        ELSE
          DiscountEdit := FALSE
         */

    end;

    local procedure InternalMovment()
    var
        ItemJournalLine: record "Item Journal Line";
        ItemJournalLine1: record "Item Journal Line";
        LineNo: Integer;
        ItemJournalBatch: record "Item Journal Batch";
        PostItemJournalBatch: record "Item Journal Line";
        loc: Record Location;
        loc2: Record Location;
        Salesheader: Record "Sales Header";

    begin
        ItemJournalLine.Reset();
        ItemJournalLine.SetRange(ItemJournalLine."Journal Template Name", 'TRANSFER');
        ItemJournalLine.SetRange(ItemJournalLine."Journal Batch Name", 'DEFAULT');
        If ItemJournalLine.FindLast() then
            LineNo := ItemJournalLine."Line No."
        else
            LineNo := 0;

        ItemJournalLine.Reset();
        ItemJournalLine.Init();
        ItemJournalLine.SetRange(ItemJournalLine."Journal Template Name", 'TRANSFER');
        ItemJournalLine.SetRange(ItemJournalLine."Journal Batch Name", 'DEFAULT');
        ItemJournalLine.Validate(ItemJournalLine."Line No.", LineNo + 10000);
        Clear(LocationCodeInput);
        LocationCodeInput.RunModal;
        LocationCodeInput.GetFillterValue(LocationCodeD, QtyD);
        if LocationCodeD = '' then
            Error('Please input The From Location Code');
        if QtyD > Rec."Quantity (Base)" then
            Error('You can not mre then the Order Qty');
        ItemJournalLine.Validate("Document No.", Rec."Document No.");
        ItemJournalLine."Entry Type" := Enum::"Item Ledger Entry Type"::Transfer;
        ItemJournalLine.Validate("Posting Date", WorkDate());
        ItemJournalLine.Validate("Item No.", rec."No.");
        ItemJournalLine.Validate("Location Code", LocationCodeD);
        ItemJournalLine.Validate("New Location Code", Rec."Location Code");
        ItemJournalLine.Validate(Quantity, QtyD);
        loc.get(LocationCodeD);
        ItemJournalLine.Validate("Shortcut Dimension 1 Code", loc."Global Dimension 1 Code");
        ItemJournalLine.Validate("Shortcut Dimension 2 Code", loc."Global Dimension 2 Code");
        ItemJournalLine.Validate("Shortcut Dimension 3 Code", loc.Code);
        loc2.get(Rec."Location Code");
        ItemJournalLine.Validate("New Shortcut Dimension 1 Code", loc2."Global Dimension 1 Code");
        ItemJournalLine.Validate("New Shortcut Dimension 2 Code", loc2."Global Dimension 2 Code");
        ItemJournalLine.Validate("New Shortcut Dimension 3 Code", loc2.Code);
        ItemJournalLine.Insert();
        PostItemJn.Run(ItemJournalLine);


    end;

    var
        GeneralLedgerSetup: Record 98;
        SampVisible: Boolean;
        UserSetup: Record 91;
        Editable: Boolean;
        Bool: Boolean;
        QuantitynotInvoiced: Decimal;
        qty: Decimal;
        SalesLineG: Record 37;
        Headerqty: Decimal;
        ApprovalEntry: Record 454;
        DiscountEdit: Boolean;
        myInt: Integer;
        LocationCodeInput: Page 50144;
        LocationCodeD: Code[10];
        QtyD: Decimal;
        PostItemJn: Codeunit "Item Jnl.-Post";
        CompanyInfo: Record "Company Information";
        UnitPriceEditable: Boolean;

    procedure Enablecontrol()
    var
        SalesHeader: Record "Sales Header";
    begin
        CompanyInfo.Get;
        SalesHeader.Get(Enum::"Sales Document Type"::Order, Rec."Document No.");
        UnitPriceEditable := True;
        if CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::"Star Foods" then
            If Rec.Type in [Enum::"Sales Line Type"::Item] then
                if SalesHeader."Shortcut Dimension 1 Code" = 'PROCESSING' then
                    UnitPriceEditable := false;



    end;
}