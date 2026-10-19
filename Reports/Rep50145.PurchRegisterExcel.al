namespace Sampoorna_BC.Sampoorna_BC;

using System.Utilities;
using Microsoft.Purchases.History;
using Microsoft.Finance.TaxEngine.Core;
using Microsoft.Finance.TaxEngine.TaxTypeHandler;
using Microsoft.Sales.History;
using Microsoft.Finance.TCS.TCSBase;
using Microsoft.Purchases.Vendor;
using Microsoft.Finance.TDS.TDSBase;
using Microsoft.Finance.GST.Base;
using System.IO;

report 50145 PurchRegisterExcel
{
    ApplicationArea = All;
    Caption = 'Purchase Register';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Integer; "Integer")
        {
            DataItemTableView = where(Number = filter(1));

            dataitem("SIL"; "Purch. Inv. Line")
            {
                DataItemLinkReference = Integer;
                DataItemTableView = where(Quantity = filter(<> 0));
                trigger OnAfterGetRecord()
                begin
                    CreateReportBody(SIL."Line No.", 'Invoice', SIL."Document No.", SIL."Posting Date", SIL."Buy-from Vendor No.",
                    Format(SIL.Type), SIL."No.", SIL."Quantity", SIL."Unit Cost", SIL."Line Discount Amount",
                    SIL."Line Amount", SIL.Amount, SIL."Location Code", SIL."GST Jurisdiction Type", SIL."Unit of Measure", SIL."Receipt No.", SIL."Shortcut Dimension 1 Code", SIL."Shortcut Dimension 2 Code",
                    SIL."Gen. Prod. Posting Group", SIL."GST Group Code", SIL."HSN/SAC Code", SIL."GST Reverse Charge", SIL."Line Discount %", SIL."Line Discount Amount",
                    sil.Description);
                end;

                trigger OnPreDataItem()
                begin
                    SIL.SetRange("Posting Date", Startdate, EndDate);
                end;


            }

            dataitem("SCL"; "Purch. Cr. Memo Line")
            {
                DataItemLinkReference = Integer;
                DataItemTableView = where(Quantity = filter(<> 0));
                trigger OnAfterGetRecord()
                begin
                    CreateReportBody(SCL."Line No.", 'Credit Memo', SCL."Document No.", SCL."Posting Date", SCL."Buy-from Vendor No.",
                    Format(SCL.Type), SCL."No.", SCL."Quantity" * -1, SCL."Unit Cost", SCL."Line Discount Amount",
                    SCL."Line Amount" * -1, SCL.Amount * -1, SCL."Location Code", SCL."GST Jurisdiction Type", SCL."Unit of Measure", '', SCL."Shortcut Dimension 1 Code", SCL."Shortcut Dimension 2 Code",
                    SCL."Gen. Prod. Posting Group", SCL."GST Group Code", SCL."HSN/SAC Code", SCL."GST Reverse Charge", SCL."Line Discount %", SCL."Line Discount Amount", SCL.Description);
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
                Excelbuffer.CreateNewBook('Purchase Register');
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
                    field("Start Date"; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }
                    field("End Date"; EndDate)
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
    var

    procedure CreateReportheader()
    var

    begin

        Excelbuffer.NewRow();
        Excelbuffer.AddColumn('Document Type', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Document No.', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Posting Date', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Vendor No.', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Vendor Name', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Type', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('No.', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Descripion', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Quantity', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Unit Cost', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Discount', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Amount', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('GST Amount', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('TDS Amount', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('TCS Amount', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Total Amount', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Location Code', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('GST Juridiction', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('UOM', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('MRN No.', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('LOB', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Branch', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Gen Prod. Posting Group', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('GST Group Code', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('HSN/SAC', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('GST%', false, '', true, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn('Reverse Charge', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Line Discount %', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Line Discount Amount', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Location GST Registration No.', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Vendor GST Registration No.', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Location State Code', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Vendor Doc No.', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn('Vendor Doc Date', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);

        Excelbuffer.AddColumn('Line Narration', false, '', true, false, false, '', Excelbuffer."Cell Type"::Text);
    end;

    procedure CreateReportBody(lineno: Integer; DocType: text[20]; DocNo: Code[20]; Postdate: Date; VendNo: Code[20]; TypeRec: Text[20]; AccNo: Code[20]; Qty: Decimal; UnitCost: Decimal; Disc: Decimal; Amt: Decimal; Totamt: Decimal;
    Loc: Code[10]; GSTJURI: Enum "GST Jurisdiction Type"; UOM: Code[10]; MRNNo: Code[20]; LOB: COde[10]; Branch: Code[10]; GENProd: Code[20]; GSTGroup: Code[10]; HSN: Code[10]; GSTReverse: Boolean; LineDicPer: Decimal; LineDiscAmt: Decimal;
    Description: Text)
    var
        vendor: Record Vendor;
        GSTAmt: Decimal;
        TDSAmt: Decimal;
        TCSAmt: Decimal;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        TDSEntry: Record "TDS Entry";
        TaxTrnsactionValue: Record "Tax Transaction Value";
        TCSEntry: Record "TCS Entry";
        PurInvoice: Record "Purch. Inv. Header";
        PurCredit: Record "Purch. Cr. Memo Hdr.";
        LocGST: Text;
        vendGST: Text;
        GSTPer: Decimal;
        LOCState: text;
        LineNarration: text;
        VendDocNo: text;
        VendDocDate: Date;



    begin
        vendor.Get(VendNo);
        Clear(GSTAmt);
        Clear(TDSAmt);
        Clear(TCSAmt);
        Clear(LocGST);
        Clear(vendGST);
        PurInvoice.Reset();
        PurInvoice.SetRange("No.", DocNo);
        If PurInvoice.FindFirst() Then begin
            LocGST := PurInvoice."Location GST Reg. No.";
            vendGST := PurInvoice."Vendor GST Reg. No.";
            LOCState := PurInvoice."Location State Code";
            LineNarration := PurInvoice."Line Narration1";
            VendDocNo := PurInvoice."Vendor Invoice No.";
            VendDocDate := PurInvoice."Document Date";
        end;
        PurCredit.Reset();
        PurCredit.SetRange("No.", DocNo);
        If PurCredit.FindFirst() Then begin
            LocGST := PurCredit."Location GST Reg. No.";
            vendGST := PurCredit."Vendor GST Reg. No.";
            LOCState := PurCredit."Location State Code";
            LineNarration := PurCredit."Line Narration1";
            VendDocNo := PurCredit."Vendor Cr. Memo No.";
            VendDocDate := PurCredit."Document Date";
        end;
        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SetRange("Document No.", DocNo);
        //DetailedGSTLedgerEntry.SetRange("Posting Date", Postdate);
        DetailedGSTLedgerEntry.SetRange("Document Line No.", lineno);
        if DetailedGSTLedgerEntry.FindSet() then begin
            DetailedGSTLedgerEntry.CalcSums("GST Amount");
            DetailedGSTLedgerEntry.CalcSums("GST %");
            GSTAmt := (DetailedGSTLedgerEntry."GST Amount");
            GSTPer := ABS(DetailedGSTLedgerEntry."GST %")
        end;

        // TDSEntry.reset;
        // TDSEntry.SetRange(TDSEntry."Document No.", DocNo);
        // if TDSEntry.Findset() then begin
        //     TDSEntry.CalcSums("TDS Amount");
        //     TDSAmt := (TDSEntry."TDS Amount");
        // end;
        // UNTIL(TDSEntry.NEXT = 0);

        //TDSSTART>>
        Clear(TaxInfoJSON);
        Clear(TaxInfoText);
        GetTaxComponentsInJson(SIL.RecordId, TaxInfoJSON);
        TaxInfoJSON.WriteTo(TaxInfoText);
        TDSAmt := GetTDSAmount(TaxInfoText);
        //TDSEND<<

        // TaxTrnsactionValue.SetRange("Table ID Filter", 123);
        // TaxTrnsactionValue.SetRange("Document No. Filter", DocNo);
        // TaxTrnsactionValue.SetRange("Line No. Filter", lineno);
        // if TaxTrnsactionValue.FindFirst() then
        //     TDSAmt := TaxTrnsactionValue.Amount;




        Excelbuffer.NewRow();
        Excelbuffer.AddColumn(DocType, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(DocNo, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(PostDate, false, '', false, false, false, '', Excelbuffer."Cell Type"::Date);
        Excelbuffer.AddColumn(VendNo, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(vendor.Name, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(TypeRec, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(AccNo, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(Description, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(Qty, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(UnitCost, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(Disc, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(Amt, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(GSTAmt, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(TDSAmt, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(TCSAmt, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(Amt + GSTAmt - TCSAmt - TDSAmt, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(Loc, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(GSTJURI, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(UOM, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(MRNNo, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(LOB, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(Branch, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(GENProd, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(GSTGroup, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(HSN, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(GSTPer, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(GSTReverse, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(LineDicPer, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(LineDiscAmt, false, '', false, false, false, '', Excelbuffer."Cell Type"::Number);
        Excelbuffer.AddColumn(LocGST, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(vendGST, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(LOCState, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(VendDocNo, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(VendDocDate, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
        Excelbuffer.AddColumn(LineNarration, false, '', false, false, false, '', Excelbuffer."Cell Type"::Text);
    end;

    procedure CreateExcel()

    begin
        // Excelbuffer.SelectOrAddSheet('Sales Register');
        Excelbuffer.WriteSheet('Purchase Register', CompanyName, UserId);
        Excelbuffer.CloseBook();
        Excelbuffer.SetFriendlyFilename('Purchase Register' + Format(CurrentDateTime) + UserId);
        Excelbuffer.OpenExcel();
    end;

    //TDSPROCEDURE1START>>
    local procedure GetTaxComponentsInJson(TaxRecordID: RecordId; var JObject: JsonObject)
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        TaxTypeObjHelper: Codeunit "Tax Type Object Helper";
        ComponentAmt: Decimal;
        JArray: JsonArray;
        ComponentJObject: JsonObject;
    begin
        if not GuiAllowed then
            exit;

        TaxTransactionValue.SetFilter("Tax Record ID", '%1', TaxRecordID);
        TaxTransactionValue.SetFilter("Value Type", '%1', TaxTransactionValue."Value Type"::Component);
        TaxTransactionValue.SetRange("Visible on Interface", true);
        if TaxTransactionValue.FindSet() then
            repeat
                Clear(ComponentJObject);
                ComponentJObject.Add('Component', TaxTransactionValue.GetAttributeColumName());
                ComponentJObject.Add('Percent', ScriptDatatypeMgmt.ConvertXmlToLocalFormat(format(TaxTransactionValue.Percent, 0, 9), "Symbol Data Type"::NUMBER));
                ComponentAmt := TaxTypeObjHelper.GetComponentAmountFrmTransValue(TaxTransactionValue);
                ComponentJObject.Add('Amount', ScriptDatatypeMgmt.ConvertXmlToLocalFormat(format(ComponentAmt, 0, 9), "Symbol Data Type"::NUMBER));
                JArray.Add(ComponentJObject);
            until TaxTransactionValue.Next() = 0;

        JObject.Add('TaxInformation', JArray);
    end;
    //TDSPROCEDURE1END<<

    //TDSPROCEDURE2START>>

    procedure GetTDSAmount(JsonText: Text): Decimal
    var
        JObject: JsonObject;
        JArray: JsonArray;
        JToken: JsonToken;
        JItem: JsonObject;
        ComponentToken: JsonToken;
        AmountToken: JsonToken;
        TDSAmount: Decimal;
        ComponentName: Text;
        AmountText: Text;
        i: Integer;
    begin
        TDSAmount := 0;

        if not JObject.ReadFrom(JsonText) then
            exit(0);

        if not JObject.Get('TaxInformation', JToken) then
            exit(0);

        JArray := JToken.AsArray();

        for i := 0 to JArray.Count - 1 do begin
            JArray.Get(i, JToken);
            JItem := JToken.AsObject();

            if JItem.Get('Component', ComponentToken) then begin
                ComponentName := ComponentToken.AsValue().AsText().Trim();

                if ComponentName = 'TDS' then begin
                    if JItem.Get('Amount', AmountToken) then begin
                        AmountText := AmountToken.AsValue().AsText();
                        AmountText := AmountText.Replace(',', ''); // remove thousand separators
                        if Evaluate(TDSAmount, AmountText) then
                            exit(TDSAmount);
                    end;
                end;
            end;
        end;

        exit(0); // TDS component not found
    end;
    //TDSPROCEDURE2END<<

    var
        Excelbuffer: Record "Excel Buffer" temporary;
        TaxInformationFactBoxPG: Page "Tax Information Factbox";
        ScriptDatatypeMgmt: Codeunit "Script Data Type Mgmt.";
        TaxInfoJSON: JsonObject;
        TaxInfoText: Text;

        Startdate: Date;
        EndDate: Date;
}
