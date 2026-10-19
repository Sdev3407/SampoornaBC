
tableextension 50017 SalesLineDiscountExt extends "Sales Line Discount"
{
    fields
    {
        field(50000; "Line Discount Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            AutoFormatExpression = "Currency Code";
            Caption = 'Line Discount Amount';

        }
    }
}