tableextension 50068 PurchPaybleSetupExt extends "Purchases & Payables Setup"
{
    fields
    {
        field(50000; "Indent Batch Name"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = CONST('RECLASS'),
                                                             "Template Type" = CONST(Transfer));
        }

    }
}