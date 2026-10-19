pageextension 50128 "Small Business Role Center" extends "Small Business Owner RC"
{
    actions
    {
        addfirst(processing)
        {
            action("General Journal")
            {
                Caption = 'General Journal';
                Image = Journal;
                RunObject = Page "General Journal";
                applicationarea = all;
            }
            action("Inventory Valuation")
            {
                RunObject = Report 1001;
                applicationarea = all;
            }
            action("Flock Performance Report")
            {
                Image = "Report";
                RunObject = Report 50035;
                applicationarea = all;
            }


            action("<Cash Payment Voucher>")
            {
                Caption = 'Cash Payment Voucher';
                Image = Voucher;
                RunObject = Page "Cash Payment Voucher";
                applicationarea = all;
            }
            action("<Cash Receipt Voucher>")
            {
                Caption = 'Cash Receipt Voucher';
                Image = Journal;
                RunObject = Page "Cash Receipt Voucher";
                applicationarea = all;
            }
            action("Item by Location")
            {
                Caption = 'Item by Location';
                Image = Item;
                RunObject = Page 491;
                applicationarea = all;
            }
            action("Consumption journal")
            {
                RunObject = Page 99000846;
                applicationarea = all;
            }

            action("SalesReport(CBF)")
            {
                Caption = 'Report SalesReport(CBF)';
                Image = "Report";
                RunObject = Report 50067;
                applicationarea = all;
            }

            action("Output Journal")
            {
                RunObject = Page 99000823;
                applicationarea = all;
            }
            action("Item Journal")
            {
                RunObject = Page 40;
                applicationarea = all;
            }
            action("Farm Data")
            {
                RunObject = Page 50068;
                applicationarea = all;
            }
            action("Performance Report")
            {
                Image = "Report";
                RunObject = Page 50084;
                applicationarea = all;
            }
        }
        addfirst(Finance)
        {
            action("Purchase credit memo")
            {
                RunObject = Page 50075;
                applicationarea = all;
            }
            action("Sale credit memo line")
            {
                RunObject = Page 50074;
                applicationarea = all;
            }
            action("Sale invoice line")
            {
                RunObject = Page 50073;
                applicationarea = all;
            }
            action("Purchase invoice  line")
            {
                RunObject = Page 50072;
                applicationarea = all;
            }
            action("Transfer receipt line")
            {
                RunObject = Page 50071;
                applicationarea = all;
            }
            action("Transfer shipment line")
            {
                RunObject = Page 50070;
                applicationarea = all;
            }
            action(Production_Order_)
            {
                RunObject = Page 50099;
                applicationarea = all;
            }
        }
        addafter("Accounting Periods")
        {

            action("Stock Report")
            {
                Image = Report;
                RunObject = Report 50070;
                applicationarea = all;
            }

            action("Liquidation Report")
            {
                Image = "Report";
                RunObject = Report 50036;
                applicationarea = all;
            }
            action("Transfer Report")
            {
                Image = "Report";
                RunObject = Report 50075;
                applicationarea = all;
            }
        }
    }
}
