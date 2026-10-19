pageextension 50041 ItemReclassJournalExt extends "Item Reclass. Journal"
{
    layout
    {
        modify("Item No.")
        {
            trigger OnAfterValidate()
            begin
                Rec.VALIDATE("Shortcut Dimension 3 Code", ShortcutDimCode[3]);
                Rec.VALIDATE("New Shortcut Dimension 3 Code", NewShortcutDimCode[3]);
            end;
        }
        modify(ShortcutDimCode3)
        {
            trigger OnAfterValidate()
            begin
                Rec."Shortcut Dimension 3 Code" := ShortcutDimCode[3];
                Rec.ValidateShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
            end;
        }

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
                trigger OnValidate()
                begin
                    Rec."New Shortcut Dimension 3 Code" := NewShortcutDimCode[3];
                    Rec.ValidateShortcutDimCode(3, Rec."New Shortcut Dimension 3 Code");
                end;

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
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Item Reclass", '%1', UserSetup."Access Item Reclass"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You can not post Item Reclass. Journal');
                //PRU_DD 1.10

                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Item Reclass", '%1', UserSetup."Access Item Reclass"::Create);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You can not post Item Reclass. Journal');
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Item Reclass", '%1', UserSetup."Access Item Reclass"::" ");
                IF UserSetup.FINDFIRST THEN
                    ERROR('You can not post Item Reclass. Journal');
                //PRU_DD 1.10

                CheckDimension; //Pru_gk DMV_0.1
            end;
        }
        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            begin
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Item Reclass", '%1', UserSetup."Access Item Reclass"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You can not post Item Reclass. Journal');
                //PRU_DD 1.10

                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Item Reclass", '%1', UserSetup."Access Item Reclass"::Create);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You can not post Item Reclass. Journal');
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Item Reclass", '%1', UserSetup."Access Item Reclass"::" ");
                IF UserSetup.FINDFIRST THEN
                    ERROR('You can not post Item Reclass. Journal');
                //PRU_DD 1.10
            end;

        }
    }
    trigger OnAfterGetCurrRecord()
    begin

        Rec.VALIDATE("Shortcut Dimension 3 Code", ShortcutDimCode[3]); //Pru_gk
        Rec.VALIDATE("New Shortcut Dimension 3 Code", NewShortcutDimCode[3]);//Pru_gk
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Reclass", '%1', UserSetup."Access Item Reclass"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the record');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Reclass", '%1', UserSetup."Access Item Reclass"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Reclass", '%1', UserSetup."Access Item Reclass"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not create new Item Reclass. Journal');
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Reclass", '%1', UserSetup."Access Item Reclass"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not modify the record');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Reclass", '%1', UserSetup."Access Item Reclass"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Reclass", '%1', UserSetup."Access Item Reclass"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not create new Item Reclass. Journal');
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin

        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Reclass", '%1', UserSetup."Access Item Reclass"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Item Reclass Journal');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Reclass", '%1', UserSetup."Access Item Reclass"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

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
                                ERROR('Item Reclass. Journal Line %1 Branch is not match of Dimension Set Entry Branch', Rec."Line No.");

                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOB' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 1 Code" THEN
                                ERROR('Item Reclass. Journal Line %1 LOB Code is not match of Dimension Set Entry LOB Code', Rec."Line No.");
                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOC' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 3 Code" THEN
                                ERROR('Item Reclass. Journal Line %1 LOC Code is not match of Dimension Set Entry LOC Code', Rec."Line No.");
                        END;
                    UNTIL DimensionSetEntry_123.NEXT = 0;
                DimensionSetEntry_123.RESET;
                DimensionSetEntry_123.SETRANGE("Dimension Set ID", Rec."New Dimension Set ID");
                IF DimensionSetEntry_123.FINDSET THEN
                    REPEAT
                        IF DimensionSetEntry_123."Dimension Code" = 'BRANCH' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."New Shortcut Dimension 2 Code" THEN
                                ERROR('Item Reclass. Journal Line %1 New Branch Code is not match of Dimension Set Entry New Branch Code', Rec."Line No.");

                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOB' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."New Shortcut Dimension 1 Code" THEN
                                ERROR('Item Reclass. Journal Line %1 New LOB Code is not match of Dimension Set Entry New LOB Code', Rec."Line No.");
                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOC' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."New Shortcut Dimension 3 Code" THEN
                                ERROR('Item Reclass. Journal Line %1 New LOC Code is not match of Dimension Set Entry New LOC Code', Rec."Line No.");
                        END;
                    UNTIL DimensionSetEntry_123.NEXT = 0;
            UNTIL Rec.NEXT = 0;

    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
}