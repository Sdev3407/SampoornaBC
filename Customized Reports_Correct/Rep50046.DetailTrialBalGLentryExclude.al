report 50046 "DetailTrialBalGLentry(Exclude)"
{
    UsageCategory = Administration;
    Caption = 'Detail Trial Balance';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\DetailTrialBalGLentryExclude.rdl';
    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = WHERE("Account Type" = CONST(Posting));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Income/Balance", "Debit/Credit", "Date Filter";
            column(PeriodGLDtFilter; STRSUBSTNO(Text000, GLDateFilter))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(ExcludeBalanceOnly; ExcludeBalanceOnly)
            {
            }
            column(PrintReversedEntries; PrintReversedEntries)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(PrintClosingEntries; PrintClosingEntries)
            {
            }
            column(PrintOnlyCorrections; PrintOnlyCorrections)
            {
            }
            column(GLAccTableCaption; TABLECAPTION + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(EmptyString; '')
            {
            }
            column(No_GLAcc; "No.")
            {
            }
            column(DetailTrialBalCaption; DetailTrialBalCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(PeriodCaption; PeriodCaptionLbl)
            {
            }
            column(OnlyCorrectionsCaption; OnlyCorrectionsCaptionLbl)
            {
            }
            column(NetChangeCaption; NetChangeCaptionLbl)
            {
            }
            column(GLEntryDebitAmtCaption; GLEntryDebitAmtCaptionLbl)
            {
            }
            column(GLEntryCreditAmtCaption; GLEntryCreditAmtCaptionLbl)
            {
            }
            column(GLBalCaption; GLBalCaptionLbl)
            {
            }
            dataitem(PageCounter; 2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(Name_GLAcc; "G/L Account".Name)
                {
                }
                column(StartBalance; StartBalance)
                {
                    AutoFormatType = 1;
                }
                dataitem("G/L Entry"; "G/L Entry")
                {
                    DataItemLink = "G/L Account No." = FIELD("No."),
                                   "Posting Date" = FIELD("Date Filter"),
                                   "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                   "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                   "Business Unit Code" = FIELD("Business Unit Filter");
                    DataItemLinkReference = "G/L Account";
                    DataItemTableView = SORTING("G/L Account No.", "Posting Date");
                    column(VATAmount_GLEntry; "VAT Amount")
                    {
                        IncludeCaption = true;
                    }
                    column(DebitAmount_GLEntry; "Debit Amount")
                    {
                    }
                    column(CreditAmount_GLEntry; "Credit Amount")
                    {
                    }
                    column(PostingDate_GLEntry; "Posting Date")
                    {
                    }
                    column(DocumentNo_GLEntry; "Document No.")
                    {
                    }
                    column(Description_GLEntry; Description)
                    {
                    }
                    column(GLBalance; GLBalance)
                    {
                        AutoFormatType = 1;
                    }
                    column(EntryNo_GLEntry; "Entry No.")
                    {
                    }
                    column(ClosingEntry; ClosingEntry)
                    {
                    }
                    column(Reversed_GLEntry; Reversed)
                    {
                    }
                    /*   //PRU SH
                    dataitem(DataItem1170000000; 16548)
                    {
                        DataItemLink = "Entry No." = FIELD("Entry No."),
                                       "Transaction No." = FIELD("Transaction No.");
                        column(Posted_Narration; "Posted Narration".Narration)
                        {
                        }
                        column(Posted_Narration_EntryNo; "Posted Narration"."Entry No.")
                        {
                        }
                        column(Posted_Narration_Transaction_No; "Posted Narration"."Transaction No.")
                        {
                        }
                    }
                    */  //PRU SH

                    trigger OnAfterGetRecord()
                    begin
                        IF PrintOnlyCorrections THEN
                            IF NOT (("Debit Amount" < 0) OR ("Credit Amount" < 0)) THEN
                                CurrReport.SKIP;
                        IF NOT PrintReversedEntries AND Reversed THEN
                            CurrReport.SKIP;

                        GLBalance := GLBalance + Amount;
                        IF ("Posting Date" = CLOSINGDATE("Posting Date")) AND
                           NOT PrintClosingEntries
                        THEN BEGIN
                            "Debit Amount" := 0;
                            "Credit Amount" := 0;
                        END;

                        IF "Posting Date" = CLOSINGDATE("Posting Date") THEN
                            ClosingEntry := TRUE
                        ELSE
                            ClosingEntry := FALSE;
                    end;

                    trigger OnPreDataItem()
                    begin
                        GLBalance := StartBalance;
                        CurrReport.CREATETOTALS(Amount, "Debit Amount", "Credit Amount", "VAT Amount");
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CurrReport.PRINTONLYIFDETAIL := ExcludeBalanceOnly OR (StartBalance = 0);
                     //PRU SH
                end;
            }

            trigger OnAfterGetRecord()
            var
                Date: Record 2000000007;
            begin
                IF ExcludeGLAccountNo <> '' THEN BEGIN///PRU-VG
                    GLAccount.RESET;
                    GLAccount.SETFILTER("No.", ExcludeGLAccountNo);
                    IF GLAccount.FINDSET THEN
                        REPEAT
                            IF GLAccount."No." = "No." THEN
                                CurrReport.SKIP;
                        UNTIL GLAccount.NEXT = 0;
                END;
                ///PRU-VG-Stop
                StartBalance := 0;
                IF GLDateFilter <> '' THEN BEGIN
                    Date.SETRANGE("Period Type", Date."Period Type"::Date);
                    Date.SETFILTER("Period Start", GLDateFilter);
                    IF Date.FINDFIRST THEN BEGIN
                        SETRANGE("Date Filter", 0D, CLOSINGDATE(Date."Period Start" - 1));
                        CALCFIELDS("Net Change");
                        StartBalance := "Net Change";
                        SETFILTER("Date Filter", GLDateFilter);
                    END;
                END;

                IF PrintOnlyOnePerPage THEN BEGIN
                    GLEntryPage.RESET;
                    GLEntryPage.SETRANGE("G/L Account No.", "No.");
                    IF CurrReport.PRINTONLYIFDETAIL AND GLEntryPage.FINDFIRST THEN  //PRU SH
                        PageGroupNo := PageGroupNo + 1;   //PRU SH
                END;
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;
                CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NewPageperGLAcc; PrintOnlyOnePerPage)
                    {
                        Caption = 'New Page per G/L Acc.';
                        ApplicationArea = All;
                    }
                    field(ExcludeGLAccsHaveBalanceOnly; ExcludeBalanceOnly)
                    {
                        Caption = 'Exclude G/L Accs. That Have a Balance Only';
                        MultiLine = true;
                        ApplicationArea = All;
                    }
                    field(InclClosingEntriesWithinPeriod; PrintClosingEntries)
                    {
                        Caption = 'Include Closing Entries Within the Period';
                        MultiLine = true;
                        ApplicationArea = All;
                    }
                    field(IncludeReversedEntries; PrintReversedEntries)
                    {
                        Caption = 'Include Reversed Entries';
                        ApplicationArea = All;
                    }
                    field(PrintCorrectionsOnly; PrintOnlyCorrections)
                    {
                        Caption = 'Print Corrections Only';
                        ApplicationArea = All;
                    }
                    field(ExcludeGLAccountNo; ExcludeGLAccountNo)
                    {
                        Caption = 'Exclude G/L Account No. Filter';
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            GLAccList: Page 18;
                            T15_Loc: Record 15;
                        begin
                            GLAccList.LOOKUPMODE(TRUE);
                            GLAccList.SETTABLEVIEW(T15_Loc);
                            IF GLAccList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                GLAccList.GETRECORD(T15_Loc);
                                ExcludeGLAccountNo := GLAccList.GetSelectionFilter;
                            END;
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            CLEAR(ExcludeGLAccountNo);
        end;
    }

    labels
    {
        PostingDateCaption = 'Posting Date';
        DocNoCaption = 'Document No.';
        DescCaption = 'Description';
        VATAmtCaption = 'VAT Amount';
        EntryNoCaption = 'Entry No.';
    }

    trigger OnPreReport()
    begin
        GLFilter := "G/L Account".GETFILTERS;
        GLDateFilter := "G/L Account".GETFILTER("Date Filter");
    end;

    var
        Text000: Label 'Period: %1';
        GLDateFilter: Text[30];
        GLFilter: Text;
        GLBalance: Decimal;
        StartBalance: Decimal;
        PrintOnlyOnePerPage: Boolean;
        ExcludeBalanceOnly: Boolean;
        PrintClosingEntries: Boolean;
        PrintOnlyCorrections: Boolean;
        PrintReversedEntries: Boolean;
        PageGroupNo: Integer;
        GLEntryPage: Record 17;
        ClosingEntry: Boolean;
        DetailTrialBalCaptionLbl: Label 'Detail Trial Balance';
        PageCaptionLbl: Label 'Page';
        BalanceCaptionLbl: Label 'This also includes general ledger accounts that only have a balance.';
        PeriodCaptionLbl: Label 'This report also includes closing entries within the period.';
        OnlyCorrectionsCaptionLbl: Label 'Only corrections are included.';
        NetChangeCaptionLbl: Label 'Net Change';
        GLEntryDebitAmtCaptionLbl: Label 'Debit';
        GLEntryCreditAmtCaptionLbl: Label 'Credit';
        GLBalCaptionLbl: Label 'Balance';
        ExcludeGLAccountNo: Text;
        GLAccount: Record 15;
        T15: Record 15;

    procedure InitializeRequest(NewPrintOnlyOnePerPage: Boolean; NewExcludeBalanceOnly: Boolean; NewPrintClosingEntries: Boolean; NewPrintReversedEntries: Boolean; NewPrintOnlyCorrections: Boolean)
    begin
        PrintOnlyOnePerPage := NewPrintOnlyOnePerPage;
        ExcludeBalanceOnly := NewExcludeBalanceOnly;
        PrintClosingEntries := NewPrintClosingEntries;
        PrintReversedEntries := NewPrintReversedEntries;
        PrintOnlyCorrections := NewPrintOnlyCorrections;
    end;
}

