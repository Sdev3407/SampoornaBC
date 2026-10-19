pageextension 50159 OutputJouExt extends "Output Journal"
{
    layout
    {
        modify("Item No.")
        {
            trigger OnAfterValidate()
            begin
                Rec.VALIDATE("Shortcut Dimension 3 Code", ShortcutDimCode[3]);//Pru_gk  
            end;
        }
        addafter("Document No.")
        {
            field("Flock No."; "Flock No.")
            {
                ApplicationArea = all;
            }

            field("Data Entry Type"; Rec."Data Entry Type")
            {
                ApplicationArea = all;
            }

        }
    }
    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                ProductionOrder_T: Record "Production Order";
                Item_T: Record Item;
                DimensionMaster: Record "Dimension Master";
                ItemJn: Record "Item Journal Line";
                DimnErr: Label 'Dimension Master Does not exist for Document No %1 and Line No. %2.';
            begin
                Companyinfo.Get;
                if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] Then Begin
                    ItemJn.RESET;
                    ItemJn.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    ItemJn.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                    IF ItemJn.FINDSET THEN
                        REPEAT
                            DimensionMaster.RESET;
                            DimensionMaster.SETRANGE("Shortcut Dimension 1 Code", ItemJn."Shortcut Dimension 1 Code");
                            DimensionMaster.SETRANGE("Shortcut Dimension 2 Code", ItemJn."Shortcut Dimension 2 Code");
                            //DimensionMaster.SETRANGE("Shortcut Dimension 3 Code", ItemJn."Shortcut Dimension 3 Code");
                            IF NOT DimensionMaster.FINDFIRST THEN
                                ERROR(DimnErr, ItemJn."Document No.", ItemJn."Line No.");
                        UNTIL ItemJn.NEXT = 0;
                End;
                ProductionOrder_T.RESET;
                ProductionOrder_T.SETRANGE("No.", Rec."Order No.");
                IF ProductionOrder_T.FINDFIRST THEN BEGIN
                    if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] Then begin
                        Item_T.GET(ProductionOrder_T."Source No.");
                        Item_T.TESTFIELD("Production BOM No.");
                    end;
                END;
                ////Pru_gk
                Companyinfo.Get;
                if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] Then
                    CheckDimension; //Pru_gk DMV_0.1
            end;
        }
        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            var
                ItemJn: Record "Item Journal Line";
                DimnErr: Label 'Dimension Master Does not exist for Document No %1 and Line No. %2.';
                DimensionMaster: Record "Dimension Master";
                Item_T: Record Item;
                ProductionOrder_T: Record "Production Order";
            begin
                //>>PRU_RPG DM_0.1
                Companyinfo.Get;
                if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] Then Begin
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
                                ERROR(DimnErr, ItemJn."Document No.", ItemJn."Line No.");
                        UNTIL ItemJn.NEXT = 0;
                end;
                // ProductionOrder_T.RESET;
                // ProductionOrder_T.SETRANGE("No.", Rec."Order No.");
                // IF ProductionOrder_T.FINDFIRST THEN BEGIN
                //     Item_T.GET(ProductionOrder_T."Source No.");
                //     Item_T.TESTFIELD("Production BOM No.");
                // END;
                ////Pru_gk
            end;
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.VALIDATE("Shortcut Dimension 3 Code", ShortcutDimCode[3]); ///Pru_gk DMV_0.1
    end;

    procedure CheckDimension()
    var
        DimensionSetEntry_123: Record "Dimension Set Entry";
    begin
        CurrPage.UPDATE;
        IF FINDFIRST THEN
            REPEAT
                DimensionSetEntry_123.RESET;
                DimensionSetEntry_123.SETRANGE("Dimension Set ID", "Dimension Set ID");
                IF DimensionSetEntry_123.FINDSET THEN
                    REPEAT
                        IF DimensionSetEntry_123."Dimension Code" = 'BRANCH' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 2 Code" THEN
                                ERROR('Output Journal %1 Branch is not match of Dimension Set Entry Branch', "Line No.");
                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOB' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 1 Code" THEN
                                ERROR('Output Journal %1 LOB Code is not match of Dimension Set Entry LOB Code', "Line No.");
                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOC' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 3 Code" THEN
                                ERROR('Output Journal %1 LOC Code is not match of Dimension Set Entry LOC Code', "Line No.");
                        END;
                    UNTIL DimensionSetEntry_123.NEXT = 0;
            UNTIL DimensionSetEntry_123.NEXT = 0;
    END;

    var
        Companyinfo: Record "Company Information";
}