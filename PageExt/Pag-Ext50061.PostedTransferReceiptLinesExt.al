pageextension 50061 PostedTransferReceiptLinesExt extends "Posted Transfer Receipt Lines"
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
            field("New LOB"; Rec."New LOB")
            {
                ApplicationArea = All;

            }
            field("New Branch"; Rec."New Branch")
            {
                ApplicationArea = All;

            }
            field("New Dimension Set ID"; Rec."New Dimension Set ID")
            {
                ApplicationArea = All;

            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;
                Visible = false;

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
    trigger OnOpenPage()
    begin
        UserSetup.GET(USERID);
        FILTERGROUP(2);
        SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        IF NOT UserSetup."User Permission" THEN BEGIN
            SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
            IF NOT UserSetup."HO Users" THEN
                SETFILTER("Transfer-to Code", UserSetup."Shortcut Dimension 3 Code");
        END;
        FILTERGROUP(0);

        InventoryPeriod.IsValidDate(InventoryOpenedFrom);
        IF InventoryOpenedFrom <> 0D THEN
            IF Rec.GETFILTER("Receipt Date") = '' THEN
                Rec.SETFILTER("Receipt Date", '%1..', CALCDATE('<+1D>', InventoryOpenedFrom))
            ELSE BEGIN
                IF Rec.GETFILTER("Receipt Date") <> STRSUBSTNO('%1..', CALCDATE('<+1D>', InventoryOpenedFrom)) THEN
                    Rec.SETFILTER("Receipt Date",
                      STRSUBSTNO('%2&%1..', CALCDATE('<+1D>', InventoryOpenedFrom), Rec.GETFILTER("Receipt Date"
                      )))
            END;
    end;

    var
        myInt: Integer;
        InventoryPeriod: Record 5814;
        InventoryOpenedFrom: Date;
        UserSetup: Record 91;
}