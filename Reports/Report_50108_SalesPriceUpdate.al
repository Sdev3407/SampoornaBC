report 50113 "Import ILE Expiration"
{
    //ApplicationArea = all;
    //UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    Caption = 'Import ILE Expiration';
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
        OutputJnlLine: Record "Item Journal Line";

        ExcelBuf: Record "Excel Buffer" temporary;
        ServerFileName: Text;
        SheetName: Text[250];
        Text005: Label 'Imported from Excel ';
        Text006: Label 'Import Excel File';
        ExcelFileExtensionTok: Label '.xlsx', Locked = true;
        FileName: Text;
        ResNo: Code[20];
        CountData: Integer;
        LastNoSeries: Code[20];
        Rec_Item: Record Item;
        "Type Slect": Option " ",Lines,Update;
        ColText1: array[14] of Text[250];
        seyinteg: Integer;
        DimSetID: Integer;
        CText1: array[3] of Text;
        ReservationEntry1: Record "Reservation Entry";
        // ReservationEntry: Record "Reservation Entry";

        ReservationEntry: Record "Reservation Entry";
        GlobalDocNo: Code[20];
        GlobalBatchName: Code[20];
        GlobalTemplname: Code[20];
        BatchName: Code[20];
        Templname: Code[20];
        LineNum: Integer;
        LOC_Code: Code[10];
        Entry_Num: Integer;
        LineNo: Integer;
        ItemNum: Code[20];
        LocationCode: Code[10];
        VarItemNo: Code[20];
        ILE: Record "Item Ledger Entry";
        pagerec: Page 6510;
        line: Integer;
        ItemJournalLine: Record "Item Journal Line";
        TrackSpec: Record "Tracking Specification";
        ResEntry: Record "Reservation Entry";
        ResEntry1: Record "Reservation Entry";
        ILeRec1: Record "Item Ledger Entry";
        REntry: Record "Reservation Entry";
        RelProdUrder: Record "Production Order";
        VarLotNo: Code[50];
        ItemtrackCode: Record "Item Tracking Code";
        Rec_Item1: Record Item;
        PLLine: Record "Price List Line";
        PLLine1: Record "Price List Line";
        T7002: Record "Price List Line";
        saleprice: Record "Sales Price";
        SP: Record "Sales Price";
        ILERec: Record "Item Ledger Entry";
        EXPirationDate: Date;
        ENtryNo: Integer;

    procedure ImportSheet(RowNum: Integer)
    begin

        CLEAR(ColText1);
        Clear(VarItemNo);
        Clear(LOC_Code);
        Clear(line);
        ExcelBuf.SETRANGE(ExcelBuf."Row No.", RowNum);
        IF ExcelBuf.FINDSET THEN
            REPEAT
                ColText1[ExcelBuf."Column No."] := ExcelBuf."Cell Value as Text";
            UNTIL ExcelBuf.NEXT = 0;

        //SP.Insert();

        if ColText1[1] <> '' then begin
            Evaluate(ENtryNo, ColText1[1]);
            ILERec.Reset();
            ILERec.SetRange(ILERec."Entry No.", ENtryNo);
            if ILERec.FindFirst() then begin
                Evaluate(EXPirationDate, ColText1[2]);
                ILERec."Expiration Date" := EXPirationDate;
                ILERec.Modify();
            END;
        end;
    END;


    procedure GetDocNo(Salescode: Code[20])
    begin
        GlobalDocNo := Salescode;
    end;

    local procedure GetEntryNo(DocNo: Code[20]): Integer
    var
        NextSalesLine: Record "Price List Line";

    begin
        NextSalesLine.Reset();
        NextSalesLine.SetRange(NextSalesLine."Price List Code", DocNo);
        if NextSalesLine.FindLast() then
            exit(NextSalesLine."Line No." + 10000)
        else
            exit(10000);

    end;

}