codeunit 50030 "Gen. Jnl.-Post LineExt"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeRunWithoutCheck', '', true, true)]
    local procedure OnBeforeRunWithoutCheck(
        var GenJournalLine: Record "Gen. Journal Line"; var GenJournalLine2: Record "Gen. Journal Line")
    var
        GenJnPostLine: Codeunit "Gen. Jnl.-Post Line";
    begin

        if GenJournalLine2."Journal Batch Name" <> '' then begin
            GenJnPostLine.CheckGLAccDimError(GenJournalLine2, GenJournalLine2."Account No.");
            GenJnPostLine.CheckGLAccDimError(GenJournalLine2, GenJournalLine2."Bal. Account No.")

        end;



    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', true, true)]
    local procedure "Gen. Jnl.-Post Line_OnAfterInitGLEntry"
    (
        var GLEntry: Record "G/L Entry";
        GenJournalLine: Record "Gen. Journal Line";
        Amount: Decimal;
        AddCurrAmount: Decimal;
        UseAddCurrAmount: Boolean;
        var CurrencyFactor: Decimal

    )
    var
        T18: Record Customer;
        TVendror: Record Vendor;
        T15: Record 15;
        BankAccount_T: Record "Bank Account";

    begin
        GLEntry."Flock Code" := GenJournalLine."Flock Code"; ////Pru_gk FPD_0.1
        GLEntry."FEED Freight Charge" := GenJournalLine."FEED Freight Charge"; ////Pru_gk FPD_0.1

        //GLEntry."Line Narration" := GenJnlLine."Line Narration"; // PRU_AS0.005 - 05 JULY 2019
        GLEntry."Line Narration1" := GenJournalLine."Line Narration1"; // PRU_AS0.005 - 04 JULY 2019
                                                                       /////Pru_gk
        IF T18.GET(GenJournalLine."Bal. Account No.") THEN
            GLEntry."Bal.Account Name" := T18.Name;
        IF TVendror.GET(GenJournalLine."Bal. Account No.") THEN
            GLEntry."Bal.Account Name" := TVendror.Name;
        IF T15.GET(GenJournalLine."Bal. Account No.") THEN
            GLEntry."Bal.Account Name" := T15.Name;
        IF BankAccount_T.GET(GenJournalLine."Bal. Account No.") THEN
            GLEntry."Bal.Account Name" := BankAccount_T.Name;
        ///////Pru_gk
        GLEntry.Comment := GenJournalLine.Comment;//PRu_VG
        //GLEntry."SFPL User ID" := GenJournalLine."User ID";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitVendLedgEntry', '', true, true)]
    local procedure "Gen. Jnl.-Post Line_OnAfterInitVendLedgEntry"
    (
        var VendorLedgerEntry: Record "Vendor Ledger Entry";
        GenJournalLine: Record "Gen. Journal Line"
    )
    begin
        VendorLedgerEntry."Line Narration1" := GenJournalLine."Line Narration1";
        VendorLedgerEntry."Applied PO No." := GenJournalLine."Applied PO No."; // PRU_AS0
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitCustLedgEntry', '', true, true)]
    local procedure "Gen. Jnl.-Post Line_OnAfterInitCustLedgEntry"
    (
        var CustLedgerEntry: Record "Cust. Ledger Entry";
        GenJournalLine: Record "Gen. Journal Line"
    )
    begin
        CustLedgerEntry."Line Narration1" := GenJournalLine."Line Narration1"; // PRU_AS0
    end;



    /*

        [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostDtldCustLedgEntriesOnBeforeUpdateTotalAmounts', '', true, true)]
        local procedure "Gen. Jnl.-Post Line_OnPostDtldCustLedgEntriesOnBeforeUpdateTotalAmounts"
        (
            var GenJnlLine: Record "Gen. Journal Line";
            DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
            var IsHandled: Boolean;
            var DetailedCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"
        )
        var
            C50006: Codeunit 50006;
        begin
            ///PRU-VG-Start
            IF DtldCustLedgEntry."Entry Type" = DtldCustLedgEntry."Entry Type"::"Initial Entry" THEN BEGIN
                IF GenJnlLine.CheckPayment THEN
                    C50006.CheckCustPayment(DtldCustLedgEntry);///PRU-VG
                IF GenJnlLine.CheckRefund THEN
                    C50006.CheckCustPaymentRefund(DtldCustLedgEntry);
                IF GenJnlLine."Reversing Entry" THEN
                    C50006.CheckCustPaymentReversal(DtldCustLedgEntry);//PRU-VG
                IF DtldCustLedgEntry."Document Type" = DtldCustLedgEntry."Document Type"::" " THEN BEGIN
                    IF GenJnlLine.CheckBlankPayment THEN BEGIN
                        C50006.CheckCustPaymentForBlankLine(DtldCustLedgEntry);//PRU-VG
                        C50006.CheckCustPaymentRefundforBlankLine(DtldCustLedgEntry);//PRU-VG
                    END;
                END;
            END;
            ///PRU-VG-Stop
        end;
    */
}