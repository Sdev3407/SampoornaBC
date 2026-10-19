pageextension 50013 ItemLedgerEntriesExt extends "Item Ledger Entries"
{
    layout
    {
        modify("Source No.")
        {
            Editable = false;
        }

        addafter("Item No.")
        {
            field("Item Name"; Rec."Item Name")
            {
                ApplicationArea = all;
            }
            field("MRP Price"; "MRP Price")
            {
                ApplicationArea = all;
            }
            field("Item Tracking"; rec."Item Tracking")
            {
                ApplicationArea = All;
            }
            field("Bardana Generation Entry"; Rec."Bardana Generation Entry")
            {
                ApplicationArea = All;
                Editable = False;
            }


        }
        modify("Lot No.")
        {
            Visible = true;
        }
        addbefore("Expiration Date")
        {
            field("Manufacturing Date"; Rec."Manufacturing Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Remaining Quantity")
        {

            field("Applies-to Entry"; Rec."Applies-to Entry")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies if the quantity on the journal line must be applied to an already-posted entry. In that case, enter the entry number that the quantity will be applied to.';
            }
            field("Area"; Rec."Area")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Area field.';
                Visible = false;
            }

            field(Correction; Rec.Correction)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Correction field.';
                Visible = false;
            }

            field("Document Date"; Rec."Document Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Document Date field.';
            }


            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the External Document No. field.';
            }

            field("Item Category Code"; Rec."Item Category Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Category Code field.';
                Visible = false;
            }


            field("Last Invoice Date"; Rec."Last Invoice Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Last Invoice Date field.';
                Visible = false;
            }
            field(Reject; Rec.Reject)
            {
                ApplicationArea = All;
            }
            field(Positive; Rec.Positive)
            {
                ApplicationArea = All;
                Editable = false;
            }

            field("Purchase Amount (Actual)"; Rec."Purchase Amount (Actual)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchase Amount (Actual) field.';
            }
            field("Purchase Amount (Expected)"; Rec."Purchase Amount (Expected)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchase Amount (Expected) field.';
            }
            field("SFPL User ID"; Rec."SFPL User ID")
            {
                ApplicationArea = All;
            }
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                Visible = false;
            }
            field(SystemCreatedBy; Rec.SystemCreatedBy)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                Visible = false;
            }
            field(SystemId; Rec.SystemId)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SystemId field.';
                Visible = false;
            }
            field(SystemModifiedAt; Rec.SystemModifiedAt)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                Visible = false;
            }
            field(SystemModifiedBy; Rec.SystemModifiedBy)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                Visible = false;
            }
            field("Transaction Specification"; Rec."Transaction Specification")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transaction Specification field.';
                Visible = false;
            }
            field("Transaction Type"; Rec."Transaction Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transaction Type field.';
                Visible = false;
            }
            field("Transport Method"; Rec."Transport Method")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transport Method field.';
                Visible = false;
            }
            field("Invoice No."; Rec."Invoice No.")
            {
                ApplicationArea = All;
                Visible = false;
            }

        }

        moveafter("Source No."; "Source Type")

        addafter("Document No.")
        {

            field("Item Type"; Rec."Item Type")
            {
                ApplicationArea = All;
            }
            field("Flock No."; Rec."Flock No.")
            {
                ApplicationArea = All;

            }
        }
        moveafter(Description; "Unit of Measure Code")
        addafter("Entry No.")
        {
            field("In-transit Mortality"; Rec."In-transit Mortality")
            {
                ApplicationArea = All;

            }
            field("Location Name"; Rec."Location Name")
            {
                ApplicationArea = All;

            }
            field("Data Entry Type"; Rec."Data Entry Type")
            {
                ApplicationArea = All;

            }

            field("Laying Entry Type"; Rec."Laying Entry Type")
            {
                ApplicationArea = All;

            }
            field("Hatching Entry Type"; Rec."Hatching Entry Type")
            {
                ApplicationArea = All;

            }
            field("Descriptive Entry Type"; Rec."Descriptive Entry Type")
            {
                ApplicationArea = All;

            }
            field("Data Entry Sheet No."; rec."Data Entry Sheet No.")
            {
                ApplicationArea = all;
            }
            field("Alternate UOM"; Rec."Alternate UOM")
            {
                ApplicationArea = All;

            }
            field("Alternate Quantity"; Rec."Alternate Quantity")
            {
                ApplicationArea = All;

            }
            field(Consumption; Consumption)
            {
                ApplicationArea = All;
            }

        }
        moveafter("Alternate Quantity"; "Dimension Set ID")





    }



    var
        myInt: Integer;
}