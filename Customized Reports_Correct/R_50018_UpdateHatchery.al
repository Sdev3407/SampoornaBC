report 50018 "Update Hatchery"
{
    ProcessingOnly = true;
    Caption = 'Update Hatchery Report';
    UsageCategory = Administration;
    ApplicationArea = all;
    dataset
    {
        dataitem(DataItem1170000000; 5405)
        {

            trigger OnAfterGetRecord()
            var
                ProductionOrder: Record 5405;
            begin
                ProductionOrder.RESET;
                ProductionOrder.SETFILTER("Shortcut Dimension 1 Code", '<>%1', 'CBF');
                IF ProductionOrder.FINDFIRST THEN BEGIN
                    REPEAT
                        ProductionOrder."Hatchery No." := '';
                        ProductionOrder."Hatchery Name" := '';
                        ProductionOrder.MODIFY;
                    UNTIL ProductionOrder.NEXT = 0;
                END;
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('')
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
}

