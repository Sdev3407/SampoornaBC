namespace Sampoorna_BC.Sampoorna_BC;
using System.IO;
using Microsoft.Utilities;
using Microsoft.Inventory.Item;
using Microsoft.Purchases.Vendor;
using Microsoft.Finance.GeneralLedger.Journal;

page 50137 "PO Import Worksheet"
{
    AutoSplitKey = true;
    Caption = 'PO Import Worksheet';
    DelayedInsert = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "PO Import Buffer";
    SourceTableView = sorting("Batch Name", "Line No.");
    UsageCategory = Tasks;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName; BatchName)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Batch Name';
                Lookup = true;
                ToolTip = 'Specifies the name of the journal batch, a personalized journal layout, that the journal is based on.';

                trigger OnLookup(var Text: Text): Boolean
                var
                    GenJnlLine: Record "Gen. Journal Line";
                    GenJnlBatch: Record "Gen. Journal Batch";
                    GenBatch: Page "General Journal Batches";
                begin
                    CurrPage.SaveRecord();
                    GenJnlBatch.Reset();
                    GenJnlBatch.SetRange("Journal Template Name", 'Purchases');
                    if GenJnlBatch.FindSet() then;
                    if PAGE.RunModal(0, GenJnlBatch) = ACTION::LookupOK then begin
                        BatchName := GenJnlBatch.Name;
                    end;
                    GenJnlManagement.SetJournalSimplePageModePreference(true, PAGE::"PO Import Worksheet");
                    GenJnlManagement.SetLastViewedJournalBatchName(PAGE::"PO Import Worksheet", BatchName);
                    CurrPage.Update(false);
                    FilterGroup(2);
                    if BatchName <> '' then
                        SetFilter("Batch Name", BatchName);
                    FilterGroup(0);
                end;

                trigger OnValidate()
                var
                    GenJnlBatch: Record "Gen. Journal Batch";
                begin
                    GenJnlBatch.Reset();
                    GenJnlBatch.SetRange("Journal Template Name", 'Purchases');
                    GenJnlBatch.SetRange(Name, BatchName);
                    if not GenJnlBatch.FindFirst() then
                        Error('Gen. Journal Batch Does not exist');
                    GenJnlManagement.SetLastViewedJournalBatchName(PAGE::"PO Import Worksheet", BatchName);
                    FilterGroup(2);
                    if BatchName <> '' then
                        SetFilter("Batch Name", BatchName);
                    FilterGroup(0);
                end;
            }
            repeater(Group)
            {
                // Editable = false;
                field("Batch Name"; Rec."Batch Name")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Vendor Invoice No."; "Vendor Invoice No.")
                {
                    ApplicationArea = All;
                }

                field("Vendor Name"; "Vendor Name")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        RecVendor: Record Vendor;
                    begin
                        // CurrPage.SaveRecord();
                        RecVendor.Reset();
                        // RecVendor.SetRange(Broker, true);
                        if RecVendor.FindSet() then;
                        if PAGE.RunModal(0, RecVendor) = ACTION::LookupOK then begin
                            Validate("Vendor Name", RecVendor.Name);
                        end;

                    end;
                }
                field("Vendor No."; "Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; "Order Date")
                {
                    ApplicationArea = All;
                }
                field("Brokerage Code"; "Brokerage Code")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        RecVendor: Record Vendor;
                    begin
                        // CurrPage.SaveRecord();
                        RecVendor.Reset();
                        RecVendor.SetRange(Broker, true);
                        if RecVendor.FindSet() then;
                        if PAGE.RunModal(0, RecVendor) = ACTION::LookupOK then begin
                            Validate("Brokerage Code", RecVendor.Name);
                        end;
                    end;
                }
                field("Brokerage Rate"; "Brokerage Rate")
                {
                    ApplicationArea = All;

                }
                field("Rate Basis"; "Rate Basis")
                {
                    ApplicationArea = All;
                }
                field("Terms Code"; "Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Mandi Name"; "Mandi Name")
                {
                    ApplicationArea = All;
                }
                field("Payment Method"; "Payment Method")
                {
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; "Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Creditors Type"; "Creditors Type")
                {
                    ApplicationArea = All;
                }
                field("Loc Code"; "Loc Code")
                {
                    ApplicationArea = All;
                }
                field("Item Name"; "Item Name")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        RecItem: Record Item;
                    begin
                        // CurrPage.SaveRecord();
                        RecItem.Reset();
                        if RecItem.FindSet() then;
                        if PAGE.RunModal(0, RecItem) = ACTION::LookupOK then begin
                            Validate("Item Name", RecItem.Description);
                        end;

                    end;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = ALl;
                }
                field("Order Created"; "Order Created")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Order No."; "Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Order Line No."; "Order Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("File Name";
                Rec."File Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sheet Name"; Rec."Sheet Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Imported Date"; Rec."Imported Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Imported Time"; Rec."Imported Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("&Import")
            {
                Caption = '&Import';
                Image = ImportExcel;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                ToolTip = 'Import data from excel.';
                trigger OnAction()
                var
                begin
                    if BatchName = '' then
                        Error(BatchISBlankMsg);
                    ReadExcelSheet();
                    ImportExcelData();
                    CurrPage.Update(true);
                end;
            }
            action("Create&Orders")
            {
                Caption = 'Create &Orders';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                ToolTip = 'Create Purchase Order From Buffer.';
                trigger OnAction()

                var
                    ImportPoBuffer: Record "PO Import Buffer";
                begin
                    ImportPoBuffer.Reset();
                    ImportPoBuffer.SetRange("Batch Name", Rec."Batch Name");
                    ImportPoBuffer.FindFirst();
                    Report.Run(Report::CreatePurchaseOrders, true, false, ImportPoBuffer);
                end;
            }
        }
    }
    trigger OnOpenPage()
    VAR

        LastGenJnlBatch: Text;
    begin
        // "Batch Name" := 'PURCHASE';
        LastGenJnlBatch := GenJnlManagement.GetLastViewedJournalBatchName(PAGE::"PO Import Worksheet");
        if LastGenJnlBatch <> '' then
            BatchName := LastGenJnlBatch;
        FilterGroup(2);
        if BatchName <> '' then
            SetFilter("Batch Name", BatchName);
        FilterGroup(0);
    end;

    trigger OnAfterGetRecord()
    Begin
        FilterGroup(2);
        if BatchName <> '' then
            SetFilter("Batch Name", BatchName);
        FilterGroup(0);
        // "Batch Name" := BatchName;
    End;

    var
        BatchName: Code[10];
        FileName: Text[100];
        SheetName: Text[100];
        TempExcelBuffer: Record "Excel Buffer" temporary;
        UploadExcelMsg: Label 'Please Choose the Excel file.';
        NoFileFoundMsg: Label 'No Excel file found!';
        BatchISBlankMsg: Label 'Batch name is blank';
        ExcelImportSucess: Label 'Excel is successfully imported.';

    local procedure ReadExcelSheet()
    var
        FileMgt: Codeunit "File Management";
        IStream: InStream;
        FromFile: Text[100];
    begin
        UploadIntoStream(UploadExcelMsg, '', '', FromFile, IStream);
        if FromFile <> '' then begin
            FileName := FileMgt.GetFileName(FromFile);
            SheetName := TempExcelBuffer.SelectSheetsNameStream(IStream);
        end else
            Error(NoFileFoundMsg);
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.OpenBookStream(IStream, SheetName);
        TempExcelBuffer.ReadSheet();
    end;

    local procedure ImportExcelData()
    var
        POImportBuffer: Record "PO Import Buffer";
        RowNo: Integer;
        ColNo: Integer;
        LineNo: Integer;
        MaxRowNo: Integer;
    begin
        RowNo := 0;
        ColNo := 0;
        MaxRowNo := 0;
        LineNo := 0;
        POImportBuffer.Reset();
        if POImportBuffer.FindLast() then
            LineNo := POImportBuffer."Line No.";
        TempExcelBuffer.Reset();
        if TempExcelBuffer.FindLast() then begin
            MaxRowNo := TempExcelBuffer."Row No.";
        end;
        for RowNo := 2 to MaxRowNo do begin
            LineNo := LineNo + 10000;
            POImportBuffer.Init();
            Evaluate(POImportBuffer."Batch Name", BatchName);
            POImportBuffer."Line No." := LineNo;
            Evaluate(POImportBuffer."Vendor Invoice No.", GetValueAtCell(RowNo, 1));
            Evaluate(POImportBuffer."Vendor Name", GetValueAtCell(RowNo, 2));
            POImportBuffer.Validate("Vendor Name");
            Evaluate(POImportBuffer."Order Date", GetValueAtCell(RowNo, 3));
            Evaluate(POImportBuffer."Brokerage Code", GetValueAtCell(RowNo, 4));
            POImportBuffer.Validate("Brokerage Code");
            Evaluate(POImportBuffer."Brokerage Rate", GetValueAtCell(RowNo, 5));
            Evaluate(POImportBuffer."Rate Basis", GetValueAtCell(RowNo, 6));
            Evaluate(POImportBuffer."Terms Code", GetValueAtCell(RowNo, 7));
            Evaluate(POImportBuffer."Mandi Name", GetValueAtCell(RowNo, 8));
            Evaluate(POImportBuffer."Payment Method", GetValueAtCell(RowNo, 9));
            Evaluate(POImportBuffer."Payment Terms Code", GetValueAtCell(RowNo, 10));
            Evaluate(POImportBuffer."Location Code", GetValueAtCell(RowNo, 11));
            POImportBuffer.Validate("Location Code");
            Evaluate(POImportBuffer."Creditors Type", GetValueAtCell(RowNo, 12));
            Evaluate(POImportBuffer."Loc Code", GetValueAtCell(RowNo, 13));
            Evaluate(POImportBuffer."Item Name", GetValueAtCell(RowNo, 14));
            POImportBuffer.Validate("Item Name");
            Evaluate(POImportBuffer.Quantity, GetValueAtCell(RowNo, 15));
            Evaluate(POImportBuffer."Unit Price", GetValueAtCell(RowNo, 16));
            POImportBuffer."Sheet Name" := SheetName;
            POImportBuffer."File Name" := FileName;
            POImportBuffer."Imported Date" := Today;
            POImportBuffer."Imported Time" := Time;
            POImportBuffer.Insert();
        end;
        Message(ExcelImportSucess);
    end;

    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    begin
        TempExcelBuffer.Reset();
        If TempExcelBuffer.Get(RowNo, ColNo) then
            exit(TempExcelBuffer."Cell Value as Text")
        else
            exit('');
    end;

    var
        PJ: Page "Purchase Journal";
        GenJnlManagement: Codeunit GenJnlManagement;
}