codeunit 50037 BarCode
{

    procedure QRcodeForLotNo(QRCodeInput1: Text[300]; ProCOde: code[20])
    var
        QRCodeInput: Text[300];
        QRCodeFileName: text[300];
        TempBlob: Codeunit "Temp Blob";
        QRFieldRef: FieldRef;
        QRRecRef: RecordRef;
        InputFile: File;
        InStream: InStream;
        OutStream: OutStream;
        proOrder: Record "Production Order";
        QRCOCDeMget:Codeunit "Swiss QR Code Helper";
    begin
        if proOrder.Get(proOrder.Status::Released, ProCOde) then begin
            QRCodeFileName := GetQRCode(QRCodeInput1);
            InputFile.Open(QRCodeFileName);
            InputFile.CreateInStream(InStream);
            proOrder."Batch Barcode".CreateOutStream(OutStream);
            CopyStream(OutStream, InStream);
            InputFile.Close;
            IF ERASE(QRCodeFileName) THEN;
            proOrder.Modify();
        END else
            if proOrder.Get(proOrder.Status::Finished, ProCOde) then begin
                QRCodeFileName := GetQRCode(QRCodeInput1);
                InputFile.Open(QRCodeFileName);
                InputFile.CreateInStream(InStream);
                proOrder."Batch Barcode".CreateOutStream(OutStream);
                CopyStream(OutStream, InStream);
                InputFile.Close;
                IF ERASE(QRCodeFileName) THEN;
                proOrder.Modify();
            END;
    end;

    

    [Scope('OnPrem')]
    LOCAL procedure GetQRCode(QRCodeInput: Text[200]) QRCodeFileName: Text[1024]
    var
        IBarCodeProvider: DotNet QRCodeProvider;

    begin
        GetBarCodeProvider(IBarCodeProvider);
        QRCodeFileName := IBarCodeProvider.GetBarcode(QRCodeInput);

    end;

    [Scope('OnPrem')]
    procedure GetBarCodeProvider(VAR IBarCodeProvider: DotNet QRCodeProvider)
    var
        QRCodeProvider: dotnet QRCodeProvider;
    begin
        IF ISNULL(IBarCodeProvider) THEN
            IBarCodeProvider := QRCodeProvider.QRCodeProvider;
    end;



}