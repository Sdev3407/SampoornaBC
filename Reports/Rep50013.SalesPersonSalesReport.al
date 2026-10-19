report 50013 "SalesPerson Sales Report"
{
    // 50013
    ApplicationArea = All;
    Caption = 'SP Wise Sales';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\SP Wise Sales Report.rdl';
    dataset
    {
        dataitem(SalespersonPurchaser; "Salesperson/Purchaser")
        {
            DataItemTableView = where(Blocked = filter(false));
            column(Name; Name)
            { }
            column(CustCount; CustCount)
            { }
            column(RemBal; RemBal)
            { }
            column(AvgSales; AvgSales)
            { }
            column(AvgDebtorPerDaySales; AvgDebtorPerDaySales)
            { }
            trigger OnAfterGetRecord()
            var
                RecCust: Record Customer;
                RecCLE: Record "Cust. Ledger Entry";
            begin
                Clear(RemBal);
                Clear(CustCount);
                Clear(AvgDebtorPerDaySales);
                Clear(AvgSales);
                RecCust.Reset();
                RecCust.SetLoadFields("Salesperson Code", "No.", "Balance (LCY)");
                RecCust.SetAutoCalcFields("Balance (LCY)");
                RecCust.SetRange("Salesperson Code", SalespersonPurchaser.Code);
                if RecCust.FindSet() then
                    CustCount := RecCust.Count;
                RecCust.SetFilter("Balance (LCY)", '<>%1', 0);
                if RecCust.FindSet() then begin
                    repeat
                        RemBal += RecCust."Balance (LCY)";
                    until RecCust.Next() = 0;
                end;

                Clear(AvgSales);
                RecCLE.Reset();
                RecCLE.SetLoadFields("Posting Date", "Salesperson Code", "Sales (LCY)");
                RecCLE.SetRange("Posting Date", CalcDate('-3M', WorkDate()), WorkDate());
                RecCLE.SetRange("Salesperson Code", SalespersonPurchaser.Code);
                RecCLE.SetFilter("Sales (LCY)", '<>%1', 0);
                if RecCLE.FindSet() then begin
                    RecCLE.CalcSums("Sales (LCY)");
                    AvgSales := (RecCLE."Sales (LCY)" / 3);
                    // if AvgSales <> 0 then
                    //     AvgSales /= 3;
                end;

                if (RemBal = 0) and (AvgSales = 0) then
                    CurrReport.Skip();

                AvgDebtorPerDaySales := 0;
                if AvgSales <> 0 then
                    AvgDebtorPerDaySales := ((RemBal / (AvgSales)) * 30);
                AvgSales /= 100000;
                RemBal /= 100000;
            end;
        }
    }
    var
        CustCount: Integer;
        AvgSales: Decimal;
        RemBal: Decimal;
        AvgDebtorPerDaySales: Decimal;
        SalHDR: Record "Sales Header";
}
