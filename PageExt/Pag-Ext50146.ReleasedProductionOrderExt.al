pageextension 50146 ReleasedProductionOrderExt extends "Released Production Order"
{
    layout
    {
        addafter("Gen. Prod. Posting Group")
        {
            field("SFPL User ID"; Rec."SFPL User ID")
            {
                ApplicationArea = All;
            }
        }
        modify(Quantity)
        {
            trigger OnBeforeValidate()
            begin
                IF ((Rec."Shortcut Dimension 1 Code" = 'CBF') AND (Rec."Supervisor Name" = '')) THEN
                    ERROR('Please update the Supervisor Code');
            end;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Last Date Modified")
        {
            Visible = false;
        }
        modify("Source No.")
        {
            trigger OnAfterValidate()
            begin
                //Pru_P0272 >>
                IF Rec."Source Type" = Rec."Source Type"::Item THEN BEGIN
                    recItem.RESET;
                    recItem.SETRANGE("No.", Rec."Source No.");
                    recItem.SETFILTER("Production BOM No.", '<>%1', '');
                    IF recItem.FINDFIRST THEN BEGIN
                        ProdBomEdit := FALSE
                    END ELSE BEGIN
                        ProdBomEdit := TRUE;
                    END;
                END;
                // <<
            end;
        }
        moveafter(Description; "Description 2")
        moveafter("Description 2"; "Source Type")
        moveafter("Source Type"; "Source No.")
        moveafter("Source No."; "Search Description")
        addafter("Search Description")
        {
            field("Supervisor Name"; rec."Supervisor Name")
            {
                ApplicationArea = all;
                Visible = Visible;
            }



        }

        moveafter("Supervisor Name"; Quantity)
        moveafter(Quantity; "Due Date")
        moveafter("Due Date"; Blocked)
        moveafter(Blocked; "Location Code")
        addafter("Location Code")
        {
            field("Hatching Date"; Rec."Hatching Date")
            {
                ApplicationArea = All;
                Visible = Visible;
                Caption = 'Hatching Date';
            }
            field("Breed Code"; rec."Breed Code")
            {
                ApplicationArea = all;
                Visible = Visible;
            }
            field("Hatchery Entry"; rec."Hatchery Entry")
            {
                ApplicationArea = all;
                Visible = Visible;
            }
            field("Hatchery Name"; rec."Hatchery Name")
            {
                ApplicationArea = all;
                Visible = Visible;
            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 3 Code';
            }
            field("Hatchery No."; rec."Hatchery No.")
            {
                ApplicationArea = all;
                Visible = Visible;
                Editable = EditBool;
            }
            field("Flock No.(Breeder)"; rec."Flock No.(Breeder)")
            {
                ApplicationArea = all;
                Visible = Visible;
            }
            field("Laying EGG Week"; rec."Laying EGG Week")
            {
                ApplicationArea = all;
                Visible = Visible;
            }
            field("STD %"; rec."STD %")
            {
                ApplicationArea = all;
                Visible = Visible;
            }
            field("Opening Female Bird"; rec."Opening Female Bird")
            {
                ApplicationArea = all;
                Visible = Visible;
            }
            field("DOC Placing Date"; rec."DOC Placing Date")

            {
                ApplicationArea = all;
                Visible = Visible;
            }
            field("Flock Value"; rec."Flock Value")
            {
                ApplicationArea = all;
                Visible = Visible;
            }
            field("Prod. Bom No."; rec."Prod. Bom No.")
            {
                ApplicationArea = all;
                Editable = ProdBomEdit;
                Visible = VisibleSFPL;
            }
            field("BOM Version No"; Rec."BOM Version No")
            {
                ApplicationArea = All;
                Editable = true;
                Visible = VisibleSFPL;
            }
            field("Batch Size"; Rec."Batch Size")
            {
                ApplicationArea = All;
                Visible = VisibleSFPL;
                Caption = 'Batch Size (In TON)';
            }

        }
        addafter("Due Date")
        {
            field("Lot No."; Rec."Lot No.")
            {
                ApplicationArea = All;
                Caption = 'Batch No.';
                Visible = VisibleStar;
                Editable = false;
            }
        }
        ///
        addafter("Bin Code")
        {
            field("Batch Barcode"; rec."Batch Barcode")
            {
                ApplicationArea = all;
            }
        }
        addafter("Description 2")
        {
            field("RPO Type"; Rec."RPO Type")
            {
                ApplicationArea = All;
                Visible = VisibleStar;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("&Warehouse Entries")
        {
            action("Print Batch Barcode 1/2")
            {
                ApplicationArea = All;
                Caption = 'Print Batch Barcode 1/4';
                Image = BarCode;
                Promoted = true;

                trigger OnAction()
                var
                    BarcodeWebServices: Codeunit 50013;
                    ProductionOrder: Record 5405;
                begin
                    ProductionOrder.RESET;
                    ProductionOrder.SETRANGE(ProductionOrder."No.", Rec."No.");
                    IF ProductionOrder.FINDFIRST THEN BEGIN
                        REPORT.RUNMODAL(50059, TRUE, TRUE, ProductionOrder);
                    END;
                end;
            }

            action("Work Order SFPL")
            {
                ApplicationArea = all;
                Caption = 'Work Order SFPL';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                trigger OnAction()
                var
                    BarcodeWebServices: Codeunit 50013;
                    ProductionOrder: Record 5405;
                begin
                    ProductionOrder.RESET;
                    ProductionOrder.SETRANGE(ProductionOrder."No.", Rec."No.");
                    IF ProductionOrder.FINDFIRST THEN BEGIN
                        REPORT.RUNMODAL(50043, TRUE, TRUE, ProductionOrder);
                    END;
                end;
            }
        }
    }
    var


        UserSetup: Record "User Setup";
        EditBool: Boolean;
        ProdOrderLine: Record "Prod. Order Line";
        ILE: Record "Item Ledger Entry";
        RemQty: Decimal;
        ItemRec: Record Item;
        ProductionBOMLine: Record "Production BOM Line";
        ProdOrderComponent: Record "Prod. Order Component";
        ProdBomEdit: Boolean;
        recItem: Record Item;
        ProdBOMHdr: Record "Production BOM Header";
        Item: Record Item;
        Visible: Boolean;
        VisibleStar: Boolean;
        VisibleSFPL: Boolean;
        ProductionOrder: Record "Production Order";
        CompanyInfo: Record "Company Information";

    trigger OnOpenPage()
    begin

        //<<PRU_RC
        CompanyInfo.Get;
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        IF NOT UserSetup."User Permission" THEN BEGIN
            Rec.SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
            Rec.SETFILTER("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
            IF NOT UserSetup."HO Users" THEN
                Rec.SETFILTER("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
        END;
        Rec.FILTERGROUP(0);

        //>>RPU_RC
        VisibleSFPL := False;
        VisibleStar := false;
        If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] Then
            VisibleSFPL := True
        else
            VisibleStar := true;


        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access R Prod. Order", '%1', UserSetup."Access R Prod. Order"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Released Prod. Order');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access R Prod. Order", '%1', UserSetup."Access R Prod. Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);

        IF (Rec."Shortcut Dimension 1 Code" = 'FEED') AND (Rec."Shortcut Dimension 1 Code" = 'CATTLE') THEN
            EditBool := FALSE
        ELSE
            EditBool := TRUE;


        IF Rec."Source Type" = Rec."Source Type"::Item THEN BEGIN
            recItem.RESET;
            recItem.SETRANGE("No.", Rec."Source No.");
            recItem.SETFILTER("Production BOM No.", '<>%1', '');
            IF recItem.FINDFIRST THEN BEGIN
                ProdBomEdit := FALSE
            END ELSE BEGIN
                ProdBomEdit := TRUE;
            END;
        END;


        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        //UserSetup.SETRANGE("HO Users", FALSE);
        if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then
            UserSetup.SETFILTER("Responsibility Center", '%1', 'FEED')
        else
            UserSetup.SETFILTER("Responsibility Center", '%1', 'PROCESSING');
        IF UserSetup.FINDFIRST THEN
            Visible := FALSE
        ELSE
            Visible := TRUE;

    end;

    trigger OnAfterGetRecord()
    begin
        IF Rec."Source Type" = Rec."Source Type"::Item THEN BEGIN

            recItem.RESET;
            recItem.SETRANGE("No.", Rec."Source No.");
            recItem.SETFILTER("Production BOM No.", '<>%1', '');
            IF recItem.FINDFIRST THEN BEGIN
                //"Prod. Bom No." := recItem."Production BOM No.";
                ProdBomEdit := FALSE
            END ELSE BEGIN
                //"Prod. Bom No." := ''
                ProdBomEdit := TRUE;
            END;
        END;
        // <<
    end;


    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access R Prod. Order", '%1', UserSetup."Access R Prod. Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access R Prod. Order", '%1', UserSetup."Access R Prod. Order"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to create Released Production Order');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access R Prod. Order", '%1', UserSetup."Access R Prod. Order"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access R Prod. Order", '%1', UserSetup."Access R Prod. Order"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Create Released Production Order');
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access R Prod. Order", '%1', UserSetup."Access R Prod. Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change Released Prod. Order Details');
        //PRU_DD 1.10
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access R Prod. Order", '%1', UserSetup."Access R Prod. Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to delete the Released Prod. order');

        Rec.CalcFields("Batch Barcode");
        if Rec."Batch Barcode".HasValue then
            Error('You can not delete the Production order due to QR Code has been Generated.');
        //PRU_DD 1.10
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        ProdOrderLine_123: Record "Prod. Order Line";
        DimensionSetEntry_123: Record "Dimension Set Entry";
    begin
        ///Pru_gk DMV_.01
        ProdOrderLine_123.RESET;
        ProdOrderLine_123.SETRANGE("Prod. Order No.", Rec."No.");
        IF ProdOrderLine_123.FINDFIRST THEN
            REPEAT
                IF ProdOrderLine_123."Shortcut Dimension 1 Code" <> Rec."Shortcut Dimension 1 Code" THEN
                    ERROR('Prod. Order lines %1 LOB Code is not match of Prod. Order header LOB Code', ProdOrderLine_123."Line No.");
                IF ProdOrderLine_123."Shortcut Dimension 2 Code" <> Rec."Shortcut Dimension 2 Code" THEN
                    ERROR('Prod. Order %1 Branch is not match of Prod. Order header Branch', ProdOrderLine_123."Line No.");
                IF ProdOrderLine_123."Dimension Set ID" <> Rec."Dimension Set ID" THEN
                    ERROR('Prod. Order %1 dimension set id is not match of Prod. Order header dimension set id', ProdOrderLine_123."Line No.");
                DimensionSetEntry_123.RESET;
                DimensionSetEntry_123.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
                IF DimensionSetEntry_123.FINDSET THEN
                    REPEAT
                        IF DimensionSetEntry_123."Dimension Code" = 'BRANCH' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 2 Code" THEN
                                ERROR('Prod. Order %1 Branch is not match of Purchase header Branch', ProdOrderLine_123."Line No.");
                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOB' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 1 Code" THEN
                                ERROR('Prod. Order %1 LOB Code is not match of Prod. Order header LOB Code', ProdOrderLine_123."Line No.");
                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOC' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 3 Code" THEN
                                ERROR('Prod. Order %1 LOC Code is not match of Prod. Order Header LOC Code', ProdOrderLine_123."Line No.");
                        END;
                    UNTIL DimensionSetEntry_123.NEXT = 0;
            UNTIL ProdOrderLine_123.NEXT = 0;
        ///Pru_gk DMV_.01

    end;

    LOCAL procedure CalculateFlockValue(RPS_No: Code[20])
    var
        ValueEntry_Rec: Record "Value Entry";
        ProductionOrder_Rec: Record "Production Order";
        TotalFlockValue: Decimal;
    begin
        //>>PRU_RPG MNF_0.1
        ProductionOrder_Rec.RESET;
        ProductionOrder_Rec.SETRANGE(Status, ProductionOrder_Rec.Status::Released);
        IF (RPS_No <> '') THEN
            ProductionOrder_Rec.SETRANGE("No.", RPS_No);
        IF ProductionOrder_Rec.FINDSET THEN BEGIN
            CLEAR(TotalFlockValue);
            REPEAT
                ValueEntry_Rec.RESET;
                ValueEntry_Rec.SETCURRENTKEY("Document No.", "Source No.", "Item Ledger Entry Type");
                ValueEntry_Rec.SETRANGE("Document No.", ProductionOrder_Rec."No.");
                ValueEntry_Rec.SETRANGE("Item Ledger Entry Type", ValueEntry_Rec."Item Ledger Entry Type"::Consumption);
                ValueEntry_Rec.CALCSUMS("Cost Amount (Actual)");
                TotalFlockValue := ABS(ValueEntry_Rec."Cost Amount (Actual)");

                ValueEntry_Rec.RESET;
                ValueEntry_Rec.SETCURRENTKEY("Document No.", "Source No.", "Item Ledger Entry Type");
                ValueEntry_Rec.SETRANGE("Document No.", ProductionOrder_Rec."No.");
                ValueEntry_Rec.SETRANGE("Item Ledger Entry Type", ValueEntry_Rec."Item Ledger Entry Type"::" ");
                ValueEntry_Rec.CALCSUMS("Cost Amount (Actual)");
                TotalFlockValue += ValueEntry_Rec."Cost Amount (Actual)";

                IF (RPS_No <> '') THEN BEGIN
                    Rec."Flock Value" := TotalFlockValue;
                    Rec.MODIFY;
                END ELSE BEGIN
                    ProductionOrder_Rec."Flock Value" := TotalFlockValue;
                    ProductionOrder_Rec.MODIFY;
                END;
            UNTIL ProductionOrder_Rec.NEXT = 0;
        END;
        //<<PRU_RPG MNF_0.1
    END;

}