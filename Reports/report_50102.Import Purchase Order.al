report 50102 "Import Purchae Order"
{
    Permissions = TableData 17 = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; 2000000026)
        {
            DataItemTableView = SORTING(Number);

            trigger OnAfterGetRecord()
            begin
                ImportSheet(Number);
            end;

            trigger OnPreDataItem()
            begin
                ExcelBuf.OpenBook(ServerFileName, SheetName);
                // ExcelBuf.CreateNewBook('Import Ourchase Order');
                ExcelBuf.ReadSheet;
                SETRANGE(Number, 2, ExcelBuf.COUNT);
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

        trigger OnQueryClosePage(CloseAction: Action): Boolean
        var
            FileMgt: Codeunit "File Management";
        begin
            IF CloseAction = ACTION::OK THEN BEGIN
                ServerFileName := FileMgt.UploadFile(Text006, ExcelFileExtensionTok);
                IF ServerFileName = '' THEN
                    EXIT(FALSE);

                SheetName := ExcelBuf.SelectSheetsName(ServerFileName);
                IF SheetName = '' THEN
                    EXIT(FALSE);

            END;
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        ExcelBuf.DELETEALL;
        MESSAGE('Import Data');
    end;

    var
        ExcelBuf: Record "Excel Buffer" temporary;
        ServerFileName: Text;
        SheetName: Text[250];
        Text000: Label 'You must specify a budget name to import to.';
        Text001: Label 'Do you want to create a %1 with the name %2?';
        Text002: Label '%1 %2 is blocked. You cannot import entries.';
        Text003: Label 'Are you sure that you want to %1 for the budget name %2?';
        Text004: Label '%1 table has been successfully updated with %2 entries.';
        Text005: Label 'Imported from Excel ';
        Text006: Label 'Import Excel File';
        Text007: Label 'Analyzing Data...\\';
        Text008: Label 'You cannot specify more than 8 dimensions in your Excel worksheet.';
        Text009: Label 'G/L ACCOUNT NO';
        Text010: Label 'G/L Account No.';
        Text011: Label 'The text G/L Account No. can only be specified once in the Excel worksheet.';
        Text012: Label 'The dimensions specified by worksheet must be placed in the lines before the table.';
        Text013: Label 'Dimension ';
        Text014: Label 'Date';
        Text015: Label 'Dimension 1';
        Text016: Label 'Dimension 2';
        Text017: Label 'Dimension 3';
        Text018: Label 'Dimension 4';
        Text019: Label 'Dimension 5';
        Text020: Label 'Dimension 6';
        Text021: Label 'Dimension 7';
        Text022: Label 'Dimension 8';
        Text023: Label 'You cannot import the same information twice.\';
        Text024: Label 'The combination G/L Account No. - Dimensions - Date must be unique.';
        Text025: Label 'G/L Accounts have not been found in the Excel worksheet.';
        Text026: Label 'Dates have not been recognized in the Excel worksheet.';
        Text027: Label 'Replace entries,Add entries';
        Text028: Label 'A filter has been used on the %1 when the budget was exported. When a filter on a dimension has been used, a column with the same dimension must be present in the worksheet imported. The column in the worksheet must specify the dimension value codes the program should use when importing the budget.';
        ExcelFileExtensionTok: Label '.xlsx', Locked = true;
        FileName: Text;
        ResNo: Code[20];
        CountData: Integer;
        LastNoSeries: Code[20];
        Rec_Item: Record Item;
        "Type Slect": Option " ",Lines,Update;
        ColText1: array[11] of Text[250];
        seyinteg: Integer;
        DimSetID: Integer;
        CText1: array[3] of Text;
        GLEntNo: Integer;
        BranchCode: Code[20];
        SalesLine: Record "Purchase Line";
        Rec_SL: Record "Purchase Line";
        GlobalDocNo: Code[20];
        PurchaseHeader: Record "Purchase Header";
        LineNo: Integer;
        BCDCurrFact: Decimal;
        swsCurrFact: Decimal;
        CIFCurrFact: Decimal;
        TotGst: Decimal;

    procedure ImportSheet(RowNum: Integer)
    begin
        CLEAR(ColText1);
        BCDCurrFact := 0;
        swsCurrFact := 0;
        ExcelBuf.SETRANGE(ExcelBuf."Row No.", RowNum);
        IF ExcelBuf.FINDSET THEN
            REPEAT
                ColText1[ExcelBuf."Column No."] := ExcelBuf."Cell Value as Text";
            UNTIL ExcelBuf.NEXT = 0;
        IF ColText1[1] <> '' THEN BEGIN
            // if SheetName = 'Item' then //Pru_gk 24102021
            LineNo := GetEntryNo(GlobalDocNo); //Pru_gk 24102021

            PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, GlobalDocNo);
            IF Rec_SL.GET(Rec_SL."Document Type"::Order, GlobalDocNo, LineNo) THEN BEGIN
                Rec_SL.Validate("No.", ColText1[2]);
                Rec_SL.Validate(Description, ColText1[3]);

                Rec_SL.MODIFY(TRUE);
            END;
        END;
    end;

    procedure GetDocNo(DocumentNo: Code[20])
    begin
        GlobalDocNo := DocumentNo;
    end;

    local procedure GetEntryNo(DocNo: Code[20]): Integer
    begin
        SalesLine.RESET;
        //SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::"Blanket Order");
        SalesLine.SETRANGE("Document No.", DocNo);
        IF SalesLine.FINDLAST THEN
            EXIT(SalesLine."Line No." + 10000)
        ELSE
            EXIT(10000);
    end;

}

