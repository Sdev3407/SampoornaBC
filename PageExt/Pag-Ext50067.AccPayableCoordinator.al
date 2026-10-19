pageextension 50067 "Acc.PayableCoordinator" extends "Acc. Payables Coordinator RC"
{
    actions
    {
        addfirst(reporting)
        {
            action("Vendor Statement")
            {
                Caption = 'Vendor Statement';
                Image = "Report";
                RunObject = Report "Vendor Statement";
                Applicationarea = All;
            }
        }
        addafter("&Vendor - List")
        {
            action("Brokerage Commission Report")
            {
                Image = "Report";
                // RunObject = Report 50005;
                Applicationarea = All;
            }
            action("<Inventory Valuation>")
            {
                Caption = 'Inventory Valuation';
                RunObject = Report 1001;
                Applicationarea = All;
            }
            action("TDS Entries")
            {
                Image = "Report";
                RunObject = Report 50072;
                Applicationarea = All;
            }
            action("<Journal Voucher>")
            {
                Caption = 'Journal Voucher';
                Image = Journal;
                RunObject = Page "Journal Voucher";
                Applicationarea = All;
            }

            action("Change Branch")
            {
                RunObject = Page "User Wise Change  Resp. Center";
                Applicationarea = All;
            }
            action("Posted GC-EDit")
            {
                Image = BeginningText;
                RunObject = Page 50079;
                Applicationarea = All;
            }
            action("General Journal")
            {
                Caption = 'General Journal';
                Image = Journal;
                RunObject = Page "General Journal";
                Applicationarea = All;
            }
        }

    }
}