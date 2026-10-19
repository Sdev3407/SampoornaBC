pageextension 50060 PostedTransferShipmentLinesExt extends "Posted Transfer Shipment Lines"
{
    layout
    {
        addafter("Item No.")
        {
            field("Breed Code"; Rec."Breed Code")
            {
                ApplicationArea = All;

            }
            field("RPO Created"; Rec."RPO Created")
            {
                ApplicationArea = All;

            }
            field("Chicks Item"; Rec."Chicks Item")
            {
                ApplicationArea = All;

            }
            field("Alternate Quantity"; Rec."Alternate Quantity")
            {
                ApplicationArea = All;

            }
            field("Alternate UOM"; Rec."Alternate UOM")
            {
                ApplicationArea = All;

            }
            field("Weak Bird Quantity"; Rec."Weak Bird Quantity")
            {
                ApplicationArea = All;

            }
            field("Transit Mortality Quantity"; Rec."Transit Mortality Quantity")
            {
                ApplicationArea = All;

            }
            field("Flock No."; Rec."Flock No.")
            {
                ApplicationArea = All;

            }
            field("Item Type"; Rec."Item Type")
            {
                ApplicationArea = All;

            }
            field("Flock Description"; Rec."Flock Description")
            {
                ApplicationArea = All;

            }
            field("Location State code"; Rec."Location State code")
            {
                ApplicationArea = All;

            }
            field("Total Taxable Value"; Rec."Total Taxable Value")
            {
                ApplicationArea = All;

            }
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;

            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}