pageextension 50155 UpdateRefNo extends "Update Reference Invoice No"
{

    actions
    {
        modify(Verify)
        {
            trigger OnAfterAction()
            var
                ItemJ: Page "Item Journal";
                PORec: Record "Purchase Header";
            begin
                PORec.Reset();
                PORec.SetRange("No.", Rec."Document No.");
                if PORec.FindFirst() then begin
                    PORec."Reference Invoice No." := Rec."Reference Invoice Nos.";
                    PORec.Modify();
                end;
            end;
        }
    }
}