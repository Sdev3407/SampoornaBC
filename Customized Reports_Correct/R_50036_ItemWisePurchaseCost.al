report 50036 "Item Wise Purchase Cost"
{
    UsageCategory = Administration;
    Caption = 'Item Wise Purchase Cost Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\ItemWisePurchaseCost.rdl';
    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            DataItemTableView = SORTING("Posting Date")
                                ORDER(Ascending);
            RequestFilterFields = "Posting Date";
            column(VendorPostingDate; "Vendor Ledger Entry"."Posting Date")
            {
            }
            dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
            {
                DataItemLink = "No." = FIELD("Document No.");
                column(InvHeaderNo; "Purch. Inv. Header"."No.")
                {
                }
                column(InvHeaderPostingDate; "Purch. Inv. Header"."Posting Date")
                {
                }
                column(VendorNo; "Purch. Inv. Header"."Buy-from Vendor No.")
                {
                }
                column(vendorcity; "Purch. Inv. Header"."Buy-from City")
                {
                }
                column(VendorName; "Purch. Inv. Header"."Buy-from Vendor Name")
                {
                }
                column(BuyfromAddress2; "Purch. Inv. Header"."Buy-from Address 2")
                {
                }
                column(DueDate; "Purch. Inv. Header"."Due Date")
                {
                }
                column(BrokerageCode; "Purch. Inv. Header"."Brokerage Code")
                {
                }
                column(PaymentTermsCode; "Purch. Inv. Header"."Payment Terms Code")
                {
                }
                column(MandiName; "Purch. Inv. Header"."Mandi Name")
                {
                }
                column(AmounttoVendor; "Purch. Inv. Header"."Amount")
                {
                }
                column(ShortcutDimension1Code; "Purch. Inv. Header"."Shortcut Dimension 1 Code")
                {
                }
                column(VendorInvoiceNo; "Purch. Inv. Header"."Vendor Invoice No.")
                {
                }
                column(LocationStateCode; "Purch. Inv. Header"."Location State Code")
                {
                }
                /*  //PRU SH 01082022
                column(State_PurchInvHeader; "Purch. Inv. Header".State)
                {
                }
                */  //PRU SH 01082022
                column(State_PurchInvHeader; State_PurchInvHeader)
                {
                }
                column(GenBusPostingGroup_PurchInvHeader; "Purch. Inv. Header"."Gen. Bus. Posting Group")
                {
                }
                column(PaymentStatus; PaymentStatus)
                {
                }
                column(StatusPY; StatusPY)
                {
                }
                column(VendorType; VendorType)
                {
                }
                column(MandiName1; MandiName)
                {
                }
                dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = ORDER(Ascending)
                                        WHERE(Type = FILTER(Item));
                    column(AmountToVendorInvoiceLine; "Purch. Inv. Line"."Amount")
                    {
                    }
                    column(DocumentNo; "Purch. Inv. Line"."Document No.")
                    {
                    }
                    column(LineBuyfromVendorNo; "Purch. Inv. Line"."Buy-from Vendor No.")
                    {
                    }
                    column(LineNo; "Purch. Inv. Line"."No.")
                    {
                    }
                    column(Quantity; "Purch. Inv. Line".Quantity)
                    {
                    }
                    column(LocationCode; "Purch. Inv. Line"."Location Code")
                    {
                    }
                    column(Description; "Purch. Inv. Line".Description)
                    {
                    }
                    column(InvLinePostingDate; "Purch. Inv. Line"."Posting Date")
                    {
                    }
                    column(CostAmt; CostAmt)
                    {
                    }
                    column(Discount; Discount)
                    {
                    }
                    column(Freight; Freight)
                    {
                    }
                    column(ImportCharge; ImportCharge)
                    {
                    }
                    column(RateDiff; RateDiff)
                    {
                    }
                    column(Dami; Dami)
                    {
                    }
                    column(LoadingUnLoading; LoadingUnLoading)
                    {
                    }
                    column(OtherMaizeExpense; OtherMaizeExpense)
                    {
                    }
                    column(QualityCut; QualityCut)
                    {
                    }
                    column(TotalCostAmt; TotalCostAmt)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CostAmt := 0;
                        //CLEAR(CostAmt);
                        ValueEntry.RESET;
                        ValueEntry.SETRANGE("Document No.", "Purch. Inv. Line"."Document No.");
                        ValueEntry.SETRANGE("Document Line No.", "Purch. Inv. Line"."Line No.");
                        //ValueEntry.SETFILTER("Item Charge No.",'');
                        IF ValueEntry.FINDFIRST THEN
                            REPEAT
                                CostAmt += ValueEntry."Cost Amount (Actual)";
                            UNTIL ValueEntry.NEXT = 0;
                        //========================

                        CLEAR(ItemLedgerEntryNo);
                        ValueEntry.RESET;
                        ValueEntry.SETRANGE("Document No.", "Purch. Inv. Line"."Document No.");
                        ValueEntry.SETRANGE("Document Line No.", "Purch. Inv. Line"."Line No.");
                        IF ValueEntry.FINDFIRST THEN
                            REPEAT
                                ItemLedgerEntryNo := ValueEntry."Item Ledger Entry No.";
                            UNTIL ValueEntry.NEXT = 0;
                        //=====================================================

                        ValueEntry.GET(ItemLedgerEntryNo);
                        CLEAR(Discount);
                        ValueEntry.RESET;
                        ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgerEntryNo);
                        ValueEntry.SETFILTER("Item Charge No.", FIL);
                        IF ValueEntry.FINDSET THEN
                            REPEAT
                                Discount += ValueEntry."Cost Amount (Actual)";
                            UNTIL ValueEntry.NEXT = 0;

                        //=======================
                        ValueEntry.GET(ItemLedgerEntryNo);
                        CLEAR(Freight);
                        ValueEntry.RESET;
                        ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgerEntryNo);
                        ValueEntry.SETFILTER("Item Charge No.", Freight_);
                        IF ValueEntry.FINDSET THEN
                            REPEAT
                                Freight += ValueEntry."Cost Amount (Actual)";
                            UNTIL ValueEntry.NEXT = 0;
                        //=======================
                        ValueEntry.GET(ItemLedgerEntryNo);
                        CLEAR(ImportCharge);
                        ValueEntry.RESET;
                        ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgerEntryNo);
                        ValueEntry.SETFILTER("Item Charge No.", 'IMP-CHRG');
                        IF ValueEntry.FINDSET THEN
                            REPEAT
                                ImportCharge += ValueEntry."Cost Amount (Actual)";
                            UNTIL ValueEntry.NEXT = 0;

                        //===========================================

                        ValueEntry.GET(ItemLedgerEntryNo);
                        CLEAR(QualityCut);
                        ValueEntry.RESET;
                        ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgerEntryNo);
                        ValueEntry.SETFILTER("Item Charge No.", QualityCutFil);
                        IF ValueEntry.FINDSET THEN
                            REPEAT
                                QualityCut += ValueEntry."Cost Amount (Actual)";
                            UNTIL ValueEntry.NEXT = 0;
                        //======================================

                        ValueEntry.GET(ItemLedgerEntryNo);
                        CLEAR(RateDiff);
                        ValueEntry.RESET;
                        ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgerEntryNo);
                        //ValueEntry.SETFILTER("Item Charge No.",'%1|%2','RateDiffFil','RateDiffFil1');
                        ValueEntry.SETFILTER("Item Charge No.", RateDiffFil);
                        IF ValueEntry.FINDSET THEN
                            REPEAT
                                RateDiff += ValueEntry."Cost Amount (Actual)";
                            UNTIL ValueEntry.NEXT = 0;
                        //===============================================
                        ValueEntry.GET(ItemLedgerEntryNo);
                        CLEAR(Dami);
                        ValueEntry.RESET;
                        ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgerEntryNo);
                        ValueEntry.SETFILTER("Item Charge No.", DamiTotal);
                        IF ValueEntry.FINDSET THEN
                            REPEAT
                                Dami += ValueEntry."Cost Amount (Actual)";
                            UNTIL ValueEntry.NEXT = 0;
                        //===================================================

                        ValueEntry.GET(ItemLedgerEntryNo);
                        CLEAR(LoadingUnLoading);
                        ValueEntry.RESET;
                        ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgerEntryNo);
                        ValueEntry.SETFILTER("Item Charge No.", '%1', 'LOADING/UNLOADING');
                        IF ValueEntry.FINDSET THEN
                            REPEAT
                                LoadingUnLoading += ValueEntry."Cost Amount (Actual)";
                            UNTIL ValueEntry.NEXT = 0;
                        //=======================
                        ValueEntry.GET(ItemLedgerEntryNo);
                        CLEAR(OtherMaizeExpense);
                        ValueEntry.RESET;
                        ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgerEntryNo);
                        ValueEntry.SETFILTER("Item Charge No.", OtherMaizeExpenseFilter);
                        IF ValueEntry.FINDSET THEN
                            REPEAT
                                OtherMaizeExpense += ValueEntry."Cost Amount (Actual)";
                            UNTIL ValueEntry.NEXT = 0;


                        //
                        TotalCostAmt := 0;

                        TotalCostAmt += OtherMaizeExpense + LoadingUnLoading + Dami + RateDiff + QualityCut + ImportCharge + Freight + Discount + CostAmt;
                        //MESSAGE('%1',TotalCostAmt);
                    end;

                    trigger OnPreDataItem()
                    begin
                        FIL := 'DISCOUNT_ BIRDS|DISCOUNT_ CHICKS|DISCOUNT_ EGGS|DISCOUNT_ GEN|DISCOUNT_ IMPORT|DISCOUNT_ INGREDIENT|DISCOUNT_ MAIZE|DISCOUNT_ MEDICINE|DISCOUNT_ PACK|DISCOUNT_ PREMIX|DISCOUNT_ VACCINE|DISCOUNT_SOYA';
                        QualityCutFil :=
                        'QUALITYCUT_ BIRDS|QUALITYCUT_ CHICKS|QUALITYCUT_ EGGS|QUALITYCUT_ GEN ITEM|QUALITYCUT_ IMPORT|QUALITYCUT_ INGREDIE|QUALITYCUT_ MAIZE|QUALITYCUT_ MEDICINE|QUALITYCUT_ PACKING|QUALITYCUT_ PREMIX|QUALITYCUT_ VACCINE|QUALITYCUT_SOYA';
                        RateDiffFil := 'RATEDIFF_ BIRDS|RATEDIFF_ CHICKS|RATEDIFF_ EGGS|RATEDIFF_ GEN|RATEDIFF_ IMPORT|RATEDIFF_ INGREDIENT|RATEDIFF_ MAIZE|RATEDIFF_ MEDICINE|RATEDIFF_ PACKING|RATEDIFF_ PREMIX|RATEDIFF_ VACCINE|RATEDIFF_CATTLE|RATEDIFF_EMPTY BAGS';
                        RateDiffFil1 := 'RATEDIFF_FISH|RATEDIFF_GOAT|RATEDIFF_PIG|RATEDIFF_POULTRY|RATEDIFF_SOYA';
                        Freight_ := 'FREIGHT IN|FREIGHT IN_SOYA|FREIGHT IN-GRAINS|FREIGHT OTW-CHICKS|FREIGHT OUTWARD|FREIGHT_IMPORT|FREIGHT_IN_DOM_FEED_|FREIGHT_IN_FEED|FREIGHT-WASTAGE|FREIGHT IN_SOYA_DOC';
                        DamiTotal := 'DAMI|DAMI_WHEAT';
                        OtherMaizeExpenseFilter := 'MAIZE|WHEAT EXPENSES';
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(MandiName);
                    Mandimaster.RESET;
                    Mandimaster.SETRANGE(Code, "Purch. Inv. Header"."Mandi Name");
                    IF Mandimaster.FINDFIRST THEN
                        MandiName := Mandimaster.Description;

                    CLEAR(PaymentStatus);
                    VendorLedgerEntry.RESET;
                    VendorLedgerEntry.SETRANGE("Document No.", "Purch. Inv. Header"."No.");
                    IF VendorLedgerEntry.FINDFIRST THEN
                        VendorLedgerEntry.CALCFIELDS("Remaining Amount");
                    PaymentStatus := VendorLedgerEntry."Remaining Amount";

                    IF PaymentStatus <> 0 THEN
                        StatusPY := 'No'
                    ELSE
                        StatusPY := 'Yes';
                end;
            }
            dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
            {
                DataItemLink = "No." = FIELD("Document No.");
                column(MemoHdrNo; "Purch. Cr. Memo Hdr."."No.")
                {
                }
                column(MemoHdrPostingDate; "Purch. Cr. Memo Hdr."."Posting Date")
                {
                }
                column(MemoHdrVendorNo; "Purch. Cr. Memo Hdr."."Buy-from Vendor No.")
                {
                }
                column(MemoHdrCity; "Purch. Cr. Memo Hdr."."Buy-from City")
                {
                }
                column(MemoHdrVendorName; "Purch. Cr. Memo Hdr."."Buy-from Vendor Name")
                {
                }
                column(MemoDueDate; "Purch. Cr. Memo Hdr."."Due Date")
                {
                }
                column(MemoHdrBrokerageCode; "Purch. Cr. Memo Hdr."."Brokerage Code")
                {
                }
                column(MemoHdrPaymentTermsCode; "Purch. Cr. Memo Hdr."."Payment Terms Code")
                {
                }
                column(MemoHdrMandiName; "Purch. Cr. Memo Hdr."."Mandi Name")
                {
                }
                column(MemoHdrAmounttoVendor; -"Purch. Cr. Memo Hdr."."Amount")
                {
                }
                column(MemoHdrShortcutDimension1Code; "Purch. Cr. Memo Hdr."."Shortcut Dimension 1 Code")
                {
                }
                column(VendorCrMemoNo; "Purch. Cr. Memo Hdr."."Vendor Cr. Memo No.")
                {
                }
                column(MemoLocationStateCode; "Purch. Cr. Memo Hdr."."Location State Code")
                {
                }
                /* //PRU SH 01082022
                column(State_PurchCrMemoHdr; "Purch. Cr. Memo Hdr.".State)
                {
                }
                */   //PRU SH 01082022
                column(State_PurchCrMemoHdr; State_PurchCrMemoHdr)
                {
                }
                column(GenBusPostingGroup_PurchCrMemoHdr; "Purch. Cr. Memo Hdr."."Gen. Bus. Posting Group")
                {
                }
                column(MandiNameMemo; MandiNameMemo)
                {
                }
                column(VendorTypeMemo; VendorTypeMemo)
                {
                }
                dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = ORDER(Ascending)
                                        WHERE(Type = FILTER(Item));
                    column(AmountToVendorCRLine; -"Purch. Cr. Memo Line"."Amount")
                    {
                    }
                    column(MemoDocumentNo; "Purch. Cr. Memo Line"."Document No.")
                    {
                    }
                    column(MemoLineNo; "Purch. Cr. Memo Line"."No.")
                    {
                    }
                    column(MemoQuantity; -"Purch. Cr. Memo Line".Quantity)
                    {
                    }
                    column(MemoLineLocationCode; "Purch. Cr. Memo Line"."Location Code")
                    {
                    }
                    column(MemoLineDescription; "Purch. Cr. Memo Line".Description)
                    {
                    }
                    column(MemoLinePostingDate; "Purch. Cr. Memo Line"."Posting Date")
                    {
                    }
                    column(CostAmtCreditMemo; CostAmtCreditMemo)
                    {
                    }
                    column(FreightCrMemo; FreightCrMemo)
                    {
                    }
                    column(DiscountCrMemo; DiscountCrMemo)
                    {
                    }
                    column(ImportChargeCrMemo; ImportChargeCrMemo)
                    {
                    }
                    column(QualityCutCrMemo; QualityCutCrMemo)
                    {
                    }
                    column(RateDiffCrMemo; RateDiffCrMemo)
                    {
                    }
                    column(DamiCrMemo; DamiCrMemo)
                    {
                    }
                    column(LoadingUnLoadingCrMemo; LoadingUnLoadingCrMemo)
                    {
                    }
                    column(OtherMaizeExpensesCrMemo; OtherMaizeExpensesCrMemo)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CostAmtCreditMemo := 0;
                        ValueEntry5802.RESET;
                        ValueEntry5802.SETRANGE("Document No.", "Purch. Cr. Memo Line"."Document No.");
                        ValueEntry5802.SETRANGE("Document Line No.", "Purch. Cr. Memo Line"."Line No.");
                        ValueEntry5802.SETFILTER("Item Charge No.", '');
                        IF ValueEntry5802.FINDSET THEN
                            REPEAT
                                CostAmtCreditMemo += ValueEntry5802."Cost Amount (Actual)";
                            UNTIL ValueEntry.NEXT = 0;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(MandiNameMemo);
                    Mandimaster.RESET;
                    Mandimaster.SETRANGE(Code, "Purch. Cr. Memo Hdr."."Mandi Name");
                    IF Mandimaster.FINDFIRST THEN
                        MandiNameMemo := Mandimaster.Description;

                    /*  //PRU SH 01082022
                                        CLEAR(VendorTypeMemo);
                                        Vendor.RESET;
                                        Vendor.SETRANGE("No.", "Purch. Cr. Memo Hdr."."Buy-from Vendor No.");
                                        IF Vendor.FINDFIRST THEN
                                            VendorTypeMemo := Vendor."Vendor Type";
                    */  //PRU SH 01082022
                    CLEAR(PaymentStatus);
                    VendorLedgerEntry.RESET;
                    VendorLedgerEntry.SETRANGE("Document No.", "Purch. Cr. Memo Hdr."."No.");
                    IF VendorLedgerEntry.FINDFIRST THEN
                        VendorLedgerEntry.CALCFIELDS("Remaining Amount");
                    PaymentStatus := VendorLedgerEntry."Remaining Amount";

                    IF PaymentStatus <> 0 THEN
                        StatusPY := 'No'
                    ELSE
                        StatusPY := 'Yes';
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Mandimaster: Record 50028;
        MandiName: Text[100];
        MandiNameMemo: Text[100];
        Vendor: Record 23;
        VendorType: Option " ",Manufacturer,"First Stage Dealer","Second Stage Dealer",Importer;
        VendorTypeMemo: Option " ",Manufacturer,"First Stage Dealer","Second Stage Dealer",Importer;
        ValueEntry: Record 5802;
        ValueEntry5802: Record 5802;
        CostAmt: Decimal;
        CostAmtCreditMemo: Decimal;
        ItemLedgerEntryNo: Integer;
        Discount: Decimal;
        Freight: Decimal;
        ImportCharge: Decimal;
        RateDiff: Decimal;
        Dami: Decimal;
        LoadingUnLoading: Decimal;
        OtherMaizeExpense: Decimal;
        ItemLedgerEntryNoCrMemo: Integer;
        DiscountCrMemo: Decimal;
        FreightCrMemo: Decimal;
        ImportChargeCrMemo: Decimal;
        QualityCutCrMemo: Decimal;
        RateDiffCrMemo: Decimal;
        DamiCrMemo: Decimal;
        LoadingUnLoadingCrMemo: Decimal;
        OtherMaizeExpensesCrMemo: Decimal;
        DiscountText: Text;
        FIL: Text;
        QualityCutFil: Text;
        QualityCut: Decimal;
        RateDiffFil: Text;
        RateDiffFil1: Text;
        FIlCrMemo: Text;
        FilCrmo: Text;
        RateDiffFillCrMemo: Text;
        RateDiffFillCrMemo1: Text;
        VendorLedgerEntry: Record 25;
        PaymentStatus: Decimal;
        StatusPY: Text;
        TotalCostAmt: Decimal;
        Freight_: Text;
        DamiTotal: Text;
        State_PurchCrMemoHdr: Code[10];
        OtherMaizeExpenseFilter: Text;
        State_PurchInvHeader: Code[10];
}

