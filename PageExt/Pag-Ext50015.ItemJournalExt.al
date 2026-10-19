pageextension 50015 ItemJournalExt extends "Item Journal"
{
    layout
    {
        modify("Item No.")
        {
            StyleExpr = DescriptionEmphasize;
        }
        addafter(Amount)
        {
            // field("Data Entry Sheet No."; Rec."Data Entry Sheet No.")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Data Entry Sheet No.';
            //     Visible = true;
            // }
            // field("Additional Unit of Measure"; Rec."Additional Unit of Measure")
            // {
            //     ApplicationArea = All;

            // }
            // field("Additional Unit Quantity"; Rec."Additional Unit Quantity")
            // {
            //     ApplicationArea = All;

            // }
            // field(Rejected; Rec.Rejected)
            // {
            //     ApplicationArea = All;

            // }
            // field(Fertility; Rec.Fertility)
            // {
            //     ApplicationArea = All;

            // }
            // field(Age; Rec.Age)
            // {
            //     ApplicationArea = All;

            // }
            // field("Breed Code"; Rec."Breed Code")
            // {
            //     ApplicationArea = All;

            // }
            // field("Lay Day Comment"; Rec."Lay Day Comment")
            // {
            //     ApplicationArea = All;

            // }
            // field("Chicks Item"; Rec."Chicks Item")
            // {
            //     ApplicationArea = All;

            // }
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = All;

            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;

            }
            // field("Alternate UOM"; Rec."Alternate UOM")
            // {
            //     ApplicationArea = All;

            // }
            // field("Alternate Quantity"; Rec."Alternate Quantity")
            // {
            //     ApplicationArea = All;

            // }
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
            // field("Weak Mortality"; Rec."Weak Mortality")
            // {
            //     ApplicationArea = All;

            // }
            // field("Transit Mortality"; Rec."Transit Mortality")
            // {
            //     ApplicationArea = All;

            // }
            // field("Exclude Quantity of Mortality"; Rec."Exclude Quantity of Mortality")
            // {
            //     ApplicationArea = All;

            // }
            // field("Debit Note Type"; Rec."Debit Note Type")
            // {
            //     ApplicationArea = All;

            // }
            // field("In-transit Mortality"; Rec."In-transit Mortality")
            // {
            //     ApplicationArea = All;

            // }
            // field("Data Entry Type"; Rec."Data Entry Type")
            // {
            //     ApplicationArea = All;

            // }
            // field("Laying Entry Type"; Rec."Laying Entry Type")
            // {
            //     ApplicationArea = All;

            // }
            // field("Hatching Entry Type"; Rec."Hatching Entry Type")
            // {
            //     ApplicationArea = All;

            // }
            // field("Descriptive Entry Type"; Rec."Descriptive Entry Type")
            // {
            //     ApplicationArea = All;

            // }
            field("Apply Entry"; Rec."Apply Entry")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify(PreviewPosting)
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                ItemJournalLineRec.RESET;
                ItemJournalLineRec.SETRANGE("Entry Type", ItemJournalLineRec."Entry Type"::"Negative Adjmt.");
                ItemJournalLineRec.SetRange("Journal Batch Name", rec."Journal Batch Name");
                ItemJournalLineRec.SETRANGE("Document No.", Rec."Document No.");
                ItemJournalLineRec.SETRANGE("Line No.", Rec."Line No.");
                IF ItemJournalLineRec.FINDSET THEN
                    REPEAT
                        ILE.RESET;
                        ILE.SETRANGE("Item No.", Rec."Item No.");
                        ILE.SETRANGE("Posting Date", 0D, Rec."Posting Date");
                        ILE.SETRANGE("Location Code", Rec."Location Code");
                        IF ILE.FINDSET THEN BEGIN
                            ILE.CALCSUMS("Remaining Quantity");
                            RemQty := ILE."Remaining Quantity";
                        END;
                        IF RemQty < Rec.Quantity THEN
                            ERROR('Stock Not Available for Item No %1 of %2 Location', Rec."Item No.", Rec."Location Code");
                    UNTIL ItemJournalLineRec.NEXT = 0;
            end;

        }
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                CompanyInfo.Get;
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to post Item Journal');

                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::Create);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to post Item Journal');

                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to post Item Journal');
                If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna Then Begin
                    ItemJn.RESET;
                    ItemJn.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    ItemJn.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                    IF ItemJn.FINDSET THEN
                        REPEAT
                            DimensionMaster.RESET;
                            DimensionMaster.SETRANGE("Shortcut Dimension 1 Code", ItemJn."Shortcut Dimension 1 Code");
                            DimensionMaster.SETRANGE("Shortcut Dimension 2 Code", ItemJn."Shortcut Dimension 2 Code");
                            DimensionMaster.SETRANGE("Shortcut Dimension 3 Code", ItemJn."Shortcut Dimension 3 Code");
                            IF NOT DimensionMaster.FINDFIRST THEN
                                ERROR(DimnErr, ItemJn."Document No.", ItemJn."Line No.", ItemJn."Shortcut Dimension 1 Code", ItemJn."Shortcut Dimension 2 Code", ItemJn."Shortcut Dimension 3 Code");
                        UNTIL ItemJn.NEXT = 0;
                end;
                ItemJournalLineRec.RESET;
                ItemJournalLineRec.SETRANGE("Entry Type", ItemJournalLineRec."Entry Type"::"Negative Adjmt.");
                ItemJournalLineRec.SetRange("Journal Batch Name", rec."Journal Batch Name");
                ItemJournalLineRec.SETRANGE("Document No.", Rec."Document No.");
                ItemJournalLineRec.SETRANGE("Line No.", Rec."Line No.");
                IF ItemJournalLineRec.FINDSET THEN
                    REPEAT
                        ILE.RESET;
                        ILE.SETRANGE("Item No.", Rec."Item No.");
                        ILE.SETRANGE("Posting Date", 0D, Rec."Posting Date");
                        ILE.SETRANGE("Location Code", Rec."Location Code");
                        IF ILE.FINDSET THEN BEGIN
                            ILE.CALCSUMS("Remaining Quantity");
                            RemQty := ILE."Remaining Quantity";
                        END;
                        IF RemQty < Rec.Quantity THEN
                            ERROR('Stock Not Available for Item No %1 of %2 Location', Rec."Item No.", Rec."Location Code");
                    UNTIL ItemJournalLineRec.NEXT = 0;

                If rec."Journal Batch Name" <> '' then
                    If UserId <> 'JOBQUEUE' Then
                        If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna Then
                            If Rec."Entry Type" = EntryType::"Positive Adjmt." then Begin
                                Item.Get(Rec."Item No.");
                                If Item.Exempted = false then
                                    if "Item"."Inventory Posting Group" <> 'SCRAP' Then
                                        Rec.TestField("Apply Entry");

                            End;

            end;

        }
        modify("Post and &Print")
        {
            Visible = false;
            /*
            trigger OnBeforeAction()
            begin
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::Edit);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to post Item Journal');

                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::Create);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to post Item Journal');

                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You do not have permission to post Item Journal');
                CheckDimension; ////Pru_gk DMV_0.1
            end;
            */
        }
    }
    trigger OnAfterGetRecord()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not  have Permission to Delete Item Journal');

        CodeOnFormat()
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not  have Permission to create Item Journal');
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not  have Permission to Change Item Journal Details');
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    var
        JnlSelected: Boolean;
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Item Journal');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Journal", '%1', UserSetup."Access Item Journal"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETRANGE(UserSetup."HO Users", FALSE);
        IF UserSetup.FINDFIRST THEN
            Dimenstiounedit := FALSE;
    end;

    local procedure CheckDimension()
    var
        DimensionSetEntry_123: Record 480;
    begin
        If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna Then Begin
            IF Rec.FINDFIRST THEN
                REPEAT
                    DimensionSetEntry_123.RESET;
                    DimensionSetEntry_123.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
                    IF DimensionSetEntry_123.FINDSET THEN
                        REPEAT
                            IF DimensionSetEntry_123."Dimension Code" = 'BRANCH' THEN BEGIN
                                IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 2 Code" THEN
                                    ERROR('Item Journal Line %1 Branch is not match of Dimension Set Entry Branch', Rec."Line No.");
                            END;
                            IF DimensionSetEntry_123."Dimension Code" = 'LOB' THEN BEGIN
                                IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 1 Code" THEN
                                    ERROR('Item Journal Line %1 LOB Code is not match of Dimension Set Entry LOB Code', Rec."Line No.");
                            END;
                            IF DimensionSetEntry_123."Dimension Code" = 'LOC' THEN BEGIN
                                IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 3 Code" THEN
                                    ERROR('Item Journal Line %1 LOC Code is not match of Dimension Set Entry LOC Code', Rec."Line No.");
                            END;
                        UNTIL DimensionSetEntry_123.NEXT = 0;
                UNTIL Rec.NEXT = 0;
        End;
    end;

    procedure CodeOnFormat()
    var
        Item: Record Item;

    begin
        // Clear(DescriptionEmphasize);
        // Item.Get(Rec."Item No.");
        // //DescriptionIndent := Rec.Level;
        // if Item."Item Tracking Code" <> '' then
        //     DescriptionEmphasize := 'Unfavorable';

    end;

    var
        DescriptionEmphasize: Text;
        UserSetup: Record 91;
        DimensionMaster: Record "Dimension Master";
        ItemJn: Record 83;
        DimnErr: Label 'Dimension Master Does not exist for Document No %1 and Line No. %2..%3..%4..%5';
        Dimenstiounedit: Boolean;
        CurrentJnlBatchName: Text[50];
        ILE: Record "Item Ledger Entry";
        RemQty: Decimal;
        ItemJournalLineRec: Record "Item Journal Line";
        Item: Record Item;
        CompanyInfo: Record "Company Information";

}



