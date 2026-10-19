enum 50000 "Consume Inventory"
{
    Extensible = true;
    AssignmentCompatibility = true;

    //value(0; "Purchase") { Caption = 'Purchase'; }
    //value(1; "Sale") { Caption = 'Sale'; }
    value(2; "Positive Adjmt.") { Caption = 'Return'; }
    value(3; "Negative Adjmt.") { Caption = 'Issue'; }
}