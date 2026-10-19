report 50094 "Customer Price Group Modify"
{
    UsageCategory = Administration;
    Caption = 'Customer Price Group Modify Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\CustomerPriceGroupModify.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {

            trigger OnAfterGetRecord()
            begin
                Customer."Customer Price Group" := '';
                Customer.MODIFY;
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

