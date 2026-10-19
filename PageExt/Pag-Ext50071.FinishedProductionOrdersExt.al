pageextension 50071 FinishedProductionOrdersExt extends "Finished Production Orders"
{
    layout
    {
        moveafter("No."; Description)
        moveafter(Description; "Source No.")
        moveafter("Source No."; "Routing No.")
        moveafter("Routing No."; Quantity)
        moveafter(Quantity; "Starting Date-Time")
        moveafter("Starting Date-Time"; "Ending Date-Time")
        addafter("Ending Date")
        {
            field("Prod. Bom No."; Rec."Prod. Bom No.")
            { ApplicationArea = all; }
            field("BOM Version No"; Rec."BOM Version No")
            { ApplicationArea = all; }
            field("Hatching Date"; rec."Hatching Date")
            {
                ApplicationArea = all;
            }
            field("Hatchery Name"; rec."Hatchery Name")
            {
                ApplicationArea = all;
            }
            field("Breed Code"; rec."Breed Code")
            {
                ApplicationArea = all;
            }
            field("Description 2"; rec."Description 2")
            {
                ApplicationArea = all;
            }

        }
        moveafter("Description 2"; "Due Date")
        moveafter("Due Date"; "Assigned User ID")
        moveafter("Assigned User ID"; Status)
        moveafter(Status; "Search Description")
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
        }
    }

    trigger OnOpenPage()
    begin
        //<<PRU_RC
        UserSetup.GET(USERID);
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        Rec.SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
        IF NOT UserSetup."HO Users" THEN
            Rec.SETFILTER("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
        Rec.FILTERGROUP(0);
        //>>RPU_RC
    end;

    var

        UserSetup: Record 91;
}