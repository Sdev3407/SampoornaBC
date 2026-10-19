report 50088 ImportProdBom
{
    ApplicationArea = All;
    Caption = 'ImportProdBom';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Integer; "Integer")
        {
            DataItemTableView = where(Number = filter(1));
            trigger OnAfterGetRecord()
            var
                ProdBOMHeader1: Record "Production BOM Header";
                ProdBOMVerHeader1: Record "Production BOM Version";
            begin
                if RepOutput = RepOutput::Import then begin
                    ReadExcelSheet();
                    ImportExcelData();
                end;
                if RepOutput in [RepOutput::"Export Template"] then begin
                    ExportTemplate();
                end;
                if OldDocNo <> '' then begin
                    if (OldVerNo = '') then begin
                        ProdBOMHeader1.Get(OldDocNo);
                        ProdBOMHeader1.Validate(Status, ProdBOMHeader1.Status::Certified);
                        ProdBOMHeader1.Modify();
                    end;

                    if (OldVerNo <> '') then begin
                        ProdBOMVerHeader1.Get(OldDocNo, OldVerNo);
                        ProdBOMVerHeader1.Validate(Status, ProdBOMVerHeader1.Status::Certified);
                        ProdBOMVerHeader1.Modify();
                    end;
                end;
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
                    field(RepOutput; RepOutput)
                    {
                        ApplicationArea = All;
                        Caption = 'Report Type';
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
            if RepOutput = RepOutput::" " then
                Error('Kindly Select Report output');
        end;
    }
    Local procedure ReadExcelSheet()
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
        ProdBOMHeader: Record "Production BOM Header";
        ProdBOMLine: Record "Production BOM Line";
        ProdBOMVerHeader: Record "Production BOM Version";
        RowNo: Integer;
        ColNo: Integer;
        LineNo: Integer;
        MaxRowNo: Integer;
    begin
        RowNo := 0;
        ColNo := 0;
        MaxRowNo := 0;
        LineNo := 0;
        TempExcelBuffer.Reset();
        if TempExcelBuffer.FindLast() then begin
            MaxRowNo := TempExcelBuffer."Row No.";
        end;
        Clear(OldDocNo);
        Clear(OldVerNo);
        for RowNo := 2 to MaxRowNo do begin
            Clear(DocNoValue);
            Clear(VerNoValue);
            Clear(StartDate);

            DocNoValue := GetValueAtCell(RowNo, 1);
            VerNoValue := GetValueAtCell(RowNo, 2);
            if OldDocNo <> '' then begin
                if ((DocNoValue <> OldDocNo) and (OldVerNo = '')) then begin
                    ProdBOMHeader.Get(OldDocNo);
                    ProdBOMHeader.Validate(Status, ProdBOMHeader.Status::Certified);
                    ProdBOMHeader.Modify();
                end;

                if ((DocNoValue <> OldDocNo) and (OldVerNo <> '')) then begin
                    ProdBOMVerHeader.Get(OldDocNo, OldVerNo);
                    ProdBOMVerHeader.Validate(Status, ProdBOMVerHeader.Status::Certified);
                    ProdBOMVerHeader.Modify();
                end;
                Clear(ProdBOMHeader);
                Clear(ProdBOMVerHeader);
            end;

            if GetValueAtCell(RowNo, 11) <> '' then
                Evaluate(StartDate, GetValueAtCell(RowNo, 11));
            if DocNoValue <> '' then begin
                if ((not ProdBOMHeader.Get(DocNoValue)) and (VerNoValue = '')) then begin
                    ProdBOMHeader.Init();
                    ProdBOMHeader.Validate("No.", DocNoValue);
                    ProdBOMHeader."Version Nos." := '';
                    ProdBOMHeader.Validate("Unit of Measure Code", GetValueAtCell(RowNo, 3));
                    ProdBOMHeader.Validate(Description, GetValueAtCell(RowNo, 4));
                    ProdBOMHeader.Validate("Last Date Modified", Today);
                    ProdBOMHeader.Insert(true);
                    InsertProdBOMLine(ProdBOMHeader."No.", '', GetValueAtCell(RowNo, 5), GetValueAtCell(RowNo, 6),
                    GetValueAtCell(RowNo, 7), GetValueAtCell(RowNo, 9), GetValueAtCell(RowNo, 10));
                end else
                    if VerNoValue = '' then begin
                        InsertProdBOMLine(ProdBOMHeader."No.", '', GetValueAtCell(RowNo, 5), GetValueAtCell(RowNo, 6),
                                            GetValueAtCell(RowNo, 7), GetValueAtCell(RowNo, 9), GetValueAtCell(RowNo, 10));
                    end else
                        if VerNoValue <> '' then begin
                            if not ProdBOMVerHeader.Get(DocNoValue, VerNoValue) then begin
                                ProdBOMVerHeader.Init();
                                ProdBOMVerHeader.Validate("Production BOM No.", DocNoValue);
                                ProdBOMVerHeader."Version Code" := VerNoValue;
                                ProdBOMVerHeader.Validate("Unit of Measure Code", GetValueAtCell(RowNo, 3));
                                ProdBOMVerHeader.Validate(Description, GetValueAtCell(RowNo, 4));
                                ProdBOMVerHeader.Validate("Starting Date", StartDate);
                                ProdBOMVerHeader.Validate("Last Date Modified", Today);
                                ProdBOMVerHeader.Insert(true);
                                InsertProdBOMLine(ProdBOMHeader."No.", ProdBOMVerHeader."Version Code",
                                GetValueAtCell(RowNo, 5), GetValueAtCell(RowNo, 6), GetValueAtCell(RowNo, 7),
                                 GetValueAtCell(RowNo, 9), GetValueAtCell(RowNo, 10));
                            end else
                                InsertProdBOMLine(ProdBOMHeader."No.", ProdBOMVerHeader."Version Code",
                                   GetValueAtCell(RowNo, 5), GetValueAtCell(RowNo, 6), GetValueAtCell(RowNo, 7),
                                    GetValueAtCell(RowNo, 9), GetValueAtCell(RowNo, 10));
                        end;
            end;
            OldDocNo := DocNoValue;
            OldVerNo := VerNoValue;
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

    procedure InsertProdBOMLine(ProdBOMNo: Code[50]; VerNo: Code[20]; LineNo: Text;
    Type: Text; No: Code[50]; LineUOM: Code[20]; QtyPer: Text)
    var
        ProdBOMLine1: Record "Production BOM Line";
        LineType: Enum "Production BOM Line Type";
        OrdinalValue: Integer;
        Index: Integer;
        QuantityPer: Decimal;
        LineNumber: Integer;
    begin
        if QtyPer <> '' then
            Evaluate(QuantityPer, QtyPer);
        if LineNo <> '' then
            Evaluate(LineNumber, LineNo);
        Index := LineType.Names.IndexOf(Type);
        OrdinalValue := LineType.Ordinals.Get(Index);
        LineType := Enum::"Production BOM Line Type".FromInteger(OrdinalValue);

        ProdBOMLine1.Init();
        ProdBOMLine1."Production BOM No." := ProdBOMNo;
        ProdBOMLine1."Version Code" := VerNo;
        ProdBOMLine1."Line No." := LineNumber + 10000;
        ProdBOMLine1.Insert(true);

        ProdBOMLine1.Validate(Type, LineType);
        ProdBOMLine1.Validate("No.", No);
        ProdBOMLine1.Validate("Quantity per", QuantityPer);
        ProdBOMLine1.Validate("Unit of Measure Code", LineUOM);
        ProdBOMLine1.Modify(true);
    end;

    Procedure ExportTemplate()
    var
        ProdBOMTempLbl: Label 'Prod BOM Import';
        ExcelFileName: Label 'Prod BOM Import Template';
    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn('Prod BOM  No.', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Version No.', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('UOM Code', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Description', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Line No.', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Type', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('No.', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Description', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Component UOM', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Qty. Per', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Starting Date', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.CreateNewBook(ProdBOMTempLbl);
        TempExcelBuffer.WriteSheet(ProdBOMTempLbl, CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
        TempExcelBuffer.OpenExcel();
    end;

    var
        FileName: Text[100];
        SheetName: Text[100];
        RepOutput: Option " ","Import","Export Template";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        UploadExcelMsg: Label 'Please Choose the Excel file.';
        NoFileFoundMsg: Label 'No Excel file found!';
        ExcelImportSucess: Label 'Excel is successfully imported.';
        DocNoValue: Text;
        VerNoValue: Text;
        OldDocNo: Text;
        OldVerNo: Text;
        StartDate: Date;
}