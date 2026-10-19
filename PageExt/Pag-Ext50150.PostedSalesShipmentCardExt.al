pageextension 50150 PostedSalesShipmentCardExt extends "Posted Sales Shipment"
{
    layout
    {
        addafter("Order No.")
        {
            field("Transporter Code"; rec."Transporter Code")
            {
                ApplicationArea = all;
            }
            field("Driver Mobile No."; rec."Driver Mobile No.")
            {
                ApplicationArea = all;
            }

        }
        moveafter("Mode of Transport"; "Vehicle No.")
        moveafter("Vehicle No."; "Vehicle Type")
        moveafter("Vehicle Type"; "LR/RR No.")
        moveafter("LR/RR No."; "LR/RR Date")

        /*  addafter("Sell-to Customer Name")
           {
               field("Transporter Code"; Rec."Transporter Code")
               {
                   ApplicationArea = All;
               }
               field("LR/RR No."; rec."LR/RR No.")
               {
                   ApplicationArea = all;
               }
               field("Vehicle No."; Rec."Vehicle No.")
               {
                   ApplicationArea = All;
               }
               field("LR/RR Date"; rec."LR/RR Date")
               {
                   ApplicationArea = all;
               }
           }*/
    }
    actions
    {
        addafter("&Print")
        {
            action("Print")
            {
                ApplicationArea = Location;
                Caption = 'Print For Job Work';
                Ellipsis = true;
                Image = Print;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    TrShipment: Record "Sales Shipment Header";
                begin
                    TrShipment.RESET;
                    TrShipment.SETRANGE(TrShipment."No.", Rec."No.");
                    IF TrShipment.FINDFIRST THEN BEGIN
                        REPORT.RUNMODAL(50099, TRUE, TRUE, TrShipment);
                    END;
                end;
            }
        }
    }
}