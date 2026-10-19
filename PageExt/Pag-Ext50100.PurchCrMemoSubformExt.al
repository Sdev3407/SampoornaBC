pageextension 50100 PurchCrMemoSubformExt extends "Purch. Cr. Memo Subform"
{
    layout
    {


        modify(Exempted)
        {
            Visible = false;
        }
        addafter(Exempted)
        {

            field("TDS Section Code"; Rec."TDS Section Code")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the Section Codes as per the Income Tax Act 1961 for e tds returns';
                trigger OnLookup(var Text: Text): Boolean
                begin
                    OnAfterTDSSectionCodeLookupPurchLine1(Rec, Rec."Buy-from Vendor No.", true);
                    UpdateTaxAmount();
                end;

                trigger OnValidate()
                begin
                    UpdateTaxAmount();
                end;
            }
        }
        modify("Gen. Prod. Posting Group")
        {
            ApplicationArea = all;
            Visible = true;
            Editable = true;
        }

        modify("FA Posting Type")
        {
            Visible = true;
            Editable = true;
        }

        addafter("HSN/SAC Code")
        {

            field("GST Reverse Charge"; "GST Reverse Charge")
            {
                ApplicationArea = all;
                Visible = true;
                Editable = false;
            }

        }
        addafter("FA Posting Type")
        {
            field("Salvage Value"; Rec."Salvage Value")
            {
                ApplicationArea = All;
            }
        }

        /* addafter("No.")
         {
             field("QC Enabled"; Rec."QC Enabled")
             {
                 ApplicationArea = All;

             }
             field("Chicks Item"; Rec."Chicks Item")
             {
                 ApplicationArea = All;

             }
             field("Challan Qty"; Rec."Challan Qty")
             {
                 ApplicationArea = All;

             }
             field("Weight Qty"; Rec."Weight Qty")
             {
                 ApplicationArea = All;

             }
             field("Excess/Short Qty"; Rec."Excess/Short Qty")
             {
                 ApplicationArea = All;

             }
             field("Indent No."; Rec."Indent No.")
             {
                 ApplicationArea = All;

             }
             field("Indent Line No."; Rec."Indent Line No.")
             {
                 ApplicationArea = All;

             }
             field("Bag Item No."; Rec."Bag Item No.")
             {
                 ApplicationArea = All;

             }
             field("Bag Quantity"; Rec."Bag Quantity")
             {
                 ApplicationArea = All;

             }
             field("Parent Bag Line No."; Rec."Parent Bag Line No.")
             {
                 ApplicationArea = All;

             }
             field("Quantity With Bag"; Rec."Quantity With Bag")
             {
                 ApplicationArea = All;

             }
             field("Alternate Quantity"; Rec."Alternate Quantity")
             {
                 ApplicationArea = All;

             }
             field("Alternate UOM"; Rec."Alternate UOM")
             {
                 ApplicationArea = All;

             }
             field("Week Bird Quantity"; Rec."Week Bird Quantity")
             {
                 ApplicationArea = All;

             }
             field("Transit Mortality Quantity"; Rec."Transit Mortality Quantity")
             {
                 ApplicationArea = All;

             }
             field("Flock No."; Rec."Flock No.")
             {
                 ApplicationArea = All;

             }
             field("Item Type"; Rec."Item Type")
             {
                 ApplicationArea = All;

             }
             field("Extra Quantity"; Rec."Extra Quantity")
             {
                 ApplicationArea = All;

             }
             field("Short Closed"; Rec."Short Closed")
             {
                 ApplicationArea = All;

             }
             field("Actual Qty."; Rec."Actual Qty.")
             {
                 ApplicationArea = All;

             }
             field("Location State Code"; Rec."Location State Code")
             {
                 ApplicationArea = All;

             }
             field("Tax Free"; Rec."Tax Free")
             {
                 ApplicationArea = All;

             }
         }*/
    }
    trigger OnDeleteRecord(): Boolean
    var
        ReservePurchLine: Codeunit 99000834;
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Credit Memo", '%1', UserSetup."Access Purchase Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to Delete Purchase Credit Memo');

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Credit Memo", '%1', UserSetup."Access Purchase Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to Enter Purchase Credit Memo Details');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Credit Memo", '%1', UserSetup."Access Purchase Credit Memo"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to Change Purchase Credit Memo Details');
    end;

    local procedure UpdateTaxAmount()
    var
        CalculateTax: Codeunit "Calculate Tax";
    begin
        CurrPage.SaveRecord();
        CalculateTax.CallTaxEngineOnPurchaseLine(Rec, xRec);
    end;

    local procedure OnAfterTDSSectionCodeLookupPurchLine1(var PurchLine: Record "Purchase Line"; VendorNo: Code[20]; SetTDSSection: boolean)
    var
        Section: Record "TDS Section";
        AllowedSections: Record "Allowed Sections";
    begin
        if PurchLine."Document Type" IN [PurchLine."Document Type"::"Return Order", PurchLine."Document Type"::"Credit Memo"] then begin
            AllowedSections.Reset();
            AllowedSections.SetRange("Vendor No", VendorNo);
            if AllowedSections.FindSet() then
                repeat
                    section.setrange(code, AllowedSections."TDS Section");
                    if Section.FindFirst() then
                        Section.Mark(true);
                until AllowedSections.Next() = 0;
            Section.setrange(code);
            section.MarkedOnly(true);
            if page.RunModal(Page::"TDS Sections", Section) = Action::LookupOK then
                checkDefaultandAssignTDSSection(PurchLine, Section.Code, SetTDSSection);
        end;
    end;


    var
        myInt: Integer;
        UserSetup: Record 91;
}