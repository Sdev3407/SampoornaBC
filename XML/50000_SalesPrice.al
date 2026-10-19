xmlport 50000 "SalesPrice ImportData"
{
    Caption = 'SalesPrice ImportData';
    Format = VariableText;
    Direction = Import;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Root)
        {

            tableelement(Integer; Integer)
            {

                AutoSave = true;
                UseTemporary = true;
                AutoUpdate = false;
                XmlName = 'Integer';
                SourceTableView = SORTING(Number) WHERE(Number = CONST(1));
                /*
                                textattribute(SalesCode)
                                {

                                }
                */
                textattribute(producttype)
                {

                }
                textattribute(ProductNo)
                {

                }
                textattribute(Description)
                {

                }

                textattribute(sourceno)
                {

                }
                textattribute(locationcode)
                {

                }
                textattribute(uom)
                {

                }
                textattribute(unitprice)
                {

                }
                textattribute(startingdate)
                {

                }
                textattribute(endingdate)
                {

                }
                textattribute(mrp)
                {

                }
                textattribute(mrpprice)
                {

                }

                textattribute(discounttype)
                {

                }
                trigger OnAfterInitRecord()
                begin
                    IntNum += 1;
                    Integer.Number := IntNum;
                end;




                trigger OnAfterInsertRecord()
                begin
                    IF Heading then begin  ////skip heading of csv
                        Heading := false;
                        currxmlport.skip;
                    end;

                    Evaluate(startdate1, startingdate);
                    Evaluate(enddate1, endingdate);
                    Evaluate(producttype1, producttype);

                    Evaluate(unitprice1, unitprice);
                    Evaluate(mrp1, mrp);
                    Evaluate(mrpprice1, mrpprice);
                    Evaluate(producttype1, producttype);
                    Evaluate(discounttype1, discounttype);

                    LineNo := GetNextLineNo();
                    Message('%1', LineNo);
                    SalesCodeVar2 := SalesCodeVar1;
                    Message('%1', SalesCodeVar2);
                    PLLine.Init();
                    PLLine."Price List Code" := SalesCodeVar2;
                    PLLine."Line No." := LineNo;
                    PLLine.Insert();
                    Message('%1.....%2......', SalesCodeVar2, LineNo);
                    if producttype <> '' then
                        PLLine.validate("Asset Type", producttype1);
                    if ProductNo <> '' then
                        PLLine.validate("Product No1", ProductNo);
                    if Description <> '' then
                        PLLine.validate(Description, Description);
                    if sourceno <> '' then
                        PLLine.validate("Source No.", sourceno);
                    if locationcode <> '' then
                        PLLine.validate(PLLine."Variant Code", locationcode);
                    if uom <> '' then
                        PLLine.validate("Unit of Measure Code", uom);
                    if unitprice <> '' then
                        PLLine.validate("Unit Price", unitprice1);
                    if startingdate <> '' then
                        PLLine.validate("Starting Date", startdate1);
                    if endingdate <> '' then
                        PLLine.validate("Ending Data", enddate1);
                    if mrp <> '' then
                        PLLine.validate(MRP, mrp1);
                    if mrpprice <> '' then
                        PLLine.validate("MRP PRICE", mrpprice1);
                    //  PLLine.Validate();
                    if discounttype <> '' then
                        PLLine.validate("Discount Perc/Amount", discounttype1);
                    PLLine.Modify();


                end;

            }
        }
    }
    trigger OnPreXmlPort()
    begin
        Heading := true;
    end;

    trigger OnPostXmlPort()
    begin
        Message('Sales price Created Successfully');
    end;

    /*
        local procedure GetNextLineNo(SalesCode: Code[20]): Integer;
        var
            NextSalesLine: Record "Price List Line";

        begin
            NextSalesLine.Reset();
            NextSalesLine.SetRange(NextSalesLine."Price List Code", SalesCode);
            if NextSalesLine.FindLast() then
                exit(NextSalesLine."Line No." + 10000)
            else
                exit(10000);

        end;
        */
    local procedure GetNextLineNo(): Integer;
    var
        NextSalesLine: Record "Price List Line";

    begin
        NextSalesLine.Reset();
        NextSalesLine.SetRange(NextSalesLine."Price List Code", SalesCodeVar1);
        if NextSalesLine.FindLast() then
            exit(NextSalesLine."Line No." + 10000)
        else
            exit(10000);

    end;

    procedure GetDocNo(SalesCodeVar: Code[20])
    begin
        SalesCodeVar1 := SalesCodeVar;
        Message(SalesCodeVar1);
    end;

    var
        recsalespricelines: Record "Price List Line";
        PriceListHeader: Record "Price List Header";
        PLLine: Record "Price List Line";
        NoOfLoops: Integer;
        RecHeader: Record "Sales Header";
        RecHeader1: Record "Sales Header";
        RecSLine: Record "Sales Line";
        RecSLine1: Record "Sales Line";
        LineNo: Integer;
        IQty: Decimal;
        ItemQty1: Decimal;
        ItemUnitPrice1: Decimal;
        startdate1: Date;
        enddate1: Date;
        producttype1: Option ,Item,"Item Discount Group",Resource,"Resource Group","Service Cost","G/L Account";
        Docno: Code[20];
        heading: Boolean;
        unitprice1: Decimal;
        mrp1: Boolean;
        mrpprice1: Decimal;
        discounttype1: Decimal;
        SalesCodeVar1: Code[20];
        SalesCodeVar2: Code[20];
        IntNum: Integer;
}