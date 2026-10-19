pageextension 50160 ConsumptionJouExt extends "Consumption Journal"
{
    layout
    {
        modify("Item No.")
        {
            trigger OnAfterValidate()
            begin
                Rec.VALIDATE("Shortcut Dimension 3 Code", ShortcutDimCode[3]); ///Pru_gk DMV_0.1
            end;
        }
        modify("Prod. Order Comp. Line No.")
        {
            trigger OnAfterValidate()
            begin
                Rec.VALIDATE("Shortcut Dimension 3 Code", ShortcutDimCode[3]); ///Pru_gk DMV_0.1
            end;
        }
        modify("Location Code")
        {
            Visible = true;
        }
        addafter("Document No.")
        {


            field("Flock No."; "Flock No.")
            {
                ApplicationArea = all;
            }
            field("Entry Type"; Rec."Entry Type")
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
        addafter("P&ost")
        {
            Action("Update LOC")
            {
                trigger OnAction()
                var
                    myInt: Integer;
                begin

                    Rec.Reset();
                    rec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    rec.SetRange("Journal Template Name", Rec."Journal Template Name");
                    if rec.FindSet() then
                        repeat
                            rec.Validate(Rec."Shortcut Dimension 3 Code", Rec."Location Code");
                            rec.Modify();

                        until Rec.Next = 0;
                end;
            }
        }
        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            var
                ItemJn: Record "Item Journal Line";
                DimensionMaster: Record "Dimension Master";
                DimnErr: Label 'Dimension Master Does not exist for Document No %1 and Line No. %2.';
            begin
                Companyinfo.get;
                If Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] then begin
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
                        UNTIL ItemJn.NEXT = 0;//<<PRU_RPG DM_0.1
                End;
            end;
        }

        modify("P&ost")
        {
            trigger OnBeforeAction()
            var
                ProductionOrder_T: Record "Production Order";
                Item_T: Record Item;
                DimensionMaster: Record "Dimension Master";
                ItemJournalLineRec: Record "Item Journal Line";
                ILE: Record "Item Ledger Entry";
                RemQty: Decimal;
                ItemJn: Record "Item Journal Line";
                DimnErr: Label 'Dimension Master Does not exist for Document No %1 and Line No. %2.';
            begin
                Rec.VALIDATE("Shortcut Dimension 3 Code", ShortcutDimCode[3]);
                //PruRaj_RQ_0.01
                ItemJournalLineRec.RESET;
                ItemJournalLineRec.SETRANGE("Entry Type", ItemJournalLineRec."Entry Type"::Consumption);
                ItemJournalLineRec.SETRANGE("Document No.", "Document No.");
                IF ItemJournalLineRec.FINDSET THEN
                    REPEAT
                        ILE.RESET;
                        ILE.SETRANGE("Item No.", ItemJournalLineRec."Item No.");
                        ILE.SETRANGE("Posting Date", 0D, ItemJournalLineRec."Posting Date");
                        ILE.SETRANGE("Location Code", ItemJournalLineRec."Location Code");
                        IF ILE.FINDSET THEN BEGIN
                            ILE.CALCSUMS("Remaining Quantity");
                            RemQty := ILE."Remaining Quantity";
                        END;
                        IF RemQty < ItemJournalLineRec.Quantity THEN
                            ERROR('Stock not available of Item No %1 of %2 Location', ItemJournalLineRec."Item No.", ItemJournalLineRec."Location Code");
                    UNTIL ItemJournalLineRec.NEXT = 0;
                //PruRaj_RQ_0.01

                //>>PRU_RPG DM_0.1
                //>>PRU_RPG DM_0.1
                Companyinfo.get;
                // If Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] then begin
                //     ItemJn.RESET;
                //     ItemJn.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                //     ItemJn.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                //     IF ItemJn.FINDSET THEN
                //         REPEAT
                //             DimensionMaster.RESET;
                //             DimensionMaster.SETRANGE("Shortcut Dimension 1 Code", ItemJn."Shortcut Dimension 1 Code");
                //             DimensionMaster.SETRANGE("Shortcut Dimension 2 Code", ItemJn."Shortcut Dimension 2 Code");
                //             DimensionMaster.SETRANGE("Shortcut Dimension 3 Code", ItemJn."Shortcut Dimension 3 Code");
                //             IF NOT DimensionMaster.FINDFIRST THEN
                //                 ERROR(DimnErr, ItemJn."Document No.", ItemJn."Line No.");
                //         UNTIL ItemJn.NEXT = 0;//<<PRU_RPG DM_0.1
                CheckDimension;///Pru_DMV_0.1
                //end;
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
        IF Rec.FINDFIRST THEN
            REPEAT
                DimensionSetEntry_123.RESET;
                DimensionSetEntry_123.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
                IF DimensionSetEntry_123.FINDSET THEN
                    REPEAT
                        Rec.VALIDATE("Shortcut Dimension 3 Code", ShortcutDimCode[3]); ///Pru_gk DMV_0.1
                        IF DimensionSetEntry_123."Dimension Code" = 'BRANCH' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 2 Code" THEN
                                ERROR('Consumption Journal Line %1 Branch is not match of Dimension Set Entry Branch', "Line No.");
                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOB' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 1 Code" THEN
                                ERROR('Consumption Journal line %1 LOB Code is not match of Dimension Set Entry LOB Code', "Line No.");
                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOC' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 3 Code" THEN
                                ERROR('Consumption Journal Line %1 LOC Code is not match of Dimension Set Entry LOC Code', "Line No.");
                        END;
                    UNTIL DimensionSetEntry_123.NEXT = 0;
            UNTIL NEXT = 0;
    END;

    var
        Companyinfo: record "Company Information";
}