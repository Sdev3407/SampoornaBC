report 50029 "Customer Ledger Entries Report"
{
    UsageCategory = Administration;
    Caption = 'Customer Ledger Entries Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\CustomerLedgerEntriesReport.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Date Filter";
            column(DateFilter; GETFILTER("Date Filter"))
            {
            }
            column(DateFilterCaption; DateFilterCaption)
            {
            }
            column(No_GLAccount; Customer."No.")
            {
            }
            column(Name_GLAccount; Customer.Name)
            {
            }
            column(OpenBal; OpenBal)
            {
            }
            column(BalAtDate; CloseBal)
            {
            }
            column(PdateCaption; PdateCaption)
            {
            }
            column(DDateCaption; DDateCaption)
            {
            }
            column(DocNoCaption; DocNoCaption)
            {
            }
            column(DocTypeCaption; DocTypeCaption)
            {
            }
            column(BalAccTypeCap; BalAccTypeCap)
            {
            }
            column(BalAccNoCaption; BalAccNoCaption)
            {
            }
            column(LineNarrCaption; LineNarrCaption)
            {
            }
            column(DrAmtCaption; DrAmtCaption)
            {
            }
            column(CrAmtCaption; CrAmtCaption)
            {
            }
            column(RunBalCaption; RunBalCaption)
            {
            }
            column(UserIDCaption; UserIDCaption)
            {
            }
            column(SourceNoCaption; SourceNoCaption)
            {
            }
            column(SourceNameCaption; SourceNameCaption)
            {
            }
            column(OpenBalCap; OpenBalCap)
            {
            }
            column(CloseBalCap; CloseBalCap)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(ReportCap; ReportCap)
            {
            }
            column(AmtCaption; AmtCaption)
            {
            }
            column(UOMCaption; UOMCaption)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                CalcFields = Amount, "Debit Amount", "Credit Amount";
                DataItemLink = "Customer No." = FIELD("No."),
                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Customer No.", "Posting Date", "Currency Code")
                                    ORDER(Ascending);
                column(EntryNo_; "Entry No.")
                {
                }
                column(CustNo; "Customer No.")
                {
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
                column(DocumentType_GLEntry; "Document Type")
                {
                }
                column(DocumentNo_GLEntry; "Document No.")
                {
                }
                column(Amount_GLEntry; Amount)
                {
                }
                column(DocumentDate_GLEntry; "Document Date")
                {
                }
                column(BalAccountType_GLEntry; "Bal. Account Type")
                {
                }
                column(BalAccountNo_GLEntry; "Bal. Account No.")
                {
                }
                column(LineNarration_GLEntry; '')
                {
                }
                column(RunningBal; RunningBal)
                {
                }
                column(UserID_GLEntry; "User ID")
                {
                }
                column(ExternalDocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."External Document No.")
                {
                }
                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    DataItemLink = "External Document No." = FIELD("External Document No."),
                                   "Source No." = FIELD("Customer No.");
                    DataItemTableView = WHERE("Source Type" = CONST(Customer),
                                              "External Document No." = FILTER(<> ''));
                    column(ItemNo_ItemLedgerEntry; "Item Ledger Entry"."Item No.")
                    {
                    }
                    column(Quantity_ItemLedgerEntry; ABS("Item Ledger Entry".Quantity))
                    {
                    }
                    column(UnitofMeasureCode_ItemLedgerEntry; "Item Ledger Entry"."Unit of Measure Code")
                    {
                    }
                    column(Description_ItemLedgerEntry; T27.Description)
                    {
                    }
                    column(ExternalDocumentNo_ItemLedgerEntry; "Item Ledger Entry"."External Document No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        T27.GET("Item Ledger Entry"."Item No.");
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(VendInvNo);
                    IF T112.GET("Document No.") THEN
                        VendInvNo := T112."External Document No."
                    ELSE
                        IF T114.GET("Document No.") THEN
                            VendInvNo := T114."External Document No.";

                    T271.RESET;
                    T271.SETRANGE("Document No.", "Document No.");
                    IF T271.FINDFIRST THEN
                        IF T271."Cheque No." <> '' THEN
                            VendInvNo := T271."Cheque No." + '- ' + FORMAT(T271."Cheque Date");

                    Temp17.DELETEALL;
                    TempGL.DELETEALL;
                    T17.RESET;
                    //T17.SETCURRENTKEY("Document No.");
                    T17.SETRANGE("Document No.", "Document No.");
                    IF Customer.GETFILTER("Global Dimension 1 Filter") <> '' THEN
                        T17.SETRANGE(T17."Global Dimension 1 Code", "Global Dimension 1 Code");
                    IF Customer.GETFILTER("Global Dimension 2 Filter") <> '' THEN
                        T17.SETRANGE(T17."Global Dimension 2 Code", "Global Dimension 2 Code");
                    T17.SETRANGE("Posting Date", "Posting Date");
                    IF T17.FINDFIRST THEN BEGIN
                        REPEAT
                            IF T17."Entry No." = "Entry No." THEN BEGIN
                                RunningBal := ((RunningBal + "Debit Amount") - "Credit Amount");
                                CLEAR(LineNarration);
                                ///LineNarration := T17."Line Narration";
                            END ELSE BEGIN
                                IF NOT Temp17.GET(T17."Entry No.") THEN BEGIN
                                    Temp17.INIT;
                                    Temp17.TRANSFERFIELDS(T17);
                                    Temp17.INSERT;
                                END;
                            END;
                        UNTIL T17.NEXT = 0;
                    END
                    ELSE
                        CurrReport.SKIP;

                    CLEAR(VoucherNarr);
                    T16548.RESET;
                    T16548.SETRANGE("Transaction No.", "Transaction No.");
                    T16548.SETFILTER("Entry No.", '%1', 0);
                    IF T16548.FINDFIRST THEN
                        VoucherNarr := T16548.Narration;
                    CLEAR(GLAccNo);

                    Temp17.RESET;
                    Temp17.SETCURRENTKEY("G/L Account No.");
                    Temp17.SETRANGE("Document No.", "Document No.");
                    Temp17.SETFILTER("G/L Account No.", NoAccountsFilter);
                    IF Temp17.FINDFIRST THEN
                        REPEAT
                            IF Temp17."G/L Account No." = GLAccNo THEN BEGIN
                                TempGL."Debit Amount" := TempGL."Debit Amount" + Temp17."Debit Amount";
                                TempGL."Credit Amount" := TempGL."Credit Amount" + Temp17."Credit Amount";
                                TempGL.Amount := TempGL.Amount + Temp17.Amount;
                                TempGL.MODIFY;
                            END
                            ELSE BEGIN
                                TempGL.INIT;
                                TempGL.TRANSFERFIELDS(Temp17);
                                TempGL.INSERT;
                            END;
                            GLAccNo := Temp17."G/L Account No."
UNTIL Temp17.NEXT = 0;

                    Temp17.RESET;
                    Temp17.SETCURRENTKEY("G/L Account No.");
                    Temp17.SETRANGE("Document No.", "Document No.");
                    Temp17.SETFILTER("G/L Account No.", AccountsFilter);
                    IF Temp17.FINDFIRST THEN
                        REPEAT
                            IF NOT TempGL.GET("Entry No.") THEN BEGIN
                                TempGL.INIT;
                                TempGL.TRANSFERFIELDS(Temp17);
                                TempGL.INSERT;
                            END;
                        UNTIL Temp17.NEXT = 0;

                    IF ExporttoExcel THEN BEGIN
                        EnterCell(Row, 1, FORMAT("Posting Date"), TRUE, FALSE, FALSE, CellTypeVar::Date);
                        EnterCell(Row, 2, FORMAT("Document Type"), TRUE, FALSE, FALSE, CellTypeVar::Text);
                        EnterCell(Row, 3, FORMAT("Source Code"), TRUE, FALSE, FALSE, CellTypeVar::Text);  //PRU-ASH
                        EnterCell(Row, 4, "Document No.", TRUE, FALSE, FALSE, CellTypeVar::Text);
                        EnterCell(Row, 5, FORMAT("Document Date"), TRUE, FALSE, FALSE, CellTypeVar::Date);
                        EnterCell(Row, 6, VendInvNo, TRUE, FALSE, FALSE, CellTypeVar::Text);
                        EnterCell(Row, 7, "Global Dimension 1 Code", TRUE, FALSE, FALSE, CellTypeVar::Text);
                        EnterCell(Row, 8, "Global Dimension 2 Code", TRUE, FALSE, FALSE, CellTypeVar::Text);
                        EnterCell(Row, 9, T17.Comment, TRUE, FALSE, FALSE, CellTypeVar::Text);
                        //EnterCell(Row,10,T17.Activity,TRUE,FALSE,FALSE,CellTypeVar::Text);/////VG
                        ///EnterCell(Row,11,T17.Category,TRUE,FALSE,FALSE,CellTypeVar::Text);///VG
                        //EnterCell(Row,10,FORMAT("Document Type"),TRUE,FALSE,FALSE,CellTypeVar::Text);
                        EnterCell(Row, 17, LineNarration, TRUE, FALSE, FALSE, CellTypeVar::Text);
                        EnterCell(Row, 18, VoucherNarr, TRUE, FALSE, FALSE, CellTypeVar::Text);
                        EnterCell(Row, 19, FORMAT("Debit Amount"), TRUE, FALSE, FALSE, CellTypeVar::Number);
                        EnterCell(Row, 20, FORMAT("Credit Amount"), TRUE, FALSE, FALSE, CellTypeVar::Number);
                        EnterCell(Row, 21, FORMAT(RunningBal), TRUE, FALSE, FALSE, CellTypeVar::Number);
                        ////EnterCell(Row,22,FORMAT(T17."Created By"),TRUE,FALSE,FALSE,CellTypeVar::Text);///VG  //PRU-ASH
                        EnterCell(Row, 23, "User ID", TRUE, FALSE, FALSE, CellTypeVar::Text);
                        Row := Row + 1;
                    END;
                end;

                trigger OnPostDataItem()
                begin
                    IF ExporttoExcel THEN BEGIN
                        Row := Row + 1;
                        //EnterCell(Row,1,"No.",TRUE,FALSE,FALSE,CellTypeVar::Date);
                        //EnterCell(Row,2,Name,TRUE,FALSE,FALSE,CellTypeVar::Text);
                        EnterCell(Row, 20, CloseBalCap, TRUE, FALSE, FALSE, CellTypeVar::Number);           //PRU-ASH
                        EnterCell(Row, 21, FORMAT(CloseBal), TRUE, FALSE, FALSE, CellTypeVar::Number);      //PRU-ASH
                        Row := Row + 2;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Posting Date", StartDate, EndDate);
                    CLEAR(RunningBal);
                    RunningBal := OpenBal;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(OpenBal);
                CLEAR(CloseBal);
                T21.RESET;
                T21.SETRANGE(T21."Customer No.", "No.");
                T21.SETFILTER("Posting Date", '<%1', GETRANGEMIN("Date Filter"));
                IF GETFILTER("Global Dimension 1 Filter") <> '' THEN
                    T21.SETFILTER("Global Dimension 1 Code", '%1', GETFILTER("Global Dimension 1 Filter"));
                IF GETFILTER(Customer."Global Dimension 2 Filter") <> '' THEN
                    T21.SETFILTER("Global Dimension 2 Code", '%1', GETFILTER("Global Dimension 2 Filter"));
                T21.SETAUTOCALCFIELDS(Amount);
                IF T21.FINDFIRST THEN
                    REPEAT
                        OpenBal := OpenBal + T21.Amount;
                    UNTIL T21.NEXT = 0;

                T21.RESET;
                T21.SETRANGE(T21."Customer No.", "No.");
                T21.SETFILTER("Posting Date", '<=%1', GETRANGEMAX("Date Filter"));
                IF GETFILTER("Global Dimension 1 Filter") <> '' THEN
                    T21.SETFILTER("Global Dimension 1 Code", '%1', GETFILTER("Global Dimension 1 Filter"));
                IF GETFILTER(Customer."Global Dimension 2 Filter") <> '' THEN
                    T21.SETFILTER("Global Dimension 2 Code", '%1', GETFILTER("Global Dimension 2 Filter"));
                T21.SETAUTOCALCFIELDS(Amount);
                IF T21.FINDFIRST THEN
                    REPEAT
                        CloseBal := CloseBal + T21.Amount;
                    UNTIL T21.NEXT = 0;

                IF ExporttoExcel THEN BEGIN
                    Row := Row + 1;
                    EnterCell(Row, 1, "No.", TRUE, FALSE, FALSE, CellTypeVar::Text);
                    EnterCell(Row, 2, Name, TRUE, FALSE, FALSE, CellTypeVar::Text);
                    EnterCell(Row, 3, 'Date Filter:', TRUE, FALSE, FALSE, CellTypeVar::Text);
                    EnterCell(Row, 4, GETFILTER("Date Filter"), TRUE, FALSE, FALSE, CellTypeVar::Text);

                    EnterCell(Row, 20, OpenBalCap, TRUE, FALSE, FALSE, CellTypeVar::Number);      //PRU-ASH
                    EnterCell(Row, 21, FORMAT(OpenBal), TRUE, FALSE, FALSE, CellTypeVar::Number);  //PRU-ASH
                    Row := Row + 2;
                    EnterCell(Row, 1, PdateCaption, TRUE, FALSE, FALSE, CellTypeVar::Text);
                    EnterCell(Row, 2, DocTypeCaption, TRUE, FALSE, FALSE, CellTypeVar::Text);
                    EnterCell(Row, 3, 'Source Code', TRUE, FALSE, FALSE, CellTypeVar::Text);  //PRU-ASH
                    EnterCell(Row, 4, DocNoCaption, TRUE, FALSE, FALSE, CellTypeVar::Text);
                    EnterCell(Row, 5, DDateCaption, TRUE, FALSE, FALSE, CellTypeVar::Text);
                    EnterCell(Row, 6, VendorInvNoCap, TRUE, FALSE, FALSE, CellTypeVar::Text);
                    EnterCell(Row, 7, 'Customer Code', TRUE, FALSE, FALSE, CellTypeVar::Text);
                    EnterCell(Row, 8, CircleCodeCap, TRUE, FALSE, FALSE, CellTypeVar::Text);
                    EnterCell(Row, 9, 'Month', TRUE, FALSE, FALSE, CellTypeVar::Text);
                    EnterCell(Row, 10, 'Activity', TRUE, FALSE, FALSE, CellTypeVar::Text);
                    EnterCell(Row, 11, 'Category', TRUE, FALSE, FALSE, CellTypeVar::Text);
                    //EnterCell(Row,10,DocTypeCaption,TRUE,FALSE,FALSE,CellTypeVar::Text);
                    EnterCell(Row, 12, BalAccNoCaption, TRUE, FALSE, FALSE, CellTypeVar::Text);
                    EnterCell(Row, 13, BalAccTypeCap, TRUE, FALSE, FALSE, CellTypeVar::Text);
                    EnterCell(Row, 14, SourceNoCaption, TRUE, FALSE, FALSE, CellTypeVar::Text);
                    EnterCell(Row, 15, SourceNameCaption, TRUE, FALSE, FALSE, CellTypeVar::Text);
                    EnterCell(Row, 16, 'Amount', TRUE, FALSE, FALSE, CellTypeVar::Text);
                    EnterCell(Row, 17, 'Line Narration', TRUE, FALSE, FALSE, CellTypeVar::Text);
                    EnterCell(Row, 18, LineNarrCaption, TRUE, FALSE, FALSE, CellTypeVar::Text);
                    EnterCell(Row, 19, DrAmtCaption, TRUE, FALSE, FALSE, CellTypeVar::Number);
                    EnterCell(Row, 20, CrAmtCaption, TRUE, FALSE, FALSE, CellTypeVar::Number);
                    EnterCell(Row, 21, RunBalCaption, TRUE, FALSE, FALSE, CellTypeVar::Number);
                    EnterCell(Row, 22, 'Created by', TRUE, FALSE, FALSE, CellTypeVar::Number);    //PRU-ASH
                    EnterCell(Row, 23, UserIDCaption, TRUE, FALSE, FALSE, CellTypeVar::Number);
                    Row := Row + 2
                    ;

                END;
            end;

            trigger OnPreDataItem()
            begin
                //T21.COPYFILTERS("Cust. Ledger Entry");
                IF GETFILTER("Date Filter") = '' THEN
                    ERROR('Please Enter the Date Filter');
                StartDate := GETRANGEMIN("Date Filter");
                EndDate := GETRANGEMAX("Date Filter");
                Row := 4;
                IF ExporttoExcel THEN BEGIN
                    EnterCell(1, 8, COMPANYNAME, TRUE, FALSE, FALSE, CellTypeVar::Text);
                    EnterCell(2, 8, ReportCap, TRUE, FALSE, FALSE, CellTypeVar::Text);
                END;
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
                    field(ExporttoExcel; ExporttoExcel)
                    {
                        Caption = 'Export to Excel';
                        Visible = false;
                        ApplicationArea = All;
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

    trigger OnPostReport()
    begin
        IF ExporttoExcel THEN
            ExcelBuf.CreateNewBook('CLE Report');
        ExcelBuf.WriteSheet('CLE Report', CompanyName, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename(StrSubstNo('CLE Report', CurrentDateTime, UserId));
        ExcelBuf.OpenExcel();
        // ExcelBuf.CreateBookAndOpenExcel('', 'CLE Report', ReportCap, COMPANYNAME, USERID);
    end;

    trigger OnPreReport()
    begin
        AccountsFilter := '32011000000..32011888888|52000000000..52012999999|32014990000..32016888888|53012000000..53012888888|31011000000..31011188888';
        NoAccountsFilter := '<31011000000|>31011188888&<32011000000|>32011888888&<32014990000|>32016888888&<52000000000|>52012999999&<53012000000|>53012888888';
        VendorFilter := '32011000000..32011888888';
        ImprestFilter := '32014990000..32016888888|34011100019';
        CustomerFilter := '52000000000..52012999999';
        BankFilter := '53012000000..53012888888|31011000000..31011188888';
    end;

    var
        T21: Record 21;
        OpenBal: Decimal;
        StartDate: Date;
        EndDate: Date;
        RunningBal: Decimal;
        PdateCaption: Label 'Posting Date';
        DDateCaption: Label 'Document Date';
        DocNoCaption: Label 'Document No.';
        DocTypeCaption: Label 'Document Type';
        BalAccTypeCap: Label 'Description';
        BalAccNoCaption: Label 'Item No.';
        LineNarrCaption: Label 'Voucher Narration';
        DrAmtCaption: Label 'Debit Amount';
        CrAmtCaption: Label 'Credit Amount';
        RunBalCaption: Label 'Running Balance';
        UserIDCaption: Label 'User ID';
        OpenBalCap: Label 'Opening Balance';
        CloseBalCap: Label 'Closing Balance';
        ReportCap: Label 'Customer Ledger Entries Report ';
        CloseBal: Decimal;
        T17: Record 17;
        LineNarration: Text[250];
        ExporttoExcel: Boolean;
        T112: Record 112;
        T114: Record 114;
        VendInvNo: Code[35];
        Temp17: Record 17 temporary;
        TempGL: Record 17 temporary;
        VoucherNarr: Text[150];
        T16548: Record "Posted Narration";
        GLAccNo: Code[20];
        Row: Integer;
        ExcelBuf: Record 370 temporary;
        CellTypeVar: Option Number,Text,Date,Time;
        VendorInvNoCap: Label 'Reference Doc. No.';
        CircleCodeCap: Label 'Circle Code';
        AmtCaption: Label 'Amount';
        AccountsFilter: Text[250];
        NoAccountsFilter: Text[250];
        VendorFilter: Text[250];
        CustomerFilter: Text[250];
        BankFilter: Text[250];
        ImprestFilter: Text[250];
        GLEntryRec: Record 17;
        AccountNo: Code[20];
        AccountName: Text[50];
        T23: Record 23;
        T18: Record 18;
        T270: Record 270;
        T480: Record 480;
        SourceNoCaption: Label 'Source No.';
        SourceNameCaption: Label 'Quantity';
        DateFilterCaption: Label 'Date Filter:';
        T271: Record 271;
        T27: Record 27;
        UOMCaption: Label 'UOM';


    procedure EnterCell(RowNo: Integer; ColNo: Integer; CellValue: Text[250]; BoldBool: Boolean; UndBool: Boolean; ItalicBool: Boolean; CellType: Option Number,Text,Date,Time)
    begin
        ExcelBuf.VALIDATE(ExcelBuf."Row No.", RowNo);
        ExcelBuf.VALIDATE(ExcelBuf."Column No.", ColNo);
        ExcelBuf.VALIDATE(ExcelBuf."Cell Type", CellType);
        ExcelBuf.VALIDATE(ExcelBuf."Cell Value as Text", CellValue);
        IF ColNo = 1 THEN
            ExcelBuf.NumberFormat := 'dd/mm/yyyy';
        IF ColNo = 3 THEN
            ExcelBuf.NumberFormat := 'dd/mm/yyyy';

        IF ColNo = 16 THEN
            ExcelBuf.NumberFormat := '#,##0.00;-#,##0.00;;@';
        IF ColNo = 19 THEN
            ExcelBuf.NumberFormat := '#,##0.00;-#,##0.00;;@';
        IF ColNo = 20 THEN
            ExcelBuf.NumberFormat := '#,##0.00;-#,##0.00;;@';
        IF ColNo = 21 THEN
            ExcelBuf.NumberFormat := '#,##0.00;-#,##0.00;;@';
        //IF ColNo=13 THEN
        //ExcelBuf.NumberFormat := '0.00';
        //IF ColNo=14 THEN
        //ExcelBuf.NumberFormat := '0.00';
        //IF ColNo=15 THEN
        //ExcelBuf.NumberFormat := '0.00';

        ExcelBuf.Bold := BoldBool;
        ExcelBuf.Italic := ItalicBool;
        ExcelBuf.Underline := UndBool;
        ExcelBuf.INSERT;
    end;
}

