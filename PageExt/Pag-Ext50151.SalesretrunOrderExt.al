pageextension 50151 SalesretrunOrderExt extends "Sales Return Order Subform"
{
    layout
    {
        modify(Exempted)
        {
            Visible = false;
        }
        
        addafter(Description)
        {

            field("Alternate UOM"; "Alternate UOM")
            {
                ApplicationArea = All;
            }
            field("Alternate Quantity"; "Alternate Quantity")
            {
                ApplicationArea = All;
            }
        }
        modify("No.")
        {
            ApplicationArea = Advanced;
            trigger OnLookup(var Text: Text): Boolean
            var
                PurchRec: Record 36;
                ItemList: Page "Item List";
                Item: Record 27;
                GlAccList: Page "G/L Account List";
                GlAccRec: Record 15;
                fixedrec: Page "Fixed Asset List";
                FixedRec1: Record "Fixed Asset";
                ItemChargeRec: Page "Item Charges";
                ItemChargeRec1: Record "Item Charge";
                UserSetup: Record "User Setup";
            // var venList : Page 27;
            begin
                UserSetup.Get(USERID);
                if Rec.Type = Rec.Type::Item then begin
                    if PurchRec.Get(Rec."Document Type", Rec."Document No.") then;
                    Item.Reset();
                    if UserSetup."Salesperson User" = true then
                        if PurchRec."Location Code" <> '' then
                            Item.SetRange("Item Location", PurchRec."Location Code");
                    //  Item.SetFilter("Category Type", '%1', PurchRec."Category Type");
                    ItemList.SETTABLEVIEW(Item);
                    ItemList.LOOKUPMODE(TRUE);
                    if (ItemList.RunModal() = Action::LookupOK) then begin
                        ItemList.GetRecord(Item);
                        rec.Validate("No.", Item."No.");
                    end;
                end else
                    if ((Rec.Type = Rec.Type::"G/L Account") And (Rec."System-Created Entry" = false)) then begin
                        GlAccRec.Reset();
                        GlAccRec.SetRange("Direct Posting", true);
                        GlAccRec.SetFilter("Account Type", '%1', GlAccRec."Account Type"::Posting);
                        GlAccRec.SetRange("Direct Posting", true);
                        GlAccList.SETTABLEVIEW(GlAccRec);
                        GlAccList.LOOKUPMODE(TRUE);
                        if (GlAccList.RunModal() = Action::LookupOK) then begin
                            GlAccList.GetRecord(GlAccRec);
                            rec.Validate("No.", GlAccRec."No.");
                        end;
                    end else
                        if ((Rec.Type = Rec.Type::"G/L Account") And (Rec."System-Created Entry" = false)) then begin
                            GlAccRec.Reset();
                            GlAccList.SETTABLEVIEW(GlAccRec);
                            GlAccList.LOOKUPMODE(TRUE);
                            if (GlAccList.RunModal() = Action::LookupOK) then begin
                                GlAccList.GetRecord(GlAccRec);
                                rec.Validate("No.", GlAccRec."No.");
                            end;
                        end else
                            if (Rec.Type = Rec.Type::"Fixed Asset") then begin
                                FixedRec1.Reset();
                                //GlAccList.SETTABLEVIEW(GlAccRec);
                                fixedrec.LOOKUPMODE(TRUE);
                                if (fixedrec.RunModal() = Action::LookupOK) then begin
                                    fixedrec.GetRecord(FixedRec1);
                                    rec.Validate("No.", FixedRec1."No.");
                                end;
                            end else
                                if (Rec.Type = Rec.Type::"Charge (Item)") then begin
                                    ItemChargeRec1.Reset();
                                    //GlAccList.SETTABLEVIEW(GlAccRec);
                                    ItemChargeRec.LOOKUPMODE(TRUE);
                                    if (ItemChargeRec.RunModal() = Action::LookupOK) then begin
                                        ItemChargeRec.GetRecord(ItemChargeRec1);
                                        rec.Validate("No.", ItemChargeRec1."No.");
                                    end;
                                end;
            end;

        }
    }
}