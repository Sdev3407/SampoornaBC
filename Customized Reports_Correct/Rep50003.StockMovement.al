report 50003 "Stock Movement"
{
    UsageCategory = Administration;
    Caption = 'Stock Movement Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\StockMovement.rdl';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.";
            column(No_; "No.")
            {
            }
            column(Decs; Item.Description)
            {
            }
            column(Qty; Qty)
            {
            }
            column(CA; CA)
            {
            }
            column(SaleQty; SaleQty)
            {
            }
            column(SaleAmount; SaleAmount)
            {
            }
            column(PurchQty; PurchQty)
            {
            }
            column(PurchAmount; PurchAmount)
            {
            }
            column(PostitiveQty; TotalIncreaseQty)
            {
            }
            column(PostitiveAmount; TotalIncreaseAmount)
            {
            }
            column(NegativeQty; TotalDecreaseQty)
            {
            }
            column(NegativeAmount; TotalDecreaseAmount)
            {
            }
            column(OpeningStock_Caption; OpeningStock_Caption)
            {
            }
            column(Report_Caption; Report_Caption)
            {
            }
            column(PAGENO_Caption; PAGENO_Caption)
            {
            }
            column(Quantity_Caption; Quantity_Caption)
            {
            }
            column(InventoryValue_Caption; InventoryValue_Caption)
            {
            }
            column(Total_Caption; Total_Caption)
            {
            }
            column(ItemNo_Caption; ItemNo_Caption)
            {
            }
            column(PerQtyRate_Caption; PerQtyRate_Caption)
            {
            }
            column(Purchase_Caption; Purchase_Caption)
            {
            }
            column(Sales_Caption; Sales_Caption)
            {
            }
            column(OtherIncrease_Caption; OtherIncrease_Caption)
            {
            }
            column(OtherDecrease_Caption; OtherDecrease_Caption)
            {
            }
            column(ClosingStock_Caption; ClosingStock_Caption)
            {
            }
            column(ClosingQty; ClosingQty)
            {
            }
            column(ClosingAmount; ClosingAmount)
            {
            }
            column(PurchRate; PurchRate)
            {
            }
            column(OpeningRate; OpeningRate)
            {
            }
            column(SalesRate; SalesRate)
            {
            }
            column(ClosingRate; ClosingRate)
            {
            }
            column(OtherIncrRate; OtherIncrRate)
            {
            }
            column(Otherdecrate; Otherdecrate)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(COMPANYNAME; CompanyInfo.Name)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(Location; Location)
            {
            }
            column(Location_Caption; Location_Caption)
            {
            }
            column(StartDate_Caption; StartDate_Caption)
            {
            }
            column(EndDate_Caption; EndDate_Caption)
            {
            }

            trigger OnAfterGetRecord()
            begin
                T32.RESET;
                T32.SETCURRENTKEY("Item No.", "Posting Date");
                T32.SETRANGE("Item No.", "No.");
                T32.SETRANGE("Posting Date", StartDate, EndDate);
                IF Location <> '' THEN
                    T32.SETRANGE("Location Code", Location);
                IF T32.FINDSET THEN BEGIN
                    REPEAT
                        IF NOT TempItem.GET(T32."Item No.") THEN BEGIN
                            TempItem."No." := T32."Item No.";
                            TempItem.INSERT;
                        END;
                    UNTIL T32.NEXT = 0;
                END ELSE BEGIN
                    T32.SETFILTER("Posting Date", '<%1', StartDate);
                    IF Location <> '' THEN
                        T32.SETRANGE("Location Code", Location);
                    IF T32.FINDSET THEN BEGIN
                        REPEAT
                            IF NOT TempItem.GET(T32."Item No.") THEN BEGIN
                                TempItem."No." := T32."Item No.";
                                TempItem.INSERT;
                            END;
                        UNTIL T32.NEXT = 0;
                    END;
                END;

                IF NOT TempItem.GET("No.") THEN
                    CurrReport.SKIP;

                CLEAR(ClosingQty);
                Qty := 0;
                CA := 0;
                PostitiveAmount := 0;
                PostitiveAmount2 := 0;
                PostitiveAmount3 := 0;
                PostitiveAmount4 := 0;
                PostitiveQty := 0;
                PostitiveQty2 := 0;
                PostitiveQty3 := 0;
                PostitiveQty4 := 0;
                NegativeQty := 0;
                NegativeQty2 := 0;
                NegativeQty3 := 0;
                NegativeQty4 := 0;
                NegativeAmount := 0;
                NegativeAmount2 := 0;
                NegativeAmount3 := 0;
                NegativeAmount4 := 0;
                SaleAmount := 0;
                SaleAmount1 := 0;
                SaleAmount2 := 0;
                SaleQty := 0;
                SaleQty1 := 0;
                SaleQty2 := 0;
                PurchQty := 0;
                PurchQty1 := 0;
                PurchQty2 := 0;
                PurchAmount := 0;
                PurchAmount1 := 0;
                PurchAmount2 := 0;

                //OPENING VALUES
                T32.RESET;
                T32.SETCURRENTKEY("Item No.", "Posting Date");
                T32.SETRANGE("Item No.", Item."No.");
                T32.SETFILTER("Posting Date", '<%1', StartDate);
                IF Location <> '' THEN
                    T32.SETRANGE("Location Code", Location);
                T32.SETAUTOCALCFIELDS(T32."Cost Amount (Actual)");
                T32.SETAUTOCALCFIELDS(T32."Cost Amount (Expected)");
                IF T32.FINDSET THEN
                    REPEAT
                        Qty += T32.Quantity;
                        CA += T32."Cost Amount (Actual)" + T32."Cost Amount (Expected)";
                    UNTIL T32.NEXT = 0;

                T32.RESET;
                T32.SETCURRENTKEY("Item No.", "Posting Date");
                T32.SETRANGE("Item No.", Item."No.");
                T32.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                T32.SETRANGE("Entry Type", T32."Entry Type"::Sale);
                T32.SETRANGE("Document Type", T32."Document Type"::"Sales Shipment");
                IF Location <> '' THEN
                    T32.SETRANGE("Location Code", Location);
                T32.SETAUTOCALCFIELDS(T32."Cost Amount (Actual)");
                T32.SETAUTOCALCFIELDS(T32."Cost Amount (Expected)");
                IF T32.FINDSET THEN
                    REPEAT
                        SaleQty1 += T32.Quantity;
                        SaleAmount1 += T32."Cost Amount (Actual)" + T32."Cost Amount (Expected)";
                    UNTIL T32.NEXT = 0;

                T32.RESET;
                T32.SETCURRENTKEY("Item No.", "Posting Date");
                T32.SETRANGE("Item No.", Item."No.");
                T32.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                IF Location <> '' THEN
                    T32.SETRANGE("Location Code", Location);
                T32.SETRANGE("Entry Type", T32."Entry Type"::Sale);
                T32.SETRANGE("Document Type", T32."Document Type"::" ");
                T32.SETAUTOCALCFIELDS(T32."Cost Amount (Actual)");
                T32.SETAUTOCALCFIELDS(T32."Cost Amount (Expected)");
                IF T32.FINDSET THEN
                    REPEAT
                        SaleQty2 += T32.Quantity;
                        SaleAmount2 += T32."Cost Amount (Actual)" + T32."Cost Amount (Expected)";
                    UNTIL T32.NEXT = 0;

                T32.RESET;
                T32.SETCURRENTKEY("Item No.", "Posting Date");
                T32.SETRANGE("Item No.", Item."No.");
                T32.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                IF Location <> '' THEN
                    T32.SETRANGE("Location Code", Location);
                T32.SETRANGE("Entry Type", T32."Entry Type"::Purchase);
                T32.SETRANGE("Document Type", T32."Document Type"::"Purchase Receipt");
                T32.SETAUTOCALCFIELDS(T32."Cost Amount (Actual)");
                T32.SETAUTOCALCFIELDS(T32."Cost Amount (Expected)");
                IF T32.FINDSET THEN
                    REPEAT
                        PurchQty1 += T32.Quantity;
                        PurchAmount1 += T32."Cost Amount (Actual)" + T32."Cost Amount (Expected)";
                    UNTIL T32.NEXT = 0;

                T32.RESET;
                T32.SETCURRENTKEY("Item No.", "Posting Date");
                T32.SETRANGE("Item No.", Item."No.");
                T32.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                IF Location <> '' THEN
                    T32.SETRANGE("Location Code", Location);
                T32.SETRANGE("Entry Type", T32."Entry Type"::Purchase);
                T32.SETRANGE("Document Type", T32."Document Type"::" ");
                T32.SETAUTOCALCFIELDS(T32."Cost Amount (Actual)");
                T32.SETAUTOCALCFIELDS(T32."Cost Amount (Expected)");
                IF T32.FINDSET THEN
                    REPEAT
                        PurchQty2 += T32.Quantity;
                        PurchAmount2 += T32."Cost Amount (Actual)" + T32."Cost Amount (Expected)";
                    UNTIL T32.NEXT = 0;


                T32.RESET;
                T32.SETCURRENTKEY("Item No.", "Posting Date");
                T32.SETRANGE("Item No.", Item."No.");
                T32.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                IF Location <> '' THEN
                    T32.SETRANGE("Location Code", Location);
                T32.SETFILTER("Entry Type", '%1|%2', T32."Entry Type"::"Positive Adjmt.", T32."Entry Type"::Output);
                T32.SETRANGE("Document Type");
                T32.SETAUTOCALCFIELDS(T32."Cost Amount (Actual)");
                T32.SETAUTOCALCFIELDS(T32."Cost Amount (Expected)");
                IF T32.FINDSET THEN
                    REPEAT
                        PostitiveQty += T32.Quantity;
                        PostitiveAmount += T32."Cost Amount (Actual)" + T32."Cost Amount (Expected)";
                    UNTIL T32.NEXT = 0;

                T32.RESET;
                T32.SETCURRENTKEY("Item No.", "Posting Date");
                T32.SETRANGE("Item No.", Item."No.");
                T32.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                IF Location <> '' THEN
                    T32.SETRANGE("Location Code", Location);
                T32.SETFILTER("Entry Type", '%1', T32."Entry Type"::Sale);
                T32.SETFILTER("Document Type", '%1', T32."Document Type"::"Sales Return Receipt");
                T32.SETAUTOCALCFIELDS(T32."Cost Amount (Actual)");
                T32.SETAUTOCALCFIELDS(T32."Cost Amount (Expected)");
                IF T32.FINDSET THEN
                    REPEAT
                        PostitiveQty2 += T32.Quantity;
                        PostitiveAmount2 += T32."Cost Amount (Actual)" + T32."Cost Amount (Expected)";
                    UNTIL T32.NEXT = 0;

                T32.RESET;
                T32.SETCURRENTKEY("Item No.", "Posting Date");
                T32.SETRANGE("Item No.", Item."No.");
                T32.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                IF Location <> '' THEN
                    T32.SETRANGE("Location Code", Location);
                T32.SETFILTER("Entry Type", '%1', T32."Entry Type"::Transfer);
                T32.SETFILTER("Document Type", '%1', T32."Document Type"::"Transfer Receipt");
                T32.SETAUTOCALCFIELDS(T32."Cost Amount (Actual)");
                T32.SETAUTOCALCFIELDS(T32."Cost Amount (Expected)");
                IF T32.FINDSET THEN
                    REPEAT
                        PostitiveQty3 += T32.Quantity;
                        PostitiveAmount3 += T32."Cost Amount (Actual)" + T32."Cost Amount (Expected)";
                    UNTIL T32.NEXT = 0;


                T32.RESET;
                T32.SETCURRENTKEY("Item No.", "Posting Date");
                T32.SETRANGE("Item No.", Item."No.");
                T32.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                IF Location <> '' THEN
                    T32.SETRANGE("Location Code", Location);
                T32.SETFILTER("Entry Type", '%1', T32."Entry Type"::Transfer);
                T32.SETFILTER("Document Type", '%1', T32."Document Type"::" ");
                T32.SETRANGE(Positive, TRUE);
                T32.SETAUTOCALCFIELDS(T32."Cost Amount (Actual)");
                T32.SETAUTOCALCFIELDS(T32."Cost Amount (Expected)");
                IF T32.FINDSET THEN
                    REPEAT
                        PostitiveQty4 += T32.Quantity;
                        PostitiveAmount4 += T32."Cost Amount (Actual)" + T32."Cost Amount (Expected)";
                    UNTIL T32.NEXT = 0;


                //Other Decrease
                T32.RESET;
                T32.SETCURRENTKEY("Item No.", "Posting Date");
                T32.SETRANGE("Item No.", Item."No.");
                T32.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                IF Location <> '' THEN
                    T32.SETRANGE("Location Code", Location);
                T32.SETFILTER("Entry Type", '%1|%2', T32."Entry Type"::"Negative Adjmt.", T32."Entry Type"::Consumption);
                T32.SETRANGE("Document Type");
                T32.SETRANGE(Positive);
                T32.SETAUTOCALCFIELDS(T32."Cost Amount (Actual)");
                T32.SETAUTOCALCFIELDS(T32."Cost Amount (Expected)");
                IF T32.FINDSET THEN
                    REPEAT
                        NegativeQty += T32.Quantity;
                        NegativeAmount += T32."Cost Amount (Actual)" + T32."Cost Amount (Expected)";
                    UNTIL T32.NEXT = 0;

                T32.RESET;
                T32.SETCURRENTKEY("Item No.", "Posting Date");
                T32.SETRANGE("Item No.", Item."No.");
                T32.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                IF Location <> '' THEN
                    T32.SETRANGE("Location Code", Location);
                T32.SETFILTER("Entry Type", '%1', T32."Entry Type"::Purchase);
                T32.SETFILTER("Document Type", '%1', T32."Document Type"::"Purchase Return Shipment");
                T32.SETAUTOCALCFIELDS(T32."Cost Amount (Actual)");
                T32.SETAUTOCALCFIELDS(T32."Cost Amount (Expected)");
                IF T32.FINDSET THEN
                    REPEAT
                        NegativeQty2 += T32.Quantity;
                        NegativeAmount2 += T32."Cost Amount (Actual)" + T32."Cost Amount (Expected)";
                    UNTIL T32.NEXT = 0;

                T32.RESET;
                T32.SETCURRENTKEY("Item No.", "Posting Date");
                T32.SETRANGE("Item No.", Item."No.");
                T32.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                IF Location <> '' THEN
                    T32.SETRANGE("Location Code", Location);
                T32.SETFILTER("Entry Type", '%1', T32."Entry Type"::Transfer);
                T32.SETFILTER("Document Type", '%1', T32."Document Type"::"Transfer Shipment");
                T32.SETAUTOCALCFIELDS(T32."Cost Amount (Actual)");
                T32.SETAUTOCALCFIELDS(T32."Cost Amount (Expected)");
                IF T32.FINDSET THEN
                    REPEAT
                        NegativeQty3 += T32.Quantity;
                        NegativeAmount3 += T32."Cost Amount (Actual)" + T32."Cost Amount (Expected)";
                    UNTIL T32.NEXT = 0;

                T32.RESET;
                T32.SETCURRENTKEY("Item No.", "Posting Date");
                T32.SETRANGE("Item No.", Item."No.");
                T32.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                IF Location <> '' THEN
                    T32.SETRANGE("Location Code", Location);
                T32.SETFILTER("Entry Type", '%1', T32."Entry Type"::Transfer);
                T32.SETFILTER("Document Type", '%1', T32."Document Type"::" ");
                T32.SETRANGE(Positive, FALSE);
                T32.SETAUTOCALCFIELDS(T32."Cost Amount (Actual)");
                T32.SETAUTOCALCFIELDS(T32."Cost Amount (Expected)");
                IF T32.FINDSET THEN
                    REPEAT
                        NegativeQty4 += T32.Quantity;
                        NegativeAmount4 += T32."Cost Amount (Actual)" + T32."Cost Amount (Expected)";
                    UNTIL T32.NEXT = 0;


                PurchQty := PurchQty1 + PurchQty2;
                PurchAmount := PurchAmount1 + PurchAmount2;
                IF NOT (PurchQty = 0) THEN
                    PurchRate := PurchAmount / PurchQty
                ELSE
                    PurchRate := 0;

                SaleQty := SaleQty1 + SaleQty2;
                SaleAmount := SaleAmount1 + SaleAmount2;
                IF (SaleQty = 0) THEN
                    SalesRate := 0
                ELSE
                    SalesRate := SaleAmount / SaleQty;

                IF Qty = 0 THEN
                    OpeningRate := 0
                ELSE
                    OpeningRate := CA / Qty;

                TotalIncreaseQty := PostitiveQty + PostitiveQty2 + PostitiveQty3 + PostitiveQty4;
                TotalIncreaseAmount := PostitiveAmount + PostitiveAmount2 + PostitiveAmount3 + PostitiveAmount4;
                IF TotalIncreaseQty = 0 THEN
                    OtherIncrRate := 0
                ELSE
                    OtherIncrRate := TotalIncreaseAmount / TotalIncreaseQty;

                TotalDecreaseQty := NegativeQty + NegativeQty2 + NegativeQty3 + NegativeQty4;
                TotalDecreaseAmount := NegativeAmount + NegativeAmount2 + NegativeAmount3 + NegativeAmount4;
                IF TotalDecreaseQty = 0 THEN
                    Otherdecrate := 0
                ELSE
                    Otherdecrate := TotalDecreaseAmount / TotalDecreaseQty;

                ClosingQty := Qty + PurchQty + PostitiveQty + PostitiveQty2 + PostitiveQty3 + PostitiveQty4 + SaleQty + NegativeQty + NegativeQty2 + NegativeQty3 + NegativeQty4;
                ClosingAmount := CA + PurchAmount + PostitiveAmount + PostitiveAmount2 + PostitiveAmount3 + PostitiveAmount4 + SaleAmount + NegativeAmount + NegativeAmount2 + NegativeAmount3 + NegativeAmount4;

                IF ClosingQty = 0 THEN
                    ClosingRate := 0
                ELSE
                    ClosingRate := ClosingAmount / ClosingQty;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(StartDate; StartDate)
                    {
                        Caption = 'Start Date';
                        ApplicationArea = All;
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'End Date';
                        ApplicationArea = All;
                    }
                    field(Location; Location)
                    {
                        Caption = 'Location';
                        TableRelation = Location;
                        ApplicationArea = All;
                    }
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
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        T32: Record 32;
        StartDate: Date;
        EndDate: Date;
        Location: Code[150];
        TempItem: Record 27 temporary;
        Qty: Decimal;
        CA: Decimal;
        PurchQty: Decimal;
        PurchAmount: Decimal;
        SaleQty: Decimal;
        SaleAmount: Decimal;
        PostitiveQty: Decimal;
        PostitiveAmount: Decimal;
        PostitiveQty2: Decimal;
        PostitiveAmount2: Decimal;
        PostitiveQty3: Decimal;
        PostitiveAmount3: Decimal;
        PostitiveQty4: Decimal;
        PostitiveAmount4: Decimal;
        NegativeQty: Decimal;
        NegativeAmount: Decimal;
        NegativeQty2: Decimal;
        NegativeAmount2: Decimal;
        NegativeQty3: Decimal;
        NegativeAmount3: Decimal;
        OpeningStock_Caption: Label 'Opening Stock';
        Report_Caption: Label 'Inventory Movement';
        PAGENO_Caption: Label 'Page';
        Quantity_Caption: Label 'Qty.';
        InventoryValue_Caption: Label 'Value';
        Total_Caption: Label 'Total';
        ItemNo_Caption: Label 'Item No.';
        PerQtyRate_Caption: Label 'Per Qty Rate';
        Purchase_Caption: Label 'Purchase';
        Sales_Caption: Label 'Sales';
        OtherIncrease_Caption: Label 'Other Increase';
        OtherDecrease_Caption: Label 'Other Decrease';
        ClosingStock_Caption: Label 'Closing Stock';
        NegativeQty4: Decimal;
        NegativeAmount4: Decimal;
        PurchRate: Decimal;
        SalesRate: Decimal;
        OpeningRate: Decimal;
        ClosingRate: Decimal;
        OtherIncrRate: Decimal;
        Otherdecrate: Decimal;
        TotalIncreaseQty: Decimal;
        TotalIncreaseAmount: Decimal;
        TotalDecreaseQty: Decimal;
        TotalDecreaseAmount: Decimal;
        ClosingQty: Decimal;
        ClosingAmount: Decimal;
        CompanyInfo: Record 79;
        PurchQty1: Decimal;
        PurchQty2: Decimal;
        PurchAmount1: Decimal;
        PurchAmount2: Decimal;
        SaleAmount1: Decimal;
        SaleQty1: Decimal;
        SaleAmount2: Decimal;
        SaleQty2: Decimal;
        Location_Caption: Label 'Location';
        StartDate_Caption: Label 'Date';
        EndDate_Caption: Label 'End Date';
}

