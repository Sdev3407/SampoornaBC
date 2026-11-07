page 50016 "Sales Person Target"
{
    //DeleteAllowed = false;
    PageType = List;
    SourceTable = "Sales Person Target";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sales Person Code"; Rec."Sales Person Code")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Qty In MT"; Rec."Qty In MT")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ImportSalesTarget)
            {
                ApplicationArea = All;
                Caption = 'Import Sales Target';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ImportSalesTargets();
                end;
            }
        }
    }

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        UploadExcelMsg: Label 'Please choose the Excel file.';
        NoFileFoundMsg: Label 'No Excel file found.';
        ExcelImportSuccessMsg: Label 'Sales targets were successfully imported.';

    local procedure ImportSalesTargets()
    var
        SalesTarget: Record "Sales Person Target";
        ExcelStream: InStream;
        FromFile: Text;
        SheetName: Text[250];
        RowNo: Integer;
        MaxRowNo: Integer;
        ImportedCount: Integer;
        SalesPersonCode: Text;
        StartDateText: Text;
        EndDateText: Text;
        QtyInMTText: Text;
    begin
        if not UploadIntoStream(UploadExcelMsg, '', '', FromFile, ExcelStream) then
            exit;

        if FromFile = '' then
            Error(NoFileFoundMsg);

        SheetName := TempExcelBuffer.SelectSheetsNameStream(ExcelStream);
        if SheetName = '' then
            exit;

        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.OpenBookStream(ExcelStream, SheetName);
        TempExcelBuffer.ReadSheet();

        TempExcelBuffer.Reset();
        if not TempExcelBuffer.FindLast() then
            Error('The selected worksheet is empty.');
        MaxRowNo := TempExcelBuffer."Row No.";

        for RowNo := 2 to MaxRowNo do begin
            SalesPersonCode := GetValueAtCell(RowNo, 1);
            StartDateText := GetValueAtCell(RowNo, 2);
            EndDateText := GetValueAtCell(RowNo, 3);
            QtyInMTText := GetValueAtCell(RowNo, 4);

            if (SalesPersonCode <> '') or (StartDateText <> '') or (EndDateText <> '') or (QtyInMTText <> '') then begin
                if SalesPersonCode = '' then
                    Error('Sales Person Code is required on row %1.', RowNo);
                SalesTarget.Init();
                SalesTarget.Validate("Sales Person Code", SalesPersonCode);
                if not Evaluate(SalesTarget."Start Date", StartDateText) then
                    Error('Invalid Start Date on row %1.', RowNo);
                if not Evaluate(SalesTarget."End Date", EndDateText) then
                    Error('Invalid End Date on row %1.', RowNo);
                if not Evaluate(SalesTarget."Qty In MT", QtyInMTText) then
                    Error('Invalid Qty In MT on row %1.', RowNo);
                SalesTarget.Insert();
                ImportedCount += 1;
            end;
        end;

        if ImportedCount = 0 then
            Error('No sales target rows were found in the selected worksheet.');

        Message(ExcelImportSuccessMsg);
    end;

    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    begin
        TempExcelBuffer.Reset();
        if TempExcelBuffer.Get(RowNo, ColNo) then
            exit(TempExcelBuffer."Cell Value as Text");
        exit('');
    end;
}

