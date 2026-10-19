page 50022 "Indent Order SubForm"
{
    // Version No.   UserID    Date        Where                        Description
    // ---------------------------------------------------------------------------------------------------------------
    // PRU-VR1.00              031115      Page Desinger               Stock In Hand
    // PRU-VR1.00              031115                                  Funcation- CalculateInv()
    // PRU-VG 1.1  10122016  Merge Indent Functionality
    // PRU-AM 1.0              211116      Onaftergetrecord            Calculate Remaining Quantity
    // PRU-AM 1.1              221116     OnOpenPage and OnafterGet    Page Fields editable/non editable
    // PRU-VG 2.0              281116     Rejecting indent Line

    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Indent Line";
    // ApplicationArea = All;
    // UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = PageEdit;
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = FieldEditable;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = FieldEditable;

                    trigger OnValidate()
                    begin
                        CalculateInv;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Editable = FieldEditable;

                    trigger OnValidate()
                    begin
                        CLEAR(RemQty);
                        Rec.CALCFIELDS("PO Approve Qty", "PO Received Qty");
                        RemQty := Rec.Quantity - (Rec."PO Approve Qty" + Rec."PO Received Qty");
                    end;
                }
                field("PO Approve Qty"; Rec."PO Approve Qty")
                {
                    ApplicationArea = All;
                    Caption = 'On PO Line Qty.';
                    Editable = false;
                }
                field("PO Received Qty"; Rec."PO Received Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Approval User ID"; Rec."Approval User ID")
                {
                    ApplicationArea = All;
                }
                field(RemQty; RemQty)
                {
                    ApplicationArea = All;
                    Caption = 'Remaining Qty.';
                    Editable = false;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                }
                field("Approx Cost"; Rec."Approx Cost")
                {
                    ApplicationArea = All;
                    Editable = FieldEditable;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                    Editable = FieldEditable;

                    trigger OnValidate()
                    begin
                        CalculateInv;
                    end;
                }
                field("Stock In Hand"; Rec."Stock In Hand")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnDrillDown()
                    begin
                        ILE.RESET;
                        ILE.SETCURRENTKEY("Item No.");
                        ILE.SETRANGE("Item No.", Rec."No.");
                        //ILE.SETFILTER("Rejected Location",'%1',FALSE);//PRU-VG
                        IF Rec.Location <> '' THEN
                            ILE.SETRANGE("Location Code", Rec.Location);
                        PAGE.RUNMODAL(PAGE::"Item Ledger Entries", ILE);
                    end;
                }
                field("Indent Date"; Rec."Indent Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    Editable = FieldEditable;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        CLEAR(RemQty);
        Rec.CALCFIELDS("PO Approve Qty", "PO Received Qty");
        RemQty := Rec.Quantity - (Rec."PO Approve Qty" + Rec."PO Received Qty");
    end;

    trigger OnAfterGetRecord()
    begin
        CalculateInv;
        //PRU-AM 1.1
        IF (Rec."Approval Status" = Rec."Approval Status"::Approved) OR (Rec."Approval Status" = Rec."Approval Status"::Rejected) THEN
            FieldEditable := FALSE
        ELSE
            FieldEditable := TRUE;
        IF Rec.Status = Rec.Status::Close THEN
            CurrPage.EDITABLE(FALSE);
        //PRU-AM 1.1
        //>-PRU-VG 2.0
        CLEAR(RemQty);
        Rec.CALCFIELDS("PO Approve Qty", "PO Received Qty");
        RemQty := Rec.Quantity - (Rec."PO Approve Qty" + Rec."PO Received Qty");
        PageEdit := TRUE;
        //<-PRU-VG 2.0
        IndentLine.RESET;
        IndentLine.SETRANGE("Document No.", Rec."Document No.");
        IndentLine.SETRANGE("Approval Status", Rec."Approval Status"::Approved);
        IF IndentLine.FINDFIRST THEN
            ApprovedCount := IndentLine.COUNT;
        IndentLine.RESET;
        IndentLine.SETRANGE("Document No.", Rec."Document No.");
        IF IndentLine.FINDFIRST THEN
            TotalCount := IndentLine.COUNT;
        IF TotalCount <> 0 THEN BEGIN
            IF ApprovedCount = TotalCount THEN
                PageEdit := FALSE
            ELSE
                PageEdit := TRUE;
        END ELSE
            PageEdit := TRUE;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Indent", '%1', UserSetup."Access Indent"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the record');
        //PRU_DD 1.10
    end;

    trigger OnInit()
    begin
        IndentLine.RESET;
        IndentLine.SETRANGE("Document No.", Rec."Document No.");
        IndentLine.SETRANGE("Approval Status", Rec."Approval Status"::Approved);
        IF IndentLine.FINDFIRST THEN
            ApprovedCount := IndentLine.COUNT;
        IndentLine.RESET;
        IndentLine.SETRANGE("Document No.", Rec."Document No.");
        IF IndentLine.FINDFIRST THEN
            TotalCount := IndentLine.COUNT;
        IF TotalCount <> 0 THEN BEGIN
            IF ApprovedCount = TotalCount THEN
                PageEdit := FALSE
            ELSE
                PageEdit := TRUE;
        END ELSE
            PageEdit := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        FieldEditable := TRUE;


        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Indent", '%1', UserSetup."Access Indent"::Edit);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Indent", '%1', UserSetup."Access Indent"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not modify the record');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Indent", '%1', UserSetup."Access Indent"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Indent", '%1', UserSetup."Access Indent"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not create new record');
        //PRU_DD 1.10

        //FieldEditableClosed := NOT("Approval Status" = "Approval Status"::Closed);
        CLEAR(SafetyStock);
        CLEAR(QtyOnProdOrder);
        CLEAR(QtyonPurchOrder);
        CLEAR("Purchase Period");
        CLEAR("Safety Stock Period");
        CLEAR("Lead Time");
        FieldEditable := TRUE;
    end;

    trigger OnOpenPage()
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Indent", '%1', UserSetup."Access Indent"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Indent');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Indent", '%1', UserSetup."Access Indent"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    var
        IndentLine: Record "Indent Line";
        IndentHeader: Record "Parameter Master";
        CarryOutAction: Codeunit 99000813;
        PurchHeader: Record 38;
        VendorNo: Code[20];
        [InDataSet]
        IndentQtyEditable: Boolean;
        POCount: Integer;
        IndentLine1: Record "Indent Line";
        StockInHand: Decimal;
        SafetyStock: Decimal;
        QtyonPurchOrder: Decimal;
        QtyOnProdOrder: Decimal;
        Item: Record 27;
        Item1: Record 27;
        ILE: Record 32;
        PurchaseLine: Record 39;
        ProdOrderLine: Record 5406;
        IndentOrder: Page 50004;
        "Purchase Period": DateFormula;
        "Safety Stock Period": DateFormula;
        "Lead Time": DateFormula;
        LocationRec: Record 14;
        FieldEditable: Boolean;
        RemQty: Decimal;
        TotalCount: Integer;
        ApprovedCount: Integer;
        PageEdit: Boolean;
        Text50001: Label 'You do not have permission to approve the Indent line.';
        Text50000: Label 'You are not authorized to re-open the indent.';
        Text50002: Label '%1 PO created';
        Text50003: Label 'The split Quantity on multi vendor do not match with the PO approve quantity';
        Text50004: Label 'Multi Vendor Lines exist for Indent No. %1 Line No. %2. Delete the multi Vendor Lines before re-opening the lines';
        Text50005: Label 'You do not have permission to reject the Indent line.';
        UserSetup: Record 91;


    local procedure CalculateInv()
    begin
        //PRU-VR1.00
        IF (Rec."No." <> '') THEN BEGIN
            Item.RESET;
            Item.SETRANGE("No.", Rec."No.");
            IF Rec.Location <> '' THEN
                Item.SETRANGE("Location Filter", Rec.Location);
            Item.FINDFIRST;
            SafetyStock := Item."Safety Stock Quantity";

            IF Item.CALCFIELDS(Item."Qty. on Purch. Order") THEN
                QtyonPurchOrder := Item."Qty. on Purch. Order"
            ELSE
                QtyonPurchOrder := 0;
            IF Item.CALCFIELDS(Item."Qty. on Prod. Order") THEN
                QtyOnProdOrder := Item."Qty. on Prod. Order"
            ELSE
                QtyOnProdOrder := 0;
            "Lead Time" := Item."Lead Time Calculation";
        END
        ELSE BEGIN
            SafetyStock := 0;
            QtyonPurchOrder := 0;
            QtyOnProdOrder := 0;
            CLEAR("Purchase Period");
            CLEAR("Safety Stock Period");
            CLEAR("Lead Time");
        END;
        //PRU-VR1.00
    end;
}

