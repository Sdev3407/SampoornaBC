report 50072 "Consolidate OutstandingDetail"
{
    UsageCategory = Administration;
    Caption = 'Consolidate Outstanding Detail Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\ConsolidateOutstandingDetail.rdl';
    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = WHERE("Global Dimension 1 Code" = CONST('CBF'),
                                      "Document Type" = CONST(Invoice),
                                      "Remaining Amount" = FILTER(<> 0));
            RequestFilterFields = "Customer No.";
            column(ReportDate; ReportDate)
            {
            }
            column(ExcessCredit; ExcessCredit)
            {
            }
            column(BalSymb; BalSymb)
            {
            }
            column(CreditLimit; Customer."CDS Credit Limit")
            {
            }
            column(NetCreditSale; NetCreditSale)
            {
            }
            column(SerialNo; Srno)
            {
            }
            column(DayWiseSaleTotal1; DayWiseSaleTotal[1])
            {
            }
            column(DayWiseSaleTotal2; DayWiseSaleTotal[2])
            {
            }
            column(DayWiseSaleTotal3; DayWiseSaleTotal[3])
            {
            }
            column(DayWiseSaleTotal4; DayWiseSaleTotal[4])
            {
            }
            column(DayWiseSaleTotal5; DayWiseSaleTotal[5])
            {
            }
            column(DayWiseSaleTotal6; DayWiseSaleTotal[6])
            {
            }
            column(DayWiseSale1; DayWiseSale[1])
            {
            }
            column(DayWiseSale2; DayWiseSale[2])
            {
            }
            column(DayWiseSale3; DayWiseSale[3])
            {
            }
            column(DayWiseSale4; DayWiseSale[4])
            {
            }
            column(DayWiseSale5; DayWiseSale[5])
            {
            }
            column(OpeningBal; DayWiseSale[6])
            {
            }
            column(CustomerName; Customer.Name)
            {
            }
            column(AgeingDate5; ReportAgeing[1])
            {
            }
            column(AgeingDate4; ReportAgeing[2])
            {
            }
            column(AgeingDate3; ReportAgeing[3])
            {
            }
            column(AgeingDate2; ReportAgeing[4])
            {
            }
            column(AgeingDate1; ReportAgeing[5])
            {
            }
            column(EntryNo_CustLedgerEntry; "Cust. Ledger Entry"."Entry No.")
            {
            }
            column(CustomerNo_CustLedgerEntry; "Cust. Ledger Entry"."Customer No.")
            {
            }
            column(PostingDate_CustLedgerEntry; "Cust. Ledger Entry"."Posting Date")
            {
            }
            column(DocumentType_CustLedgerEntry; "Cust. Ledger Entry"."Document Type")
            {
            }
            column(DocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."Document No.")
            {
            }
            column(Description_CustLedgerEntry; "Cust. Ledger Entry".Description)
            {
            }
            column(CurrencyCode_CustLedgerEntry; "Cust. Ledger Entry"."Currency Code")
            {
            }
            column(Amount_CustLedgerEntry; "Cust. Ledger Entry".Amount)
            {
            }
            column(RemainingAmount_CustLedgerEntry; "Cust. Ledger Entry"."Remaining Amount")
            {
            }
            column(OriginalAmtLCY_CustLedgerEntry; "Cust. Ledger Entry"."Original Amt. (LCY)")
            {
            }
            column(RemainingAmtLCY_CustLedgerEntry; "Cust. Ledger Entry"."Remaining Amt. (LCY)")
            {
            }
            column(AmountLCY_CustLedgerEntry; "Cust. Ledger Entry"."Amount (LCY)")
            {
            }
            column(SalesLCY_CustLedgerEntry; "Cust. Ledger Entry"."Sales (LCY)")
            {
            }
            column(ProfitLCY_CustLedgerEntry; "Cust. Ledger Entry"."Profit (LCY)")
            {
            }
            column(InvDiscountLCY_CustLedgerEntry; "Cust. Ledger Entry"."Inv. Discount (LCY)")
            {
            }
            column(SelltoCustomerNo_CustLedgerEntry; "Cust. Ledger Entry"."Sell-to Customer No.")
            {
            }
            column(CustomerPostingGroup_CustLedgerEntry; "Cust. Ledger Entry"."Customer Posting Group")
            {
            }
            column(GlobalDimension1Code_CustLedgerEntry; "Cust. Ledger Entry"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_CustLedgerEntry; "Cust. Ledger Entry"."Global Dimension 2 Code")
            {
            }
            column(SalespersonCode_CustLedgerEntry; "Cust. Ledger Entry"."Salesperson Code")
            {
            }
            column(UserID_CustLedgerEntry; "Cust. Ledger Entry"."User ID")
            {
            }
            column(SourceCode_CustLedgerEntry; "Cust. Ledger Entry"."Source Code")
            {
            }
            column(OnHold_CustLedgerEntry; "Cust. Ledger Entry"."On Hold")
            {
            }
            column(AppliestoDocType_CustLedgerEntry; "Cust. Ledger Entry"."Applies-to Doc. Type")
            {
            }
            column(AppliestoDocNo_CustLedgerEntry; "Cust. Ledger Entry"."Applies-to Doc. No.")
            {
            }
            column(Open_CustLedgerEntry; "Cust. Ledger Entry".Open)
            {
            }
            column(DueDate_CustLedgerEntry; "Cust. Ledger Entry"."Due Date")
            {
            }
            column(PmtDiscountDate_CustLedgerEntry; "Cust. Ledger Entry"."Pmt. Discount Date")
            {
            }
            column(OriginalPmtDiscPossible_CustLedgerEntry; "Cust. Ledger Entry"."Original Pmt. Disc. Possible")
            {
            }
            column(PmtDiscGivenLCY_CustLedgerEntry; "Cust. Ledger Entry"."Pmt. Disc. Given (LCY)")
            {
            }
            column(Positive_CustLedgerEntry; "Cust. Ledger Entry".Positive)
            {
            }
            column(ClosedbyEntryNo_CustLedgerEntry; "Cust. Ledger Entry"."Closed by Entry No.")
            {
            }
            column(ClosedatDate_CustLedgerEntry; "Cust. Ledger Entry"."Closed at Date")
            {
            }
            column(ClosedbyAmount_CustLedgerEntry; "Cust. Ledger Entry"."Closed by Amount")
            {
            }
            column(AppliestoID_CustLedgerEntry; "Cust. Ledger Entry"."Applies-to ID")
            {
            }
            column(JournalBatchName_CustLedgerEntry; "Cust. Ledger Entry"."Journal Batch Name")
            {
            }
            column(ReasonCode_CustLedgerEntry; "Cust. Ledger Entry"."Reason Code")
            {
            }
            column(BalAccountType_CustLedgerEntry; "Cust. Ledger Entry"."Bal. Account Type")
            {
            }
            column(BalAccountNo_CustLedgerEntry; "Cust. Ledger Entry"."Bal. Account No.")
            {
            }
            column(TransactionNo_CustLedgerEntry; "Cust. Ledger Entry"."Transaction No.")
            {
            }
            column(ClosedbyAmountLCY_CustLedgerEntry; "Cust. Ledger Entry"."Closed by Amount (LCY)")
            {
            }
            column(DebitAmount_CustLedgerEntry; "Cust. Ledger Entry"."Debit Amount")
            {
            }
            column(CreditAmount_CustLedgerEntry; "Cust. Ledger Entry"."Credit Amount")
            {
            }
            column(DebitAmountLCY_CustLedgerEntry; "Cust. Ledger Entry"."Debit Amount (LCY)")
            {
            }
            column(CreditAmountLCY_CustLedgerEntry; "Cust. Ledger Entry"."Credit Amount (LCY)")
            {
            }
            column(DocumentDate_CustLedgerEntry; "Cust. Ledger Entry"."Document Date")
            {
            }
            column(ExternalDocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."External Document No.")
            {
            }
            column(CalculateInterest_CustLedgerEntry; "Cust. Ledger Entry"."Calculate Interest")
            {
            }
            column(ClosingInterestCalculated_CustLedgerEntry; "Cust. Ledger Entry"."Closing Interest Calculated")
            {
            }
            column(NoSeries_CustLedgerEntry; "Cust. Ledger Entry"."No. Series")
            {
            }
            column(ClosedbyCurrencyCode_CustLedgerEntry; "Cust. Ledger Entry"."Closed by Currency Code")
            {
            }
            column(ClosedbyCurrencyAmount_CustLedgerEntry; "Cust. Ledger Entry"."Closed by Currency Amount")
            {
            }
            column(AdjustedCurrencyFactor_CustLedgerEntry; "Cust. Ledger Entry"."Adjusted Currency Factor")
            {
            }
            column(OriginalCurrencyFactor_CustLedgerEntry; "Cust. Ledger Entry"."Original Currency Factor")
            {
            }
            column(OriginalAmount_CustLedgerEntry; "Cust. Ledger Entry"."Original Amount")
            {
            }
            column(DateFilter_CustLedgerEntry; "Cust. Ledger Entry"."Date Filter")
            {
            }
            column(RemainingPmtDiscPossible_CustLedgerEntry; "Cust. Ledger Entry"."Remaining Pmt. Disc. Possible")
            {
            }
            column(PmtDiscToleranceDate_CustLedgerEntry; "Cust. Ledger Entry"."Pmt. Disc. Tolerance Date")
            {
            }
            column(MaxPaymentTolerance_CustLedgerEntry; "Cust. Ledger Entry"."Max. Payment Tolerance")
            {
            }
            column(LastIssuedReminderLevel_CustLedgerEntry; "Cust. Ledger Entry"."Last Issued Reminder Level")
            {
            }
            column(AcceptedPaymentTolerance_CustLedgerEntry; "Cust. Ledger Entry"."Accepted Payment Tolerance")
            {
            }
            column(AcceptedPmtDiscTolerance_CustLedgerEntry; "Cust. Ledger Entry"."Accepted Pmt. Disc. Tolerance")
            {
            }
            column(PmtToleranceLCY_CustLedgerEntry; "Cust. Ledger Entry"."Pmt. Tolerance (LCY)")
            {
            }
            column(AmounttoApply_CustLedgerEntry; "Cust. Ledger Entry"."Amount to Apply")
            {
            }
            column(ICPartnerCode_CustLedgerEntry; "Cust. Ledger Entry"."IC Partner Code")
            {
            }
            column(ApplyingEntry_CustLedgerEntry; "Cust. Ledger Entry"."Applying Entry")
            {
            }
            column(Reversed_CustLedgerEntry; "Cust. Ledger Entry".Reversed)
            {
            }
            column(ReversedbyEntryNo_CustLedgerEntry; "Cust. Ledger Entry"."Reversed by Entry No.")
            {
            }
            column(ReversedEntryNo_CustLedgerEntry; "Cust. Ledger Entry"."Reversed Entry No.")
            {
            }
            column(Prepayment_CustLedgerEntry; "Cust. Ledger Entry".Prepayment)
            {
            }
            column(PaymentMethodCode_CustLedgerEntry; "Cust. Ledger Entry"."Payment Method Code")
            {
            }
            column(AppliestoExtDocNo_CustLedgerEntry; "Cust. Ledger Entry"."Applies-to Ext. Doc. No.")
            {
            }
            column(RecipientBankAccount_CustLedgerEntry; "Cust. Ledger Entry"."Recipient Bank Account")
            {
            }
            column(MessagetoRecipient_CustLedgerEntry; "Cust. Ledger Entry"."Message to Recipient")
            {
            }
            column(ExportedtoPaymentFile_CustLedgerEntry; "Cust. Ledger Entry"."Exported to Payment File")
            {
            }
            column(DimensionSetID_CustLedgerEntry; "Cust. Ledger Entry"."Dimension Set ID")
            {
            }
            column(DirectDebitMandateID_CustLedgerEntry; "Cust. Ledger Entry"."Direct Debit Mandate ID")
            {
            }
            /*  //PRU SH
            column(TDSNatureofDeduction_CustLedgerEntry; "Cust. Ledger Entry"."TDS Nature of Deduction")
            {
            }
            column(TDSGroup_CustLedgerEntry; "Cust. Ledger Entry"."TDS Group")
            {
            }
            column(TotalTDSTCSInclSHECESS_CustLedgerEntry; "Cust. Ledger Entry"."Total TDS/TCS Incl SHE CESS")
            {
            }

            column(TCSType_CustLedgerEntry; "Cust. Ledger Entry"."TCS Type")
            {
            }
            column(TDSReceivableGroup_CustLedgerEntry; "Cust. Ledger Entry"."TDS Receivable Group")
            {
            }

            column(PoT_CustLedgerEntry; "Cust. Ledger Entry".PoT)
            {
            }
            column(CustomerPANNo_CustLedgerEntry; "Cust. Ledger Entry"."Customer P.A.N No.")
            {
            }
            column(ServTaxonAdvancePayment_CustLedgerEntry; "Cust. Ledger Entry"."Serv. Tax on Advance Payment")
            {
            }
            */  //PRU SH
            column(TDSNatureofDeduction_CustLedgerEntry; TDSNatureofDeduction_CustLedgerEntry)
            {
            }
            column(TDSGroup_CustLedgerEntry; TDSGroup_CustLedgerEntry)
            {
            }
            column(TotalTDSTCSInclSHECESS_CustLedgerEntry; TotalTDSTCSInclSHECESS_CustLedgerEntry)
            {
            }

            column(TCSType_CustLedgerEntry; TCSType_CustLedgerEntry)
            {
            }
            column(TDSReceivableGroup_CustLedgerEntry; TDSReceivableGroup_CustLedgerEntry)
            {
            }

            column(PoT_CustLedgerEntry; PoT_CustLedgerEntry)
            {
            }
            column(CustomerPANNo_CustLedgerEntry; CustomerPANNo_CustLedgerEntry)
            {
            }
            column(ServTaxonAdvancePayment_CustLedgerEntry; ServTaxonAdvancePayment_CustLedgerEntry)
            {
            }
            column(TDSCertificateReceivable_CustLedgerEntry; "Cust. Ledger Entry"."TDS Certificate Receivable")
            {
            }
            column(CertificateReceived_CustLedgerEntry; "Cust. Ledger Entry"."Certificate Received")
            {
            }
            column(CertificateNo_CustLedgerEntry; "Cust. Ledger Entry"."Certificate No.")
            {
            }
            column(TDSCertificateReceived_CustLedgerEntry; "Cust. Ledger Entry"."TDS Certificate Received")
            {
            }
            column(TDSCertificateRcptDate_CustLedgerEntry; "Cust. Ledger Entry"."TDS Certificate Rcpt Date")
            {
            }
            column(TDSCertificateAmount_CustLedgerEntry; "Cust. Ledger Entry"."TDS Certificate Amount")
            {
            }
            column(TCSNatureofCollection_CustLedgerEntry; "Cust. Ledger Entry"."TCS Nature of Collection")
            {
            }
            column(FinancialYear_CustLedgerEntry; "Cust. Ledger Entry"."Financial Year")
            {
            }

            column(LocationCode_CustLedgerEntry; "Cust. Ledger Entry"."Location Code")
            {
            }
            column(HSNSACCode_CustLedgerEntry; "Cust. Ledger Entry"."HSN/SAC Code")
            {
            }
            column(GSTonAdvancePayment_CustLedgerEntry; "Cust. Ledger Entry"."GST on Advance Payment")
            {
            }
            column(AdvPmtAdjustment_CustLedgerEntry; "Cust. Ledger Entry"."Adv. Pmt. Adjustment")
            {
            }
            column(GSTJurisdictionType_CustLedgerEntry; "Cust. Ledger Entry"."GST Jurisdiction Type")
            {
            }
            column(LocationStateCode_CustLedgerEntry; "Cust. Ledger Entry"."Location State Code")
            {
            }
            column(SellerStateCode_CustLedgerEntry; "Cust. Ledger Entry"."Seller State Code")
            {
            }
            column(SellerGSTRegNo_CustLedgerEntry; "Cust. Ledger Entry"."Seller GST Reg. No.")
            {
            }
            column(GSTCustomerType_CustLedgerEntry; "Cust. Ledger Entry"."GST Customer Type")
            {
            }
            column(LocationGSTRegNo_CustLedgerEntry; "Cust. Ledger Entry"."Location GST Reg. No.")
            {
            }
            column(GSTGroupCode_CustLedgerEntry; "Cust. Ledger Entry"."GST Group Code")
            {
            }
            column(GSTinJournal_CustLedgerEntry; "Cust. Ledger Entry"."GST in Journal")
            {
            }
            column(JournalEntry_CustLedgerEntry; "Cust. Ledger Entry"."Journal Entry")
            {
            }
            column(GSTWithoutPaymentofDuty_CustLedgerEntry; "Cust. Ledger Entry"."GST Without Payment of Duty")
            {
            }
            column(LocationARNNo_CustLedgerEntry; "Cust. Ledger Entry"."Location ARN No.")
            {
            }
            column(CustomerName_CustLedgerEntry; "Cust. Ledger Entry"."Customer Name")
            {
            }
            column(ShortcutDimension3Code_CustLedgerEntry; "Cust. Ledger Entry"."Shortcut Dimension 3 Code")
            {
            }
            column(LineNarration1_CustLedgerEntry; "Cust. Ledger Entry"."Line Narration1")
            {
            }


            trigger OnAfterGetRecord()
            begin
                IF DuplicateCustomer <> "Cust. Ledger Entry"."Customer No." THEN BEGIN
                    Srno += 1;
                    NetCreditSale := 0;
                    FOR I := 1 TO Last DO BEGIN
                        IF I > 5 THEN BEGIN
                            DayWiseSale[I] := 0;
                            CustLedgerEntry.RESET;
                            CustLedgerEntry.SETRANGE(CustLedgerEntry."Customer No.", "Cust. Ledger Entry"."Customer No.");
                            CustLedgerEntry.SETRANGE(CustLedgerEntry."Global Dimension 1 Code", 'CBF');
                            CustLedgerEntry.SETRANGE(CustLedgerEntry."Document Type", CustLedgerEntry."Document Type"::Invoice);
                            CustLedgerEntry.SETRANGE(CustLedgerEntry."Posting Date", 0D, ReportAgeing[I]);
                            CustLedgerEntry.SETFILTER(CustLedgerEntry."Remaining Amount", '<>%1', 0);
                            IF CustLedgerEntry.FINDSET THEN
                                REPEAT
                                    CustLedgerEntry.CALCFIELDS(CustLedgerEntry."Remaining Amount");
                                    DayWiseSale[I] += CustLedgerEntry."Remaining Amount";
                                    DayWiseSaleTotal[I] += DayWiseSale[I];
                                UNTIL CustLedgerEntry.NEXT = 0;
                        END ELSE BEGIN
                            DayWiseSale[I] := 0;
                            CustLedgerEntry.RESET;
                            CustLedgerEntry.SETRANGE(CustLedgerEntry."Customer No.", "Cust. Ledger Entry"."Customer No.");
                            CustLedgerEntry.SETRANGE(CustLedgerEntry."Global Dimension 1 Code", 'CBF');
                            CustLedgerEntry.SETRANGE(CustLedgerEntry."Document Type", CustLedgerEntry."Document Type"::Invoice);
                            CustLedgerEntry.SETRANGE(CustLedgerEntry."Posting Date", ReportAgeing[I], ReportAgeing[I]);
                            CustLedgerEntry.SETFILTER(CustLedgerEntry."Remaining Amount", '<>%1', 0);
                            IF CustLedgerEntry.FINDSET THEN
                                REPEAT
                                    CustLedgerEntry.CALCFIELDS(CustLedgerEntry."Remaining Amount");
                                    DayWiseSale[I] += CustLedgerEntry."Remaining Amount";
                                    DayWiseSaleTotal[I] += DayWiseSale[I];
                                //MESSAGE('%1',DayWiseSale[I]);
                                UNTIL CustLedgerEntry.NEXT = 0;
                        END;
                        NetCreditSale += DayWiseSale[I];
                    END;
                    Customer.RESET;
                    IF Customer.GET("Cust. Ledger Entry"."Customer No.") THEN;
                    IF NetCreditSale > Customer."CDS Credit Limit" THEN
                        ExcessCredit += ABS(Customer."CDS Credit Limit" - NetCreditSale);
                    DuplicateCustomer := "Cust. Ledger Entry"."Customer No.";
                END ELSE
                    CurrReport.SKIP;
                // Customer.RESET;
                // IF Customer.GET("Cust. Ledger Entry"."Customer No.") THEN;
                // IF NetCreditSale > Customer."CDS Credit Limit" THEN
                //  ExcessCredit := Customer."CDS Credit Limit" - NetCreditSale;
                // IF ExcessCredit < 0 THEN
                //  BalSymb := 'Cr'
                // ELSE
                //  BalSymb := 'Dr';
            end;

            trigger OnPreDataItem()
            begin
                ReportAgeing[1] := ReportDate;
                FOR I := 2 TO Last DO BEGIN
                    ReportAgeing[I] := CALCDATE('-1D', ReportAgeing[I - 1]);
                    //MESSAGE('%1',ReportAgeing[I]);
                END;
                "Cust. Ledger Entry".SETCURRENTKEY("Customer No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        Last := 6;
        ReportDate := CALCDATE('-1D', WORKDATE);
    end;

    var
        ReportAgeing: array[6] of Date;
        ReportDate: Date;
        I: Integer;
        Customer: Record 18;
        CustLedgerEntry: Record 21;
        DayWiseSale: array[6] of Decimal;
        Last: Integer;
        DuplicateCustomer: Code[40];
        Srno: Integer;
        NetCreditSale: Decimal;
        ExcessCredit: Decimal;
        BalSymb: Text;
        DayWiseSaleTotal: array[6] of Decimal;
        TDSNatureofDeduction_CustLedgerEntry: Decimal;
        TDSGroup_CustLedgerEntry: Decimal;
        TotalTDSTCSInclSHECESS_CustLedgerEntry: Decimal;
        TCSType_CustLedgerEntry: Decimal;
        TDSReceivableGroup_CustLedgerEntry: Decimal;
        PoT_CustLedgerEntry: Decimal;
        CustomerPANNo_CustLedgerEntry: Decimal;
        ServTaxonAdvancePayment_CustLedgerEntry: Decimal;

}

