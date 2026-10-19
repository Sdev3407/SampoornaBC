codeunit 50029 "Gen. Jnl.-PostExt"
{

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnCalculateSumsOnAfterCalcSums', '', true, true)]
    local procedure "Item Tracking Lines_OnCalculateSumsOnAfterCalcSums"
       (
           var TrackingSpecification: Record "Tracking Specification";
           var SourceTrackingSpecification: Record "Tracking Specification"

       )
    begin
        if (SourceTrackingSpecification."Source ID" = 'H-DES/1490') AND (SourceTrackingSpecification."Source Batch Name" = 'DEFAULT') then begin
            TrackingSpecification."Quantity (Base)" := SourceTrackingSpecification."Quantity (Base)";
            TrackingSpecification."Qty. to Handle" := SourceTrackingSpecification."Qty. to Handle";
            TrackingSpecification."Qty. to Handle (Base)" := SourceTrackingSpecification."Qty. to Handle (Base)";
            TrackingSpecification."Qty. to Invoice" := SourceTrackingSpecification."Qty. to Invoice";
            TrackingSpecification."Qty. to Invoice (Base)" := SourceTrackingSpecification."Qty. to Invoice (Base)";
            TrackingSpecification."Quantity Handled (Base)" := SourceTrackingSpecification."Quantity Handled (Base)";
            TrackingSpecification."Quantity Invoiced (Base)" := SourceTrackingSpecification."Quantity Invoiced (Base)";
        END;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', true, true)]
    local procedure "Gen. Jnl.-Post Line_OnAfterInitGLEntry"
    (
        var GLEntry: Record "G/L Entry";
        GenJournalLine: Record "Gen. Journal Line";
        Amount: Decimal;
        AddCurrAmount: Decimal;
        UseAddCurrAmount: Boolean;
        var CurrencyFactor: Decimal;
        var GLRegister: Record "G/L Register"
    )
    var
        TranRecJ: Record "Transfer Receipt Header";
        TranShipH: Record "Transfer Shipment Header";
    begin
        TranShipH.Reset();
        TranShipH.SetRange("No.", GenJournalLine."Document No.");
        if TranShipH.FindFirst() then
            GLEntry."Shortcut Dimension 3 Code" := TranShipH."Shortcut Dimension 3 Code";//PRU-VG

        TranRecJ.Reset();
        TranRecJ.SetRange("No.", GenJournalLine."Document No.");
        if TranRecJ.FindFirst() then begin
            GLEntry."Shortcut Dimension 3 Code" := TranRecJ."Shortcut Dimension 3 Code";//PRU-VG
                                                                                        //  if GenJournalLine."Account No." = '125900' then
            GLEntry."Dimension Set ID" := TranRecJ."Dimension Set ID";
            //if GenJournalLine."Account No." = '125900' then
            // Error('%1..%2..%3', TranRecJ."Dimension Set ID", GLEntry."Dimension Set ID", GenJournalLine."Dimension Set ID");                                                                                  //  Error('%1', TranRecJ."Shortcut Dimension 3 Code");
        END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnAfterCopyGLEntryFromGenJnlLine', '', true, true)]
    local procedure "G/L Entry_OnAfterCopyGLEntryFromGenJnlLine"
    (
        var GLEntry: Record "G/L Entry";
        var GenJournalLine: Record "Gen. Journal Line"
    )
    var
        T480: Record "Dimension Set Entry";
        TranShipH: Record "Transfer Shipment Header";
        TranRecJ: Record "Transfer Receipt Header";
        gen: Codeunit 12;
    begin
        GLEntry."Line Narration1" := GenJournalLine."Line Narration1"; // PRU_AS0.005 - 04 JULY 2019
                                                                       //     Message('%1..%2', GenJournalLine."Dimension Set ID", GenJournalLine."Document No.");
        T480.RESET;//PRU-VG
        T480.SETRANGE("Dimension Set ID", GenJournalLine."Dimension Set ID");//PRU-VG
        T480.SETRANGE(T480."Dimension Code", 'LOC');//PRU-VG
        IF T480.FINDFIRST THEN//PRU-VG
            GLEntry."Shortcut Dimension 3 Code" := T480."Dimension Value Code";//PRU-VG
        T480.RESET;//PRU-VG
        T480.SETRANGE("Dimension Set ID", GenJournalLine."Dimension Set ID");//PRU-VG
        T480.SETRANGE(T480."Dimension Code", 'EMPLOYEE');//PRU-VG
        IF T480.FINDFIRST THEN//PRU-VG
            GLEntry."Shortcut Dimension 4 Code" := T480."Dimension Value Code";//PRU-VG

        TranShipH.Reset();
        TranShipH.SetRange("No.", GenJournalLine."Document No.");
        if TranShipH.FindFirst() then
            GLEntry."Shortcut Dimension 3 Code" := TranShipH."Shortcut Dimension 3 Code";//PRU-VG

        TranRecJ.Reset();
        TranRecJ.SetRange("No.", GenJournalLine."Document No.");
        if TranRecJ.FindFirst() then begin
            GLEntry."Shortcut Dimension 3 Code" := TranRecJ."Shortcut Dimension 3 Code";//PRU-VG
                                                                                        //    if GenJournalLine."Account No." = '125900' then
            GLEntry."Dimension Set ID" := TranRecJ."Dimension Set ID";
            //if GenJournalLine."Account No." = '125900' then
            //  Error('%1', TranRecJ."Shortcut Dimension 3 Code");
        END;

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post", 'OnBeforeCode', '', true, true)]
    local procedure "Gen. Jnl.-Post_OnBeforeCode"
    (
        var GenJournalLine: Record "Gen. Journal Line";
        var HideDialog: Boolean
    )
    var
        GLSetupRec: Record 98;
        DimensionMaster: Record 50030;
        SetPostTrue: Boolean;
        DimnErr: Label 'Dimension Master Does not exist for Document No %1 and Line No. %2.';
        GenJournal1: Record 81;
        CompanyInfo: Record "Company Information";
        GLEntry: Record 81;
        DefaultDimension: Record "Default Dimension";
        Dimensetentry: Record "Dimension Set Entry";
        DimensionSetEntry: record "Dimension Set Entry";

    begin
        //>>PRU_RPG DM_0.1
        CompanyInfo.Get;


        if (GenJournalLine."Journal Batch Name" <> '') And (GenJournalLine."Account No." <> '') Then begin
            DefaultDimension.Reset();
            DefaultDimension.SetRange("Table ID", 15);
            DefaultDimension.SetRange("No.", GenJournalLine."Account No.");
            DefaultDimension.SetRange("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
            if DefaultDimension.FindFirst() then
                repeat
                    Dimensetentry.SetRange("Dimension Set ID", GenJournalLine."Dimension Set ID");
                    Dimensetentry.SetRange("Dimension Code", DefaultDimension."Dimension Code");
                    Dimensetentry.SetFilter("Dimension Value Code", '<>%1', '');
                    if not Dimensetentry.FindFirst() then
                        Error('%1 is mandatory for account code %2', DefaultDimension."Dimension Code", DefaultDimension."No.");

                UNTIL DefaultDimension.Next() = 0;

            DefaultDimension.Reset();
            DefaultDimension.SetRange("Table ID", 15);
            DefaultDimension.SetFilter("No.", '%1', '');
            DefaultDimension.SetRange("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
            if DefaultDimension.FindFirst() then
                repeat
                    Dimensetentry.SetRange("Dimension Set ID", GenJournalLine."Dimension Set ID");
                    Dimensetentry.SetRange("Dimension Code", DefaultDimension."Dimension Code");
                    Dimensetentry.SetFilter("Dimension Value Code", '<>%1', '');
                    if not Dimensetentry.FindFirst() then
                        Error('%1 is mandatory for Bal. account code %2', DefaultDimension."Dimension Code", DefaultDimension."No.");
                UNTIL DefaultDimension.Next() = 0;

            DefaultDimension.Reset();
            DefaultDimension.SetRange("Table ID", 81);
            DefaultDimension.SetRange("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
            if DefaultDimension.FindFirst() then
                repeat
                    Dimensetentry.SetRange("Dimension Set ID", GenJournalLine."Dimension Set ID");
                    Dimensetentry.SetRange("Dimension Code", DefaultDimension."Dimension Code");
                    Dimensetentry.SetFilter("Dimension Value Code", '<>%1', '');
                    if not Dimensetentry.FindFirst() then
                        Error('%1 is mandatory for account code %2', DefaultDimension."Dimension Code", DefaultDimension."No.");

                UNTIL DefaultDimension.Next() = 0;

            DefaultDimension.Reset();
            DefaultDimension.SetRange("Table ID", 15);
            DefaultDimension.SetRange("No.", GenJournalLine."Bal. Account No.");
            DefaultDimension.SetRange("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
            if DefaultDimension.FindFirst() then
                repeat
                    Dimensetentry.SetRange("Dimension Set ID", GenJournalLine."Dimension Set ID");
                    Dimensetentry.SetRange("Dimension Code", DefaultDimension."Dimension Code");
                    Dimensetentry.SetFilter("Dimension Value Code", '<>%1', '');
                    if not Dimensetentry.FindFirst() then
                        Error('%1 is mandatory for Bal. account code %2', DefaultDimension."Dimension Code", DefaultDimension."No.");

                UNTIL DefaultDimension.Next() = 0;


        end;

        if SetPostTrue then
            HideDialog := true;
        //<<PRU_RPG DM_0.1
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post", 'OnBeforeShowPostResultMessage', '', true, true)]
    local procedure "Gen. Jnl.-Post_OnBeforeShowPostResultMessage"
    (
        var GenJnlLine: Record "Gen. Journal Line";
        TempJnlBatchName: Code[10];
        var IsHandled: Boolean
    )
    var
        GLRegRec: Record 45;
        DocNo: Code[20];
        DocNo1: Code[20];
        CU50007: Codeunit 50007;
        GLEntry_Loc: Record 17;
        DocNoBlankPay: Code[20];
        DocNoBlankRef: Code[20];
        GLSetupRec: Record 98;
        CompanyInfo: Record "Company Information";
    begin
        // PRU_AS 04 Dec 2019 - START
        CompanyInfo.Get;
        GLSetupRec.GET;
        IF GLSetupRec."Run SMS" = TRUE THEN BEGIN
            GLRegRec.RESET;
            GLRegRec.SETRANGE("No.", GenJnlLine."Line No.");
            IF GLRegRec.FINDSET THEN BEGIN
                GLEntry_Loc.RESET;
                GLEntry_Loc.SETCURRENTKEY("Document No.");
                GLEntry_Loc.SETRANGE("Entry No.", GLRegRec."From Entry No.", GLRegRec."To Entry No.");
                IF GLEntry_Loc.FINDSET THEN
                    REPEAT
                        IF DocNo <> GLEntry_Loc."Document No." THEN
                            If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                                //CU50007.BankCustomerReceiptVoucherDetailsSMS(GLEntry_Loc."Document No.");
                        DocNo := GLEntry_Loc."Document No.";
                    UNTIL GLEntry_Loc.NEXT = 0;
            END;

            GLRegRec.RESET;
            GLRegRec.SETRANGE("No.", GenJnlLine."Line No.");
            IF GLRegRec.FINDSET THEN BEGIN
                GLEntry_Loc.RESET;
                GLEntry_Loc.SETCURRENTKEY("Document No.");
                GLEntry_Loc.SETRANGE("Entry No.", GLRegRec."From Entry No.", GLRegRec."To Entry No.");
                IF GLEntry_Loc.FINDSET THEN
                    REPEAT
                        IF DocNo1 <> GLEntry_Loc."Document No." THEN
                            If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                                CU50007.BankCustomerReFundDetailsSMS(GLEntry_Loc."Document No.");
                        DocNo1 := GLEntry_Loc."Document No.";
                    UNTIL GLEntry_Loc.NEXT = 0;
            END;

            GLRegRec.RESET;
            GLRegRec.SETRANGE("No.", GenJnlLine."Line No.");
            IF GLRegRec.FINDSET THEN BEGIN
                GLEntry_Loc.RESET;
                GLEntry_Loc.SETCURRENTKEY("Document No.");
                GLEntry_Loc.SETRANGE("Entry No.", GLRegRec."From Entry No.", GLRegRec."To Entry No.");
                IF GLEntry_Loc.FINDSET THEN
                    REPEAT
                        IF DocNoBlankPay <> GLEntry_Loc."Document No." THEN
                            // CU50007.BlankDocCustomerReceiptVoucherDetailsSMS(GLEntry_Loc."Document No.");
                            DocNoBlankPay := GLEntry_Loc."Document No.";
                    UNTIL GLEntry_Loc.NEXT = 0;
            END;
        END;
        // PRU_AS 04 Dec 2019 - END
    end;

    procedure SetPostingTrue(SetTrue: Boolean)
    begin
        SetPostTrue := SetTrue;
    end;

    var
        SetPostTrue: Boolean;
}