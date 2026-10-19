report 50063 "Product Release Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout/ProductReleaseReport.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;


    dataset
    {
        dataitem("Sales Invoice Line"; "Sales Invoice Line")
        {
            DataItemTableView = SORTING("Posting Date")
                                ORDER(Ascending)
                                WHERE(Type = CONST(Item),
                                      Quantity = FILTER(<> 0),
                                      "No." = FILTER(<> ''));
            RequestFilterFields = "Posting Date", "No.";
            PrintOnlyIfDetail = false;
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfoCity; CompanyInfo.City)
            {
            }
            column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfoPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyInfoGSTRegistrationNo; CompanyInfo."GST Registration No.")
            {
            }
            column(PostingDate; "Sales Invoice Line"."Posting Date")
            {
            }
            column(ItemName; "Sales Invoice Line".Description)
            {
            }

            // column(Quantity; "Sales Invoice Line".Quantity)
            // {
            // }
            column(DocumentNo; "Sales Invoice Line"."Document No.")
            {
            }
            column(CustomerName; CustomerName)
            {
            }
            // column(BatchDate; BatchDate)
            // {
            // }
            column(ShipToCity; ShipToCity)
            {
            }

            column(Descrip; Descrip)
            {
            }
            column(DocumentNo1; "Sales Invoice Line"."Document No.")
            {
            }
            column(Postingdate1; "Sales Invoice Line"."Posting Date")
            {
            }
            column(Batchno1; Batchno)
            {
            }
            column(ShiptoName; ShiptoName)
            {
            }
            dataitem("Value Entry"; "Value Entry")
            {
                DataItemLinkReference = "Sales Invoice Line";
                DataItemLink = "Document No." = field("Document No."), "Posting Date" = field("Posting Date"), "Document Line No." = field("Line No.");
                DataItemTableView = where(Adjustment = filter(false));
                PrintOnlyIfDetail = false;
                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    DataItemLinkReference = "Value Entry";
                    DataItemLink = "Entry No." = field("Item Ledger Entry No.");
                    DataItemTableView = order(ascending);
                    column(BatchNo; "Item Ledger Entry"."Lot No.")
                    {
                    }
                    column(Document_No_; "Document No.")
                    { }
                    column(Quantity; "Item Ledger Entry".Quantity * -1)
                    {
                    }
                    column(Qty; "Item Ledger Entry".Quantity * -1)
                    {
                    }
                    column(BatchDate; BatchDate)
                    { }
                    trigger OnAfterGetRecord()
                    var
                        ILE: record "Item Ledger Entry";
                    begin
                        CLEAR(BatchDate);

                        BatchMaster.RESET;
                        BatchMaster.SETRANGE("Batch No.", "Item Ledger Entry"."Lot No.");
                        IF BatchMaster.FINDFIRST THEN
                            BatchDate := BatchMaster."Batch Date";
                    end;
                }
            }
            trigger OnAfterGetRecord()
            begin
                CLEAR(CustomerName);
                Customer.RESET;
                Customer.SETRANGE("No.", "Sales Invoice Line"."Sell-to Customer No.");
                IF Customer.FINDFIRST THEN
                    CustomerName := Customer.Name;


                CLEAR(ShipToCity);
                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETRANGE("No.", "Sales Invoice Line"."Document No.");
                IF SalesInvoiceHeader.FINDFIRST THEN
                    ShipToCity := SalesInvoiceHeader."Ship-to City";

                CLEAR(ShiptoName);
                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETRANGE("No.", "Sales Invoice Line"."Document No.");
                IF SalesInvoiceHeader.FINDFIRST THEN
                    ShiptoName := SalesInvoiceHeader."Ship-to Name";
                //
                CLEAR(Qty);
                CLEAR(Postingdate);
                CLEAR(DocumentNo);
                CLEAR(Batchno);
                Item.RESET;
                Item.SETRANGE("No.", "Sales Invoice Line"."No.");
                IF Item.FINDFIRST THEN
                    REPEAT
                    // IF Item."Item Type" = Item."Item Type"::"Finished Product" THEN
                    //   Qty :="Sales Invoice Line".Quantity;
                    //   Postingdate := "Sales Invoice Line"."Posting Date";
                    //   DocumentNo := "Sales Invoice Line"."Document No.";
                    //   Batchno := "Sales Invoice Line"."Batch No.";
                    UNTIL Item.NEXT = 0;
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
        CompanyInfo.GET;
    end;

    var
        CompanyInfo: Record "79";
        Customer: Record "18";
        CustomerName: Text[50];
        BatchMaster: Record "Batch Master";
        BatchDate: Date;
        ShipToCity: Text;
        SalesInvoiceHeader: Record "112";
        Item: Record "27";
        Qty: Decimal;
        SalesInvoiceLine: Record "113";
        Postingdate: Date;
        DocumentNo: Code[20];
        Descrip: Text[50];
        Batchno: Code[20];
        ShiptoName: Text;
}

