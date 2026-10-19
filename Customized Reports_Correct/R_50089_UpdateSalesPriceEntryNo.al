report 50089 UpdateSalesPriceEntryNo
{
    UsageCategory = Administration;
    Caption = 'Update Sales Price EntryNo Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\UpdateSalesPriceEntryNo.rdl';
    dataset
    {
        dataitem("Sales Price"; 7002)
        {

            trigger OnAfterGetRecord()
            begin
                i := i + 1;
                "Sales Price"."Entry No." := i;
                MODIFY;
            end;

            trigger OnPreDataItem()
            begin
                CLEAR(i);
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
        i: Integer;
}

