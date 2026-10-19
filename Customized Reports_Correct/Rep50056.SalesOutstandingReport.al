report 50056 "Sales Outstanding Report"
{
    UsageCategory = Administration;
    Caption = 'Sales Outstanding Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\SalesOutstandingReport.rdl';



    dataset
    {
        dataitem(Customer; Customer)
        {
            CalcFields = "Net Change";
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending)
                                WHERE("Net Change" = FILTER(<> 0));
            RequestFilterFields = "No.";
            column(TeamType_Customer; TeamType)
            {
            }
            column(TeamName_Customer; TeamName)
            {
            }
            column(SalesPersonName; SalesPerson)
            {
            }
            column(Name_Customer; Customer.Name)
            {
            }
            column(SalesMT; SalesMT)
            {
            }
            column(Amount; Amount)
            {
            }
            column(CMOutstanding; Customer."Net Change")
            {
            }
            column(Last31Amount; Last31Amount)
            {
            }
            column(Next30Amount; Next30Amount)
            {
            }
            column(CreditLimitLCY_Customer; Customer."Credit Limit (LCY)")
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(AsOnDate; AsOnDate)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SalesPerson := '';
                TeamType := '';
                TeamName := '';
                IF SalespersonPurchaser.GET("Salesperson Code") THEN
                    SalesPerson := SalespersonPurchaser.Name;
                TeamSalesperson.RESET;
                TeamSalesperson.SETRANGE("Salesperson Code", "Salesperson Code");
                IF TeamSalesperson.FINDFIRST THEN BEGIN
                    IF Team.GET(TeamSalesperson."Team Code") THEN BEGIN
                        TeamType := FORMAT(Team."Team Type");
                        TeamName := Team.Name;

                    END;
                END;

                // For Current Month Outstanding
                CMOutstanding := 0;
                Qty := 0;
                SalesMT := 0;
                Last31Amount := 0;
                Next30Amount := 0;

                SalesInvoiceLine.RESET;
                SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Posting Date", StartDate, EndDate);
                SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Sell-to Customer No.", "No.");
                SalesInvoiceLine.SetRange(SalesInvoiceLine.Type, SalesInvoiceLine.Type::Item);
                IF SalesInvoiceLine.FINDFIRST THEN
                    REPEAT
                        Qty += SalesInvoiceLine."Quantity (Base)";
                        Amount += SalesInvoiceLine."Amount";
                    UNTIL SalesInvoiceLine.NEXT = 0;

                SalesCreditMemoLine.RESET;
                SalesCreditMemoLine.SETRANGE(SalesCreditMemoLine."Posting Date", StartDate, EndDate);
                SalesCreditMemoLine.SETRANGE(SalesCreditMemoLine."Sell-to Customer No.", "No.");
                SalesCreditMemoLine.SetRange(SalesCreditMemoLine.Type, SalesCreditMemoLine.Type::Item);
                IF SalesCreditMemoLine.FINDFIRST THEN
                    REPEAT
                        Qty -= SalesCreditMemoLine."Quantity (Base)";
                        Amount -= SalesCreditMemoLine."Amount";
                    UNTIL SalesCreditMemoLine.NEXT = 0;

                CMOutstanding := "Net Change";

                IF Qty <> 0 THEN
                    SalesMT := Qty / 1000;

                CustLedgerEntry.RESET;
                CustLedgerEntry.SETCURRENTKEY("Customer No.", "Posting Date");
                CustLedgerEntry.SETRANGE("Date Filter", Next30EndDate, EndDate1);
                CustLedgerEntry.SETRANGE("Posting Date", Next30EndDate, EndDate1);
                CustLedgerEntry.SETRANGE("Customer No.", "No.");
                CustLedgerEntry.SETFILTER("Remaining Amt. (LCY)", '<>%1', 0);
                IF CustLedgerEntry.FINDFIRST THEN
                    REPEAT
                        CustLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)");
                        Next30Amount += CustLedgerEntry."Remaining Amt. (LCY)";
                    UNTIL CustLedgerEntry.NEXT = 0;

                Last31Amount := CMOutstanding - Next30Amount;
            end;

            trigger OnPreDataItem()
            begin
                StartDate := CALCDATE('-CM', AsOnDate);
                EndDate := CALCDATE('CM', AsOnDate);
                IF AsOnDate = 0D THEN
                    ERROR('As on Date should not be Blank');
                EndDate1 := AsOnDate;
                Last31StartDate := CALCDATE('-31D', AsOnDate);
                Next30EndDate := CALCDATE('-30D', AsOnDate);

                DummyDate := CALCDATE('-60Y', TODAY);

                SETRANGE("Date Filter", DummyDate, AsOnDate);
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
                    field("As on Date"; AsOnDate)
                    {
                        Caption = 'As on Date';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            AsOnDate := WORKDATE;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        StartDate := 0D;
        EndDate := 0D;
        EndDate1 := 0D;
        Last31StartDate := 0D;
        Next30EndDate := 0D;
    end;

    var
        AsOnDate: Date;
        CustLedgerEntry: Record 21;
        SalespersonPurchaser: Record 13;
        SalesShipmentHeader: Record 110;
        SalesShipmentLine: Record 111;
        StartDate: Date;
        EndDate: Date;
        Qty: Decimal;
        Amount: Decimal;
        SalesMT: Decimal;
        CMOutstanding: Decimal;
        EndDate1: Date;
        Last31StartDate: Date;
        Next30EndDate: Date;
        Last31Amount: Decimal;
        Next30Amount: Decimal;
        SalesInvoiceLine: Record 113;
        SalesCreditMemoLine: Record "Sales Cr.Memo Line";
        Customer1: Record 18;
        DummyDate: Date;
        Team: Record 5083;
        TeamSalesperson: Record 5084;
        TeamType: Text;
        TeamName: Text;
        SalesPerson: Text;
}

