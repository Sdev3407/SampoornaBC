pageextension 50138 UnitsofMeasureExt extends "Units of Measure"
{
    layout
    {
        addafter(Description)
        {
            field("E-Invoicing UOM Code"; Rec."E-Invoicing UOM Code")
            {
                ApplicationArea = All;

            }
            field("GST UOM"; Rec."GST UOM")
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