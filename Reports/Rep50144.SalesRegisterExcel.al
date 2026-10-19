namespace Sampoorna_BC.Sampoorna_BC;

using System.Utilities;
using Microsoft.Sales.History;
using Microsoft.Finance.TCS.TCSBase;
using Microsoft.Finance.TDS.TDSBase;
using Microsoft.Finance.GST.Base;
using Microsoft.Inventory.Item;
using Microsoft.Sales.Document;
using Microsoft.Sales.Customer;
using System.IO;

report 50144 SalesRegisterExcel
{
    ApplicationArea = All;
    Caption = 'Sales Register Excel';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Integer; "Integer")
        {
            DataItemTableView = where(Number = filter(1));

            dataitem("SIL"; "Sales Invoice Line")
            {
                DataItemLinkReference = Integer;
                DataItemTableView = order(ascending) where(Quantity = filter(<> 0));
                trigger OnAfterGetRecord()
                begin
                    CreateReportBody(SIL."Line No.", 'Invoice', SIL."Document No.", SIL."Posting Date", SIL."Sell-to Customer No.",
                    Format(SIL.Type), SIL."No.", SIL."Quantity", SIL."Unit Price", SIL."Line Discount Amount", SIL."Line Discount %",
                    SIL."Line Amount", SIL.Amount, SIL."Location Code", SIL."Alternate Quantity", SIL."Alternate UOM", SIL."Flock No.",
                    SIL."Bird Type", SIL."Male Brid Qty.", SIL."Female Bird Qty.", SIL."Freight Reimbursment Discount", SIL."Location State Code", SIL."Price Discount", SIL."HSN/SAC Code",
                    SIL.MRP, SIL."MRP Price", SIL."Total MRP", SIL."Item Category Code", SIL."Gen. Prod. Posting Group", SIL."GST Jurisdiction Type",
                    SIL."GST Group Code", SIL."Invoice Type", SIL."GST Place of Supply", SIL."GST Group Type", SIL."Item Type", SIL."Unit of Measure Code",
                    SIL.Description);

                    Customter.Get("Sell-to Customer No.");
                end;

                trigger OnPreDataItem()
                begin
                    SIL.SetRange("Posting Date", Startdate, EndDate);
                end;

            }

            dataitem("SCL"; "Sales Cr.Memo Line")
            {
                DataItemLinkReference = Integer;
                DataItemTableView = order(ascending) where(Quantity = filter(<> 0));
                trigger OnAfterGetRecord()


                begin
                    CreateReportBody(SCL."Line No.", 'Credit Memo', SCL."Document No.", SCL."Posting Date", SCL."Sell-to Customer No.",
                    Format(SCL.Type), SCL."No.", SCL."Quantity" * -1, SCL."Unit Price", SCL."Line Discount Amount", SCL."Line Discount %",
                    SCL."Line Amount" * -1, SCL.Amount * -1, SCL."Location Code", SCL."Alternate Quantity", SCL."Alternate UOM", SCL."Flock No.",
                    SCL."Bird Type", SCL."Male Brid Qty.", SCL."Female Bird Qty.", SCL."Freight Reimbursment Discount", SCL."Location State Code", SCL."Price Discount", SCL."HSN/SAC Code",
                    SCL.MRP, SCL."MRP Price", SCL."Total MRP", SCL."Item Category Code", SCL."Gen. Prod. Posting Group", SCL."GST Jurisdiction Type",
                    SCL."GST Group Code", SCL."Invoice Type", SCL."GST Place of Supply", SCL."GST Group Type", SCL."Item Type", SCL."Unit of Measure Code",
                    SCL.Description);
                    Customter.get("Sell-to Customer No.");
                end;

                trigger OnPreDataItem()
                begin
                    SCL.SetRange("Posting Date", Startdate, EndDate);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CreateReportheader();
            end;

            trigger OnPostDataItem()
            begin
                CreateExcel();
            end;

            trigger OnPreDataItem()
            begin
                Excelbuffer.Reset();
                Excelbuffer.DeleteAll();
                Excelbuffer.CreateNewBook('Sales Register');
            end;
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
                    field(Startdate; Startdate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
        trigger OnClosePage()
        begin
            if EndDate = 0D then
                EndDate := Today;
            if Startdate = 0D then
                Startdate := 0D;
        end;
    }
    procedure CreateReportheader()
    var

    begin

        Excelbuffer.NewRow();
        Excelbuffer.AddColumn('Document Type', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Document No.', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Posting Date', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Sell to No.', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Sell to Name.', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Type', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('No.', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Description', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Quantity', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Unit Price', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Discount Amount', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Discount %', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Amount', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('GST Amount', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('TDS Amount', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('TCS Amount', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Total Amount', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Location Code', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Alternate Qty', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Alternate UOM', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Flock No.', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Bird Type', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Male Bird', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Female Bird', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Freight Rembrusment Amount', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Location State Code', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Price Discount', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('HSN/SAC Code', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('MRP', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('MRP Price', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Total MRP', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Item Catagory', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Gen Prod Posting Group', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('GST Juridiction', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('GST Group Code', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Invoice Type', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('GST Place Of Supply', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('GST Group Type', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Cust Discount Group', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Cust Price Group', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Location GST No.', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Cust GST No.', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Cust State Code (Bill To)', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Item Type', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('UOM', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);

    end;

    procedure CreateReportBody(lineno: Integer; DocType: text[20]; DocNo: Code[20]; Postdate: Date; CustNo: Code[20]; TypeRec: Text[20]; AccNo: Code[20]; Qty: Decimal; UnitPrice: Decimal; Disc: Decimal; DiscPer: Decimal; Amt: Decimal; Totamt: Decimal;
    LocationCode: Code[10]; AltQty: Decimal; AltUOM: Code[10]; FlockNo: Code[20]; BirdType: Option; MaleBrid: Decimal; FemaleBird: Decimal; Freight: Decimal; LocationState: Text[10]; PriceDiscount: Decimal; HSNSAC: Code[10]; MRP: Boolean; MRPPrice: Decimal;
TotalMRP: Decimal; ItemCa: Text[20]; GenProd: Code[20]; GSTJuri: Enum "GST Jurisdiction Type"; GSTGroup: Text[20]; InvoiceType: Enum "Sales Invoice Type"; GSTPlaceOf: Enum "GST Dependency Type"; GSTGroupType: Enum "GST Group Type"; ItemType: Option; UOM: Text; Desc: Text
)
    var
        GSTAmt: Decimal;
        TDSAmt: Decimal;
        TCSAmt: Decimal;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        TDSEntry: Record "TDS Entry";
        TCSEntry: Record "TCS Entry";
        LocState: text;
    begin

        Customter.Get(CustNo);

        Clear(GSTAmt);
        Clear(TDSAmt);
        Clear(TCSAmt);
        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SetRange("Document No.", DocNo);
        DetailedGSTLedgerEntry.SetRange("Posting Date", Postdate);
        DetailedGSTLedgerEntry.SetRange("Document Line No.", lineno);
        if DetailedGSTLedgerEntry.FindSet() then begin
            DetailedGSTLedgerEntry.CalcSums("GST Amount");
            GSTAmt := (DetailedGSTLedgerEntry."GST Amount") * -1;
        end;

        TDSEntry.Reset();
        TDSEntry.SetRange("Document No.", DocNo);
        TDSEntry.SetRange("Posting Date", Postdate);
        //TDSEntry.SetRange("Account No.", AccNo);
        if TDSEntry.FindSet() then begin
            TDSEntry.CalcSums("TDS Amount");
            TDSAmt := TDSEntry."TDS Amount";
        end;

        TCSEntry.Reset();
        TCSEntry.SetRange("Document No.", DocNo);
        TCSEntry.SetRange("Posting Date", Postdate);
        //TCSEntry.SetRange("Account No.", AccNo);
        if TCSEntry.FindSet() then begin
            TCSEntry.CalcSums("TCS Amount");
            TCSAmt := TCSEntry."TCS Amount";
        end;
        SalesInvoiceHeader.Reset();
        SalesInvoiceHeader.SetRange("No.", DocNo);
        If SalesInvoiceHeader.FindFirst() Then begin
            CustDis := SalesInvoiceHeader."Customer Disc. Group";
            CustPrice := SalesInvoiceHeader."Customer Price Group";
            LocationGST := SalesInvoiceHeader."Location GST Reg. No.";
            CustGST := SalesInvoiceHeader."Customer GST Reg. No.";
            LocState := SalesInvoiceHeader."GST Bill-to State Code";
        end;
        SalesCreditMemo.Reset();
        SalesCreditMemo.SetRange("No.", DocNo);
        If SalesCreditMemo.FindFirst() Then begin
            CustDis := SalesCreditMemo."Customer Disc. Group";
            CustPrice := SalesCreditMemo."Customer Price Group";
            LocationGST := SalesCreditMemo."Location GST Reg. No.";
            CustGST := SalesCreditMemo."Customer GST Reg. No.";
            LocState := SalesCreditMemo."GST Bill-to State Code";
        end;

        Excelbuffer.NewRow();
        Excelbuffer.AddColumn(DocType, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(DocNo, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(PostDate, false, '', false, false, false, '', Excelbuffer."Cell Type"::Date);
        Excelbuffer.AddColumn(CustNo, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(Customter.Name, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(TypeRec, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(AccNo, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(Desc, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(Qty, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(Unitprice, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(Disc, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(DiscPer, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(Amt, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(GSTAmt, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(TDSAmt, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(TCSAmt, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(Amt + GSTAmt, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(LocationCode, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(AltQty, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(AltUOM, false, '', false, false, false, '', Excelbuffer."Cell Type"::Date);
        Excelbuffer.AddColumn(FlockNo, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(BirdType, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(MaleBrid, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(FemaleBird, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(Freight, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(LocationState, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(PriceDiscount, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(HSNSAC, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(MRP, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(MRPPrice, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(TotalMRP, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(ItemCa, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(GenProd, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(GSTJuri, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(GSTGroup, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(InvoiceType, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(GSTPlaceOf, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(GSTGroupType, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(CustDis, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(CustPrice, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(LocationGST, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(CustGST, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(LocState, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(ItemType, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(UOM, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
    end;

    procedure CreateExcel()

    begin
        // Excelbuffer.SelectOrAddSheet('Sales Register');
        Excelbuffer.WriteSheet('Sales Register', CompanyName, UserId);
        Excelbuffer.CloseBook();
        Excelbuffer.SetFriendlyFilename('Sales Register' + Format(CurrentDateTime) + UserId);
        Excelbuffer.OpenExcel();
    end;

    var
        Excelbuffer: Record "Excel Buffer" temporary;
        Startdate: Date;
        EndDate: Date;
        Customter: Record Customer;
        SelltoName: Text;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCreditMemo: Record "Sales Cr.Memo Header";
        CustDis: Text;
        CustPrice: text;
        LocationGST: Text;
        CustGST: text;
        Rec_Item: Record Item;
}
