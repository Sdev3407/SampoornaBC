tableextension 50002 FADepreciationBookEXT extends "FA Depreciation Book"
{
    fields
    {
        field(50000; "Book Value After Dispasal"; Decimal)
        {

            CalcFormula = - Sum("FA Ledger Entry"."Credit Amount" WHERE("FA No." = FIELD("FA No."),
                                                                        "Depreciation Book Code" = FIELD("Depreciation Book Code"),
                                                                        "FA Posting Category" = FILTER(Disposal)));
            FieldClass = FlowField;
        }
    }
}