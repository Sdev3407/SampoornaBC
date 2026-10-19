tableextension 50075 "BankAccLedgerENtryExt" extends "Bank Account Ledger Entry"
{
    fields
    {
        field(50000; "Shortcut Dimension 3Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                // ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(50001; "Shortcut Dimension 4Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
    }
}