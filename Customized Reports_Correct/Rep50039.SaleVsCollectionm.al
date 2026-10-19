report 50039 "Sale Vs Collectionm"
{

    UsageCategory = Administration;
    Caption = 'Sale Vs Collection Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\SaleVsCollectionm.rdl';

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = ORDER(Ascending)
                                WHERE("Global Dimension 1 Code" = FILTER('FEED | CATTLE'));
            column(CustNo; "Cust. Ledger Entry"."Customer No.")
            {
            }
            column(SalespersonCode; "Cust. Ledger Entry"."Salesperson Code")
            {
            }
            column(TeamCode; TeamCode)
            {
            }
            column(SalesPersonName; SalesPersonName)
            {
            }
            column(SalesPerCode; SalesPerCode)
            {
            }
            column(CustmCode; CustmCode)
            {
            }
            column(Amt21; Amt21)
            {
            }
            column(DocNo; "Cust. Ledger Entry"."Document No.")
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(CustomerName; "Cust. Ledger Entry"."Customer Name")
            {
            }
            column(AsOnDate; AsOnDate)
            {
            }
            column(MTDAmount; MTDAmount)
            {
            }
            column(YTDAmount; YTDAmount)
            {
            }
            column(GrandTotalMTD; GrandTotalMTD)
            {
            }
            column(PrintDate; PrintDate)
            {
            }
            column(GrandTotalytd; GrandTotalytd)
            {
            }
            column(CustNo1; CustNo)
            {
            }
            dataitem(Temp; "Cust. Ledger Entry")
            {
                DataItemLink = "Document No." = FIELD("Document No.");
                DataItemTableView = ORDER(Ascending)
                                    WHERE("Global Dimension 1 Code" = FILTER('FEED | CATTLE'));
                column(Amt; Amt)
                {
                }
                column(AMT11; AMT11)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Amt := 0;
                    CustLedgerEntry.RESET;
                    CustLedgerEntry.SETRANGE("Posting Date", StartDate, EndDate);
                    CustLedgerEntry.SETRANGE("Document No.", Temp."Document No.");
                    CustLedgerEntry.SETRANGE("Customer No.", Temp."Customer No.");
                    CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
                    IF CustLedgerEntry.FINDFIRST THEN
                        REPEAT
                            CustLedgerEntry.CALCFIELDS("Original Amount");
                            Amt += CustLedgerEntry."Original Amount";
                        UNTIL CustLedgerEntry.NEXT = 0;
                    //
                    CLEAR(AMT11);
                    CustLedgerEntry.RESET;
                    CustLedgerEntry.SETRANGE("Posting Date", StartDate, EndDate);
                    CustLedgerEntry.SETRANGE("Document No.", Temp."Document No.");
                    CustLedgerEntry.SETRANGE("Customer No.", Temp."Customer No.");
                    CustLedgerEntry.SETRANGE("Entry No.", Temp."Entry No.");
                    CustLedgerEntry.SETFILTER("Document Type", '%1|%2', CustLedgerEntry."Document Type"::Payment, CustLedgerEntry."Document Type"::Refund);
                    IF CustLedgerEntry.FINDFIRST THEN
                        REPEAT
                            CustLedgerEntry.CALCFIELDS("Original Amount");
                            AMT11 += CustLedgerEntry."Original Amount";
                        UNTIL CustLedgerEntry.NEXT = 0;
                end;

                trigger OnPreDataItem()
                begin
                    Temp.SETRANGE("Posting Date", StartDate, EndDate);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(TeamCode);
                Customer.RESET;
                Customer.SETRANGE("No.", "Cust. Ledger Entry"."Customer No.");
                IF Customer.FINDFIRST THEN
                    TeamCode := Customer."Team Code";
                //
                CLEAR(SalesPerCode);
                Customer.RESET;
                Customer.SETRANGE("No.", "Cust. Ledger Entry"."Customer No.");
                IF Customer.FINDFIRST THEN
                    SalesPerCode := Customer."Salesperson Code";
                //
                CLEAR(CustNo);
                Customer.RESET;
                Customer.SETRANGE("No.", "Cust. Ledger Entry"."Customer No.");
                IF Customer.FINDFIRST THEN
                    CustNo := Customer."No.";
                //


                CLEAR(SalesPersonName);
                SalespersonPurchaser.RESET;
                SalespersonPurchaser.SETRANGE(Code, SalesPerCode);
                IF SalespersonPurchaser.FINDFIRST THEN
                    SalesPersonName := SalespersonPurchaser.Name;
                //===========================Amount=====================================

                //
                MTDAmount := 0;
                CustLedgerEntry.RESET;
                CustLedgerEntry.SETRANGE("Posting Date", StartDate, EndDate);
                CustLedgerEntry.SETRANGE("Document No.", "Cust. Ledger Entry"."Document No.");
                CustLedgerEntry.SETRANGE("Customer No.", "Cust. Ledger Entry"."Customer No.");
                //CustLedgerEntry.SETRANGE("Salesperson Code","Cust. Ledger Entry"."Salesperson Code");
                CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
                IF CustLedgerEntry.FINDFIRST THEN
                    REPEAT
                        CustLedgerEntry.CALCFIELDS("Original Amount");
                        MTDAmount += CustLedgerEntry."Original Amount";
                    UNTIL CustLedgerEntry.NEXT = 0;
                //
                YTDAmount := 0;
                CustLedgerEntry21.RESET;
                CustLedgerEntry.SETRANGE("Posting Date", StartDate, EndDate);
                CustLedgerEntry21.SETRANGE("Document No.", "Cust. Ledger Entry"."Document No.");
                CustLedgerEntry21.SETRANGE("Customer No.", "Cust. Ledger Entry"."Customer No.");
                CustLedgerEntry21.SETRANGE("Entry No.", "Cust. Ledger Entry"."Entry No.");
                CustLedgerEntry21.SETFILTER("Document Type", '%1|%2', CustLedgerEntry21."Document Type"::Payment, CustLedgerEntry21."Document Type"::Refund);
                IF CustLedgerEntry21.FINDFIRST THEN
                    REPEAT
                        CustLedgerEntry21.CALCFIELDS("Original Amount");
                        YTDAmount += CustLedgerEntry21."Original Amount";
                    UNTIL CustLedgerEntry21.NEXT = 0;

                //========================================================================
                IF (YTDAmount = 0) AND (MTDAmount = 0) THEN
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                "Cust. Ledger Entry".SETRANGE("Posting Date", StartDate, EndDate);
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
                    field(AsOnDate; AsOnDate)
                    {
                        Caption = 'AsOnDate';
                        Visible = false;
                    }
                    field("Start Date"; StartDate)
                    {
                        ApplicationArea = All;
                    }
                    field("End Date"; EndDate)
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
            //AsOnDate := AsOnDate;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        Last := 1;
        //AsOnDate := CALCDATE('-1D',WORKDATE);
        //AsOnDate := AsOnDate;
        //Day := DATE2DMY(AsOnDate,1);
        //Month := DATE2DMY(AsOnDate,2);
        //Year := DATE2DMY(AsOnDate,3);
        //StaringDate := DMY2DATE(1,Month,Year);
    end;

    var
        CustLedgerEntry: Record 21;
        Amt: Decimal;
        SalespersonPurchaser: Record 13;
        SalesPersonName: Text;
        AMT11: Decimal;
        AsOnDate: Date;
        StartDate: Date;
        EndDate: Date;
        PrintDate: Text[50];
        TotAmt: Decimal;
        CustNo: Code[20];
        TeamCode: Code[20];
        TeamSalesperson: Record 5084;
        Customer: Record 18;
        SalesPerCode: Code[20];
        CustmCode: Code[20];
        Amt21: Decimal;
        CustName: Text;
        MTDAmount: Decimal;
        YTDAmount: Decimal;
        Last: Integer;
        Day: Integer;
        Month: Integer;
        Year: Integer;
        StaringDate: Date;
        GrandTotalMTD: Decimal;
        GrandTotalytd: Decimal;
        CustLedgerEntry21: Record 21;
}

