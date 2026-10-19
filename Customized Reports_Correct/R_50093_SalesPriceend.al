report 50093 SalesPriceend
{
    UsageCategory = Administration;
    Caption = 'SalesPrice End Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\SalesPriceend.rdl';
    dataset
    {
        dataitem("Sales Price"; "Sales Price")
        {

            trigger OnPreDataItem()
            begin
                int := 1 / 4 / 2018;
                IF "Sales Price"."Starting Date" = 0D THEN;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        int: Integer;
}

