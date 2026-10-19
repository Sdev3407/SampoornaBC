report 50060 "New Analysis Report"
{
    UsageCategory = Administration;
    Caption = 'New Analysis Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\NewAnalysisReport.rdl';
    dataset
    {
        dataitem("Salesperson/Purchaser"; "Salesperson/Purchaser")
        {
            DataItemTableView = WHERE(Blocked = FILTER(false));
            RequestFilterFields = "Code";
            column(Code_SalespersonPurchaser; "Salesperson/Purchaser".Code)
            {
            }
            column(TeamType_Customer; TeamType)
            {
            }
            column(TeamName_Customer; TeamName)
            {
            }
            column(SalesPersonName; "Salesperson/Purchaser".Name)
            {
            }
            dataitem(Date; Date)
            {
                DataItemTableView = SORTING("Period Type", "Period Start")
                                    ORDER(Ascending);
                column(SalesMT; SalesMT)
                {
                }
                column(EndDate; EndDate)
                {
                }
                column(AsOnDate; AsOnDate)
                {
                }
                column(PeriodStart_Date; Date."Period Start")
                {
                }
                column(PeriodEnd_Date; Date."Period End")
                {
                }
                column(TotalSalesVale; TotalSalesVale)
                {
                }
                column(AvergaeSellingRate; AvergaeSellingRate)
                {
                }
                column(NoofDays; NoofDays)
                {
                }
                column(Outstanding; Outstanding)
                {
                }

                trigger OnAfterGetRecord()
                var
                    recCustomer: Record 18;
                begin
                    Outstanding := 0;
                    Qty := 0;
                    SalesMT := 0;
                    CrQty := 0;
                    TotalQty := 0;
                    TotalSalesVale := 0;
                    CRSalesVale := 0;
                    SalesVale := 0;
                    AvergaeSellingRate := 0;
                    NoofDays := 0;

                    Customer.RESET;
                    Customer.SETRANGE("Salesperson Code", "Salesperson/Purchaser".Code);
                    Customer.SETRANGE("Date Filter", DummyDate, NORMALDATE(Date."Period End"));
                    Customer.CALCFIELDS("Net Change");
                    IF Customer.FINDFIRST THEN
                        REPEAT
                            Customer.CALCFIELDS("Net Change");
                            Outstanding += Customer."Net Change";
                            CustLedgerEntry.RESET;
                            CustLedgerEntry.SETCURRENTKEY("Customer No.", "Posting Date");
                            CustLedgerEntry.SETRANGE("Date Filter", Date."Period Start", NORMALDATE(Date."Period End"));
                            CustLedgerEntry.SETRANGE("Posting Date", Date."Period Start", NORMALDATE(Date."Period End"));
                            CustLedgerEntry.SETRANGE("Customer No.", Customer."No.");
                            IF CustLedgerEntry.FINDFIRST THEN
                                REPEAT
                                    CustLedgerEntry.CALCFIELDS("Original Amount");
                                    IF (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Invoice) THEN BEGIN
                                        SalesVale += CustLedgerEntry."Original Amount";
                                        SalesInvoiceLine.RESET;
                                        SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Document No.", CustLedgerEntry."Document No.");
                                        SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Sell-to Customer No.", CustLedgerEntry."Customer No.");
                                        SalesInvoiceLine.SETRANGE(SalesInvoiceLine.Type, SalesInvoiceLine.Type::Item);
                                        IF SalesInvoiceLine.FINDFIRST THEN
                                            REPEAT
                                                Qty += SalesInvoiceLine."Quantity (Base)";
                                            UNTIL SalesInvoiceLine.NEXT = 0;
                                    END;
                                /*
                                    IF (CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::"Credit Memo") THEN BEGIN
                                      CRSalesVale += CustLedgerEntry."Original Amount";
                                      SalesCrMemoLine.RESET;
                                      SalesCrMemoLine.SETRANGE(SalesCrMemoLine."Document No.",CustLedgerEntry."Document No.");
                                      SalesCrMemoLine.SETRANGE(SalesCrMemoLine."Sell-to Customer No.",CustLedgerEntry."Customer No.");
                                      IF SalesCrMemoLine.FINDFIRST THEN REPEAT
                                        CrQty += SalesCrMemoLine."Quantity (Base)";
                                      UNTIL SalesCrMemoLine.NEXT = 0;
                                    END;
                                    */
                                UNTIL CustLedgerEntry.NEXT = 0;

                        UNTIL Customer.NEXT = 0;


                    TotalQty := Qty; //- CrQty;
                    IF TotalQty <> 0 THEN
                        SalesMT := TotalQty / 1000;

                    TotalSalesVale := SalesVale; //- CRSalesVale;

                    IF (TotalSalesVale <> 0) AND (SalesMT <> 0) THEN
                        AvergaeSellingRate := TotalSalesVale / SalesMT;

                    IF (Outstanding <> 0) AND (TotalSalesVale <> 0) THEN
                        NoofDays := (Outstanding / TotalSalesVale) * 30;

                end;

                trigger OnPreDataItem()
                begin
                    Date.SETRANGE("Period Type", Date."Period Type"::Month);
                    Date.SETRANGE("Period Start", StartDate, EndDate);
                    DummyDate := CALCDATE('-60Y', StartDate);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                SalesPerson := '';
                TeamType := '';
                TeamName := '';
                Outstanding := 0;

                SalesPerson := Name;
                TeamSalesperson.RESET;
                TeamSalesperson.SETRANGE("Salesperson Code", Code);
                IF TeamSalesperson.FINDFIRST THEN BEGIN
                    IF Team.GET(TeamSalesperson."Team Code") THEN BEGIN
                        TeamType := FORMAT(Team."Team Type");
                        TeamName := Team.Name;
                    END;
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
                group(Option)
                {
                    Caption = 'Option';
                    field(StartDate; StartDate)
                    {
                        Caption = 'Start Date';
                        ApplicationArea = All;
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'End Date';
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

    var
        AsOnDate: Date;
        CustLedgerEntry: Record 21;
        SalespersonPurchaser: Record 13;
        StartDate: Date;
        EndDate: Date;
        Qty: Decimal;
        SalesMT: Decimal;
        CMOutstanding: Decimal;
        SalesInvoiceLine: Record 113;
        Customer: Record 18;
        DummyDate: Date;
        Team: Record 5083;
        TeamSalesperson: Record 5084;
        TeamName: Text;
        TeamType: Text;
        SalesPerson: Text;
        Outstanding: Decimal;
        SalesCrMemoLine: Record 115;
        CrQty: Decimal;
        SalesVale: Decimal;
        CRSalesVale: Decimal;
        TotalQty: Decimal;
        TotalSalesVale: Decimal;
        AvergaeSellingRate: Decimal;
        NoofDays: Decimal;
}

