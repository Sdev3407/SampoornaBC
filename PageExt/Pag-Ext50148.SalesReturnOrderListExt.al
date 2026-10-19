pageextension 50148 SalesReturnOrderListExt extends "Sales Return Order List"
{
    layout
    {
        modify(Status)
        {
            Visible = false;
        }
        modify(Amount)
        {
            Visible = false;
        }
        modify("Amount Including VAT")
        {
            Visible = false;
        }
    }
}