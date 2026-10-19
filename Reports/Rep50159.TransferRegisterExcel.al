namespace Sampoorna_BC.Sampoorna_BC;

using System.Utilities;
using Microsoft.Inventory.Transfer;
using Microsoft.Sales.History;
using Microsoft.Inventory.Location;
using Microsoft.Finance.TCS.TCSBase;
using Microsoft.Finance.TDS.TDSBase;
using Microsoft.Finance.GST.Base;
using System.IO;

report 50159 TransferRegisterExcel
{
    ApplicationArea = All;
    Caption = 'Transfer Register Excel';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Integer; "Integer")
        {
            DataItemTableView = where(Number = filter(1));

            dataitem("SIL"; "Transfer Shipment Line")
            {
                DataItemLinkReference = Integer;
                DataItemTableView = where(Quantity = filter(<> 0));
                trigger OnAfterGetRecord()
                begin
                    CreateReportBody(SIL."Line No.", 'Transfer Shipment', SIL."Document No.", SIL."Posting Date"
                    , SIL."Item No.", SIL.Description, SIL."Quantity", SIL."Unit Price", SIL."Amount", SIL.Amount, SIL."Transfer Order No.", SIL."Transfer-from Code", SIL."Transfer-to Code",
                    SIL."Unit of Measure", SIL."GST Group Code", SIL."HSN/SAC Code", SIL."GST Credit", "Item Type");
                end;

                trigger OnPreDataItem()
                begin
                    SIL.SetRange("Posting Date", Startdate, EndDate);
                end;

            }

            dataitem("SCL"; "Transfer Receipt Line")
            {
                DataItemLinkReference = Integer;
                DataItemTableView = where(Quantity = filter(<> 0));
                trigger OnAfterGetRecord()
                begin
                    CreateReportBody(SCL."Line No.", 'Transfer Receipt', SCL."Document No.", SCL."Posting Date"
                    , SCL."Item No.", SCL.Description, SCL."Quantity", SCL."Unit Price", SCL."Amount", SCL.Amount, SCL."Transfer Order No.", SCL."Transfer-from Code", SCL."Transfer-to Code",
                    SCL."Unit of Measure", SCL."GST Group Code", SCL."HSN/SAC Code", SCL."GST Credit", "Item Type");
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
                Excelbuffer.CreateNewBook('Transfer Register');
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
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }
                    Field(Enddate; Enddate)
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
        Excelbuffer.AddColumn('Item No', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Description', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Quantity', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Unit Price', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Amount', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('GST Amount', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Total Amount', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Transfer Order No.', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Transfer From Code', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Transfer To Code', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('UOM', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('GST Group Code', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('GST %', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('HSN/SAC Code', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('GST Credit', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('From State Code', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('To State Code', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Location State Code', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('External Doc No.', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Item Type', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);


    end;

    procedure CreateReportBody(lineno: Integer; DocType: text[20]; DocNo: Code[20]; Postdate: Date; AccNo: Code[20]; Descrip: text; Qty: Decimal; UnitPrice: Decimal; Amt: Decimal; Totamt: Decimal;
    TOD: COde[20]; FromCode: Code[10]; ToCode: Code[10]; UOM: Code[10]; GSTGroup: Code[10]; HSNCode: Code[10]; GSTCredit: Enum "GST Credit"; ItemType: Option)
    var
        GSTAmt: Decimal;
        TDSAmt: Decimal;
        TCSAmt: Decimal;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        TDSEntry: Record "TDS Entry";
        TCSEntry: Record "TCS Entry";
        Location: Record Location;
        TranferShip: Record "Transfer Shipment Header";
        Tranferrece: Record "Transfer Receipt Header";
        DetailGSTInfo: record "Detailed GST Ledger Entry Info";
        FromState: Text;
        ToState: Text;
        LocState: text;
        External: text;
        PostingDate: Date;
        GSTPer: Decimal;
        ExtenrnalDoc: Text;
    begin
        Clear(GSTAmt);
        Clear(TDSAmt);
        Clear(TCSAmt);
        Clear(FromState);
        Clear(ToState);
        Clear(LocState);
        Clear(Postdate);
        Clear(GSTAmt);
        Clear(GSTPer);
        Clear(ExtenrnalDoc);


        TranferShip.Reset();
        TranferShip.SetRange("No.", DocNo);
        if TranferShip.FindFirst() then begin
            Postdate := TranferShip."Posting Date";
            FromState := TranferShip."From State Code";
            ToState := TranferShip."To State Code";
            LocState := TranferShip."From State Code";
            ExtenrnalDoc := TranferShip."External Document No.";
        End;
        Tranferrece.Reset();
        Tranferrece.SetRange("No.", DocNo);
        if Tranferrece.FindFirst() then begin
            Postdate := Tranferrece."Posting Date";
            FromState := Tranferrece."From State Code";
            ToState := Tranferrece."To State Code";
            LocState := Tranferrece."To State Code";
            ExtenrnalDoc := Tranferrece."External Document No.";
        end;
        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SetRange("Document No.", DocNo);
        DetailedGSTLedgerEntry.SetRange("Posting Date", Postdate);
        DetailedGSTLedgerEntry.SetRange("Document Line No.", lineno);
        if DetailedGSTLedgerEntry.FindSet() then begin
            DetailedGSTLedgerEntry.CalcSums("GST Amount");
            DetailedGSTLedgerEntry.CalcSums("GST %");
            GSTAmt := ABS(DetailedGSTLedgerEntry."GST Amount");
            GSTPer := ABS(DetailedGSTLedgerEntry."GST %")
        end;



        Excelbuffer.NewRow();
        Excelbuffer.AddColumn(DocType, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(DocNo, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(Postdate, false, '', false, false, false, '', Excelbuffer."Cell Type"::Date);
        Excelbuffer.AddColumn(AccNo, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(Descrip, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(Qty, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(Unitprice, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(Amt, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(GSTAmt, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(Amt + GSTAmt - TCSAmt - TDSAmt, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(TOD, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(FromCode, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(ToCode, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(UOM, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(GSTGroup, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(GSTPer, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(HSNCode, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(GSTCredit, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(FromState, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(ToState, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(LocState, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(ExtenrnalDoc, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);


    end;

    procedure CreateExcel()

    begin
        // Excelbuffer.SelectOrAddSheet('Sales Register');
        Excelbuffer.WriteSheet('Transfer Register', CompanyName, UserId);
        Excelbuffer.CloseBook();
        Excelbuffer.SetFriendlyFilename('Transfer Register' + Format(CurrentDateTime) + UserId);
        Excelbuffer.OpenExcel();
    end;

    var
        Excelbuffer: Record "Excel Buffer" temporary;
        Startdate: Date;
        EndDate: Date;
}
