namespace Sampoorna_BC.Sampoorna_BC;
using System.IO;

page 50138 "Posted PO Imported"
{
    // AutoSplitKey = true;
    Caption = 'Posted PO Imported';
    DelayedInsert = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SaveValues = true;
    SourceTable = PostedImportBuffer;
    SourceTableView = sorting("Line No.");
    UsageCategory = Lists;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;
                field("Batch Name"; Rec."Batch Name")
                {
                    // Visible = false;
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    // Visible = false;
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor Invoice No."; "Vendor Invoice No.")
                {
                    ApplicationArea = All;
                }

                field("Vendor Name"; "Vendor Name")
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
}