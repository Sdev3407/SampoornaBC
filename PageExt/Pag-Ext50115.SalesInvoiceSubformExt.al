pageextension 50115 SalesInvoiceSubformExt extends "Sales Invoice Subform"
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
                SHRec: Record "Sales Header";
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
        addafter(Quantity)
        {
            field("Total MRP"; Rec."Total MRP")
            {
                Editable = false;
            }
        }
        addafter(Description)
        {
            field("Assessee Code"; rec."Assessee Code")
            {
                ApplicationArea = all;
            }
            field("Flock No."; Rec."Flock No.")
            {
                ApplicationArea = All;

            }
        }
        addafter("Line Amount")
        {
            field("Freight Reimbursment Discount"; Rec."Freight Reimbursment Discount")
            {
                ApplicationArea = All;

            }
            // field("Qty. to Assign"; rec."Qty. to Assign")
            // {
            //     ApplicationArea = AlL;
            // }
        }
        moveafter("Freight Reimbursment Discount"; "Qty. to Assign")
        moveafter("Qty. to Assign"; "Qty. Assigned")
        moveafter("Qty. Assigned"; "Deferral Code")
        moveafter("Deferral Code"; "GST Place Of Supply")
        moveafter("GST Place Of Supply"; "GST Group Code")
        moveafter("GST Group Code"; "GST Group Type")


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

        modify("Co&mments")
        {
            trigger OnAfterAction()
            var
                SHRec: Record "Sales Header";
            begin

                Rec.ShowLineComments;


            end;
        }
    }
    trigger OnAfterGetCurrRecord()
    begin


        IF Rec."No." = '' THEN
            Rec.SelectItemCatCode; //Pru171220#P0272

        IF Rec.Type = Rec.Type::Item THEN
            Bool := FALSE
        ELSE
            Bool := TRUE;
    end;

    trigger OnAfterGetRecord()
    var
        SHRec: Record "Sales Header";
    begin
        IF Rec."No." = '' THEN
            Rec.SelectItemCatCode; //Pru171220#P0272

    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReserveSalesLine: Codeunit 99000832;
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Invoice", '%1', UserSetup."Access Sales Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to delete Sales Invoice');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Invoice", '%1', UserSetup."Access Sales Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to Enter Sales Invoice Details');
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Invoice", '%1', UserSetup."Access Sales Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to Change Sales Invoice Details');
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin
        GeneralLedgerSetup.GET;
        //PRU-VG
        IF GeneralLedgerSetup."Company Setup" = GeneralLedgerSetup."Company Setup"::SampoornaFeeds THEN
            SampVisible := TRUE
        ELSE
            SampVisible := FALSE;
        //PRU-VG
    end;

    var
        myInt: Integer;

        UserSetup: Record 91;
        GeneralLedgerSetup: Record 98;
        SampVisible: Boolean;
        Bool: Boolean;
}