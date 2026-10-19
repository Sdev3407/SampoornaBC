report 50098 "Posted Voucher1"
{
    // // PRU_AS : Added Purch. Comment Line in layout, Also code for Purch. comment line, comment visibility conditions.
    // // PRU_AS - 16 JULY 2019 : Added  Voucher No., External document number and Date on Right Side.
    // // PRU_AS - 16 JULY 2019 : Added & Done Code for LOB, LOC, Branch Code, Description Column with Code and Name (GL/Customer/Vendor), Change Caption Prepared By - User Name.
    // // PRU_AS 22 JULY 2019 : Created Function to Find Source Code & Removed DrText From Layout.
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Posted Voucher';
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\PostedVoucher.rdl';



    dataset
    {
        dataitem("G/L Entry"; 17)
        {
            DataItemTableView = SORTING("Document No.", "Posting Date", Amount)
                                ORDER(Descending);
            RequestFilterFields = "Posting Date", "Document No.";
            column(VoucherSourceDesc; SourceDesc + ' Voucher')
            {
            }
            column(DocumentNo_GLEntry; "Document No.")
            {
            }
            column(PostingDateFormatted; FORMAT("Posting Date"))
            {
            }
            column(CompanyInformationAddress; CompanyInformation.Address + ' ' + CompanyInformation."Address 2" + '  ' + CompanyInformation.City)
            {
            }
            column(CompanyInformationName; CompanyInformation.Name)
            {
            }
            column(CreditAmount_GLEntry; "Credit Amount")
            {
            }
            column(DebitAmount_GLEntry; "Debit Amount")
            {
            }
            column(GLAccountNo_GLEntry; "G/L Entry"."G/L Account No.")
            {
            }
            column(SourceNo_GLEntry; "G/L Entry"."Source No.")
            {
            }
            column(GlobalDimension1Code_GLEntry; "G/L Entry"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_GLEntry; "G/L Entry"."Global Dimension 2 Code")
            {
            }
            column(ShortcutDimension3Code_GLEntry; "G/L Entry"."Shortcut Dimension 3 Code")
            {
            }
            column(UserID_GLEntry; SFPLUserID)
            {
            }
            column(ExtDocNo_GLEntry; "G/L Entry"."External Document No.")
            {
            }
            column(UserNameVal; UserNameVal)
            {
            }
            column(ExtDocVal; ExtDocVal)
            {
            }
            column(DrText; DrText)
            {
            }
            column(GLAccNum; GLAccNum)
            {
            }
            column(GLAccName; GLAccName)
            {
            }
            column(CrText; CrText)
            {
            }
            column(DebitAmountTotal; DebitAmountTotal)
            {
            }
            column(CreditAmountTotal; CreditAmountTotal)
            {
            }
            column(ChequeDetail; 'Cheque No: ' + ChequeNo + '  Dated: ' + FORMAT(ChequeDate))
            {
            }
            column(ChequeNo; ChequeNo)
            {
            }
            column(ChequeDate; ChequeDate)
            {
            }
            column(RsNumberText1NumberText2; 'Rs. ' + NumberText[1] + ' ' + NumberText[2])
            {
            }
            column(EntryNo_GLEntry; "Entry No.")
            {
            }
            column(PostingDate_GLEntry; "Posting Date")
            {
            }
            column(TransactionNo_GLEntry; "Transaction No.")
            {
            }
            column(VoucherNoCaption; VoucherNoCaptionLbl)
            {
            }
            column(CreditAmountCaption; CreditAmountCaptionLbl)
            {
            }
            column(DebitAmountCaption; DebitAmountCaptionLbl)
            {
            }
            column(ParticularsCaption; ParticularsCaptionLbl)
            {
            }
            column(AmountInWordsCaption; AmountInWordsCaptionLbl)
            {
            }
            column(PreparedByCaption; PreparedByCaptionLbl)
            {
            }
            column(CheckedByCaption; CheckedByCaptionLbl)
            {
            }
            column(ApprovedByCaption; ApprovedByCaptionLbl)
            {
            }
            column(BranchCap; BranchCap)
            {
            }
            column(LOBCap; LOBCap)
            {
            }
            column(LOCCap; LOCCap)
            {
            }
            column(ExternalDocCap; ExternalDocCap)
            {
            }
            column(DateCap; DateCap)
            {
            }
            column(CommentCaption; CommentCaption)
            {
            }
            column(Comment; Comment)
            {
            }
            column(LineNarration1_GLEntry; "G/L Entry"."Line Narration1")
            {
            }
            dataitem("Posted Narration"; "Posted Narration")
            {
                DataItemLink = "Transaction No." = FIELD("Transaction No."),
                               "Entry No." = FIELD("Entry No.");
                DataItemTableView = SORTING("Entry No.", "Transaction No.", "Line No.");
                column(Narration_LineNarration; Narration)
                {
                }
                column(PrintLineNarration; PrintLineNarration)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF PrintLineNarration THEN BEGIN
                        PageLoop := PageLoop - 1;
                        LinesPrinted := LinesPrinted + 1;
                    END;
                end;
            }
            dataitem(DataItem5444; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                column(IntegerOccurcesCaption; IntegerOccurcesCaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    PageLoop := PageLoop - 1;
                end;

                trigger OnPreDataItem()
                begin
                    GLEntry.SETCURRENTKEY("Document No.", "Posting Date", Amount);
                    GLEntry.ASCENDING(FALSE);
                    GLEntry.SETRANGE("Posting Date", "G/L Entry"."Posting Date");
                    GLEntry.SETRANGE("Document No.", "G/L Entry"."Document No.");
                    GLEntry.FINDLAST;
                    IF NOT (GLEntry."Entry No." = "G/L Entry"."Entry No.") THEN
                        CurrReport.BREAK;

                    SETRANGE(Number, 1, PageLoop)
                end;
            }
            dataitem(PostedNarration1; "Posted Narration")
            {
                DataItemLink = "Transaction No." = FIELD("Transaction No."),
                               "Entry No." = FIELD("Entry No.");
                DataItemTableView = SORTING("Entry No.", "Transaction No.", "Line No.") WHERE("Entry No." = FILTER(0));
                column(Narration_PostedNarration1; Narration)
                {
                }
                column(NarrationCaption; NarrationCaptionLbl)
                {
                }

                trigger OnPreDataItem()
                begin
                    GLEntry.SETCURRENTKEY("Document No.", "Posting Date", Amount);
                    GLEntry.ASCENDING(FALSE);
                    GLEntry.SETRANGE("Posting Date", "G/L Entry"."Posting Date");
                    GLEntry.SETRANGE("Document No.", "G/L Entry"."Document No.");
                    GLEntry.FINDLAST;
                    IF NOT (GLEntry."Entry No." = "G/L Entry"."Entry No.") THEN
                        CurrReport.BREAK;
                end;
            }
            dataitem("Purch. Comment Line"; 43)
            {
                DataItemLink = "No." = FIELD("Document No.");
                DataItemTableView = WHERE("Document Type" = CONST("Posted Invoice"),
                                          "Document Line No." = CONST(0));
                PrintOnlyIfDetail = false;
                column(No_PurchCommentLine; "Purch. Comment Line"."No.")
                {
                }
                column(Comment_PurchCommentLine; "Purch. Comment Line".Comment)
                {
                }
                column(LineNo_PurchCommentLine; "Purch. Comment Line"."Line No.")
                {
                }
            }

            trigger OnAfterGetRecord()
            var
                GLEntry: Record 17;
                GLEntry1: Record 17;
            begin
                CLEAR(ExtDocVal);
                CLEAR(UserNameVal);
                //Clear(SFPLUserID);

                GLEntry1.Reset();
                GLEntry1.SetRange("Document No.", "Document No.");
                GLEntry1.SetFilter("SFPL User ID", '<>%1', '');
                GLEntry1.SetFilter("User ID", 'JOBQUEUE');
                if GLEntry1.FindFirst() then begin
                    WebUser.Get(GLEntry1."SFPL User ID");
                    UserNameVal := WebUser."Full Name";
                end else
                    UserNameVal := "G/L Entry"."User ID";

                GLAccName := FindGLAccName("Source Type", "Entry No.", "Source No.", "G/L Account No.");
                GLAccNum := FindGLAccNum("Source Type", "Entry No.", "Source No.", "G/L Account No.");// PRU_AS 22 JULY 2019 : Created Function to Find Source Code.

                // PRU_AS : 22 july 2019 - start Code Commented
                IF Amount < 0 THEN BEGIN
                    CrText := 'To';
                    //DrText := ''; // Commented by PRU_AS - 16 JULY 2019
                    DrText := 'Cr'; //  PRU_AS - 16 JULY 2019
                END ELSE BEGIN
                    CrText := '';
                    DrText := 'Dr';
                END;
                // PRU_AS : 22 july 2019 - End Code Commented

                /*SourceDesc := '';
                IF "Source Code" <> '' THEN BEGIN
                  SourceCode.GET("Source Code");
                  SourceDesc := SourceCode.Description;
                END;*/

                PageLoop := PageLoop - 1;
                LinesPrinted := LinesPrinted + 1;

                ChequeNo := '';
                ChequeDate := 0D;
                IF ("Source No." <> '') AND ("Source Type" = "Source Type"::"Bank Account") THEN BEGIN
                    IF BankAccLedgEntry.GET("Entry No.") THEN BEGIN
                        ChequeNo := BankAccLedgEntry."Cheque No.";
                        ChequeDate := BankAccLedgEntry."Cheque Date";
                    END;
                END;

                IF (ChequeNo <> '') AND (ChequeDate <> 0D) THEN BEGIN
                    PageLoop := PageLoop - 1;
                    LinesPrinted := LinesPrinted + 1;
                END;
                IF PostingDate <> "Posting Date" THEN BEGIN
                    PostingDate := "Posting Date";
                    TotalDebitAmt := 0;
                END;
                IF DocumentNo <> "Document No." THEN BEGIN
                    DocumentNo := "Document No.";
                    TotalDebitAmt := 0;
                END;

                // PRU_AS - 16 JULY 2019 START
                /*UserRec.RESET;
                UserRec.SETRANGE("User Name","G/L Entry"."User ID");
                IF UserRec.FINDFIRST THEN
                  UserNameVal := UserRec."Full Name";
                  */

                GLEntry.RESET;
                GLEntry.SETRANGE("Document No.", "G/L Entry"."Document No.");
                GLEntry.SETFILTER("Source Code", '<>%1', 'INVTPCOST');
                GLEntry.SetRange("Posting Date", "G/L Entry"."Posting Date");
                IF GLEntry.FINDFIRST THEN BEGIN
                    // UserRec.RESET;
                    // UserRec.SETRANGE("User Name", GLEntry."User ID");
                    // IF UserRec.FINDFIRST THEN BEGIN
                    //     UserNameVal := UserRec."Full Name";
                    // END;
                    IF GLEntry."Source Code" <> '' THEN BEGIN
                        SourceCode.GET(GLEntry."Source Code");
                        SourceDesc := SourceCode.Description;
                    END;
                END;
                /*GLEntry.RESET;
                GLEntry.SETRANGE("Document No.","G/L Entry"."Document No.");
                IF GLEntry.FINDFIRST THEN BEGIN
                  SalesInvHeaderRec.RESET;
                  SalesInvHeaderRec.SETRANGE("No.","G/L Entry"."Document No.");
                  IF SalesInvHeaderRec.FINDFIRST THEN
                    ExtDocVal := SalesInvHeaderRec."External Document No."
                  ELSE
                    ExtDocVal := '';
                END;*/// Code Commented by PRU_AS 19 JULY 2019
                      // PRU_AS - 16 JULY 2019 END

                IF PostingDate = "Posting Date" THEN BEGIN
                    InitTextVariable;
                    TotalDebitAmt += "Debit Amount";
                    FormatNoText(NumberText, ABS(TotalDebitAmt), '');
                    PageLoop := NUMLines;
                    LinesPrinted := 0;
                END;
                IF (PrePostingDate <> "Posting Date") OR (PreDocumentNo <> "Document No.") THEN BEGIN
                    DebitAmountTotal := 0;
                    CreditAmountTotal := 0;
                    PrePostingDate := "Posting Date";
                    PreDocumentNo := "Document No.";
                END;

                DebitAmountTotal := DebitAmountTotal + "Debit Amount";
                CreditAmountTotal := CreditAmountTotal + "Credit Amount";

            end;

            trigger OnPreDataItem()
            begin
                NUMLines := 13;
                PageLoop := NUMLines;
                LinesPrinted := 0;
                DebitAmountTotal := 0;
                CreditAmountTotal := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    Visible = true;
                    field(PrintLineNarration; PrintLineNarration)
                    {
                        Caption = 'PrintLineNarration';
                    }
                }
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
        CompanyInformation.GET;
    end;

    var
        SFPLUserID: text[50];
        WebUser: Record WebUsers;
        CompanyInformation: Record 79;
        SourceCode: Record 230;
        GLEntry: Record 17;
        BankAccLedgEntry: Record 271;
        GLAccNum: Text[50];
        GLAccName: Text[100];
        SourceDesc: Text[100];
        CrText: Text[2];
        DrText: Text[2];
        NumberText: array[2] of Text[80];
        PageLoop: Integer;
        LinesPrinted: Integer;
        NUMLines: Integer;
        ChequeNo: Code[50];
        ChequeDate: Date;
        Text16526: Label 'ZERO';
        Text16527: Label 'HUNDRED';
        Text16528: Label 'AND';
        Text16529: Label '%1 results in a written number that is too long.';
        Text16532: Label 'ONE';
        Text16533: Label 'TWO';
        Text16534: Label 'THREE';
        Text16535: Label 'FOUR';
        Text16536: Label 'FIVE';
        Text16537: Label 'SIX';
        Text16538: Label 'SEVEN';
        Text16539: Label 'EIGHT';
        Text16540: Label 'NINE';
        Text16541: Label 'TEN';
        Text16542: Label 'ELEVEN';
        Text16543: Label 'TWELVE';
        Text16544: Label 'THIRTEEN';
        Text16545: Label 'FOURTEEN';
        Text16546: Label 'FIFTEEN';
        Text16547: Label 'SIXTEEN';
        Text16548: Label 'SEVENTEEN';
        Text16549: Label 'EIGHTEEN';
        Text16550: Label 'NINETEEN';
        Text16551: Label 'TWENTY';
        Text16552: Label 'THIRTY';
        Text16553: Label 'FORTY';
        Text16554: Label 'FIFTY';
        Text16555: Label 'SIXTY';
        Text16556: Label 'SEVENTY';
        Text16557: Label 'EIGHTY';
        Text16558: Label 'NINETY';
        Text16559: Label 'THOUSAND';
        Text16560: Label 'MILLION';
        Text16561: Label 'BILLION';
        Text16562: Label 'LAKH';
        Text16563: Label 'CRORE';
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        PrintLineNarration: Boolean;
        PostingDate: Date;
        TotalDebitAmt: Decimal;
        DocumentNo: Code[20];
        DebitAmountTotal: Decimal;
        CreditAmountTotal: Decimal;
        PrePostingDate: Date;
        PreDocumentNo: Code[50];
        VoucherNoCaptionLbl: Label 'Voucher No. :';
        CreditAmountCaptionLbl: Label 'Credit Amount';
        DebitAmountCaptionLbl: Label 'Debit Amount';
        ParticularsCaptionLbl: Label 'Particulars';
        AmountInWordsCaptionLbl: Label 'Amount (in words):';
        PreparedByCaptionLbl: Label 'Prepared By';
        CheckedByCaptionLbl: Label 'Checked by:';
        ApprovedByCaptionLbl: Label 'Approved by:';
        IntegerOccurcesCaptionLbl: Label 'IntegerOccurces';
        NarrationCaptionLbl: Label 'Narration :';
        CommentCaption: Label 'Comments :';
        CustRec: Record 18;
        VendRec: Record 23;
        SourceAccName: Text[100];
        ExternalDocCap: Label 'External Doc No:';
        BranchCap: Label 'Branch';
        LOBCap: Label 'LOB';
        LOCCap: Label 'LOC';
        PurchInvHeaderRec: Record 122;
        SalesInvHeaderRec: Record 112;
        ExtDocVal: Text;
        DateCap: Label 'Date:';
        SourceNoVal: Text;
        BankRec: Record 270;
        GLAccRec: Record 15;
        FARec: Record 5600;
        SourceNameVal: Text[100];
        UserNameVal: Text;
        UserRec: Record 2000000120;


    procedure FindGLAccName("Source Type": Option " ",Customer,Vendor,"Bank Account","Fixed Asset"; "Entry No.": Integer; "Source No.": Code[20]; "G/L Account No.": Code[20]): Text[50]
    var
        AccName: Text[100];
        VendLedgerEntry: Record 25;
        Vend: Record 23;
        CustLedgerEntry: Record 21;
        Cust: Record 18;
        BankLedgerEntry: Record 271;
        Bank: Record 270;
        GLAccount: Record 15;
    begin
        IF "Source Type" = "Source Type"::Vendor THEN
            IF VendLedgerEntry.GET("Entry No.") THEN
                IF IsGSTDocument(VendLedgerEntry."Document Type", VendLedgerEntry."Document No.") THEN BEGIN
                    GLAccount.GET("G/L Account No.");
                    AccName := GLAccount.Name;
                END ELSE BEGIN
                    Vend.GET("Source No.");
                    AccName := Vend.Name;
                END
            ELSE BEGIN
                GLAccount.GET("G/L Account No.");
                AccName := GLAccount.Name;
            END
        ELSE
            IF "Source Type" = "Source Type"::Customer THEN
                IF CustLedgerEntry.GET("Entry No.") THEN
                    IF IsGSTDocument(CustLedgerEntry."Document Type", CustLedgerEntry."Document No.") THEN BEGIN
                        GLAccount.GET("G/L Account No.");
                        AccName := GLAccount.Name;
                    END ELSE BEGIN
                        Cust.GET("Source No.");
                        AccName := Cust.Name;
                    END
                ELSE BEGIN
                    GLAccount.GET("G/L Account No.");
                    AccName := GLAccount.Name;
                END
            ELSE
                IF "Source Type" = "Source Type"::"Bank Account" THEN
                    IF BankLedgerEntry.GET("Entry No.") THEN BEGIN
                        Bank.GET("Source No.");
                        AccName := Bank.Name;
                    END ELSE BEGIN
                        GLAccount.GET("G/L Account No.");
                        AccName := GLAccount.Name;
                    END
                ELSE BEGIN
                    GLAccount.GET("G/L Account No.");
                    AccName := GLAccount.Name;
                END;

        IF "Source Type" = "Source Type"::" " THEN BEGIN
            GLAccount.GET("G/L Account No.");
            AccName := GLAccount.Name;
        END;

        EXIT(AccName);
    end;


    procedure FindGLAccNum("Source Type": Option " ",Customer,Vendor,"Bank Account","Fixed Asset"; "Entry No.": Integer; "Source No.": Code[20]; "G/L Account No.": Code[20]): Text[50]
    var
        AccNum: Text[50];
        VendLedgerEntry: Record 25;
        Vend: Record 23;
        CustLedgerEntry: Record 21;
        Cust: Record 18;
        BankLedgerEntry: Record 271;
        Bank: Record 270;
        GLAccount: Record 15;
    begin
        IF "Source Type" = "Source Type"::Vendor THEN
            IF VendLedgerEntry.GET("Entry No.") THEN
                IF IsGSTDocument(VendLedgerEntry."Document Type", VendLedgerEntry."Document No.") THEN BEGIN
                    GLAccount.GET("G/L Account No.");
                    AccNum := GLAccount."No.";
                END ELSE BEGIN
                    Vend.GET("Source No.");
                    AccNum := Vend."No.";
                END
            ELSE BEGIN
                GLAccount.GET("G/L Account No.");
                AccNum := GLAccount."No.";
            END
        ELSE
            IF "Source Type" = "Source Type"::Customer THEN
                IF CustLedgerEntry.GET("Entry No.") THEN
                    IF IsGSTDocument(CustLedgerEntry."Document Type", CustLedgerEntry."Document No.") THEN BEGIN
                        GLAccount.GET("G/L Account No.");
                        AccNum := GLAccount."No.";
                    END ELSE BEGIN
                        Cust.GET("Source No.");
                        AccNum := Cust."No.";
                    END
                ELSE BEGIN
                    GLAccount.GET("G/L Account No.");
                    AccNum := GLAccount."No.";
                END
            ELSE
                IF "Source Type" = "Source Type"::"Bank Account" THEN
                    IF BankLedgerEntry.GET("Entry No.") THEN BEGIN
                        Bank.GET("Source No.");
                        AccNum := Bank."No.";
                    END ELSE BEGIN
                        GLAccount.GET("G/L Account No.");
                        AccNum := GLAccount."No.";
                    END
                ELSE BEGIN
                    GLAccount.GET("G/L Account No.");
                    AccNum := GLAccount."No.";
                END;

        IF "Source Type" = "Source Type"::" " THEN BEGIN
            GLAccount.GET("G/L Account No.");
            AccNum := GLAccount."No.";
        END;

        EXIT(AccNum);
    end;

    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        Currency: Record 4;
        TensDec: Integer;
        OnesDec: Integer;
    begin
        CLEAR(NoText);
        NoTextIndex := 1;
        NoText[1] := '';

        IF No < 1 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text16526)
        ELSE BEGIN
            FOR Exponent := 4 DOWNTO 1 DO BEGIN
                PrintExponent := FALSE;
                IF No > 99999 THEN BEGIN
                    Ones := No DIV (POWER(100, Exponent - 1) * 10);
                    Hundreds := 0;
                END ELSE BEGIN
                    Ones := No DIV POWER(1000, Exponent - 1);
                    Hundreds := Ones DIV 100;
                END;
                Tens := (Ones MOD 100) DIV 10;
                Ones := Ones MOD 10;
                IF Hundreds > 0 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text16527);
                END;
                IF Tens >= 2 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    IF Ones > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                END ELSE
                    IF (Tens * 10 + Ones) > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                IF PrintExponent AND (Exponent > 1) THEN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                IF No > 99999 THEN
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(100, Exponent - 1) * 10
                ELSE
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
            END;
        END;

        IF CurrencyCode <> '' THEN BEGIN
            Currency.GET(CurrencyCode);
            //neha AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + Currency."Currency Numeric Description");
        END ELSE
            AddToNoText(NoText, NoTextIndex, PrintExponent, 'RUPEES');

        AddToNoText(NoText, NoTextIndex, PrintExponent, Text16528);

        TensDec := ((No * 100) MOD 100) DIV 10;
        OnesDec := (No * 100) MOD 10;
        IF TensDec >= 2 THEN BEGIN
            AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[TensDec]);
            IF OnesDec > 0 THEN
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[OnesDec]);
        END ELSE
            IF (TensDec * 10 + OnesDec) > 0 THEN
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[TensDec * 10 + OnesDec])
            ELSE
                AddToNoText(NoText, NoTextIndex, PrintExponent, Text16526);
        IF (CurrencyCode <> '') THEN
            //neha AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + Currency."Currency Decimal Description" + ' ONLY')

            //neha ELSE
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' PAISA ONLY');
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent := TRUE;

        WHILE STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) DO BEGIN
            NoTextIndex := NoTextIndex + 1;
            IF NoTextIndex > ARRAYLEN(NoText) THEN
                ERROR(Text16529, AddText);
        END;

        NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    procedure InitTextVariable()
    begin
        OnesText[1] := Text16532;
        OnesText[2] := Text16533;
        OnesText[3] := Text16534;
        OnesText[4] := Text16535;
        OnesText[5] := Text16536;
        OnesText[6] := Text16537;
        OnesText[7] := Text16538;
        OnesText[8] := Text16539;
        OnesText[9] := Text16540;
        OnesText[10] := Text16541;
        OnesText[11] := Text16542;
        OnesText[12] := Text16543;
        OnesText[13] := Text16544;
        OnesText[14] := Text16545;
        OnesText[15] := Text16546;
        OnesText[16] := Text16547;
        OnesText[17] := Text16548;
        OnesText[18] := Text16549;
        OnesText[19] := Text16550;

        TensText[1] := '';
        TensText[2] := Text16551;
        TensText[3] := Text16552;
        TensText[4] := Text16553;
        TensText[5] := Text16554;
        TensText[6] := Text16555;
        TensText[7] := Text16556;
        TensText[8] := Text16557;
        TensText[9] := Text16558;

        ExponentText[1] := '';
        ExponentText[2] := Text16559;
        ExponentText[3] := Text16562;
        ExponentText[4] := Text16563;
    end;


    procedure IsGSTDocument(DocumentType: Option; DocumentNo: Code[20]): Boolean
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin
        DetailedGSTLedgerEntry.SETRANGE("Document No.", DocumentNo);
        IF DetailedGSTLedgerEntry.FINDFIRST THEN
            EXIT(TRUE);
        DetailedGSTLedgerEntry.SETRANGE("Document No.");
        DetailedGSTLedgerEntry.SETRANGE("Entry Type", DetailedGSTLedgerEntry."Entry Type"::Application);
        DetailedGSTLedgerEntry.SETRANGE("Application Doc. Type", DocumentType);
        DetailedGSTLedgerEntry.SETRANGE("Application Doc. No", DocumentNo);
        IF NOT DetailedGSTLedgerEntry.ISEMPTY THEN
            EXIT(TRUE);
        EXIT(FALSE);
    end;
}

