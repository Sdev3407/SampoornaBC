pageextension 50040 PhysInventoryJournalExt extends "Phys. Inventory Journal"
{
    layout
    {
        addafter(Amount)
        {
            field("Data Entry Sheet No."; Rec."Data Entry Sheet No.")
            {
                ApplicationArea = All;
                Caption = 'Data Entry Sheet No.';
                Visible = true;
            }
            field("Additional Unit of Measure"; Rec."Additional Unit of Measure")
            {
                ApplicationArea = All;

            }
            field("Additional Unit Quantity"; Rec."Additional Unit Quantity")
            {
                ApplicationArea = All;

            }
            field(Rejected; Rec.Rejected)
            {
                ApplicationArea = All;

            }
            field(Fertility; Rec.Fertility)
            {
                ApplicationArea = All;

            }
            field(Age; Rec.Age)
            {
                ApplicationArea = All;

            }
            field("Breed Code"; Rec."Breed Code")
            {
                ApplicationArea = All;

            }
            field("Lay Day Comment"; Rec."Lay Day Comment")
            {
                ApplicationArea = All;

            }
            field("Chicks Item"; Rec."Chicks Item")
            {
                ApplicationArea = All;

            }
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = All;

            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
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
            field("Flock No."; Rec."Flock No.")
            {
                ApplicationArea = All;

            }
            field("Item Type"; Rec."Item Type")
            {
                ApplicationArea = All;

            }
            field("New Shortcut Dimension 3 Code"; Rec."New Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;

            }
            field("Weak Mortality"; Rec."Weak Mortality")
            {
                ApplicationArea = All;

            }
            field("Transit Mortality"; Rec."Transit Mortality")
            {
                ApplicationArea = All;

            }
            field("Exclude Quantity of Mortality"; Rec."Exclude Quantity of Mortality")
            {
                ApplicationArea = All;

            }
            field("Debit Note Type"; Rec."Debit Note Type")
            {
                ApplicationArea = All;

            }
            field("In-transit Mortality"; Rec."In-transit Mortality")
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
        }
    }

    actions
    {
        // Add changes to page actions here
        modify("P&ost")
        {
            trigger OnBeforeAction()
            begin
                CheckDimension;
            end;
        }
    }
    local procedure CheckDimension()
    var
        DimensionSetEntry_123: Record 480;
    begin
        IF Rec.FINDFIRST THEN
            REPEAT
                DimensionSetEntry_123.RESET;
                DimensionSetEntry_123.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
                IF DimensionSetEntry_123.FINDSET THEN
                    REPEAT
                        IF DimensionSetEntry_123."Dimension Code" = 'BRANCH' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 2 Code" THEN
                                ERROR('Phys. Inventory Journal Line %1 Branch is not match of Dimension Set Entry Branch', Rec."Line No.");
                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOB' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 1 Code" THEN
                                ERROR('Phys. Inventory Journal Line %1 LOB Code is not match of Dimension Set Entry LOB Code', Rec."Line No.");
                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOC' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 3 Code" THEN
                                ERROR('Phys. Inventory Journal Line %1 LOC Code is not match of Dimension Set Entry LOC Code', Rec."Line No.");
                        END;
                    UNTIL DimensionSetEntry_123.NEXT = 0;
            UNTIL Rec.NEXT = 0;
    end;

    var
        myInt: Integer;
}