pageextension 50086 ProductionJournalExt extends "Production Journal"
{
    layout
    {
        modify("Item No.")
        {
            StyleExpr = DescriptionEmphasize;
        }
        addafter("Output Quantity")
        {
            field(OutputQty; Rec."Finished OutPut Qty")
            {
                ApplicationArea = All;
                Visible = VisibleST;
            }
            field(FinishedItemNo; FinishedItemNo)
            {
                ApplicationArea = All;
                Caption = 'Finished Item No.';
                Visible = VisibleST;
            }
            field(FinishedItemName; FinishedItemName)
            {
                ApplicationArea = All;
                Caption = 'Finished Item Name';
                Visible = VisibleST;
            }
        }
        addafter("Item No.")
        {


        }
    }

    actions
    {
        addafter(ItemTrackingLines)
        {
            action("Update Item Tracking on Output")
            {
                ApplicationArea = ItemTracking;
                Visible = VisibleST;
                Image = ItemTrackingLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ReleprodLine: Page "Released Prod. Order Lines";
                    ItemJnLine: record "Item Journal Line";
                begin
                    ItemJnLine.Reset();
                    ItemJnLine.SetRange("Journal Template Name", 'PROD. ORDE');
                    ItemJnLine.SetRange("Document No.", Rec."Document No.");
                    ItemJnLine.SetRange("Entry Type", Enum::"Item Ledger Entry Type"::Output);
                    ItemJnLine.SetFilter(Quantity, '<>%1', 0);
                    If ItemJnLine.FindFirst() then
                        repeat
                            ReleprodLine.UpdateItemTrackingOutput(ItemJnLine);
                        until ItemJnLine.Next() = 0;
                    Message('Item Tracking has been Assigned on Output Entry');

                end;

            }
            action("Update Item Tracking on Consumption")
            {
                ApplicationArea = ItemTracking;
                Visible = VisibleST;
                Image = ItemTrackingLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ReleprodLine: Page "Released Prod. Order Lines";
                    ItemJnLine: record "Item Journal Line";
                begin
                    ItemJnLine.Reset();
                    ItemJnLine.SetRange("Journal Template Name", 'PROD. ORDE');
                    ItemJnLine.SetRange("Document No.", Rec."Document No.");
                    ItemJnLine.SetRange("Entry Type", Enum::"Item Ledger Entry Type"::Consumption);
                    ItemJnLine.SetFilter(Quantity, '<>%1', 0);
                    If ItemJnLine.FindFirst() then
                        repeat
                            ReleprodLine.UpdateItemTrackingConsumption(ItemJnLine);
                        until ItemJnLine.Next() = 0;
                    Message('Item Tracking has been Assigned on Consumption Entry');

                end;

            }
        }
        modify(ItemTrackingLines)
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                // Message('Test')
            end;
        }
        modify("Post and &Print")
        {
            Visible = False;
        }
        // Add changes to page actions here
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                ProductionLine: Record "Prod. Order Line";
                TimeChecking: Boolean;

            begin
                CompanyInfo.get;
                Time1 := Time;
                TimeChecking := False;
                If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then begin
                    UserSetup.Reset();
                    UserSetup.SetRange(UserSetup."User ID", UserId);
                    UserSetup.SetRange("Tax Details Permission", True);
                    if not UserSetup.FindFirst() then
                        If Rec."Posting Date" <> Today then Begin

                            if (Format(Time1) <= '11:00:00.000') Then
                                TimeChecking := True;

                            if not TimeChecking Then
                                Error('You can not post the Entry in back date, Current Date and Time in %1', CurrentDateTime);
                        end;
                end;
                //UserSetup.Get(UserId);
                //PruRaj_RQ_0.01
                ItemJournalLineRec.RESET;
                ItemJournalLineRec.SETRANGE("Entry Type", ItemJournalLineRec."Entry Type"::Consumption);
                ItemJournalLineRec.SETRANGE("Document No.", Rec."Document No.");
                ItemJournalLineRec.SetRange(SystemCreatedBy, UserSecurityId());
                ItemJournalLineRec.SETRANGE("Flushing Method", ItemJournalLineRec."Flushing Method"::Manual);
                IF ItemJournalLineRec.FINDSET THEN
                    REPEAT
                        CLEAR(RemQty);
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
                Time1 := Time;


                // end;




                //  DeleteRecTemp;
                CheckDimension; ///Pru_gk DMV_0.1
            end;
        }
    }
    trigger OnAfterGetRecord()
    begin
        CompanyInfo.Get;
        Rec.VALIDATE("Shortcut Dimension 3 Code", ShortcutDimCode[3]); //Pru_gk
        CodeOnFormat();

        Clear(FinishedItemName);
        Clear(FinishedItemNo);
        if rec."Entry Type" in [Rec."Entry Type"::Consumption] Then
            If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::"Star Foods"] Then begin
                ProdOrdeLine.Reset();
                ProdOrdeLine.SetRange(Status, Enum::"Production Order Status"::Released);
                ProdOrdeLine.SetRange("Prod. Order No.", Rec."Document No.");
                ProdOrdeLine.SetRange(ProdOrdeLine."Line No.", rec."Order Line No.");
                if ProdOrdeLine.FindFirst() then begin
                    FinishedItemName := ProdOrdeLine.Description;
                    FinishedItemNo := ProdOrdeLine."Item No.";
                end;
            end;

    end;

    trigger OnOpenPage()
    begin
        CompanyInfo.Get;
        VisibleSF := False;
        VisibleST := False;
        if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then
            VisibleSF := True
        else
            VisibleST := true;


    end;

    local procedure DeleteRecTemp()
    var
        TempItemJrnlLine: Record "Item Journal Line";
    begin
        TempItemJrnlLine.DELETEALL;

        IF Rec.FIND('-') THEN
            REPEAT
                CASE Rec."Entry Type" OF
                    Rec."Entry Type"::Consumption:
                        IF Rec."Quantity (Base)" = 0 THEN BEGIN
                            TempItemJrnlLine := Rec;
                            TempItemJrnlLine.INSERT;

                            Rec.DELETE;
                        END;
                    Rec."Entry Type"::Output:
                        IF Rec.TimeIsEmpty AND
                           (Rec."Output Quantity (Base)" = 0) AND (Rec."Scrap Quantity (Base)" = 0)
                        THEN BEGIN
                            TempItemJrnlLine := Rec;
                            TempItemJrnlLine.INSERT;

                            Rec.DELETE;
                        END;
                END;
            UNTIL Rec.NEXT = 0;
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
                                ERROR('Production Journal %1 Branch is not match of Dimension Set Entry Branch', Rec."Line No.");
                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOB' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 1 Code" THEN
                                ERROR('Production Journal %1 LOB Code is not match of Dimension Set Entry LOB Code', Rec."Line No.");
                        END;
                        IF DimensionSetEntry_123."Dimension Code" = 'LOC' THEN BEGIN
                            IF DimensionSetEntry_123."Dimension Value Code" <> Rec."Shortcut Dimension 3 Code" THEN
                                ERROR('Production Journal %1 LOC Code is not match of Dimension Set Entry LOC Code', Rec."Line No.");
                        END;
                    UNTIL DimensionSetEntry_123.NEXT = 0;
            UNTIL Rec.NEXT = 0;
    end;

    procedure CodeOnFormat()
    var
        Item: Record Item;

    begin
        Clear(DescriptionEmphasize);
        Item.Get(Rec."Item No.");
        //DescriptionIndent := Rec.Level;
        if Item."Item Tracking Code" <> '' then
            DescriptionEmphasize := 'Unfavorable';

    end;



    var


        Time1: Time;
        myInt: Integer;
        UOMMgt: Codeunit 5402;
        ItemJournalLineRec: Record 83;
        ILE: Record 32;
        RemQty: Decimal;
        CompanyInfo: Record "Company Information";
        ProdOrdeLine: Record "Prod. Order Line";
        Component: Record "Prod. Order Component";
        UserSetup: Record "User Setup";
        VisibleSF: Boolean;
        VisibleST: Boolean;
        OutputQty: Decimal;
        FinishedItemNo: text;
        FinishedItemName: text;

}