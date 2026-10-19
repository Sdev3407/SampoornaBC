report 50087 SPZeroSalesOutstanding
{

    ApplicationArea = All;
    Caption = 'SP Zero Sales Outstanding';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\SP Zero Sales Outstanding Report.rdl';
    dataset
    {
        dataitem(SalespersonPurchaser; "Salesperson/Purchaser")
        {
            DataItemTableView = where(Blocked = filter(false));
            PrintOnlyIfDetail = true;
            column(SPName; Name)
            { }
            dataitem(Customer; Customer)
            {

                DataItemLink = "Salesperson Code" = field(Code);
                DataItemLinkReference = SalespersonPurchaser;
                DataItemTableView = where("Sales (LCY)" = filter(0), "Balance (LCY)" = filter(> 0), "Customer Posting Group" = Filter('DOMESTIC'));

                column(CustName; Name)
                { }
                column(Balance__LCY_; ("Balance (LCY)" / 100000))
                { }
                column(LastWorkingDate; LastWorkingDate)
                { }

                trigger OnAfterGetRecord()
                var
                    CustLedger: Record "Cust. Ledger Entry";
                Begin
                    Clear(LastWorkingDate);
                    CustLedger.Reset();
                    CustLedger.SetCurrentKey("Customer No.", "Posting Date");
                    CustLedger.SetRange("Customer No.", Customer."No.");
                    CustLedger.SetRange("Document Type", CustLedger."Document Type"::Invoice);
                    if CustLedger.FindLast() then
                        LastWorkingDate := CustLedger."Posting Date";
                End;

                trigger OnPreDataItem()
                begin
                    Customer.SetAutoCalcFields("Balance (LCY)", "Sales (LCY)");
                    Customer.SetLoadFields("No.", "Salesperson Code", Name, "Balance (LCY)", "Sales (LCY)");
                    Customer.SetFilter("Date Filter", '%1..%2', CalcDate('-2M', WorkDate()), WorkDate());
                end;
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    var
        LastWorkingDate: date;

}
