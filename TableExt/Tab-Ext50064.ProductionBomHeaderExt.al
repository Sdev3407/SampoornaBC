tableextension 50064 ProductionBomHeaderExt extends "Production BOM Header"
{
    fields
    {
        field(50000; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
            trigger OnValidate()
            var
                ItemRec: Record Item;
            begin
                if ItemRec.Get("Item No.") then
                    "Item Description" := ItemRec.Description
                else
                    "Item Description" := '';
            end;
        }
        field(50001; "Item Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50002; "Location Code 1"; Text[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
    }
}