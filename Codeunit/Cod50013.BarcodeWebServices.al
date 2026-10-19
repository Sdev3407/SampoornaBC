codeunit 50013 "Barcode Web Services"
{

    trigger OnRun()
    var
        ExpireDate: Date;
    begin
        //MESSAGE('%1',TODAY-04022021D);
        MESSAGE(GetProductionOrderDetails('RPO/2425/003005'));
    end;

    var
        bxtBarcodeBinary: BigText;
        txcErrorSize: Label 'Valid values for the barcode size are 1, 2, 3, 4 & 5';
        txcErrorLength: Label 'Value to encode should be %1 digits.';
        txcErrorNumber: Label 'Only numbers allowed.';


    procedure GetProductionOrderDetails(BatchNo: Code[20]) BatchDetails: Text
    var
        ProductionOrder: Record 5405;
        ExpireDate: Date;
        DimensionValue: Record 349;
        DD: Integer;
        MM: Integer;
        YYYY: Integer;
    begin
        IF BatchNo <> '' THEN BEGIN
            ProductionOrder.RESET;
            //ProductionOrder.SETRANGE(ProductionOrder.Status,ProductionOrder.Status::Released);
            ProductionOrder.SETRANGE(ProductionOrder."No.", BatchNo);
            IF ProductionOrder.FINDFIRST THEN BEGIN
                DD := DATE2DMY(ProductionOrder."Due Date", 1);
                MM := DATE2DMY(ProductionOrder."Due Date", 2);
                YYYY := DATE2DMY(ProductionOrder."Due Date", 3);
                DimensionValue.RESET;
                DimensionValue.SETRANGE(DimensionValue.Code, ProductionOrder."Shortcut Dimension 2 Code");
                DimensionValue.SETRANGE(DimensionValue."Dimension Code", 'BRANCH');
                IF DimensionValue.FINDFIRST THEN;
                IF (TODAY - ProductionOrder."Due Date") > 120 THEN
                    BatchDetails := 'Your Barcode Is expired'
                ELSE
                    BatchDetails := 'Unit Name :' + DimensionValue.Name + ',' + 'Product Name :' + ProductionOrder.Description + ',' + 'Batch No. :' + ' ' + ProductionOrder."No." + ' , ' + ' ' + 'MFG Date : ' + FORMAT(DD) + '/' + FORMAT(MM) + '/' + FORMAT(YYYY);
            END;
            IF BatchDetails <> '' THEN
                EXIT(BatchDetails);
        END;//ELSE
    end;


    [ServiceEnabled]
    procedure SalesPriceAPI(SalesType: Enum "Sales Price Type"; SalesCode: Code[20]; ItemNo: Code[20]; Location: Code[10]; Unitofmeasure: Code[10]; OrderDate: Date): Text
    var
        SalesPrice: Record "Sales Price";
        Jsonheader: JsonObject;
        Jsonobject: JsonObject;
        jsondata: Text;
    Begin
        Clear(jsondata);
        SalesPrice.Reset();
        SalesPrice.SetRange("Sales Type", SalesPrice."Sales Type"::"Customer Price Group");
        SalesPrice.SetRange("Sales Code", SalesCode);
        SalesPrice.SetRange("Item No.", ItemNo);
        SalesPrice.SetRange("Variant Code", Location);
        SalesPrice.SetRange("Unit of Measure Code", Unitofmeasure);
        SalesPrice.SETFILTER("Starting Date", '<=%1', OrderDate);
        SalesPrice.SETFILTER("Ending Date", '%1|>=%2', 0D, OrderDate);
        if SalesPrice.FindFirst() then begin
            Jsonheader.Add('Sales_Type', SalesPrice."Sales Type");
            Jsonheader.Add('Sales_Code', SalesPrice."Sales Code");
            Jsonheader.Add('Item_No', SalesPrice."Item No.");
            Jsonheader.Add('UOM', SalesPrice."Unit of Measure Code");
            Jsonheader.Add('Location', SalesPrice."Variant Code");
            Jsonheader.Add('Unit_Price', SalesPrice."Unit Price");
            Jsonheader.Add('MRP', SalesPrice."MRP PRICE");
        end;

        Jsonobject.Add('Response', Jsonheader);
        Jsonobject.WriteTo(jsondata);
        if jsondata <> '' Then
            exit(jsondata)
        else
            exit('Sales Price Not Found')

    End;


    //  procedure

}

