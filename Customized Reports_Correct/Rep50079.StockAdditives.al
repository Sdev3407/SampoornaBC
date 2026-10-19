report 50079 "StockAdditives"
{
    UsageCategory = Administration;
    Caption = 'Stock Report IMport';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    PreviewMode = Normal;
    RDLCLayout = 'ReportLayout\StockReportImport.rdl';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.") where("Net Change" = filter(<> 0));
            RequestFilterFields = "Item Category Code";
            column(No_Item; Item."No.")
            {
            }
            column(Net_Change; Item."Net Change")
            { }
            column(Stock_Value; (Item."Stock Value"))
            { }
            column(Description_Item; Item.Description)
            {
            }
            column(Description2_Item; Item."Description 2")
            {
            }
            column(Item_Category_Code; Item."Item Category Code")
            {
            }
            column(ConsuptionQty; ConsuptionQty)
            {
            }
            column(UOM; Item."Base Unit of Measure")
            {
            }
            column(PurchaseQty; PurchaseQty)
            {
            }
            column(PurchaseAmt; PurchaseAmt)
            {
            }

            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Address; CompanyInformation.Address)
            {
            }
            column(CompanyInformation_Address2; CompanyInformation."Address 2")
            {
            }
            column(CompanyInformation_City; CompanyInformation.City)
            {
            }
            column(CompanyInformation_PostCode; CompanyInformation."Post Code")
            {
            }
            // column(CompanyInformation_State; CompanyInformation.State)
            // {
            // }
            column(CompanyInformation_State; CompanyInformation_State)
            { }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(StartingDate; StartingDate)
            {
            }
            column(EndingDate; EndingDate)
            {
            }
            column(User_ID; USERID)
            {
            }
            column(LocationCode; LocationCode)
            {
            }
            column(WillLastDate; WillLastDate)
            { }
            column(Last15DayComp; Last15DayComp)
            { }
            column(StockwithPipeLine; StockwithPipeLine)
            { }

            trigger OnAfterGetRecord()
            begin
                InitializeFunction;
                // if (Item."Item Category Code" <> 'MEDICINE') and (Item."Item Category Code" <> 'Feed Additive') and (Item."Item Category Code" <> 'VITAMIN') then
                //     CurrReport.Skip();
                Clear(WillLastDate);
                Clear(Last15DayComp);
                Clear(StockwithPipeLine);
                ItemLedgerEntry.Reset();
                ItemLedgerEntry.SetRange("Item No.", "No.");
                ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
                ItemLedgerEntry.SetRange("Posting Date", (WorkDate() - 15), WorkDate());
                ItemLedgerEntry.CalcSums(Quantity);
                ConsuptionQty := ABS(Round((ItemLedgerEntry.Quantity / 15), 0.01));

                PurchaseLine.Reset();
                PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
                PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
                PurchaseLine.SetRange("Order Date", 0D, WorkDate());
                PurchaseLine.SetRange("No.", "No.");
                if PurchaseLine.FindSet() then
                    repeat
                        PurHeader.Get(PurchaseLine."Document Type", PurchaseLine."Document No.");
                        if not (PurHeader.Status in [PurHeader.Status::Released]) and (PurHeader.Status in [PurHeader.Status::"Short Close"]) then begin
                            PurchaseQty += PurchaseLine."Outstanding Qty. (Base)";
                            PurchaseAmt += PurchaseLine."Outstanding Amount";
                        end;
                    until PurchaseLine.Next() = 0;
                Item.CalcFields("Net Change");
                // if ("Net Change" <> 0) and (ConsuptionQty <> 0) and (PurchaseQty <> 0) then
                //     WillLastDate := Today() + Round(((Item."Net Change" / ConsuptionQty) + (Item."Net Change" / ConsuptionQty)), 1);

                if (ConsuptionQty <> 0) Then
                    Last15DayComp := Round((Item."Net Change" / ConsuptionQty), 1);
                if (PurchaseQty <> 0) and (ConsuptionQty <> 0) then
                    StockwithPipeLine := Round((PurchaseQty / ConsuptionQty), 1);
                if (ConsuptionQty <> 0) Then
                    WillLastDate := today() + (Last15DayComp + StockwithPipeLine)
            end;
        }

    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                // field("Start date`"; StartingDate)
                // {
                //     ApplicationArea = All;
                // }
                // field("End Date"; EndingDate)
                // {
                //     ApplicationArea = All;
                // }
                // field("Location Code"; LocationCode)
                // {
                //     TableRelation = Location.Code;
                //     ApplicationArea = All;
                // }
                // field("Lob Code"; GlobalDimen1)
                // {
                //     TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                //     ApplicationArea = All;
                // }
                // field("Branch Code"; GlobalDimen2)
                // {
                //     TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
                //     ApplicationArea = All;
                // }
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
        // IF (StartingDate = 0D) OR (EndingDate = 0D) THEN
        //     ERROR('Start Date and End Date must have value');
        // OpeningDate := CALCDATE('-1D', StartingDate);
        //MESSAGE('%1',OpeningDate);
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(Picture);

        //Item.Setfilter("Item Category Code", '%1|%2|%3', 'MEDICINE', 'Feed Additive', 'VITAMIN');
    end;

    var
        Last15DayComp: Decimal;
        StockwithPipeLine: Decimal;
        CompanyInformation_State: code[10];
        PurchaseLine: Record "Purchase Line";
        PurHeader: Record "Purchase Header";
        PurChQty: Decimal;
        WillLastDate: Date;
        StartingDate: Date;
        EndingDate: Date;
        LocationCode: Code[20];
        GlobalDimen1: Code[20];
        GlobalDimen2: Code[20];
        OpeningQty: Decimal;
        OpeningAmt: Decimal;
        ItemLedgerEntry: Record 32;
        OpeningDate: Date;
        ValueEntry: Record 5802;
        PurchaseQty: Decimal;
        PurchaseAmt: Decimal;
        TransferInQty: Decimal;
        TransferInAmt: Decimal;
        SalesReturnQty: Decimal;
        SalesReturnAmt: Decimal;
        PositiveQty: Decimal;
        PositiveAmt: Decimal;
        OutputQty: Decimal;
        OutputAmt: Decimal;
        SalesQty: Decimal;
        SalesAmt: Decimal;
        TransferOutQty: Decimal;
        TransferOutAmt: Decimal;
        PurchaseReturnQty: Decimal;
        PurchaseReturnAmt: Decimal;
        NegativeQty: Decimal;
        NegativeAmt: Decimal;
        ConsuptionQty: Decimal;
        ConsuptionAmt: Decimal;
        ClosingQty: Decimal;
        ClosingAmt: Decimal;
        ConsumableConsumption: Decimal;
        ConsumableConsumptionamt: Decimal;
        CompanyInformation: Record 79;

    local procedure InitializeFunction()
    begin
        OpeningQty := 0;
        OpeningAmt := 0;
        PurchaseQty := 0;
        PurchaseAmt := 0;
        TransferInQty := 0;
        TransferInAmt := 0;
        SalesReturnQty := 0;
        SalesReturnAmt := 0;
        PositiveQty := 0;
        PositiveAmt := 0;
        OutputQty := 0;
        OutputAmt := 0;
        SalesQty := 0;
        SalesAmt := 0;
        TransferOutQty := 0;
        TransferOutAmt := 0;
        PurchaseReturnQty := 0;
        PurchaseReturnAmt := 0;
        NegativeQty := 0;
        NegativeAmt := 0;
        ConsuptionQty := 0;
        ConsuptionAmt := 0;
        ClosingAmt := 0;
        ClosingQty := 0;
        ConsumableConsumption := 0;
        ConsumableConsumptionamt := 0
    end;

    local procedure ItemcostByValueEntry(ItemLedgerNo: Integer) CostValue: Decimal
    var
        ValueEntry: Record 5802;
    begin
        CostValue := 0;
        ValueEntry.RESET;
        ValueEntry.SETRANGE(ValueEntry."Item Ledger Entry No.", ItemLedgerNo);
        ValueEntry.SETRANGE(ValueEntry."Posting Date", StartingDate, EndingDate);
        IF ValueEntry.FINDSET THEN BEGIN
            REPEAT
                CostValue += ValueEntry."Cost Amount (Actual)";
            UNTIL ValueEntry.NEXT = 0;
        END;
    end;
}
