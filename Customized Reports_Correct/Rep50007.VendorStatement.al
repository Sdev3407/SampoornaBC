report 50007 "Vendor Statement"
{
    Caption = 'Vendor Statement Report';
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\VendorStatement.rdl';

    dataset
    {
        dataitem("Vendor"; "Vendor")
        {
            //The property 'DataItemTableView' shouldn't have an empty value.
            //DataItemTableView = '';
            RequestFilterFields = "No.";
            column(Companyinfpicture; Companyinf.Picture)
            {
            }
            column(No_Cust; "No.")
            {
            }
            column(Vendor_Phone_No; Vendor."Phone No.")
            {
            }
            dataitem(DataItem5444; 2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                PrintOnlyIfDetail = true;
                column(CompanyInfo1Picture; CompanyInfo1.Picture)
                {
                }
                column(CompanyInfo2Picture; CompanyInfo2.Picture)
                {
                }
                column(CompanyInfo3Picture; CompanyInfo3.Picture)
                {
                }
                column(CustAddr1; CustAddr[1])
                {
                }
                column(CompanyAddr1; CompanyAddr[1])
                {
                }
                column(CustAddr2; CustAddr[2])
                {
                }
                column(CompanyAddr2; CompanyAddr[2])
                {
                }
                column(CustAddr3; CustAddr[3])
                {
                }
                column(CompanyAddr3; CompanyAddr[3])
                {
                }
                column(CustAddr4; CustAddr[4])
                {
                }
                column(CompanyAddr4; CompanyAddr[4])
                {
                }
                column(CustAddr5; CustAddr[5])
                {
                }
                column(PhoneNo_CompanyInfo; CompanyInfo."Phone No.")
                {
                }
                column(CustAddr6; CustAddr[6])
                {
                }
                column(CompanyInfoEmail; CompanyInfo."E-Mail")
                {
                }
                column(CompanyInfoHomePage; CompanyInfo."Home Page")
                {
                }
                column(VATRegNo_CompanyInfo; CompanyInfo."VAT Registration No.")
                {
                }
                column(GiroNo_CompanyInfo; CompanyInfo."Giro No.")
                {
                }
                column(BankName_CompanyInfo; CompanyInfo."Bank Name")
                {
                }
                column(BankAccNo_CompanyInfo; CompanyInfo."Bank Account No.")
                {
                }
                column(No1_Cust; Vendor."No.")
                {
                }
                column(TodayFormatted; FORMAT(TODAY))
                {
                }
                column(StartDate; FORMAT(StartDate))
                {
                }
                column(EndDate; FORMAT(EndDate))
                {
                }
                column(LastStatmntNo_Cust; '')
                {
                    //DecimalPlaces = 0 : 0;
                }
                column(CustAddr7; CustAddr[7])
                {
                }
                column(CustAddr8; CustAddr[8])
                {
                }
                column(CompanyAddr7; CompanyAddr[7])
                {
                }
                column(CompanyAddr8; CompanyAddr[8])
                {
                }
                column(StatementCaption; StatementCaptionLbl)
                {
                }
                column(PhoneNo_CompanyInfoCaption; PhoneNo_CompanyInfoCaptionLbl)
                {
                }
                column(VATRegNo_CompanyInfoCaption; VATRegNo_CompanyInfoCaptionLbl)
                {
                }
                column(GiroNo_CompanyInfoCaption; GiroNo_CompanyInfoCaptionLbl)
                {
                }
                column(BankName_CompanyInfoCaption; BankName_CompanyInfoCaptionLbl)
                {
                }
                column(BankAccNo_CompanyInfoCaption; BankAccNo_CompanyInfoCaptionLbl)
                {
                }
                column(No1_CustCaption; No1_CustCaptionLbl)
                {
                }
                column(StartDateCaption; StartDateCaptionLbl)
                {
                }
                column(EndDateCaption; EndDateCaptionLbl)
                {
                }
                column(LastStatmntNo_CustCaption; '')
                {
                }
                column(PostDate_DtldCustLedgEntriesCaption; PostDate_DtldCustLedgEntriesCaptionLbl)
                {
                }
                column(DocNo_DtldCustLedgEntriesCaption; DtldCustLedgEntries.FIELDCAPTION("Document No."))
                {
                }
                column(Desc_CustLedgEntry2Caption; CustLedgEntry2.FIELDCAPTION(Description))
                {
                }
                column(DueDate_CustLedgEntry2Caption; DueDate_CustLedgEntry2CaptionLbl)
                {
                }
                column(RemainAmtCustLedgEntry2Caption; CustLedgEntry2.FIELDCAPTION("Remaining Amount"))
                {
                }
                column(CustBalanceCaption; CustBalanceCaptionLbl)
                {
                }
                column(OriginalAmt_CustLedgEntry2Caption; CustLedgEntry2.FIELDCAPTION("Original Amount"))
                {
                }
                column(CompanyInfoHomepageCaption; CompanyInfoHomepageCaptionLbl)
                {
                }
                column(CompanyInfoEmailCaption; CompanyInfoEmailCaptionLbl)
                {
                }
                column(DocDateCaption; DocDateCaptionLbl)
                {
                }
                column(Total_Caption2; Total_CaptionLbl)
                {
                }
                column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
                {
                }
                dataitem(CurrencyLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = FILTER(1 ..));
                    PrintOnlyIfDetail = true;
                    dataitem(CustLedgEntryHdr; 2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(Currency2Code_CustLedgEntryHdr; STRSUBSTNO(Text001, CurrencyCode3))
                        {
                        }
                        column(StartBalance; StartBalance)
                        {
                            AutoFormatExpression = Currency2.Code;
                            AutoFormatType = 1;
                        }
                        column(CurrencyCode3; CurrencyCode3)
                        {
                        }
                        column(CustBalance_CustLedgEntryHdr; CustBalance)
                        {
                        }
                        column(PrintLine; PrintLine)
                        {
                        }
                        column(DtldCustLedgEntryType; FORMAT(DtldCustLedgEntries."Entry Type", 0, 2))
                        {
                        }
                        column(EntriesExists; EntriesExists)
                        {
                        }
                        column(IsNewCustCurrencyGroup; IsNewCustCurrencyGroup)
                        {
                        }
                        dataitem(DtldCustLedgEntries; 380)
                        {
                            DataItemTableView = SORTING("Vendor No.", "Posting Date", "Entry Type", "Currency Code");
                            column(PostDate_DtldCustLedgEntries; "Posting Date")
                            {
                            }
                            column(DocNo_DtldCustLedgEntries; "Document No.")
                            {
                            }
                            column(Description; Description)
                            {
                            }
                            column(DueDate_DtldCustLedgEntries; FORMAT("Due Date"))
                            {
                            }
                            column(CurrCode_DtldCustLedgEntries; "Currency Code")
                            {
                            }
                            column(Amt_DtldCustLedgEntries; Amount)
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(RemainAmt_DtldCustLedgEntries; "Remaining Amount")
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(CustBalance; CustBalance)
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(Currency2Code; Currency2.Code)
                            {
                            }
                            column(Ext; Ext)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                //>>PRU_HM
                                VdrLedgerEty.RESET;
                                VdrLedgerEty.SETRANGE("Vendor No.", "Vendor No.");
                                VdrLedgerEty.SETRANGE("Entry No.", DtldCustLedgEntries."Vendor Ledger Entry No.");
                                IF VdrLedgerEty.FINDFIRST THEN
                                    Ext := VdrLedgerEty."External Document No.";
                                //<<PRU_HM

                                IF SkipReversedUnapplied(DtldCustLedgEntries) OR (Amount = 0) THEN
                                    CurrReport.SKIP;
                                "Remaining Amount" := 0;
                                PrintLine := TRUE;
                                CASE "Entry Type" OF
                                    "Entry Type"::"Initial Entry":
                                        BEGIN
                                            "Cust. Ledger Entry".GET("Vendor Ledger Entry No.");
                                            Description := "Cust. Ledger Entry".Description;
                                            "Due Date" := "Cust. Ledger Entry"."Due Date";
                                            "Cust. Ledger Entry".SETRANGE("Date Filter", 0D, EndDate);
                                            "Cust. Ledger Entry".CALCFIELDS("Remaining Amount");
                                            "Remaining Amount" := "Cust. Ledger Entry"."Remaining Amount";
                                            "Cust. Ledger Entry".SETRANGE("Date Filter");
                                        END;
                                    "Entry Type"::Application:
                                        BEGIN
                                            DtldCustLedgEntries2.SETCURRENTKEY("Posting Date");
                                            DtldCustLedgEntries2.SETRANGE("Vendor No.", "Vendor No.");
                                            DtldCustLedgEntries2.SETRANGE("Posting Date", "Posting Date");
                                            DtldCustLedgEntries2.SETRANGE("Entry Type", "Entry Type"::Application);
                                            DtldCustLedgEntries2.SETRANGE("Transaction No.", "Transaction No.");
                                            DtldCustLedgEntries2.SETFILTER("Currency Code", '<>%1', "Currency Code");
                                            IF NOT DtldCustLedgEntries2.ISEMPTY THEN BEGIN
                                                Description := Text005;
                                                "Due Date" := 0D;
                                            END ELSE
                                                PrintLine := FALSE;
                                        END;
                                    "Entry Type"::"Payment Discount",
                                    "Entry Type"::"Payment Discount (VAT Excl.)",
                                    "Entry Type"::"Payment Discount (VAT Adjustment)",
                                    "Entry Type"::"Payment Discount Tolerance",
                                    "Entry Type"::"Payment Discount Tolerance (VAT Excl.)",
                                    "Entry Type"::"Payment Discount Tolerance (VAT Adjustment)":
                                        BEGIN
                                            Description := Text006;
                                            "Due Date" := 0D;
                                        END;
                                    "Entry Type"::"Payment Tolerance",
                                    "Entry Type"::"Payment Tolerance (VAT Excl.)",
                                    "Entry Type"::"Payment Tolerance (VAT Adjustment)":
                                        BEGIN
                                            Description := Text014;
                                            "Due Date" := 0D;
                                        END;
                                    "Entry Type"::"Appln. Rounding",
                                    "Entry Type"::"Correction of Remaining Amount":
                                        BEGIN
                                            Description := Text007;
                                            "Due Date" := 0D;
                                        END;
                                END;

                                IF PrintLine THEN BEGIN
                                    CustBalance := CustBalance + Amount;
                                    IsNewCustCurrencyGroup := IsFirstPrintLine;
                                    IsFirstPrintLine := FALSE;
                                    ClearCompanyPicture;
                                END;
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE("Vendor No.", Vendor."No.");
                                SETRANGE("Posting Date", StartDate, EndDate);
                                SETRANGE("Currency Code", Currency2.Code);

                                IF Currency2.Code = '' THEN BEGIN
                                    GLSetup.TESTFIELD("LCY Code");
                                    CurrencyCode3 := GLSetup."LCY Code"
                                END ELSE
                                    CurrencyCode3 := Currency2.Code;

                                IsFirstPrintLine := TRUE;
                            end;
                        }
                    }
                    dataitem(CustLedgEntryFooter; 2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(CurrencyCode3_CustLedgEntryFooter; CurrencyCode3)
                        {
                        }
                        column(Total_Caption; Total_CaptionLbl)
                        {
                        }
                        column(CustBalance_CustLedgEntryHdrFooter; CustBalance)
                        {
                            AutoFormatExpression = Currency2.Code;
                            AutoFormatType = 1;
                        }
                        column(EntriesExistsl_CustLedgEntryFooterCaption; EntriesExists)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            ClearCompanyPicture;
                        end;
                    }
                    dataitem(CustLedgEntry2; 25)
                    {
                        DataItemLink = "Vendor No." = FIELD("No.");
                        DataItemLinkReference = Vendor;
                        DataItemTableView = SORTING("Posting Date");
                        column(ExternalDocumentNo_CustLedgEntry2; CustLedgEntry2."External Document No.")
                        {
                        }
                        column(OverDueEntries; STRSUBSTNO(Text002, Currency2.Code))
                        {
                        }
                        column(RemainAmt_CustLedgEntry2; "Remaining Amount")
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PostDate_CustLedgEntry2; FORMAT("Posting Date"))
                        {
                        }
                        column(DocNo_CustLedgEntry2; "Document No.")
                        {
                        }
                        column(Desc_CustLedgEntry2; Description)
                        {
                        }
                        column(DueDate_CustLedgEntry2; FORMAT("Due Date"))
                        {
                        }
                        column(OriginalAmt_CustLedgEntry2; "Original Amount")
                        {
                            AutoFormatExpression = "Currency Code";
                        }
                        column(CurrCode_CustLedgEntry2; "Currency Code")
                        {
                        }
                        column(PrintEntriesDue; PrintEntriesDue)
                        {
                        }
                        column(Currency2Code_CustLedgEntry2; Currency2.Code)
                        {
                        }
                        column(CurrencyCode3_CustLedgEntry2; CurrencyCode3)
                        {
                        }
                        column(CustNo_CustLedgEntry2; "Vendor No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        var
                            CustLedgEntry: Record 25;
                        begin
                            //PRU_HM
                            //Ext := CustLedgEntry2."External Document No.";

                            //PRU_HM
                            IF IncludeAgingBand THEN BEGIN
                                IF ("Posting Date" > EndDate) AND ("Due Date" >= EndDate) THEN
                                    CurrReport.SKIP;
                                IF DateChoice = DateChoice::"Due Date" THEN
                                    IF "Due Date" >= EndDate THEN
                                        CurrReport.SKIP;
                            END;
                            CustLedgEntry := CustLedgEntry2;
                            CustLedgEntry.SETRANGE("Date Filter", 0D, EndDate);
                            CustLedgEntry.CALCFIELDS("Remaining Amount");
                            "Remaining Amount" := CustLedgEntry."Remaining Amount";
                            IF CustLedgEntry."Remaining Amount" = 0 THEN
                                CurrReport.SKIP;

                            IF IncludeAgingBand AND ("Posting Date" <= EndDate) THEN
                                UpdateBuffer(Currency2.Code, GetDate("Posting Date", "Due Date"), "Remaining Amount");
                            IF "Due Date" >= EndDate THEN
                                CurrReport.SKIP;

                            ClearCompanyPicture;
                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.CREATETOTALS("Remaining Amount");
                            IF NOT IncludeAgingBand THEN
                                SETRANGE("Due Date", 0D, EndDate - 1);
                            SETRANGE("Currency Code", Currency2.Code);
                            IF (NOT PrintEntriesDue) AND (NOT IncludeAgingBand) THEN
                                CurrReport.BREAK;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF Number = 1 THEN
                            Currency2.FINDFIRST;

                        REPEAT
                            IF NOT IsFirstLoop THEN
                                IsFirstLoop := TRUE
                            ELSE
                                IF Currency2.NEXT = 0 THEN
                                    CurrReport.BREAK;
                            "Cust. Ledger Entry".SETCURRENTKEY("Posting Date");
                            "Cust. Ledger Entry".SETRANGE("Vendor No.", Vendor."No.");
                            "Cust. Ledger Entry".SETRANGE("Posting Date", 0D, EndDate);
                            "Cust. Ledger Entry".SETRANGE("Currency Code", Currency2.Code);
                            EntriesExists := NOT "Cust. Ledger Entry".ISEMPTY;
                        UNTIL EntriesExists;
                        Cust2 := Vendor;
                        Cust2.SETRANGE("Date Filter", 0D, StartDate - 1);
                        Cust2.SETRANGE("Currency Filter", Currency2.Code);
                        Cust2.CALCFIELDS("Net Change");
                        StartBalance := -Cust2."Net Change";
                        CustBalance := -Cust2."Net Change";
                    end;

                    trigger OnPreDataItem()
                    begin
                        Vendor.COPYFILTER("Currency Filter", Currency2.Code);
                    end;
                }
                dataitem(AgingBandLoop; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = FILTER(1 ..));
                    column(AgingDate1; FORMAT(AgingDate[1] + 1))
                    {
                    }
                    column(AgingDate2; FORMAT(AgingDate[2]))
                    {
                    }
                    column(AgingDate21; FORMAT(AgingDate[2] + 1))
                    {
                    }
                    column(AgingDate3; FORMAT(AgingDate[3]))
                    {
                    }
                    column(AgingDate31; FORMAT(AgingDate[3] + 1))
                    {
                    }
                    column(AgingDate4; FORMAT(AgingDate[4]))
                    {
                    }
                    column(AgingBandEndingDate; STRSUBSTNO(Text011, AgingBandEndingDate, PeriodLength, SELECTSTR(DateChoice + 1, Text013)))
                    {
                    }
                    column(AgingDate41; FORMAT(AgingDate[4] + 1))
                    {
                    }
                    column(AgingDate5; FORMAT(AgingDate[5]))
                    {
                    }
                    column(AgingBandBufCol1Amt; AgingBandBuf."Column 1 Amt.")
                    {
                        AutoFormatExpression = AgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandBufCol2Amt; AgingBandBuf."Column 2 Amt.")
                    {
                        AutoFormatExpression = AgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandBufCol3Amt; AgingBandBuf."Column 3 Amt.")
                    {
                        AutoFormatExpression = AgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandBufCol4Amt; AgingBandBuf."Column 4 Amt.")
                    {
                        AutoFormatExpression = AgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandBufCol5Amt; AgingBandBuf."Column 5 Amt.")
                    {
                        AutoFormatExpression = AgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandCurrencyCode; AgingBandCurrencyCode)
                    {
                    }
                    column(beforeCaption; beforeCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF Number = 1 THEN BEGIN
                            ClearCompanyPicture;
                            IF NOT AgingBandBuf.FIND('-') THEN
                                CurrReport.BREAK;
                        END ELSE
                            IF AgingBandBuf.NEXT = 0 THEN
                                CurrReport.BREAK;
                        AgingBandCurrencyCode := AgingBandBuf."Currency Code";
                        IF AgingBandCurrencyCode = '' THEN
                            AgingBandCurrencyCode := GLSetup."LCY Code";
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF NOT IncludeAgingBand THEN
                            CurrReport.BREAK;
                    end;
                }
            }

            trigger OnAfterGetRecord()
            begin
                /*Currency2.DELETEALL;
                IF NOT Currency2.GET(Vendor."Currency Code") THEN BEGIN
                Currency2.INIT;
                Currency2.Code := Vendor."Currency Code";
                Currency2.INSERT;
                END;*/
                AgingBandBuf.DELETEALL;
                // CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                PrintLine := FALSE;
                Cust2 := Vendor;
                COPYFILTER("Currency Filter", Currency2.Code);
                IF PrintAllHavingBal THEN BEGIN
                    IF Currency2.FIND('-') THEN
                        REPEAT
                            Cust2.SETRANGE("Date Filter", 0D, EndDate);
                            Cust2.SETRANGE("Currency Filter", Currency2.Code);
                            Cust2.CALCFIELDS("Net Change");
                            PrintLine := Cust2."Net Change" <> 0;
                        UNTIL (Currency2.NEXT = 0) OR PrintLine;
                END;
                IF (NOT PrintLine) AND PrintAllHavingEntry THEN BEGIN
                    "Cust. Ledger Entry".RESET;
                    "Cust. Ledger Entry".SETCURRENTKEY("Posting Date");
                    "Cust. Ledger Entry".SETRANGE("Vendor No.", "No.");
                    "Cust. Ledger Entry".SETRANGE("Posting Date", StartDate, EndDate);
                    COPYFILTER("Currency Filter", "Cust. Ledger Entry"."Currency Code");
                    PrintLine := NOT "Cust. Ledger Entry".ISEMPTY;
                END;
                IF NOT PrintLine THEN
                    CurrReport.SKIP;

                FormatAddr.Vendor(CustAddr, Vendor);
                CurrReport.PAGENO := 1;
                /*
                IF NOT CurrReport.PREVIEW THEN BEGIN
                  LOCKTABLE;
                  FIND;
                  ////"Last Statement No." := "Last Statement No." + 1;
                  MODIFY;
                  COMMIT;
                END ELSE
                  ////"Last Statement No." := "Last Statement No." + 1;
                
                
                IF LogInteraction THEN
                  IF NOT CurrReport.PREVIEW THEN
                    SegManagement.LogDocument(
                      7,FORMAT("Last Statement No."),0,0,DATABASE::Customer,"No.","Salesperson Code",'',
                      Text003 + FORMAT("Last Statement No."),'');
                */
                IsFirstLoop := FALSE;

            end;

            trigger OnPreDataItem()
            begin

                VerifyDates;
                AgingBandEndingDate := EndDate;
                CalcAgingBandDates;

                CompanyInfo.GET;
                FormatAddr.Company(CompanyAddr, CompanyInfo);

                Currency2.Code := '';
                Currency2.INSERT;
                COPYFILTER("Currency Filter", Currency.Code);
                IF Currency.FIND('-') THEN
                    REPEAT
                        Currency2 := Currency;
                        Currency2.INSERT;
                    UNTIL Currency.NEXT = 0;
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
                    field("Start Date"; StartDate)
                    {
                        Caption = 'Start Date';
                        ApplicationArea = All;
                    }
                    field("End Date"; EndDate)
                    {
                        Caption = 'End Date';
                        ApplicationArea = All;
                    }
                    field(ShowOverdueEntries; PrintEntriesDue)
                    {
                        Caption = 'Show Overdue Entries';
                        ApplicationArea = All;
                    }
                    group(Include)
                    {
                        Caption = 'Include';
                        field(IncludeAllCustomerswithLE; PrintAllHavingEntry)
                        {
                            Caption = 'Include All Vendor with Ledger Entries';
                            MultiLine = true;
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                IF NOT PrintAllHavingEntry THEN
                                    PrintAllHavingBal := TRUE;
                            end;
                        }
                        field(IncludeAllCustomerswithBalance; PrintAllHavingBal)
                        {
                            Caption = 'Include All Vendor with a Balance';
                            MultiLine = true;
                            ApplicationArea = All;
                            trigger OnValidate()
                            begin
                                IF NOT PrintAllHavingBal THEN
                                    PrintAllHavingEntry := TRUE;
                            end;
                        }
                        field(IncludeReversedEntries; PrintReversedEntries)
                        {
                            Caption = 'Include Reversed Entries';
                            ApplicationArea = All;
                        }
                        field(IncludeUnappliedEntries; PrintUnappliedEntries)
                        {
                            Caption = 'Include Unapplied Entries';
                            ApplicationArea = All;
                        }
                    }
                    group("Aging Band")
                    {
                        Caption = 'Aging Band';
                        field(IncludeAgingBand; IncludeAgingBand)
                        {
                            Caption = 'Include Aging Band';
                            ApplicationArea = All;
                        }
                        field(AgingBandPeriodLengt; PeriodLength)
                        {
                            Caption = 'Aging Band Period Length';
                            ApplicationArea = All;
                        }
                        field(AgingBandby; DateChoice)
                        {
                            Caption = 'Aging Band by';
                            OptionCaption = 'Due Date,Posting Date';
                            ApplicationArea = All;
                        }
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ApplicationArea = All;
                    }
                }
                group("Output Options")
                {
                    Caption = 'Output Options';
                    Visible = false;

                    field(ReportOutput; SupportedOutputMethod)
                    {
                        Caption = 'Report Output';
                        OptionCaption = 'Print,Preview,PDF,Email,Excel,XML';
                        ApplicationArea = All;

                        trigger OnValidate()
                        var
                            CustomLayoutReporting: Codeunit 8800;
                        begin
                            ShowPrintRemaining := (SupportedOutputMethod = SupportedOutputMethod::Email);

                            CASE SupportedOutputMethod OF
                                SupportedOutputMethod::Print:
                                    ChosenOutputMethod := CustomLayoutReporting.GetPrintOption;
                                SupportedOutputMethod::Preview:
                                    ChosenOutputMethod := CustomLayoutReporting.GetPreviewOption;
                                SupportedOutputMethod::PDF:
                                    ChosenOutputMethod := CustomLayoutReporting.GetPDFOption;
                                SupportedOutputMethod::Email:
                                    ChosenOutputMethod := CustomLayoutReporting.GetEmailOption;
                                SupportedOutputMethod::Excel:
                                    ChosenOutputMethod := CustomLayoutReporting.GetExcelOption;
                                SupportedOutputMethod::XML:
                                    ChosenOutputMethod := CustomLayoutReporting.GetXMLOption;
                            END;
                        end;
                    }
                    field(ChosenOutput; ChosenOutputMethod)
                    {
                        Caption = 'Chosen Output';
                        Visible = false;
                        ApplicationArea = All;
                    }
                    group(EmailOptions)
                    {
                        Caption = 'Email Options';
                        Visible = ShowPrintRemaining;

                        field(PrintMissingAddresses; PrintRemaining)
                        {
                            Caption = 'Print remaining statements';
                            ApplicationArea = All;
                        }
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            InitRequestPageDataInternal;
            SupportedOutputMethod := SupportedOutputMethod::Preview;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET;
        SalesSetup.GET;

        CASE SalesSetup."Logo Position on Documents" OF
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                BEGIN
                    CompanyInfo1.GET;
                    CompanyInfo1.CALCFIELDS(Picture);
                END;
            SalesSetup."Logo Position on Documents"::Center:
                BEGIN
                    CompanyInfo2.GET;
                    CompanyInfo2.CALCFIELDS(Picture);
                END;
            SalesSetup."Logo Position on Documents"::Right:
                BEGIN
                    CompanyInfo3.GET;
                    CompanyInfo3.CALCFIELDS(Picture);
                END;
        END;

        LogInteractionEnable := TRUE;
    end;

    trigger OnPreReport()
    begin
        InitRequestPageDataInternal;
        Companyinf.GET;
        Companyinf.CALCFIELDS(Companyinf.Picture);
    end;

    var
        Text001: Label 'Entries %1';
        Text002: Label 'Overdue Entries %1';
        Text003: Label 'Statement ';
        GLSetup: Record 98;
        SalesSetup: Record 311;
        CompanyInfo: Record 79;
        CompanyInfo1: Record 79;
        CompanyInfo2: Record 79;
        CompanyInfo3: Record 79;
        Cust2: Record 23;
        Currency: Record 4;
        Currency2: Record 4 temporary;
        Language: Record 8;
        "Cust. Ledger Entry": Record 25;
        DtldCustLedgEntries2: Record 380;
        AgingBandBuf: Record 47 temporary;
        PrintAllHavingEntry: Boolean;
        PrintAllHavingBal: Boolean;
        PrintEntriesDue: Boolean;
        PrintUnappliedEntries: Boolean;
        PrintReversedEntries: Boolean;
        PrintLine: Boolean;
        LogInteraction: Boolean;
        EntriesExists: Boolean;
        StartDate: Date;
        EndDate: Date;
        "Due Date": Date;
        CustAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        Description: Text[100];
        StartBalance: Decimal;
        CustBalance: Decimal;
        "Remaining Amount": Decimal;
        FormatAddr: Codeunit 365;
        SegManagement: Codeunit 5051;
        CurrencyCode3: Code[10];
        Text005: Label 'Multicurrency Application';
        Text006: Label 'Payment Discount';
        Text007: Label 'Rounding';
        PeriodLength: DateFormula;
        PeriodLength2: DateFormula;
        DateChoice: Option "Due Date","Posting Date";
        AgingDate: array[5] of Date;
        Text008: Label 'You must specify the Aging Band Period Length.';
        AgingBandEndingDate: Date;
        Text010: Label 'You must specify Aging Band Ending Date.';
        Text011: Label 'Aged Summary by %1 (%2 by %3)';
        IncludeAgingBand: Boolean;
        Text012: Label 'Period Length is out of range.';
        AgingBandCurrencyCode: Code[20];
        Text013: Label 'Due Date,Posting Date';
        Text014: Label 'Application Writeoffs';
        [InDataSet]
        LogInteractionEnable: Boolean;
        Text036: Label '-%1', Comment = 'Negating the period length: %1 is the period length';
        StatementCaptionLbl: Label 'Statement';
        PhoneNo_CompanyInfoCaptionLbl: Label 'Phone No.';
        VATRegNo_CompanyInfoCaptionLbl: Label 'VAT Registration No.';
        GiroNo_CompanyInfoCaptionLbl: Label 'Giro No.';
        BankName_CompanyInfoCaptionLbl: Label 'Bank';
        BankAccNo_CompanyInfoCaptionLbl: Label 'Account No.';
        No1_CustCaptionLbl: Label 'Customer No.';
        StartDateCaptionLbl: Label 'Starting Date';
        EndDateCaptionLbl: Label 'Ending Date';
        LastStatmntNo_CustCaptionLbl: Label '''''';
        PostDate_DtldCustLedgEntriesCaptionLbl: Label 'Posting Date';
        DueDate_CustLedgEntry2CaptionLbl: Label 'Due Date';
        CustBalanceCaptionLbl: Label 'Balance';
        beforeCaptionLbl: Label '..before';
        isInitialized: Boolean;
        CompanyInfoHomepageCaptionLbl: Label 'Home Page';
        CompanyInfoEmailCaptionLbl: Label 'E-Mail';
        DocDateCaptionLbl: Label 'Document Date';
        Total_CaptionLbl: Label 'Total';
        BlankStartDateErr: Label 'Start Date must have a value.';
        BlankEndDateErr: Label 'End Date must have a value.';
        StartDateLaterTheEndDateErr: Label 'Start date must be earlier than End date.';
        IsFirstLoop: Boolean;
        CurrReportPageNoCaptionLbl: Label 'Page';
        IsFirstPrintLine: Boolean;
        IsNewCustCurrencyGroup: Boolean;
        SupportedOutputMethod: Option Print,Preview,PDF,Email,Excel,XML;
        ChosenOutputMethod: Integer;
        PrintRemaining: Boolean;
        [InDataSet]
        ShowPrintRemaining: Boolean;
        FirstCustomerPrinted: Boolean;
        Companyinf: Record 79;
        Ext: Code[50];
        VdrLedgerEty: Record 25;

    local procedure GetDate(PostingDate: Date; DueDate: Date): Date
    begin
        IF DateChoice = DateChoice::"Posting Date" THEN
            EXIT(PostingDate);

        EXIT(DueDate);
    end;

    local procedure CalcAgingBandDates()
    begin
        IF NOT IncludeAgingBand THEN
            EXIT;
        IF AgingBandEndingDate = 0D THEN
            ERROR(Text010);
        IF FORMAT(PeriodLength) = '' THEN
            ERROR(Text008);
        EVALUATE(PeriodLength2, STRSUBSTNO(Text036, PeriodLength));
        AgingDate[5] := AgingBandEndingDate;
        AgingDate[4] := CALCDATE(PeriodLength2, AgingDate[5]);
        AgingDate[3] := CALCDATE(PeriodLength2, AgingDate[4]);
        AgingDate[2] := CALCDATE(PeriodLength2, AgingDate[3]);
        AgingDate[1] := CALCDATE(PeriodLength2, AgingDate[2]);
        IF AgingDate[2] <= AgingDate[1] THEN
            ERROR(Text012);
    end;

    local procedure UpdateBuffer(CurrencyCode: Code[10]; Date: Date; Amount: Decimal)
    var
        I: Integer;
        GoOn: Boolean;
    begin
        AgingBandBuf.INIT;
        AgingBandBuf."Currency Code" := CurrencyCode;
        IF NOT AgingBandBuf.FIND THEN
            AgingBandBuf.INSERT;
        I := 1;
        GoOn := TRUE;
        WHILE (I <= 5) AND GoOn DO BEGIN
            IF Date <= AgingDate[I] THEN
                IF I = 1 THEN BEGIN
                    AgingBandBuf."Column 1 Amt." := AgingBandBuf."Column 1 Amt." + Amount;
                    GoOn := FALSE;
                END;
            IF Date <= AgingDate[I] THEN
                IF I = 2 THEN BEGIN
                    AgingBandBuf."Column 2 Amt." := AgingBandBuf."Column 2 Amt." + Amount;
                    GoOn := FALSE;
                END;
            IF Date <= AgingDate[I] THEN
                IF I = 3 THEN BEGIN
                    AgingBandBuf."Column 3 Amt." := AgingBandBuf."Column 3 Amt." + Amount;
                    GoOn := FALSE;
                END;
            IF Date <= AgingDate[I] THEN
                IF I = 4 THEN BEGIN
                    AgingBandBuf."Column 4 Amt." := AgingBandBuf."Column 4 Amt." + Amount;
                    GoOn := FALSE;
                END;
            IF Date <= AgingDate[I] THEN
                IF I = 5 THEN BEGIN
                    AgingBandBuf."Column 5 Amt." := AgingBandBuf."Column 5 Amt." + Amount;
                    GoOn := FALSE;
                END;
            I := I + 1;
        END;
        AgingBandBuf.MODIFY;
    end;


    procedure SkipReversedUnapplied(var DtldCustLedgEntries: Record 380): Boolean
    var
        CustLedgEntry: Record 25;
    begin
        IF PrintReversedEntries AND PrintUnappliedEntries THEN
            EXIT(FALSE);
        IF NOT PrintUnappliedEntries THEN
            IF DtldCustLedgEntries.Unapplied THEN
                EXIT(TRUE);
        IF NOT PrintReversedEntries THEN BEGIN
            CustLedgEntry.GET(DtldCustLedgEntries."Vendor Ledger Entry No.");
            IF CustLedgEntry.Reversed THEN
                EXIT(TRUE);
        END;
        EXIT(FALSE);
    end;


    procedure InitializeRequest(NewPrintEntriesDue: Boolean; NewPrintAllHavingEntry: Boolean; NewPrintAllHavingBal: Boolean; NewPrintReversedEntries: Boolean; NewPrintUnappliedEntries: Boolean; NewIncludeAgingBand: Boolean; NewPeriodLength: Text[30]; NewDateChoice: Option; NewLogInteraction: Boolean; NewStartDate: Date; NewEndDate: Date)
    begin
        InitRequestPageDataInternal;

        PrintEntriesDue := NewPrintEntriesDue;
        PrintAllHavingEntry := NewPrintAllHavingEntry;
        PrintAllHavingBal := NewPrintAllHavingBal;
        PrintReversedEntries := NewPrintReversedEntries;
        PrintUnappliedEntries := NewPrintUnappliedEntries;
        IncludeAgingBand := NewIncludeAgingBand;
        EVALUATE(PeriodLength, NewPeriodLength);
        DateChoice := NewDateChoice;
        LogInteraction := NewLogInteraction;
        StartDate := NewStartDate;
        EndDate := NewEndDate;
    end;

    procedure InitRequestPageDataInternal()
    begin
        IF isInitialized THEN
            EXIT;

        isInitialized := TRUE;

        IF (NOT PrintAllHavingEntry) AND (NOT PrintAllHavingBal) THEN
            PrintAllHavingBal := TRUE;

        LogInteraction := SegManagement.FindInteractTmplCode(7) <> '';
        LogInteractionEnable := LogInteraction;

        IF FORMAT(PeriodLength) = '' THEN
            EVALUATE(PeriodLength, '<1M+CM>');

        ShowPrintRemaining := (SupportedOutputMethod = SupportedOutputMethod::Email);
    end;

    local procedure VerifyDates()
    begin
        IF StartDate = 0D THEN
            ERROR(BlankStartDateErr);
        IF EndDate = 0D THEN
            ERROR(BlankEndDateErr);
        IF StartDate > EndDate THEN
            ERROR(StartDateLaterTheEndDateErr);
    end;

    local procedure ClearCompanyPicture()
    begin
        IF FirstCustomerPrinted THEN BEGIN
            CLEAR(CompanyInfo.Picture);
            CLEAR(CompanyInfo1.Picture);
            CLEAR(CompanyInfo2.Picture);
            CLEAR(CompanyInfo3.Picture);
        END;
        FirstCustomerPrinted := TRUE;
    end;
}

