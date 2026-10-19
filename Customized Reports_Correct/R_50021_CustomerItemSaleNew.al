report 50021 "Customer/Item Sale_New"
{

    UsageCategory = Administration;
    Caption = 'Customer Item Sale New Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\CustomerItemSaleNew.rdl';
    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Search Name", "Customer Posting Group";
            column(CustomerPriceGroup_Customer; Customer."Customer Price Group")
            {
            }
            column(PageNumber; PgNo)
            {
            }
            column(CustomerFilter; CustomerFilter)
            {
            }
            column(Comp__Name; CompanyInformation.Name)
            {
            }
            column(Comp___Picture; CompanyInformation.Picture)
            {
            }
            column(No_Customer; Customer."No.")
            {
            }
            column(Name_Customer; Customer.Name)
            {
            }
            column(PhoneNo_Customer; Customer."Phone No.")
            {
            }
            column(ZerotoThiry; "30DBal")
            {
            }
            column(ThirtyonetoSixty; "31-60Bal")
            {
            }
            column(SixtyOneToNinty; "61-90Bal")
            {
            }
            column(MoreThanNinty; "91-DBal")
            {
            }
            dataitem("Value Entry"; "Value Entry")
            {
                DataItemLink = "Source No." = FIELD("No."),
                               "Posting Date" = FIELD("Date Filter"),
                               "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                               "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Source Type", "Source No.", "Item No.", "Variant Code", "Posting Date")
                                    WHERE("Source Type" = CONST(Customer),
                                         "Item Charge No." = CONST(),
                                          "Expected Cost" = CONST(false));
                column(ItemNo_ValueEntry; "Value Entry"."Item No.")
                {
                }
                column(InvoicedQuantity_ValueEntry; "Value Entry"."Invoiced Quantity")
                {
                }
                column(CostAmountActual_ValueEntry; "Value Entry"."Cost Amount (Actual)")
                {
                }
                column(SalesAmountActual_ValueEntry; "Value Entry"."Sales Amount (Actual)")
                {
                }
                column(UOM; Items."Base Unit of Measure")
                {
                }
                column(Item_Desc; Items.Description)
                {
                }
                column(Inv_Disc; -"Value Entry"."Discount Amount")
                {
                }
                column(LayerMrp; LayerMrp)
                {
                }
                column(TotalBags; TotalBags)
                {
                }
                column(AvgMrp; AvgMrp)
                {
                }
                column(MaxDis; MaxDiscGr)
                {
                }
                column(BroilerMaxDisGr; BroilerMaxDisGr)
                {
                }
                column(BroilerMrp; BroilerMrp)
                {
                }
                column(AverageUNitPrice; AverageUNitPrice)
                {
                }
                column(BroilerTotalBags; BroilerTotalBags)
                {
                }
                column(BroilerMaxDis; BroilerMaxDis)
                {
                }
                column(BroilerUnitPrice; BroilerUnitPrice)
                {
                }
                column(MaxDiscByItem; MaxDiscByItem)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    /*  //PRU SH
                    Items.RESET;
                    IF Items.GET("Value Entry"."Item No.") THEN;
                    IF SkipDuplicate <> "Value Entry"."Item No." THEN BEGIN
                        MaxDiscByItem := 0;
                        SalesInvoiceLine.RESET;
                        SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Sell-to Customer No.", Customer."No.");
                        SalesInvoiceLine.SETRANGE(SalesInvoiceLine."No.", "Value Entry"."Item No.");
                        SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Posting Date", StartingDate, EndDate);
                        IF SalesInvoiceLine.FINDSET THEN
                            REPEAT
                                IF SalesInvoiceLine."Product Group Code" = 'LAYER' THEN BEGIN
                                    LayerMrp += (SalesInvoiceLine."MRP Price" * SalesInvoiceLine.Quantity);
                                    TotalBags += SalesInvoiceLine.Quantity;
                                    MaxDis := (100 - (((SalesInvoiceLine."Unit Price" / SalesInvoiceLine."MRP Price") * 100)));
                                    IF MaxDis > MaxDiscGr THEN
                                        MaxDiscGr := MaxDis
                                    ELSE
                                        MaxDiscGr := MaxDiscGr;
                                    IF MaxDis > MaxDiscByItem THEN
                                        MaxDiscByItem := MaxDis
                                    ELSE
                                        MaxDiscByItem := MaxDiscByItem;
                                    AverageUNitPrice += (SalesInvoiceLine."Unit Price" * SalesInvoiceLine.Quantity);
                                END ELSE
                                    IF SalesInvoiceLine."Product Group Code" = 'P BROILER' THEN BEGIN
                                        BroilerMrp += (SalesInvoiceLine."MRP Price" * SalesInvoiceLine.Quantity);
                                        BroilerTotalBags += SalesInvoiceLine.Quantity;
                                        BroilerMaxDis := (100 - (((SalesInvoiceLine."Unit Price" / SalesInvoiceLine."MRP Price") * 100)));
                                        IF BroilerMaxDis > BroilerMaxDisGr THEN
                                            BroilerMaxDisGr := BroilerMaxDis
                                        ELSE
                                            BroilerMaxDisGr := BroilerMaxDisGr;
                                        IF BroilerMaxDisGr > MaxDiscByItem THEN
                                            MaxDiscByItem := BroilerMaxDisGr
                                        ELSE
                                            MaxDiscByItem := MaxDiscByItem;
                                        BroilerUnitPrice += (SalesInvoiceLine."Unit Price" * SalesInvoiceLine.Quantity);
                                    END;

                            //MESSAGE('%1',BroilerMaxDisGr);
                            UNTIL SalesInvoiceLine.NEXT = 0;
                        SkipDuplicate := "Value Entry"."Item No.";
                    END;
                    // IF TotalBags <> 0 THEN
                    //  AvgMrp += LayerMrp/TotalBags;
                    IF TotalBags <> 0 THEN
                        TotalBags := TotalBags
                    ELSE
                        TotalBags := 1;
                    IF BroilerTotalBags <> 0 THEN
                        BroilerTotalBags := BroilerTotalBags
                    ELSE
                        BroilerTotalBags := 1;
                        */  //PRU SH
                end;

                trigger OnPreDataItem()
                begin
                    "Value Entry".SETCURRENTKEY("Source Type", "Source No.", "Item No.");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF CustomerPerPage THEN
                    PgNo += 1;
                LayerMrp := 0;
                TotalBags := 0;
                MaxDis := 0;
                AvgMrp := 0;
                MaxDiscGr := 0;
                BroilerMaxDisGr := 0;
                BroilerMaxDis := 0;
                "30DBal" := GetAgeingValue(CALCDATE('<-30D>', EndDate), EndDate, Customer."No.");
                "31-60Bal" := GetAgeingValue(CALCDATE('<-60D>', EndDate), CALCDATE('<-31D>', EndDate), Customer."No.");
                "61-90Bal" := GetAgeingValue(CALCDATE('<-90D>', EndDate), CALCDATE('<-61D>', EndDate), Customer."No.");
                "91-DBal" := GetAgeingValue(0D, CALCDATE('<-91D>', EndDate), Customer."No.");
            end;

            trigger OnPreDataItem()
            begin
                CustomerFilter := Customer.GETFILTERS;
                CustomerDateFilters := Customer.GETFILTER("Date Filter");
                IF CustomerDateFilters <> '' THEN BEGIN
                    EndDate := Customer.GETRANGEMAX("Date Filter");
                    StartingDate := Customer.GETRANGEMIN("Date Filter")
                END
                ELSE
                    EndDate := TODAY;
                //MESSAGE('%1',EndDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Customer Per Page"; CustomerPerPage)
                {
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        VLE: Record 5802;
        Items: Record 27;
        CompanyInformation: Record 79;
        CustomerFilter: Text;
        DateFilt: Text;
        CustomerPerPage: Boolean;
        PgNo: Integer;
        SalesInvoiceLine: Record 113;
        LayerMrp: Decimal;
        BroilerMrp: Decimal;
        SkipDuplicate: Code[20];
        TotalBags: Decimal;
        AvgMrp: Decimal;
        MaxDis: Decimal;
        EndDate: Date;
        CustomerDateFilters: Text;
        DetailedCustLedgEntry: Record 379;
        "30DBal": Decimal;
        "31-60Bal": Decimal;
        "61-90Bal": Decimal;
        "91-DBal": Decimal;
        AverageUNitPrice: Decimal;
        BroilerTotalBags: Decimal;
        BroilerAvgMrp: Decimal;
        BroilerMaxDis: Decimal;
        BroilerUnitPrice: Decimal;
        StartingDate: Date;
        MaxDiscGr: Decimal;
        MaxDiscByItem: Decimal;
        BroilerMaxDisGr: Decimal;

    local procedure GetAgeingValue(Sdate: Date; EDate: Date; CustomerNo: Code[20]) CustomerBal: Decimal
    var
        DetailedCustLedgEntry: Record 379;
    begin
        //MESSAGE('%1,%2',Sdate,EDate);
        DetailedCustLedgEntry.RESET;
        DetailedCustLedgEntry.SETRANGE(DetailedCustLedgEntry."Posting Date", Sdate, EDate);
        DetailedCustLedgEntry.SETRANGE(DetailedCustLedgEntry."Customer No.", CustomerNo);
        IF DetailedCustLedgEntry.FINDSET THEN
            REPEAT
                CustomerBal += DetailedCustLedgEntry.Amount;
            UNTIL DetailedCustLedgEntry.NEXT = 0;
    end;
}

