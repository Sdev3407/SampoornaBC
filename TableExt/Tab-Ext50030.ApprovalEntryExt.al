tableextension 50030 ApprovalEntryExt extends "Approval Entry"
{
    fields
    {
        field(50000; "Order Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
    }
}