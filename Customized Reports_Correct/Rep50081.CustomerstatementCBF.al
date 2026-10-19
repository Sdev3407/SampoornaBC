report 50081 "Customer statement CBF"
{
    UsageCategory = Administration;
    Caption = 'Customer Statement CBF Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\CustomerstatementCBF.rdl';
    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Date Filter";
            column(CompanyInFoName; CompanyInFo.Name)
            {
            }
            column(CompanyInFoEMail; CompanyInFo."E-Mail")
            {
            }
            column(CompanyInFoFaxNo; CompanyInFo."Fax No.")
            {
            }
            column(CompanyInFoPhoneNo; CompanyInFo."Phone No.")
            {
            }
            column(CompanyInFoCity; CompanyInFo.City)
            {
            }
            column(CompanyInFoPostCode; CompanyInFo."Post Code")
            {
            }
            column(CompanyInFoState; CompanyInFoState) { }


            column(CurrDate; FORMAT(CurrDate))
            {
            }
            column(CompAddr; CompAddr)
            {
            }
            column(CompStateName; CompStateName)
            {
            }
            column(CompCountryName; CompCountryName)
            {
            }
            column(No_Customer; Customer."No.")
            {
            }
            column(PeriodFilter; PeriodFilter)
            {
            }
            column(StartDateFilter; StartDateFilter)
            {
            }
            column(EndDateFilter; EndDateFilter)
            {
            }
            column(EndDateVar; EndDateVar)
            {
            }
            column(CurrUSerID; CurrUSerID)
            {
            }
            column(CurrDtTime; CurrDtTime)
            {
            }
            column(CustName; CustName)
            {
            }
            column(CustPhone; CustPhone)
            {
            }
            column(CustAddr; CustAddr)
            {
            }
            column(CustFax; CustFax)
            {
            }
            column(CustEmail; CustEmail)
            {
            }
            column(CustCity; CustCity)
            {
            }
            column(CustPin; CustPin)
            {
            }
            column(StateName; StateName)
            {
            }
            column(CompanyCap; CompanyCap)
            {
            }
            column(RegionCap; RegionCap)
            {
            }
            column(PeriodCap; PeriodCap)
            {
            }
            column(ReportIDCap; ReportIDCap)
            {
            }
            column(ReportDateCap; ReportDateCap)
            {
            }
            column(PrintedByCap; PrintedByCap)
            {
            }
            column(PageNoCap; PageNoCap)
            {
            }
            column(StatementAccCap; StatementAccCap)
            {
            }
            column(ACCodeCap; ACCodeCap)
            {
            }
            column(VouDateCap; VouDateCap)
            {
            }
            column(BranchCap; BranchCap)
            {
            }
            column(VouTypeCap; VouTypeCap)
            {
            }
            column(TransNoCap; TransNoCap)
            {
            }
            column(DescCap; DescCap)
            {
            }
            column(QtyCap; QtyCap)
            {
            }
            column(RateCap; RateCap)
            {
            }
            column(DebitCap; DebitCap)
            {
            }
            column(CreditCap; CreditCap)
            {
            }
            column(BalCap; BalCap)
            {
            }
            column(OpeningBalCap; OpeningBalCap)
            {
            }
            column(MonthTtlCap; MonthTtlCap)
            {
            }
            column(MonthBalCap; MonthBalCap)
            {
            }
            column(GrandTtlCp; GrandTtlCp)
            {
            }
            column(ChqRecCap; ChqRecCap)
            {
            }
            column(DateCap; DateCap)
            {
            }
            column(CheqNumCap; CheqNumCap)
            {
            }
            column(AmountCap; AmountCap)
            {
            }
            column(TotalCap; TotalCap)
            {
            }
            column(SFPLCap; SFPLCap)
            {
            }
            column(FinDepttCap; FinDepttCap)
            {
            }
            column(PhoneCap; PhoneCap)
            {
            }
            column(FaxCap; FaxCap)
            {
            }
            column(CustomerCareCap; CustomerCareCap)
            {
            }
            column(CBCSCap; CBCSCap)
            {
            }
            column(ToCap; ToCap)
            {
            }
            column(Note1; Note1)
            {
            }
            column(Note2; Note2)
            {
            }
            column(Note3; Note3)
            {
            }
            column(Note4; Note4)
            {
            }
            column(ForCap; ForCap)
            {
            }
            column(AuthSignCap; AuthSignCap)
            {
            }
            column(SignDateCap; SignDateCap)
            {
            }
            column(NameCap; NameCap)
            {
            }
            column(SealCap; SealCap)
            {
            }
            column(SubCap; SubCap)
            {
            }
            column(ToCap1; ToCap1)
            {
            }
            column(ConfirmBlCap; ConfirmBlCap)
            {
            }
            column(BrCap; BrCap)
            {
            }
            column(BrCap2; BrCap2)
            {
            }
            column(AsOnCap; AsOnCap)
            {
            }
            column(YourBalCap; YourBalCap)
            {
            }
            column(SubjectRealizCap; SubjectRealizCap)
            {
            }
            column(INRCap; INRCap)
            {
            }
            column(CommaCap; CommaCap)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No."),
                               "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("Posting Date")
                                    ORDER(Ascending);
                RequestFilterFields = "Global Dimension 1 Code", "Global Dimension 2 Code", "Shortcut Dimension 3 Code";
                column(DocumentType_CustLedgerEntry; "Cust. Ledger Entry"."Document Type")
                {
                }
                column(DocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(Description_CustLedgerEntry; "Cust. Ledger Entry".Description)
                {
                }
                column(PostingDate_CustLedgerEntry; FORMAT("Cust. Ledger Entry"."Posting Date"))
                {
                }
                column(GlobalDimension2Code_CustLedgerEntry; "Cust. Ledger Entry"."Global Dimension 2 Code")
                {
                }
                column(YearCount; YearCount)
                {
                }
                column(MonthlyNum; MonthlyNum)
                {
                }
                column(MonthName; MonthName)
                {
                }
                column(DesciptionVal; DesciptionVal)
                {
                }
                column(DebitAmount; DebitAmount)
                {
                }
                column(CreditAmount; CreditAmount)
                {
                }
                column(OpeningBal; FORMAT(ABS(OpeningBal), 15, '<Integer Thousand><Decimal,3>'))
                {
                }
                column(RunningBal; RunningBal)
                {
                }
                column(CRDROpeningBal; CRDROpeningBal)
                {
                }
                column(CRDRRunningBal; CRDRRunningBal)
                {
                }
                column(CRDRRunningBalLast; CRDRRunningBalLast)
                {
                }
                column(CRDRRunningChanging; CRDRRunningChanging)
                {
                }
                column(OpeningAmountRunning; FORMAT(ABS(OpeningAmountRunning), 15, '<Integer Thousand><Decimal,3>'))
                {
                }
                column(QtySum; QtySum)
                {
                }
                column(AltQtyVal; AltQtyVal)
                {
                }
                column(RateVal; RateVal)
                {
                }
                column(TCSAmount; TCSAmt)
                {
                }

                trigger OnAfterGetRecord()
                var
                    Date_Rec: Record 2000000007;
                    Date_Rec2: Record 2000000007 temporary;
                begin
                    RunningBal := 0;
                    DebitAmount := 0;
                    CreditAmount := 0;
                    CLEAR(DesciptionVal);
                    CLEAR(QtySum);
                    CLEAR(RateVal);
                    CLEAR(AltQtyVal);
                    CLEAR(MonthName); // PRU_AS 25 JULY 2019
                    CLEAR(YearVal); // PRU_AS 25 JULY 2019

                    // coding for closing balances
                    "Cust. Ledger Entry".CALCFIELDS(Amount);
                    "Cust. Ledger Entry".CALCFIELDS("Debit Amount");
                    "Cust. Ledger Entry".CALCFIELDS("Credit Amount");

                    DebitAmount := "Cust. Ledger Entry"."Debit Amount";
                    CreditAmount := "Cust. Ledger Entry"."Credit Amount";

                    MonthlyNum := DATE2DMY("Cust. Ledger Entry"."Posting Date", 2);
                    YearCount := DATE2DMY("Cust. Ledger Entry"."Posting Date", 3);
                    MonthName := FORMAT("Cust. Ledger Entry"."Posting Date", 0, '<month Text,3>,<year,2>');

                    MonthT := DATE2DMY(StartDateFilter, 2);

                    IF MonthT <> MonthlyNum THEN BEGIN
                        OpeningBal := OpeningAmountRunning;
                        IF ((OpeningBal > 0) OR (OpeningBal = 0)) THEN
                            CRDRRunningChanging := 'Dr.'
                        ELSE
                            IF OpeningBal < 0 THEN
                                CRDRRunningChanging := 'Cr.';
                    END;

                    IF "Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."Document Type"::" " THEN
                        DesciptionVal := "Cust. Ledger Entry"."Applies-to Doc. No.";

                    IF "Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."Document Type"::"Finance Charge Memo" THEN
                        DesciptionVal := "Cust. Ledger Entry"."Applies-to Doc. No.";

                    IF "Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."Document Type"::Refund THEN
                        DesciptionVal := "Cust. Ledger Entry"."Applies-to Doc. No.";

                    IF "Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."Document Type"::Reminder THEN
                        DesciptionVal := "Cust. Ledger Entry"."Applies-to Doc. No.";

                    IF "Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."Document Type"::Payment THEN
                        DesciptionVal := "Cust. Ledger Entry"."Applies-to Doc. No.";

                    IF "Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."Document Type"::Invoice THEN BEGIN
                        SalesInvLineRec.RESET;
                        SalesInvLineRec.SETRANGE("Document No.", "Cust. Ledger Entry"."Document No.");
                        IF SalesInvLineRec.FINDFIRST THEN BEGIN
                            AltQtyVal := SalesInvLineRec."Alternate Quantity";
                            RateVal := SalesInvLineRec."Unit Price";
                        END;

                        SalesInvHeaderRec.RESET;
                        SalesInvHeaderRec.SETRANGE("No.", "Cust. Ledger Entry"."Document No.");
                        IF SalesInvHeaderRec.FINDFIRST THEN BEGIN
                            DesciptionVal := SalesInvHeaderRec."Vehicle No." + ',' + FORMAT(AltQtyVal) + '/' + SalesInvHeaderRec."External Document No.";

                            SalesInvLineRec.RESET;
                            SalesInvLineRec.SETRANGE("Document No.", SalesInvHeaderRec."No.");
                            IF SalesInvLineRec.FINDSET THEN
                                REPEAT
                                    QtySum += SalesInvLineRec.Quantity;
                                UNTIL SalesInvLineRec.NEXT = 0;
                        END;
                    END;

                    IF "Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."Document Type"::"Credit Memo" THEN BEGIN
                        SalesCrMemoHdrRec.RESET;
                        SalesCrMemoHdrRec.SETRANGE("No.", "Cust. Ledger Entry"."Document No.");
                        IF SalesCrMemoHdrRec.FINDFIRST THEN
                            DesciptionVal := SalesCrMemoHdrRec."Applies-to Doc. No." + '/' + SalesCrMemoHdrRec."External Document No.";
                    END;

                    OpeningAmountRunning += ROUND(DebitAmount - CreditAmount, 0.01, '>');

                    IF ((OpeningAmountRunning > 0) OR (OpeningAmountRunning = 0)) THEN
                        CRDRRunningBal := 'Dr.'
                    ELSE
                        IF OpeningAmountRunning < 0 THEN
                            CRDRRunningBal := 'Cr.';

                    //PTPL 011220 #P0272
                    TCSAmt := 0;
                    TCSEntry.RESET;
                    TCSEntry.SETRANGE("Document No.", "Document No.");
                    IF TCSEntry.FINDFIRST THEN
                        TCSAmt := TCSEntry."TCS Amount";
                end;

                trigger OnPostDataItem()
                begin
                    IF ((OpeningAmountRunning > 0) OR (OpeningAmountRunning = 0)) THEN
                        CRDRRunningBalLast := 'Dr.'
                    ELSE
                        IF OpeningAmountRunning < 0 THEN
                            CRDRRunningBalLast := 'Cr.';
                end;
            }

            trigger OnAfterGetRecord()
            var
                Date_Var: Record 2000000007;
            begin
                if Customer."Disable Customer Statement" then
                    Error('Customer Statement is disabled for %1', Customer."No.");
                Date_Var.RESET;
                Date_Var.SETRANGE("Period Type", Date_Var."Period Type"::Month);
                Date_Var.SETRANGE("Period Start", "Date Filter");
                IF Date_Var.FINDFIRST THEN
                    MESSAGE('%1', Date_Var."Period No.");

                OpeningBal := 0;
                MonthlyNum := 0;
                CLEAR(CustName);
                CLEAR(CustPhone);
                CLEAR(CustAddr);
                CLEAR(CustEmail);
                CLEAR(CustFax);
                CLEAR(CustCity);
                CLEAR(CustPin);

                IF CustRec.GET(Customer."No.") THEN BEGIN
                    CustName := Customer.Name;
                    CustPhone := Customer."Phone No.";
                    CustEmail := Customer."E-Mail";
                    CustFax := Customer."E-Mail";
                    CustCity := Customer.City;
                    CustPin := Customer."Post Code";
                    IF StateRec.GET(CustRec."State Code") THEN
                        StateName := StateRec.Description;
                    IF (CustRec.Address <> '') AND (CustRec."Address 2" <> '') THEN
                        CustAddr := CustRec.Address + ',' + CustRec."Address 2";
                    IF (CustRec.Address <> '') AND (CustRec."Address 2" = '') THEN
                        CustAddr := CustRec.Address;
                    IF (CustRec.Address = '') AND (CustRec."Address 2" <> '') THEN
                        CustAddr := CustRec."Address 2";
                END;

                CustLedgEntryRec.RESET;
                CustLedgEntryRec.SETCURRENTKEY("Customer No.", "Posting Date");
                CustLedgEntryRec.SETRANGE("Customer No.", Customer."No.");
                CustLedgEntryRec.SETRANGE("Posting Date", 0D, StartDateFilter - 1);
                IF CustLedgEntryRec.FINDSET THEN BEGIN
                    REPEAT
                        CustLedgEntryRec.CALCFIELDS(Amount);
                        OpeningBal += CustLedgEntryRec.Amount;
                    UNTIL CustLedgEntryRec.NEXT = 0;
                END;

                IF ((OpeningBal > 0) OR (OpeningBal = 0)) THEN
                    CRDRRunningChanging := 'Dr.'
                ELSE
                    IF OpeningBal < 0 THEN
                        CRDRRunningChanging := 'Cr.';

                OpeningAmountRunning := OpeningBal;
                IF ((OpeningBal > 0) OR (OpeningBal = 0)) THEN
                    CRDROpeningBal := 'Dr.'
                ELSE
                    IF OpeningBal < 0 THEN
                        CRDROpeningBal := 'Cr.';
            end;

            trigger OnPreDataItem()
            begin
                PeriodFilter := Customer.GETFILTER("Date Filter");
                StartDateFilter := Customer.GETRANGEMIN("Date Filter");
                EndDateFilter := Customer.GETRANGEMAX("Date Filter");

                IF EndDateFilter = 0D THEN
                    EndDateVar := StartDateFilter
                ELSE
                    EndDateVar := EndDateFilter;
            end;
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

    trigger OnPreReport()
    begin
        CompanyInFo.GET;
        IF (CompanyInFo.Address <> '') AND (CompanyInFo."Address 2" <> '') THEN
            CompAddr := CompanyInFo.Address + ',' + CompanyInFo."Address 2";
        IF (CompanyInFo.Address <> '') AND (CompanyInFo."Address 2" = '') THEN
            CompAddr := CompanyInFo.Address;
        IF (CompanyInFo.Address = '') AND (CompanyInFo."Address 2" <> '') THEN
            CompAddr := CompanyInFo."Address 2";

        StateRec.RESET;
        IF StateRec.GET(CompanyInFo."State Code") THEN
            CompStateName := StateRec.Description;

        CountryRec.RESET;
        IF CountryRec.GET(CompanyInFo."Country/Region Code") THEN
            CompCountryName := CountryRec.Name;
        CurrDate := TODAY;
        CurrUSerID := USERID;
        CurrDtTime := CURRENTDATETIME;
    end;

    var
        CompanyCap: Label 'Company : ';
        RegionCap: Label 'Region :';
        PeriodCap: Label 'Period  :';
        ReportIDCap: Label 'Report ID :';
        ReportDateCap: Label 'Report Date :';
        PrintedByCap: Label 'Printed By :';
        PageNoCap: Label 'Page No : ';
        StatementAccCap: Label 'Statement of Accounts';
        ACCodeCap: Label 'A/C Code - ';
        VouDateCap: Label 'Vou Date';
        BranchCap: Label 'Branch';
        VouTypeCap: Label 'Vou Type';
        TransNoCap: Label 'TR/TRNS No.';
        DescCap: Label 'Description/DC';
        QtyCap: Label 'Qty(Kg)';
        RateCap: Label 'Rate';
        DebitCap: Label 'Debit';
        CreditCap: Label 'Credit';
        BalCap: Label 'Balance';
        OpeningBalCap: Label 'Opening Balance';
        MonthTtlCap: Label 'Month Total';
        MonthBalCap: Label 'Month Bal';
        GrandTtlCp: Label 'Grand Total';
        ChqRecCap: Label 'Cheque Received but not cleared';
        DateCap: Label 'Date';
        CheqNumCap: Label 'Cheque Number';
        AmountCap: Label 'Amount';
        TotalCap: Label 'Total :';
        CompanyInFo: Record 79;
        CompAddr: Text[100];
        CompStateName: Text;
        CompCountryName: Text;
        PeriodFilter: Text[60];
        PeriodFilterVar1: Text;
        StartDateFilter: Date;
        EndDateFilter: Date;
        EndDateVar: Date;
        RunningBal: Decimal;
        OpeningBal: Decimal;
        CloseningBal: Decimal;
        CustRec: Record 18;
        CustLedgEntryRec: Record 21;
        DebitAmount: Decimal;
        CreditAmount: Decimal;
        OpeningAmountRunning: Decimal;
        CRDROpeningBal: Text;
        CRDRRunningBal: Text;
        CRDRRunningChanging: Text;
        CRDRRunningBalLast: Text;
        SalesInvHeaderRec: Record 112;
        SalesCrMemoHdrRec: Record 114;
        SalesInvLineRec: Record 113;
        DesciptionVal: Text[100];
        QtySum: Decimal;
        AltQtyVal: Integer;
        RateVal: Decimal;
        DesciptionVal1: Text;
        MonthlyNum: Integer;
        DateCap2: Label 'Date  : ';
        SFPLCap: Label 'SUGUNA FOODS PRIVATE LIMITED';
        FinDepttCap: Label 'Finance Department';
        PhoneCap: Label 'Ph : ';
        FaxCap: Label 'Fax : ';
        CustomerCareCap: Label 'Customer Care No : ';
        CBCSCap: Label 'Customer Balance Confirmation Statement';
        ToCap: Label 'To';
        Note1: Label 'We request you to peruse all the transactions in the enclosed statement of Accounts and confirm';
        Note2: Label 'the Balance Amount due to us / due by us within 7 days from the date of receipt of statement';
        Note3: Label 'along with your reconcillation statement ; Otherwise our balance deemed to be final. We also';
        Note4: Label 'request you to settle the dues (if any) at the earliest.';
        ForCap: Label 'For';
        AuthSignCap: Label 'Authorized Signatory';
        SignDateCap: Label 'Signature & Date';
        NameCap: Label 'Name ';
        SealCap: Label 'Seal ';
        MonthName: Text;
        YearVal: Integer;
        CustName: Text[100];
        CustPhone: Text[100];
        CustAddr: Text[100];
        CustFax: Text;
        CustEmail: Text;
        CustCity: Text;
        CustPin: Text;
        StateRec: Record State;
        StateName: Text;
        CountryRec: Record 9;
        SubCap: Label 'Sub : Statement of Accounts for the period from ';
        ToCap1: Label ' To ';
        ConfirmBlCap: Label 'confirmation of Balance ';
        BrCap: Label '(';
        BrCap2: Label ')';
        AsOnCap: Label ' as on ';
        YourBalCap: Label 'Your balance in our books as on ';
        SubjectRealizCap: Label 'subject to the realization of the cheques / DDS listed at the end of the statement';
        INRCap: Label '  is INR ';
        CurrDate: Date;
        CurrUSerID: Text;
        ChqRecNotClrCap: Label 'Cheque received but not cleared : - ';
        ChequeNoCap: Label 'Cheque Number';
        AmtCap: Label 'Amount';
        GrandTtlCap: Label 'Grand Total';
        ClosBalCap: Label 'Closing Balance';
        CommaCap: Label ':';
        CurrDtTime: DateTime;
        MonthT: Integer;
        Integer_R: Record 2000000026;
        LastMonthTotal: Integer;
        YearCount: Integer;
        TCSAmt: Decimal;
        TCSEntry: Record "TCS Entry";//16514;
        CompanyInFoState: Code[10];
}

