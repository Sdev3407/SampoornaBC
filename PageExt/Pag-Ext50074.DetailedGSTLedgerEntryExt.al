pageextension 50074 DetailedGSTLedgerEntryExt extends "Detailed GST Ledger Entry"
{
    layout
    {

        addafter("Quantity")
        {
            field(ItemDis; ItemDis)
            {
                Caption = 'Item Description';
                ApplicationArea = All;

            }
            field(ItemCat; ItemCat)
            {
                Caption = 'Item Category';
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    procedure Itemdetail(ItemNo: Code[20])
    begin
        Clear(ItemCat);
        Clear(ItemDis);
        if ItemRec.Get(ItemNo) then begin
            ItemDis := ItemRec.Description;
            ItemCat := ItemRec."Item Category Code";
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        if Rec.Type = Rec.Type::Item then
            Itemdetail(rec."No.");
    end;

    var
        myInt: Integer;
        ItemCat: Code[20];
        ItemDis: Text[100];
        ItemRec: Record Item;
}