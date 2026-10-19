tableextension 50105 ProdOrderComponent extends "Prod. Order Component"
{
    fields
    {
        field(50000; "Item Catagory Code"; Code[20])
        {
            //DataClassification = ToBeClassified;
            FieldClass = Normal;
            TableRelation = "Item Category";
        }

    }
    trigger OnInsert()
    var
        RecItem: Record Item;
    begin
        RecItem.Get(Rec."Item No.");
        "Item Catagory Code" := RecItem."Item Category Code";

    end;
}