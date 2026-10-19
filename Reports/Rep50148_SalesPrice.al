report 50148 "Sales Price_SFPL"
{
    UsageCategory = Administration;
    Caption = 'Sales Price_SFPL';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\Sales Price_SFPL.rdl';

    dataset
    {
        dataitem("Sales Price"; "Sales Price")
        {
            column(Sales_Code; "Sales Code")
            {

            }
            column(Item_No_; "Item No.")
            {

            }
            column(Discount_Type; "Discount Type")
            {

            }
            column(Discount_Perc_Amount; "Discount Perc/Amount")
            {

            }
            column(Description; Description)
            {

            }
            column(Location_Code; "Location Code")
            {

            }
            column(MRP_PRICE; "MRP PRICE")
            {

            }
            column(Unit_of_Measure_Code; "Unit of Measure Code")
            {

            }
            column(Unit_Price; "Unit Price")
            {

            }
            column(Starting_Date; "Starting Date")
            {

            }
            column(Ending_Date; "Ending Date")
            {

            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin

                IF "Sales Price"."Ending Date" <> 0D then
                    CurrReport.Skip();

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    procedure CHeckCondition(IsOld: Boolean; IsNew: Boolean)
    var

    begin
        PrintNew := IsNew;
        PrintOld := IsOld;
    end;

    var
        myInt: Integer;
        PrintOld: Boolean;
        PrintNew: Boolean;
        SalesPriceRec: Record "Sales Price";
}