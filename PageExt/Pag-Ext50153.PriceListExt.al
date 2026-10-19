pageextension 50153 PriceListExt extends "Price List Lines"
{
    layout
    {
        modify(StartingDate)
        {
            Visible = true;
        }
        modify(EndingDate)
        {
            Visible = false;
        }
        addafter(StartingDate)
        {
            field("Staring Data"; Rec."Staring Data")
            {
                Visible = false;
                ApplicationArea = all;
                Caption = 'Staring Date';
            }
        }
        addafter(EndingDate)
        {
            field("Ending Data"; Rec."Ending Data")
            {
                ApplicationArea = all;
                Caption = 'Ending Date';
            }
        }
        modify(SourceType)
        {
            Visible = true;
        }
        modify(SourceNo)
        {
            Visible = true;
        }


        modify("Work Type Code")
        {
            Visible = false;
        }

        modify("Product No.")
        {
            Visible = false;
        }
        addafter("Product No.")
        {
            field("Product No1"; Rec."Product No1")
            {
                ApplicationArea = all;
                Visible = true;
                trigger OnValidate()
                begin

                end;
            }
            field("Discount Type"; Rec."Discount Type")
            {
                ApplicationArea = All;

            }
            field("Discount Perc/Amount"; Rec."Discount Perc/Amount")
            {
                ApplicationArea = All;

            }

            field("Entry No."; Rec."Entry No.")
            {
                ApplicationArea = All;
                Visible = false;

            }
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = All;

            }
            field("Line Discount Amount"; Rec."Line Discount Amount")
            {
                ApplicationArea = all;
            }

            field(MRP; Rec.MRP)
            {
                ApplicationArea = all;
            }
            field("MRP PRICE"; Rec."MRP PRICE")
            {
                ApplicationArea = all;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin

    end;

    trigger OnOpenPage()
    begin
    END;

    trigger OnAfterGetRecord()
    begin

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Rec."Asset Type" := rec."Asset Type"::" ";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        // Rec."Asset Type" := rec."Asset Type"::" ";
    end;
}