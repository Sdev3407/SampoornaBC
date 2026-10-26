pageextension 50105 ReleasedProductionOrdersExt extends "Released Production Orders"
{
    layout
    {
        moveafter("No."; Description)
        moveafter(Description; "Source No.")
        moveafter("Source No."; "Routing No.")
        moveafter("Routing No."; Quantity)
        moveafter(Quantity; "Starting Date-Time")
        moveafter("Starting Date-Time"; "Ending Date-Time")
        moveafter("Ending Date-Time"; "Due Date")
        moveafter("Due Date"; "Assigned User ID")
        moveafter("Assigned User ID"; Status)
        moveafter(Status; "Search Description")
        addafter("Search Description")
        {
            field("Hatching Date"; rec."Hatching Date")
            {
                ApplicationArea = all;
            }
            field("Breed Code"; Rec."Breed Code")
            {
                ApplicationArea = All;
                Caption = 'Breed Code';
            }
            field("Hatchery Name"; rec."Hatchery Name")
            {
                ApplicationArea = all;
            }
            field("Hatchery Entry"; rec."Hatchery Entry")
            {
                ApplicationArea = all;
            }
            field("Description 2"; rec."Description 2")
            {
                ApplicationArea = all;
            }

        }

    }

    actions
    {
        // Add changes to page actions here
        addafter("Production Order Statistics")
        {
            action("Work Order SFPL")
            {
                ApplicationArea = all;
                Caption = 'Work Order SFPL';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                RunObject = report 50043;
            }
            action("Print Batch Barcode 1/2")
            {
                ApplicationArea = all;
                Caption = '<Print Batch Barcode 1/4>';
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
            action("Print Batch Barcode 1/4")
            {
                ApplicationArea = all;
                Image = BarCode;
                Promoted = true;
                Visible = false;

                trigger OnAction()
                var
                    BarcodeWebServices: Codeunit 50013;
                    ProductionOrder: Record 5405;
                begin
                    ProductionOrder.RESET;
                    ProductionOrder.SETRANGE(ProductionOrder."No.", Rec."No.");
                    IF ProductionOrder.FINDFIRST THEN BEGIN
                        REPORT.RUNMODAL(50062, TRUE, TRUE, ProductionOrder);
                    END;
                end;
            }

        }
        addafter("Change &Status")
        {
            action(UpdateAgeDetails)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestCu: Codeunit 50021;
                    ProdOrder: Record "Production Order";
                begin
                    ProdOrder.Reset();
                    CurrPage.SetSelectionFilter(ProdOrder);
                    if ProdOrder.FindSet() then
                        repeat
                            clear(TestCu);
                            TestCu.Code(ProdOrder."No.");
                        until ProdOrder.Next() = 0;
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

    trigger OnDeleteRecord(): Boolean
    var
        myInt: Integer;
    begin
        Rec.CalcFields("Batch Barcode");
        if Rec."Batch Barcode".HasValue then
            Error('You can not delete the Production order due to QR Code has been Generated.');
    end;



    var
        myInt: Integer;
        UserSetup: Record 91;
}