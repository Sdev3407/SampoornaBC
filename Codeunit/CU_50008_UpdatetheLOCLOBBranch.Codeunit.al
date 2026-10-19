codeunit 50008 "Update the LOC LOB Branch"
{

    trigger OnRun()
    begin
        IF (Doc_Type_Glob = Doc_Type_Glob::Shipment) THEN
            UpdatetheLocLobBranchTransferShipment(Doc_No_Glob);
        /*IF (Doc_Type_Glob = Doc_Type_Glob::Receipt) THEN
          UpdatetheLocLobBranchTransferRecpt(Doc_No_Glob);*/

    end;

    var
        Doc_No_Glob: Code[20];
        Doc_Type_Glob: Option " ",Shipment,Receipt;


    procedure UpdatetheLocLobBranch(var LocCode: Code[20]; var LoBCode: Code[20]; var BranchCode: Code[20]): Integer
    var
        ItemJournalLine: Record 83;
    begin
        ItemJournalLine.INIT;
        ItemJournalLine."Journal Batch Name" := 'BFM';
        ItemJournalLine."Journal Template Name" := 'ITEM';
        ItemJournalLine.VALIDATE("Line No.", 10000);
        ItemJournalLine.VALIDATE("Entry Type", ItemJournalLine."Entry Type"::"Positive Adjmt.");
        ItemJournalLine.VALIDATE("Posting Date", TODAY);
        ItemJournalLine.VALIDATE("Item No.", 'BRCBF001');
        ItemJournalLine.VALIDATE("Shortcut Dimension 1 Code", LoBCode);
        ItemJournalLine.VALIDATE("Shortcut Dimension 2 Code", BranchCode);
        ItemJournalLine.VALIDATE("Location Code", LocCode);
        ItemJournalLine.VALIDATE("Shortcut Dimension 3 Code", LocCode);
        EXIT(ItemJournalLine."Dimension Set ID");
    end;


    procedure UpdatetheLocLobBranchTransferShipment(DocNo: Code[20])
    var
        TransferShipmentHeader: Record 5744;
        ItemLedgerEntry: Record 32;
        ValueEntry: Record 5802;
        GLEntry: Record 17;
        TransferShipmentLine: Record 5745;
        DimenSetIdValue: Integer;
        GSTLedgerEntry: Record "GST Ledger Entry";
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin
        //CLEAR(DocNo);
        CLEAR(DimenSetIdValue);
        //DocNo := 'F-P-TRR/18-19/0018';
        IF TransferShipmentHeader.GET(DocNo) THEN BEGIN
            TransferShipmentHeader.VALIDATE("Shortcut Dimension 3 Code", 'FSNR0074');
            TransferShipmentHeader.VALIDATE("Shortcut Dimension 1 Code", 'CBF');
            TransferShipmentHeader.VALIDATE("Shortcut Dimension 2 Code", '3004');
            TransferShipmentHeader.VALIDATE("Dimension Set ID", UpdatetheLocLobBranch(TransferShipmentHeader."Shortcut Dimension 3 Code",
                                                        TransferShipmentHeader."Shortcut Dimension 1 Code",
                                                        TransferShipmentHeader."Shortcut Dimension 2 Code"));
            CLEAR(DimenSetIdValue);
            DimenSetIdValue := TransferShipmentHeader."Dimension Set ID";
            TransferShipmentHeader.MODIFY;

            TransferShipmentLine.RESET;
            TransferShipmentLine.SETRANGE("Document No.", DocNo);
            IF TransferShipmentLine.FINDSET THEN
                REPEAT
                    // TransferShipmentLine.VALIDATE("Shortcut Dimension 3 Code",'SFPL0021');
                    TransferShipmentLine.VALIDATE("Shortcut Dimension 1 Code", 'CBF');
                    TransferShipmentLine.VALIDATE("Shortcut Dimension 2 Code", '3004');
                    TransferShipmentLine.VALIDATE("Dimension Set ID", DimenSetIdValue);
                    TransferShipmentLine.MODIFY;
                UNTIL TransferShipmentLine.NEXT = 0;

            ItemLedgerEntry.RESET;
            ItemLedgerEntry.SETRANGE("Document No.", DocNo);
            IF ItemLedgerEntry.FINDSET THEN
                REPEAT
                    ItemLedgerEntry.VALIDATE("Shortcut Dimension 3 Code", 'FSNR0074');
                    ItemLedgerEntry.VALIDATE("Global Dimension 1 Code", 'CBF');
                    ItemLedgerEntry.VALIDATE("Global Dimension 2 Code", '3004');
                    ItemLedgerEntry.VALIDATE("Dimension Set ID", DimenSetIdValue);
                    ItemLedgerEntry.MODIFY;
                UNTIL ItemLedgerEntry.NEXT = 0;

            ValueEntry.RESET;
            ValueEntry.SETRANGE("Document No.", DocNo);
            IF ValueEntry.FINDSET THEN
                REPEAT
                    ValueEntry.VALIDATE("Global Dimension 1 Code", 'CBF');
                    ValueEntry.VALIDATE("Global Dimension 2 Code", '3004');
                    ValueEntry.VALIDATE("Dimension Set ID", DimenSetIdValue);
                    ValueEntry.MODIFY;
                UNTIL ValueEntry.NEXT = 0;

            GLEntry.RESET;
            GLEntry.SETRANGE("Document No.", DocNo);
            IF GLEntry.FINDSET THEN
                REPEAT
                    GLEntry.VALIDATE("Shortcut Dimension 3 Code", 'FSNR0074');
                    GLEntry.VALIDATE("Global Dimension 1 Code", 'CBF');
                    GLEntry.VALIDATE("Global Dimension 2 Code", '3004');
                    GLEntry.VALIDATE("Dimension Set ID", DimenSetIdValue);
                    GLEntry.MODIFY;
                UNTIL GLEntry.NEXT = 0;
        END;


    end;


    procedure UpdatetheLocLobBranchTransferRecpt(DocNo: Code[20])
    var
        ItemLedgerEntry: Record 32;
        ValueEntry: Record 5802;
        GLEntry: Record 17;
        TransferReceiptHeader: Record 5746;
        TransferReceiptLine: Record 5747;
        DimenSetIdValue: Integer;
    begin
        CLEAR(DimenSetIdValue);
        //CLEAR(DocNo);
        //DocNo := 'F-P-TRR/18-19/0018';
        IF TransferReceiptHeader.GET(DocNo) THEN BEGIN
            TransferReceiptHeader.VALIDATE("Shortcut Dimension 3 Code", 'SFPL0062');
            TransferReceiptHeader.VALIDATE("Shortcut Dimension 1 Code", 'FEED');
            TransferReceiptHeader.VALIDATE("Shortcut Dimension 2 Code", '1007');
            TransferReceiptHeader.VALIDATE("Dimension Set ID", UpdatetheLocLobBranch(TransferReceiptHeader."Shortcut Dimension 3 Code",
                                                        TransferReceiptHeader."Shortcut Dimension 1 Code",
                                                        TransferReceiptHeader."Shortcut Dimension 2 Code"));
            CLEAR(DimenSetIdValue);
            DimenSetIdValue := TransferReceiptHeader."Dimension Set ID";
            TransferReceiptHeader.MODIFY;

            TransferReceiptLine.RESET;
            TransferReceiptLine.SETRANGE("Document No.", DocNo);
            IF TransferReceiptLine.FINDSET THEN
                REPEAT
                    TransferReceiptLine.VALIDATE("Shortcut Dimension 1 Code", 'FEED');
                    TransferReceiptLine.VALIDATE("Shortcut Dimension 2 Code", '1007');
                    TransferReceiptLine.VALIDATE("Dimension Set ID", DimenSetIdValue);
                    TransferReceiptLine.MODIFY;
                UNTIL TransferReceiptLine.NEXT = 0;

            ItemLedgerEntry.RESET;
            ItemLedgerEntry.SETRANGE("Document No.", DocNo);
            IF ItemLedgerEntry.FINDSET THEN
                REPEAT
                    ItemLedgerEntry.VALIDATE("Shortcut Dimension 3 Code", 'SFPL0062');
                    ItemLedgerEntry.VALIDATE("Global Dimension 1 Code", 'FEED');
                    ItemLedgerEntry.VALIDATE("Global Dimension 2 Code", '1007');
                    ItemLedgerEntry.VALIDATE("Dimension Set ID", DimenSetIdValue);
                    ItemLedgerEntry.MODIFY;
                UNTIL ItemLedgerEntry.NEXT = 0;

            ValueEntry.RESET;
            ValueEntry.SETRANGE("Document No.", DocNo);
            IF ValueEntry.FINDSET THEN
                REPEAT
                    ValueEntry.VALIDATE("Global Dimension 1 Code", 'FEED');
                    ValueEntry.VALIDATE("Global Dimension 2 Code", '1007');
                    ValueEntry.VALIDATE("Dimension Set ID", DimenSetIdValue);
                    ValueEntry.MODIFY;
                UNTIL ValueEntry.NEXT = 0;

            GLEntry.RESET;
            GLEntry.SETRANGE("Document No.", DocNo);
            IF GLEntry.FINDSET THEN
                REPEAT
                    GLEntry.VALIDATE("Shortcut Dimension 3 Code", 'SFPL0062');
                    GLEntry.VALIDATE("Global Dimension 1 Code", 'FEED');
                    GLEntry.VALIDATE("Global Dimension 2 Code", '1007');
                    GLEntry.VALIDATE("Dimension Set ID", DimenSetIdValue);
                    GLEntry.MODIFY;
                UNTIL GLEntry.NEXT = 0;
        END;
    end;


    procedure GetDocumentNo(Doc_No_Loc: Code[20]; Doc_Type_Loc: Option " ",Shipment,Receipt)
    begin
        Doc_No_Glob := Doc_No_Loc;
        Doc_Type_Glob := Doc_Type_Loc;
    end;
}

