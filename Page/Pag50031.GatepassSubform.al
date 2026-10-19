page 50031 "Gate pass Subform"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Gate Pass Line";
    ApplicationArea = all;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(control)
            {
                field(Type; Rec.Type)
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field(Description; Rec.Description)
                {
                    ShowMandatory = True;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ShowMandatory = True;
                }
                field(Location; Rec.Location)
                {
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        LOC: Record Location;
                    begin

                    end;
                }
                field("RGP No."; Rec."RGP No.")
                {
                    Visible = false;
                }

                field(Quantity; Rec.Quantity)
                {
                    Editable = true;
                    Caption = 'Quantity';
                    ShowMandatory = True;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        LOC: Record Location;
                    begin
                        if Rec."Document Type" = Rec."Document Type"::RRGP then begin
                            if Rec.Quantity > Rec."RGP Qty." then
                                Error('You cannot insert Qty more than the Pending Qty %1.', Rec."RGP Qty.");
                        end;

                    end;
                }
                field(UnitCost; Rec."Unit Cost")
                {
                    Editable = true;
                    ShowMandatory = True;

                    trigger OnValidate()
                    begin
                    end;
                }
                field(Value; Rec.Value)
                {
                    Editable = false;

                }
                field("RGP Qty."; Rec."RGP Qty.")
                {
                    Visible = false;
                    Enabled = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ShowMandatory = True;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                { }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                { }
            }
        }
    }

    actions
    {
        area(Processing)
        {

        }

    }


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        if Rec."Document Type" = Rec."Document Type"::RRGP then
            Error('You cannot insert the line Manually.');
    end;
}

