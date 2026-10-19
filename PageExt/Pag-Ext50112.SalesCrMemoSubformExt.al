pageextension 50112 SalesCrMemoSubformExt extends "Sales Cr. Memo Subform"
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

                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    if Rec."Alternate Quantity" <> 0 then
                        If Rec."Alternate Quantity" > 0 then
                            Error('Alternate Qty must be in Negative')
                end;
            }
        }
        modify("No.")
        {
            //   ApplicationArea = Advanced;
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
                SHRec: record "Sales Header";
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
                if SHRec.get(Rec."Document Type", Rec."Document No.") then
                    if SHRec."Shortcut Dimension 3 Code" <> '' then
                        rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
            end;

        }
        moveafter(Description; "GST Jurisdiction Type")
        addafter("GST Jurisdiction Type")
        {
            field("Flock No."; Rec."Flock No.")
            {
                ApplicationArea = All;

            }
        }
        addbefore("Location Code")
        {
            field(MRP; Rec.MRP)
            {
                ApplicationArea = all;
            }
            field("MRP Price"; Rec."MRP Price")
            {
                ApplicationArea = all;
                Visible = true;
            }
        }
        /* addafter("No.")
         {
             field("Chicks Item"; Rec."Chicks Item")
             {
                 ApplicationArea = All;

             }
             field("Alternate UOM"; Rec."Alternate UOM")
             {
                 ApplicationArea = All;

             }
             field("Alternate Quantity"; Rec."Alternate Quantity")
             {
                 ApplicationArea = All;

             }
           
             field("Item Type"; Rec."Item Type")
             {
                 ApplicationArea = All;

             }
             field("Bird Type"; Rec."Bird Type")
             {
                 ApplicationArea = All;

             }
             field("Male Brid Qty."; Rec."Male Brid Qty.")
             {
                 ApplicationArea = All;

             }
             field("Female Bird Qty."; Rec."Female Bird Qty.")
             {
                 ApplicationArea = All;

             }
             field("Freight Reimbursment Discount"; Rec."Freight Reimbursment Discount")
             {
                 ApplicationArea = All;

             }
             field("Total MRP Price"; Rec."Total MRP Price")
             {
                 ApplicationArea = All;

             }
             field("Short Closed"; Rec."Short Closed")
             {
                 ApplicationArea = All;

             }
             field("Amt. to Customer"; Rec."Amt. to Customer")
             {
                 ApplicationArea = All;

             }
             field("Shipment Amount"; Rec."Shipment Amount")
             {
                 ApplicationArea = All;

             }
             field("Location State Code"; Rec."Location State Code")
             {
                 ApplicationArea = All;

             }
             field("Price Discount"; Rec."Price Discount")
             {
                 ApplicationArea = All;

             }
         }*/
    }

    actions
    {
        // Add changes to page actions here
    }


    trigger OnDeleteRecord(): Boolean
    var

    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to Delete Sales Credit Memo');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to Create Sales Credit Memo');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Credit Memo", '%1', UserSetup."Access Sales Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to Change Sales Credit Memo Details');
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
        Bool: Boolean;
        Bool1: Boolean;
}