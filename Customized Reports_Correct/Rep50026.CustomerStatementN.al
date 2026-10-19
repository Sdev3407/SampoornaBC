report 50026 "Customer Statement_N"
{
    UsageCategory = Administration;
    Caption = 'Customer Statement_N Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\CustomerStatementN.rdl';
    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            column(No_Customer; Customer."No.")
            {
            }


            dataitem(CopyLoop; 2000000026)
            {
                DataItemTableView = SORTING(Number);
                column(AmtWord; numtext1[1])
                {
                }
                column(CopyLoopNumber; CopyLoop.Number)
                {
                }
                column(WithoutNarration; WithoutNarration)
                {
                }
                column(OutputNo; OutputNo)
                {
                }
                column(CopyText; CopyText)
                {
                }
                column(PageNoofLoop; Number)
                {
                }
                column(DocumentCaptionCopyText; STRSUBSTNO(Text000, CopyText))
                {
                }
                column(CompanyAddr1; CompanyAddr[1])
                {
                }
                column(CompanyAddr2; CompanyAddr[2])
                {
                }
                column(CompanyAddr3; CompanyAddr[3])
                {
                }
                column(CompanyAddr4; CompanyAddr[4])
                {
                }
                column(CompanyAddr5; CompanyAddr[5])
                {
                }
                column(CompanyAddr6; CompanyAddr[6])
                {
                }
                column(CompanyInfoPicture; CompanyInfo.Picture)
                {
                }
                column(PhoneNo_Comp; CompanyInfo."Phone No.")
                {
                }
                column(Email_Comp; CompanyInfo."E-Mail")
                {
                }
                column(GSTIN_Comp; CompanyInfo."GST Registration No.")
                {
                }
                column(CustomerAddr1; Customer.Name)
                {
                }
                column(CustomerAddr2; Customer."Name 2")
                {
                }
                column(CustomerAddr3; Customer.Address)
                {
                }
                column(CustomerAddr4; Customer."Address 2")
                {
                }
                column(CustomerAddr5; Customer.City)
                {
                }
                column(CustomerAddr6; Customer."Post Code")
                {
                }
                column(CustomerAddr7; Customer.County + VendorAddress)
                {
                }
                column(PhoneNo_Customer; Customer."Phone No.")
                {
                }
                column(Email_Customer; Customer."E-Mail")
                {
                }
                column(TinNo_Customer; Customer."GST Registration No.")
                {
                }
                column(TodayDT; CURRENTDATETIME)
                {
                }
                column(VendDrCrCaption; CustDrCrCaption)
                {
                }
                column(VUserID; VUserID)
                { }
                column(VPrintdateTime; VPrintdateTime)
                { }
                column(PrintDate; PrintDate)
                {
                }
                column(StartDate; StartDate)
                { }
                column(EndDate; EndDate)
                { }
                column(CurrentDate; CurrentDate)
                { }
                column(CustOpeningBalance; CustOpeningBalance)
                {
                }

                column(DrCap; DrCap)
                {
                }
                column(CrCap; CrCap)
                {
                }
                column(DropClosingBail; DropClosingBail)
                {
                }


                dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
                {
                    DataItemLink = "Customer No." = FIELD("No.");
                    DataItemLinkReference = Customer;
                    DataItemTableView = SORTING("Posting Date")
                                        WHERE(Reversed = CONST(false));
                    column(CustomerNo_CLE; "Cust. Ledger Entry"."Sell-to Customer No.")
                    {
                    }
                    column(PostingDate_CLE; "Cust. Ledger Entry"."Posting Date")
                    {
                    }
                    column(DocType_CLE; "Cust. Ledger Entry"."Document Type")
                    {
                    }
                    column(ExtDocNo_CLE; "Cust. Ledger Entry"."External Document No.")
                    {
                    }
                    column(DocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."Document No.")
                    {
                    }
                    column(DocNo_CLE; GroupDocNo)
                    {
                    }
                    column(Desc_CLE; "Cust. Ledger Entry".Description)
                    {
                    }
                    column(DrAmnt_CLE; "Cust. Ledger Entry"."Debit Amount")
                    {
                    }
                    column(CrAmnt_CLE; "Cust. Ledger Entry"."Credit Amount")
                    {
                    }
                    column(CustRunningBalance; CustRunningBalance)
                    {
                    }
                    column(DrCrCaption; DrCrCaption)
                    {
                    }
                    column(AmountWords; numtext1[1])
                    {
                    }
                    column(TCSAmnt_CLE; TCSAmt)
                    {
                    }
                    column(TcsAmt1; TcsAmt1)
                    {
                    }
                    column(DebitTotal1; DebitTotal)
                    { }
                    column(CreditTotal1; CreditTotal)
                    { }
                    column(No; No)
                    {
                    }
                    column(Description; Description)
                    {
                    }
                    column(UOM; UOM)
                    {
                    }
                    column(LineNarration1; LineNarration)
                    {
                    }
                    column(Qty; Qty)
                    {
                    }
                    column(UnitPrice; UnitPrice)
                    {
                    }
                    column(DocumentNo; DocumentNo)
                    {
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("Document No.");
                        DataItemTableView = SORTING("Posting Date")
                                            WHERE(Type = FILTER(<> "G/L Account"),
                                                  Type = FILTER(<> "Fixed Asset"),
                                                  "No." = FILTER(<> ''),
                                                  "No." = FILTER(<> '1301390'),
                                                  Quantity = FILTER(<> 0));
                        column(SalesInvoiceLineType; "Sales Invoice Line".Type)
                        {
                        }
                        column(SalesLIneNo; "Sales Invoice Line"."No.")
                        {
                        }
                        column(SalesInvoiceLineDescription; "Sales Invoice Line".Description)
                        {
                        }
                        column(UnitofMeasure; "Sales Invoice Line"."Unit of Measure")
                        {
                        }
                        column(Quantity; "Sales Invoice Line".Quantity)
                        {
                        }
                        column(SalesInvoiceLineUnitPrice; "Sales Invoice Line"."Unit Price")
                        {
                        }
                        column(SalesInvoiceLineMRPPrice; "Sales Invoice Line"."MRP Price")
                        {

                        }

                        column(SalesInvoiceLineLineAmount; "Sales Invoice Line"."Line Amount")
                        {
                        }
                        column(SalesInvoiceLineAmountToCustomer; "Sales Invoice Line"."Amount")
                        {
                        }
                    }
                    dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
                    {
                        DataItemLink = "Document No." = FIELD("Document No.");
                        DataItemTableView = WHERE("No." = FILTER(<> ''),
                                                   "No." = FILTER(<> '1301390'),
                                                  Quantity = FILTER(<> 0));
                        column(SalesCrMemoLineDescription; "Sales Cr.Memo Line".Description)
                        {
                        }
                        column(SalesCrMemoLineQuantity; "Sales Cr.Memo Line".Quantity)
                        {
                        }
                        column(SalesCrMemoLineUnitPrice; "Sales Cr.Memo Line"."Unit Price")
                        {
                        }
                        column(SalesCrMemoLineUnitofMeasure; "Sales Cr.Memo Line"."Unit of Measure")
                        {
                        }
                        column(SalesCrMemoLineLineAmount; "Sales Cr.Memo Line"."Line Amount")
                        {
                        }
                        column(SalesCrMemoLineType; "Sales Cr.Memo Line".Type)
                        {
                        }
                        column(SalesCrMemoLineNo; "Sales Cr.Memo Line"."No.")
                        {
                        }

                        column(SalesCrMemoLineMRPPrice; "Sales Cr.Memo Line"."MRP Price")
                        { }

                        column(SalesCrMemoLineAmountToCustomer; "Sales Cr.Memo Line"."Amount")
                        {
                        }
                    }
                    dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
                    {
                        DataItemLink = "Document No." = FIELD("Document No."),
                                       "Cust. Ledger Entry No." = FIELD("Entry No.");
                        DataItemTableView = ORDER(Ascending)
                                            WHERE("Initial Document Type" = FILTER(.. Payment));
                        column(DetailedCustLedgEntryCreditAmount; "Detailed Cust. Ledg. Entry"."Credit Amount")
                        {
                        }
                    }
                    dataitem("G/L Entry"; "G/L Entry")
                    {
                        DataItemLink = "Document No." = FIELD("Document No.");
                        DataItemTableView = ORDER(Ascending)
                                            WHERE("Document Type" = CONST(Refund));
                        column(GLEntryDebitAmount; "G/L Entry"."Debit Amount")
                        {
                        }
                    }

                    trigger OnAfterGetRecord()
                    begin
                        /////CLEAR(VendRunningBalance);

                        //-->Running Balance
                        IF "Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."Document Type"::" " THEN
                            GroupDocNo := "Cust. Ledger Entry"."Document No." + FORMAT("Cust. Ledger Entry"."Entry No.")
                        ELSE
                            GroupDocNo := "Cust. Ledger Entry"."Document No.";
                        "Cust. Ledger Entry".CALCFIELDS("Debit Amount");
                        "Cust. Ledger Entry".CALCFIELDS("Credit Amount");
                        CustRunningBalance := (CustRunningBalance + "Cust. Ledger Entry"."Debit Amount" - "Cust. Ledger Entry"."Credit Amount");

                        IF CustRunningBalance > 0 THEN
                            DrCrCaption := 'Dr'
                        ELSE
                            DrCrCaption := 'Cr';

                        //<--Running Balance

                        //-->Amount in Words
                        Check1.InitTextVariable;
                        Check1.FormatNoText1(numtext1, ABS(CustRunningBalance), '');
                        //<--Amount in Words

                        //PTPL 011220 #P0272
                        TCSAmt := '';
                        TCSEntry.RESET;
                        TCSEntry.SETRANGE("Document No.", "Cust. Ledger Entry"."Document No.");
                        IF TCSEntry.FINDFIRST THEN BEGIN
                            IF "Cust. Ledger Entry"."Credit Amount" < 0 THEN
                                TCSAmt := '-' + FORMAT(TCSEntry."TCS Amount")
                            ELSE
                                TCSAmt := FORMAT(TCSEntry."TCS Amount");

                        END ELSE
                            TCSAmt := '0.00';
                        IF TCSAmt = '0' THEN
                            TCSAmt := '0.00';
                        CLEAR(TcsAmt1);
                        tcsEntry11.RESET;
                        tcsEntry11.SETRANGE("Document No.", "Document No.");
                        IF tcsEntry11.FINDFIRST THEN
                            REPEAT
                                TcsAmt1 += tcsEntry11."TCS Amount";
                            UNTIL tcsEntry11.NEXT = 0;


                        if not WithoutNarration then begin
                            LineNarration := "Cust. Ledger Entry"."Line Narration1";
                        end else
                            LineNarration := '';


                        /*CLEAR(Qty);
                        CLEAR(No);
                        CLEAR(UnitPrice);
                        CLEAR(Description);
                        SalesInvoiceLine.RESET;
                        SalesInvoiceLine.SETRANGE("Sell-to Customer No.","Cust. Ledger Entry"."Customer No.");
                        IF SalesInvoiceLine.FINDFIRST THEN
                          REPEAT
                            No :=SalesInvoiceLine."No.";
                            Description :=SalesInvoiceLine.Description;
                            Qty :=SalesInvoiceLine.Quantity;
                            UnitPrice :=SalesInvoiceLine."Unit Price";
                            UOM := SalesInvoiceLine."Unit of Measure";
                            DocumentNo := SalesInvoiceLine."Document No.";
                          UNTIL SalesInvoiceLine.NEXT=0;*/

                    end;

                    trigger OnPreDataItem()
                    begin
                        "Cust. Ledger Entry".SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                        CLEAR(CustRunningBalance);
                        CustRunningBalance := CustOpeningBalance;
                        //MESSAGE('Tested');
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN
                        CopyText := Text003;
                    CurrReport.PAGENO := 1;

                    OutputNo += 1;
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);

                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if Customer."Disable Customer Statement" then
                    CurrReport.Quit();
                IF (SaveReport) OR (SaveReportPdf) THEN
                    CurrReport.Quit();

                CompanyInfo.CALCFIELDS(Picture);
                FormatAddr.Company(CompanyAddr, CompanyInfo);
                FormatAddr.Customer(CustomerAddr, Customer);

                //-->Opening Balance
                CustOpeningBalance := 0.0;
                CLERec.RESET;
                CLEAR(CustOpeningBalance);
                CLERec.SETRANGE("Customer No.", Customer."No.");
                CLERec.SETFILTER("Posting Date", '<%1', StartDate);
                IF CLERec.FINDSET THEN
                    REPEAT
                        CLERec.CALCFIELDS("Original Amt. (LCY)");
                        CustOpeningBalance := CustOpeningBalance + CLERec."Original Amt. (LCY)";
                    UNTIL CLERec.NEXT = 0;
                //MESSAGE('%1',CustOpeningBalance);
                //<--Opening Balance
                //->Opening Balance Dr Cr Caption
                IF CustOpeningBalance > 0 THEN
                    CustDrCrCaption := TRUE
                ELSE
                    CustDrCrCaption := FALSE;
                //<-Opening Balance Dr Cr Caption

                IF CountryRegionRec.GET(Customer."Country/Region Code") THEN
                    VendorAddress := CountryRegionRec.Name;
                CustLedgerEntry.RESET;
                CustLedgerEntry.SETRANGE(CustLedgerEntry."Sell-to Customer No.", Customer."No.");
                CustLedgerEntry.SETFILTER(CustLedgerEntry."Posting Date", '%1..%2', StartDate, EndDate);
                IF NOT CustLedgerEntry.FINDFIRST THEN BEGIN
                    DropClosingBail := CustOpeningBalance;
                    IF DropClosingBail > 0 THEN
                        DrCap := 'Dr'
                    ELSE
                        DrCap := 'Cr';
                    Check1.InitTextVariable;
                    Check1.FormatNoText1(numtext1, ABS(DropClosingBail), '');
                END;
                DebitTotal := 0;
                CreditTotal := 0;
                CustLedgerEntry.RESET;
                CustLedgerEntry.SETRANGE(CustLedgerEntry."Sell-to Customer No.", Customer."No.");
                CustLedgerEntry.SETFILTER(CustLedgerEntry."Posting Date", '%1..%2', StartDate, EndDate);
                if CustLedgerEntry.FindFirst() Then
                    repeat
                        CustLedgerEntry.CalcFields("Debit Amount");
                        CustLedgerEntry.CalcFields("Credit Amount");

                        DebitTotal += CustLedgerEntry."Debit Amount";
                        CreditTotal += CustLedgerEntry."Credit Amount";

                    until CustLedgerEntry.Next() = 0;


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
                    field(SaveReportPdf; SaveReportPdf)
                    {
                        Caption = 'Send Mail';
                        ApplicationArea = All;
                    }
                    field(StartDate; StartDate)
                    {
                        Caption = 'Starting Date';
                        ApplicationArea = All;
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'Ending Date';
                        ApplicationArea = All;
                    }
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copy';
                        ApplicationArea = All;
                    }
                    field("Without Line Narration"; WithoutNarration)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            // if not WithoutNarration then
            //     Clear(WithoutNarration);
        end;
    }

    labels
    {
    }
    // trigger OnInitReport()
    // var
    //     Cust: Record Customer;
    // begin
    //     Cust.Get;
    // end;

    trigger OnPreReport()
    var
        Customer1: Record Customer;
    begin

        IF StartDate <> 0D THEN BEGIN
            IF EndDate = 0D THEN
                ERROR('You Must Specify the End Date');
        END
        ELSE
            ERROR('You Must Specify the Start Date');
        PrintDate := 'Period From ' + FORMAT(StartDate) + ' To ' + FORMAT(EndDate);
        StarDate := StarDate;
        EnDate := EndDate;
        CurrentDate := CurrentDateTime;
        if VUserID = '' then
            VUserID := UserId;
        if VPrintdateTime = 0DT then
            VPrintdateTime := CurrentDateTime;

        CompanyInfo.GET;
        // << Save pdf
        IF SaveReportPdf THEN BEGIN

            CLEAR(AutoMailReport);
            Customer1.CopyFilters(Customer);
            Customer1.SetRange("Disable Customer Statement", false);
            if Customer1.FindSet then
                repeat
                    //Message(Customer1."No.")
                    AutoMailReport.CustomerSendEmail(Customer1, StartDate, EndDate, WithoutNarration);
                until Customer1.Next() = 0;
        END;
        IF SaveReport THEN BEGIN
            COMMIT;
            RecCustomer.RESET;
            RecCustomer.SETFILTER(RecCustomer."No.", Customer.GETFILTER("No."));
            RecCustomer.SetRange("Disable Customer Statement", false);
            IF RecCustomer.FINDSET THEN
                REPEAT
                    PDFCustomer.RESET;
                    PDFCustomer.SETRANGE(PDFCustomer."No.", RecCustomer."No.");
                    IF PDFCustomer.FINDFIRST THEN BEGIN
                        COMMIT;
                        REPORT.RUN(50026, FALSE, FALSE, PDFCustomer);
                    END;
                UNTIL RecCustomer.NEXT = 0;
        END;
        // Save Pdf >>
    end;

    var
        StartDate: Date;
        EndDate: Date;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[50];
        OutputNo: Integer;
        Text003: Label 'COPY';
        CompanyAddr: array[8] of Text[50];
        CompanyInfo: Record 79;
        FormatAddr: Codeunit 365;
        Text000: Label 'Customer Statement %1';
        CustomerAddr: array[9] of Text;
        CustOpeningBalance: Decimal;
        CustRunningBalance: Decimal;
        DebitTotal: Decimal;
        CreditTotal: Decimal;
        CLERec: Record 21;
        DrCrCaption: Text;
        check1: Report 50101;
        numtext1: array[2] of Text;
        AmountInWords: Text;
        RunningDrBalance: Decimal;
        CustDrCrCaption: Boolean;
        VendorAddress: Text;
        CountryRegionRec: Record 9;
        PrintDate: Text[50];
        StarDate: Date;
        EnDate: Date;
        CurrentDate: DateTime;
        TCSAmt: Text;
        TCSEntry: Record "TCS Entry";//16514;
        TcsAmt1: Decimal;
        tcsEntry11: Record "TCS Entry";//16514;
        SalesInvoiceLine: Record 113;
        No: Code[20];
        Description: Text[50];
        UnitPrice: Decimal;
        Qty: Decimal;
        UOM: Text[10];
        DocumentNo: Code[20];
        SaveReport: Boolean;
        SaveReportPdf: Boolean;
        RecCustomer: Record 18;
        PDFCustomer: Record 18;
        AutoMailReport: Codeunit 50019;
        WithoutNarration: Boolean;
        GroupDocNo: Code[40];
        DropClosingBail: Decimal;
        CustLedgerEntry: Record 21;
        DrCap: Text;
        CrCap: Text;
        SalesInvoiceLineMRPPrice: Decimal;
        SalesCrMemoLineMRPPrice: Decimal;
        LineNarration: Text;
        VUserID: Text;
        VPrintdateTime: DateTime;


    procedure SetReportPreview(IsPreview: Boolean)
    begin
        SaveReport := IsPreview;
    end;

    procedure SetReportFilter(FromDate: Date; ToDate: Date)
    begin
        StartDate := FromDate;
        EndDate := ToDate;
    end;

    procedure SetNarration(Narration: Boolean)
    begin
        WithoutNarration := Narration;
    end;

    procedure SavePDF(PDF: Boolean)
    begin
        SaveReportPdf := PDF;
    end;

    procedure SetPrintIDandPrintTime(UserID: Text; PrintDateTime: DateTime)
    begin
        VUserID := UserID;
        VPrintdateTime := PrintDateTime;
    end;
}

