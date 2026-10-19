report 50020 "KFC PRODUCT DISHPATCH REPORT"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout/KFCPRODUCTDISHPATCHREPORT.rdl';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    Caption = 'KFC Product Dispatch';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("Posting Date")
                                ORDER(Ascending);
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
            column(PostingDate; "Sales Invoice Header"."Posting Date")
            {
            }
            column(SelltoCustomerName; "Sales Invoice Header"."Sell-to Customer Name")
            {
            }
            column(VehicleNo; "Sales Invoice Header"."Vehicle No.")
            {
            }
            column(ShiptoCity_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to City")
            {
            }
            column(ShipToCity; "Sales Invoice Header"."Ship-to Name")
            {
            }
            column(No_; "No.")
            { }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = ORDER(Ascending)
                                    WHERE(Type = CONST(Item),
                                          "No." = FILTER(<> ''));
                PrintOnlyIfDetail = false;
                column(ItemName; "Sales Invoice Line".Description)
                {
                }
                column(ItemNo_; "Sales Invoice Line"."No.")
                { }
                dataitem("Value Entry"; "Value Entry")
                {
                    DataItemLinkReference = "Sales Invoice Line";
                    DataItemLink = "Document No." = field("Document No."), "Posting Date" = field("Posting Date"), "Document Line No." = field("Line No.");
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
                    }
                }
            }

            trigger OnAfterGetRecord()
            begin

                Customer.GET("Sales Invoice Header"."Sell-to Customer No.");
                IF NOT Customer."KFC Customer" THEN
                    CurrReport.SKIP;

                CLEAR(ShipToCity);
                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETRANGE("No.", "Sales Invoice Line"."Document No.");
                //SalesInvoiceHeader.SETFILTER("Ship-to Code",'<>%1','');
                IF SalesInvoiceHeader.FINDFIRST THEN
                    ShipToCity := SalesInvoiceHeader."Ship-to Name";
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
        CompanyInfo: Record "Company Information";
        ShipToCity: Text;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        Customer: Record Customer;
}

