report 50066 "SalesReport(CBF)"
{
    UsageCategory = Administration;
    Caption = 'Sales Report (CBF)';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\SalesReportCBF.rdl';

    dataset
    {
        dataitem("Sales Invoice Line"; "Sales Invoice Line")
        {
            DataItemTableView = WHERE("Shortcut Dimension 1 Code" = FILTER('CBF'),
                                      Type = FILTER(Item));
            RequestFilterFields = "Posting Date", "Shortcut Dimension 2 Code";
            column(DocumentNo; "Sales Invoice Line"."Document No.")
            {
            }
            column(LocationCode; "Sales Invoice Line"."Location Code")
            {
            }
            column(Quantity; "Sales Invoice Line".Quantity)
            {
            }
            column(Amount; "Sales Invoice Line".Amount)
            {
            }
            column(UnitPrice; "Sales Invoice Line"."Unit Price")
            {
            }
            column(PostingDate; "Sales Invoice Line"."Posting Date")
            {
            }
            column(AlternateQuantity; "Sales Invoice Line"."Alternate Quantity")
            {
            }
            column(ShortcutDimension2Code; "Sales Invoice Line"."Shortcut Dimension 2 Code")
            {
            }
            column(DcNo; DcNo)
            {
            }
            column(PanNo; PanNo)
            {
            }
            column(FlockAge; ABS(FlockAge))
            {
            }
            column(CustName; CustName)
            {
            }
            column(LocationName; LocationName)
            {
            }
            column(ReportDate; ReportDate)
            {
            }
            column(BranchName; BranchName)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(CustName);
                CLEAR(LocationName);
                CLEAR(DcNo);
                CLEAR(PanNo);
                CLEAR(FlockAge);
                CLEAR(BranchName);
                //
                Customer.RESET;
                Customer.SETRANGE("No.", "Sales Invoice Line"."Sell-to Customer No.");
                IF Customer.FINDFIRST THEN
                    CustName := Customer.Name;
                //
                Location.RESET;
                Location.SETRANGE(Code, "Sales Invoice Line"."Location Code");
                IF Location.FINDFIRST THEN
                    LocationName := Location.Name;

                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETRANGE("No.", "Sales Invoice Line"."Document No.");
                IF SalesInvoiceHeader.FINDFIRST THEN
                    DcNo := SalesInvoiceHeader."DC No.";
                PanNo := SalesInvoiceHeader."P.A.N. No.";

                ProductionOrder.RESET;
                ProductionOrder.SETRANGE("No.", "Sales Invoice Line"."Flock No.");
                IF ProductionOrder.FINDFIRST THEN
                    FlockAge := (ProductionOrder."Due Date" - 1) - "Sales Invoice Line"."Posting Date";

                /*DimensionValue.RESET;
                DimensionValue.SETRANGE("Dimension Value ID","Sales Invoice Line"."Dimension Set ID");
                IF DimensionValue.FINDSET THEN
                  BranchName :=DimensionValue.Name;*/

                //
                DimensionValue.RESET;
                DimensionValue.SETRANGE(DimensionValue."Dimension Code", 'BRANCH');
                DimensionValue.SETRANGE(DimensionValue.Code, "Sales Invoice Line"."Shortcut Dimension 2 Code");
                IF DimensionValue.FINDFIRST THEN
                    BranchName := DimensionValue.Name;


                //
                //"Shortcut Dimension 2 Code" := DimensionValue.Code > '3000' THEN
                //ERROR('Can not Dimension open');

            end;

            trigger OnPreDataItem()
            begin
                ReportDate := WORKDATE;
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

    var
        SalesInvoiceHeader: Record 112;
        DcNo: Code[20];
        PanNo: Code[10];
        Location: Record 14;
        LocationName: Text[50];
        ReportDate: Date;
        Customer: Record 18;
        CustName: Text[50];
        ProductionOrder: Record 5405;
        FlockAge: Decimal;
        DimensionValue: Record 349;
        BranchName: Text[50];
}

