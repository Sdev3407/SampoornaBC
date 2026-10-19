table 50070 "Item Loc Inventory Temp"
{
    Caption = 'Item Loc Inventory Temp';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item No."; Code[20]) { }
        field(2; "Location Code"; Code[20]) { }
        field(3; Inventory; Decimal) { }
        field(4; "Cost Amount (Actual)"; Decimal) { }
        field(5; "Inventory Posting Group"; Code[20]) { }
        field(6; "Responsibilty Center"; Code[20]) { }
        field(7; "Item Description"; Text[100]) { }
        field(8; "Item UOM"; Text[10]) { }
        field(9; "Location Name"; Text[100]) { }
        field(10; Branch; Code[20]) { }
    }

    keys { key(PK; "Item No.", "Location Code") { Clustered = true; } }
}
