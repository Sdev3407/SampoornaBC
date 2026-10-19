report 50042 "Sales Person Statistic"
{
    Caption = 'Salesperson - Sales Statistics';
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\SalesPersonStatistic.rdl';
    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            MaxIteration = 0;
            RequestFilterFields = "Posting Date";
            column(SalespersonCode_CustLedgerEntry; "Cust. Ledger Entry"."Salesperson Code")
            {
            }
            column(TeamCode; TeamSalesperson."Team Code")
            {
            }
            column(SalesPersonName; SalespersonPurchaser.Name)
            {
            }
            column(TenDayColl; TenDayColl)
            {
            }
            column(TenDaySales; TenDaySales)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF RemoveDuplicate <> "Cust. Ledger Entry"."Salesperson Code" THEN BEGIN
                    SalespersonPurchaser.RESET;
                    IF SalespersonPurchaser.GET("Cust. Ledger Entry"."Salesperson Code") THEN;
                    TeamSalesperson.RESET;
                    TeamSalesperson.SETRANGE(TeamSalesperson."Salesperson Code", "Cust. Ledger Entry"."Salesperson Code");
                    IF TeamSalesperson.FINDFIRST THEN;
                    CustLedgerEntry.RESET;
                    CustLedgerEntry.COPYFILTERS("Cust. Ledger Entry");
                    CustLedgerEntry.SETRANGE(CustLedgerEntry."Salesperson Code", "Cust. Ledger Entry"."Salesperson Code");
                    CustLedgerEntry.SETRANGE(CustLedgerEntry."Posting Date", StartDate, AsonDate);
                    CustLedgerEntry.SETFILTER(CustLedgerEntry."Document Type", '%1|%2', CustLedgerEntry."Document Type"::"Credit Memo", CustLedgerEntry."Document Type"::Invoice);
                    IF CustLedgerEntry.FINDSET THEN BEGIN
                        REPEAT
                            CustLedgerEntry.CALCFIELDS(Amount);
                            TenDaySales := CustLedgerEntry.Amount;
                        UNTIL CustLedgerEntry.NEXT = 0;
                    END;
                    CustLedgerEntry.RESET;
                    CustLedgerEntry.COPYFILTERS("Cust. Ledger Entry");
                    CustLedgerEntry.SETRANGE(CustLedgerEntry."Salesperson Code", "Cust. Ledger Entry"."Salesperson Code");
                    CustLedgerEntry.SETRANGE(CustLedgerEntry."Posting Date", StartDate, AsonDate);
                    CustLedgerEntry.SETFILTER(CustLedgerEntry."Document Type", '%1', CustLedgerEntry."Document Type"::Payment);
                    IF CustLedgerEntry.FINDSET THEN BEGIN
                        REPEAT
                            CustLedgerEntry.CALCFIELDS(Amount);
                            TenDayColl := CustLedgerEntry.Amount;
                        UNTIL CustLedgerEntry.NEXT = 0;
                    END;
                    RemoveDuplicate := "Cust. Ledger Entry"."Salesperson Code";
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
                field("As On date"; AsonDate)
                {
                    ApplicationArea = All;
                }

            }
        }

        actions
        {
        }
    }

    labels
    {
        ReportLabel = 'Salesperson - Sales Statistics';
        PageLabel = 'Page';
        AmountsInLCYLabel = 'All amounts are in LCY';
        ProfitPctLabel = 'Profit %';
        InvDiscAmountLabel = 'Invoice Disc. Amount (LCY)';
        PmtDiscGivenLabel = 'Payment Disc. Given (LCY)';
        PmtToleranceLabel = 'Pmt. Tolerance (LCY)';
        AdjProfitPctLabel = 'Adjusted Profit %';
        AdjProfitLCYLabel = 'Adjusted Profit (LCY)';
        TotalLabel = 'Total';
        SalesLCYLabel = 'Sales (LCY)';
        ProfitLCYLabel = 'Profit (LCY)';
        CodeLabel = 'Code';
    }

    trigger OnPreReport()
    begin
        IF AsonDate = 0D THEN
            AsonDate := TODAY;
        StartDate := CALCDATE('<-10D>', AsonDate);
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        Text000: Label 'Period: %1';
        SalespersonFilter: Text;
        CustLedgEntryFilter: Text;
        PeriodText: Text[30];
        AdjProfit: Decimal;
        ProfitPct: Decimal;
        AdjProfitPct: Decimal;
        SalesLCY: Decimal;
        ProfitLCY: Decimal;
        InvDiscLCY: Decimal;
        PmtDiscGivenLCY: Decimal;
        PmtToleranceLCY: Decimal;
        TeamSalesperson: Record 5084;
        SalespersonPurchaser: Record 13;
        AsonDate: Date;
        StartDate: Date;
        CustLedgerEntry: Record 21;
        TenDaySales: Decimal;
        TenDayColl: Decimal;
        AsonOutstanding: Decimal;
        RemoveDuplicate: Code[20];
        UserSetup: Record 91;
        CompanyInformation: Record 79;
}

