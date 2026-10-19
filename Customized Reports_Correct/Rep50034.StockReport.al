report 50034 "Stock Report"
{
    UsageCategory = Administration;
    Caption = 'Stock Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;

    RDLCLayout = 'ReportLayout\StockReport.rdl';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = where(Type = Filter(Inventory));
            column(No_Item; Item."No.")
            {
            }
            column(Description_Item; Item.Description)
            {
            }
            column(Description2_Item; Item."Description 2")
            {
            }
            column(OpeningQty; OpeningQty)
            {
            }
            column(OpeningAmt; OpeningAmt)
            {
            }
            column(PurchaseQty; PurchaseQty)
            {
            }
            column(BarENtryCons; BarENtryCons)
            { }
            column(BarENtryConsAmt; BarENtryConsAmt)
            { }
            column(BarEntryOut; BarEntryOut)
            { }
            column(BarEntryOutAmt; BarEntryOutAmt)
            { }
            column(PurchaseAmt; PurchaseAmt)
            {
            }
            column(TransferInQty; TransferInQty)
            {
            }
            column(TransferInAmt; TransferInAmt)
            {
            }
            column(SalesReturnQty; SalesReturnQty)
            {
            }
            column(SalesReturnAmt; SalesReturnAmt)
            {
            }
            column(PositiveQty; PositiveQty)
            {
            }
            column(PositiveAmt; PositiveAmt)
            {
            }
            column(OutputQty; OutputQty)
            {
            }
            column(OutputAmt; OutputAmt)
            {
            }
            column(SalesQty; SalesQty)
            {
            }
            column(SalesAmt; SalesAmt)
            {
            }
            column(TransferOutQty; TransferOutQty)
            {
            }
            column(TransferOutAmt; TransferOutAmt)
            {
            }
            column(PurchaseReturnQty; PurchaseReturnQty)
            {
            }
            column(PurchaseReturnAmt; PurchaseReturnAmt)
            {
            }
            column(NegativeQty; NegativeQty)
            {
            }
            column(NegativeAmt; NegativeAmt)
            {
            }
            column(ConsuptionQty; ConsuptionQty)
            {
            }
            column(ConsuptionAmt; ConsuptionAmt)
            {
            }
            column(ClosingQty; ClosingQty)
            {
            }
            column(ClosingAmt; ClosingAmt)
            {
            }
            column(ConsumableConsumption; ConsumableConsumption)
            {
            }
            column(ConsumableConsumptionamt; ConsumableConsumptionamt)
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
            column(User_ID; VUSERID)
            {
            }
            column(LocationCode; LocationCode)
            {
            }

            trigger OnAfterGetRecord()
            begin
                InitializeFunction;  // Clear all Variables
                                     // << Calculate Opening and Closing
                Clear(OpeningQty);
                Clear(OpeningAmt);
                Clear(ClosingQty);
                Clear(ClosingAmt);
                // ItemLedgerEntry.RESET;
                // ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", 0D, OpeningDate);
                // ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", Item."No.");
                // ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code", LocationCode);
                // ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 1 Code", GlobalDimen1);
                // ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 2 Code", GlobalDimen2);
                // ItemLedgerEntry.SetAutoCalcFields("Cost Amount (Actual)");
                // IF ItemLedgerEntry.FINDSET THEN begin
                //     //     REPEAT

                //     ItemLedgerEntry.CalcSums(Quantity);
                //     OpeningQty := ItemLedgerEntry.Quantity;
                //     OpeningAmt := ItemLedgerEntry."Cost Amount (Actual)";
                //     ClosingQty := ItemLedgerEntry.Quantity;
                //     ClosingAmt := ItemLedgerEntry."Cost Amount (Actual)";
                // end;
                // UNTIL ItemLedgerEntry.NEXT = 0;
                //  Calculate Opening and Closing >>

                // << Calculate Purchase and Closing

                Item.SetFilter("Location Filter", LocationCode);
                // RecItem.SetFilter("Global Dimension 1 Filter", GlobalDimen1);
                // RecItem.SetFilter("Global Dimension 2 Filter", GlobalDimen2);
                //Item.SetRange("No.", Item."No.");
                Item.SetRange("Date Filter", 0D, OpeningDate);
                Item.CalcFields("Net Change");
                Item.CalcFields("Stock Value");
                //Message('%1', Item."Net Change");
                OpeningQty := Item."Net Change";
                OpeningAmt := Item."Stock Value";
                ClosingQty := Item."Net Change";
                ClosingAmt := Item."Stock Value";



                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", StartingDate, EndingDate);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", Item."No.");
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code", LocationCode);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 1 Code", GlobalDimen1);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 2 Code", GlobalDimen2);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Document Type", '%1|%2|%3', ItemLedgerEntry."Document Type"::"Purchase Receipt", ItemLedgerEntry."Document Type"::"Purchase Invoice", ItemLedgerEntry."Document Type"::" ");
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                        PurchaseQty += ItemLedgerEntry.Quantity;
                        PurchaseAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                        ClosingQty += ItemLedgerEntry.Quantity;
                        ClosingAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                    UNTIL ItemLedgerEntry.NEXT = 0;
                //  Calculate Purchase and Closing >>

                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", StartingDate, EndingDate);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", Item."No.");
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code", LocationCode);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 1 Code", GlobalDimen1);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 2 Code", GlobalDimen2);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Transfer);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Document Type", ItemLedgerEntry."Document Type"::"Transfer Receipt");
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                        TransferInQty += ItemLedgerEntry.Quantity;
                        TransferInAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                        ClosingQty += ItemLedgerEntry.Quantity;
                        ClosingAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                    UNTIL ItemLedgerEntry.NEXT = 0;

                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", StartingDate, EndingDate);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", Item."No.");
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code", LocationCode);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 1 Code", GlobalDimen1);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 2 Code", GlobalDimen2);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Transfer);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Document Type", ItemLedgerEntry."Document Type"::" ");
                ItemLedgerEntry.SetRange(Positive, true);
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                        TransferInQty += ItemLedgerEntry.Quantity;
                        TransferInAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                        ClosingQty += ItemLedgerEntry.Quantity;
                        ClosingAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                    UNTIL ItemLedgerEntry.NEXT = 0;

                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", StartingDate, EndingDate);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", Item."No.");
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code", LocationCode);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 1 Code", GlobalDimen1);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 2 Code", GlobalDimen2);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Document Type", '%1|%2', ItemLedgerEntry."Document Type"::"Sales Credit Memo", ItemLedgerEntry."Document Type"::"Sales Return Receipt");
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                        SalesReturnQty += ItemLedgerEntry.Quantity;
                        SalesReturnAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                        ClosingQty += ItemLedgerEntry.Quantity;
                        ClosingAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                    UNTIL ItemLedgerEntry.NEXT = 0;

                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", StartingDate, EndingDate);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", Item."No.");
                ItemLedgerEntry.SetRange(Consumption, false);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code", LocationCode);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 1 Code", GlobalDimen1);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 2 Code", GlobalDimen2);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::"Positive Adjmt.");
                //ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Document Type",ItemLedgerEntry."Document Type"::"Sales Credit Memo",ItemLedgerEntry."Document Type"::"Sales Return Receipt");
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                        PositiveQty += ItemLedgerEntry.Quantity;
                        PositiveAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                        ClosingQty += ItemLedgerEntry.Quantity;
                        ClosingAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                    UNTIL ItemLedgerEntry.NEXT = 0;

                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", StartingDate, EndingDate);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", Item."No.");
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code", LocationCode);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 1 Code", GlobalDimen1);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 2 Code", GlobalDimen2);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Output);
                ItemLedgerEntry.SetRange(ItemLedgerEntry."Bardana Generation Entry", false);
                //ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Document Type",ItemLedgerEntry."Document Type"::"Sales Credit Memo",ItemLedgerEntry."Document Type"::"Sales Return Receipt");
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                        OutputQty += ItemLedgerEntry.Quantity;
                        OutputAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                        ClosingQty += ItemLedgerEntry.Quantity;
                        ClosingAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                    UNTIL ItemLedgerEntry.NEXT = 0;

                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", StartingDate, EndingDate);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", Item."No.");
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code", LocationCode);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 1 Code", GlobalDimen1);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 2 Code", GlobalDimen2);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Document Type", '%1|%2', ItemLedgerEntry."Document Type"::"Sales Invoice", ItemLedgerEntry."Document Type"::"Sales Shipment");
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                        SalesQty += ItemLedgerEntry.Quantity;
                        SalesAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                        ClosingQty += ItemLedgerEntry.Quantity;
                        ClosingAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                    UNTIL ItemLedgerEntry.NEXT = 0;

                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", StartingDate, EndingDate);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", Item."No.");
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code", LocationCode);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 1 Code", GlobalDimen1);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 2 Code", GlobalDimen2);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Transfer);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Document Type", ItemLedgerEntry."Document Type"::"Transfer Shipment");
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                        TransferOutQty += ItemLedgerEntry.Quantity;
                        TransferOutAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                        ClosingQty += ItemLedgerEntry.Quantity;
                        ClosingAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                    UNTIL ItemLedgerEntry.NEXT = 0;

                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", StartingDate, EndingDate);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", Item."No.");
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code", LocationCode);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 1 Code", GlobalDimen1);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 2 Code", GlobalDimen2);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Transfer);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Document Type", ItemLedgerEntry."Document Type"::" ");
                ItemLedgerEntry.SetRange(Positive, false);
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                        TransferOutQty += ItemLedgerEntry.Quantity;
                        TransferOutAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                        ClosingQty += ItemLedgerEntry.Quantity;
                        ClosingAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                    UNTIL ItemLedgerEntry.NEXT = 0;


                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", StartingDate, EndingDate);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", Item."No.");
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code", LocationCode);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 1 Code", GlobalDimen1);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 2 Code", GlobalDimen2);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Document Type", '%1|%2', ItemLedgerEntry."Document Type"::"Purchase Credit Memo", ItemLedgerEntry."Document Type"::"Purchase Return Shipment");
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                        PurchaseReturnQty += ItemLedgerEntry.Quantity;
                        PurchaseReturnAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                        ClosingQty += ItemLedgerEntry.Quantity;
                        ClosingAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                    UNTIL ItemLedgerEntry.NEXT = 0;

                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", StartingDate, EndingDate);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", Item."No.");
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code", LocationCode);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 1 Code", GlobalDimen1);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 2 Code", GlobalDimen2);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::"Negative Adjmt.");
                ItemLedgerEntry.SetRange(Consumption, false);
                //ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Document Type",'%1|%2',ItemLedgerEntry."Document Type"::"Purchase Credit Memo",ItemLedgerEntry."Document Type"::"Purchase Return Shipment");
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                        NegativeQty += ItemLedgerEntry.Quantity;
                        NegativeAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                        ClosingQty += ItemLedgerEntry.Quantity;
                        ClosingAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                    UNTIL ItemLedgerEntry.NEXT = 0;

                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", StartingDate, EndingDate);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", Item."No.");
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code", LocationCode);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 1 Code", GlobalDimen1);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 2 Code", GlobalDimen2);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Entry Type", '%1|%2', ItemLedgerEntry."Entry Type"::"Negative Adjmt.", ItemLedgerEntry."Entry Type"::"Positive Adjmt.");
                ItemLedgerEntry.SetRange(Consumption, true);
                //ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Document Type",'%1|%2',ItemLedgerEntry."Document Type"::"Purchase Credit Memo",ItemLedgerEntry."Document Type"::"Purchase Return Shipment");
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                        ConsumableConsumption += ItemLedgerEntry.Quantity;
                        ConsumableConsumptionamt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                        ClosingQty += ItemLedgerEntry.Quantity;
                        ClosingAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                    UNTIL ItemLedgerEntry.NEXT = 0;

                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", StartingDate, EndingDate);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", Item."No.");
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code", LocationCode);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 1 Code", GlobalDimen1);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 2 Code", GlobalDimen2);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
                ItemLedgerEntry.SetRange(ItemLedgerEntry."Bardana Generation Entry", false);
                //ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Document Type",'%1|%2',ItemLedgerEntry."Document Type"::"Purchase Credit Memo",ItemLedgerEntry."Document Type"::"Purchase Return Shipment");
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                        ConsuptionQty += ItemLedgerEntry.Quantity;
                        ConsuptionAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                        ClosingQty += ItemLedgerEntry.Quantity;
                        ClosingAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                    UNTIL ItemLedgerEntry.NEXT = 0;

                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", StartingDate, EndingDate);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", Item."No.");
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code", LocationCode);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 1 Code", GlobalDimen1);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 2 Code", GlobalDimen2);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
                ItemLedgerEntry.SetRange(ItemLedgerEntry."Bardana Generation Entry", true);
                //ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Document Type",'%1|%2',ItemLedgerEntry."Document Type"::"Purchase Credit Memo",ItemLedgerEntry."Document Type"::"Purchase Return Shipment");
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                        BarENtryCons += ItemLedgerEntry.Quantity;
                        BarENtryConsAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                        ClosingQty += ItemLedgerEntry.Quantity;
                        ClosingAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                    UNTIL ItemLedgerEntry.NEXT = 0;

                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", StartingDate, EndingDate);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", Item."No.");
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code", LocationCode);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 1 Code", GlobalDimen1);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 2 Code", GlobalDimen2);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Output);
                ItemLedgerEntry.SetRange(ItemLedgerEntry."Bardana Generation Entry", true);
                //ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Document Type",'%1|%2',ItemLedgerEntry."Document Type"::"Purchase Credit Memo",ItemLedgerEntry."Document Type"::"Purchase Return Shipment");
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                        BarEntryOut += ItemLedgerEntry.Quantity;
                        BarEntryOutAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                        ClosingQty += ItemLedgerEntry.Quantity;
                        ClosingAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                    UNTIL ItemLedgerEntry.NEXT = 0;

                IF (OpeningQty = 0) AND
                  (OpeningAmt = 0) AND
                  (PurchaseQty = 0) AND
                  (PurchaseAmt = 0) AND
                  (TransferInQty = 0) AND
                  (TransferInAmt = 0) AND
                  (SalesReturnQty = 0) AND
                  (SalesReturnAmt = 0) AND
                  (PositiveQty = 0) AND
                  (PositiveAmt = 0) AND
                  (OutputQty = 0) AND
                  (OutputAmt = 0) AND
                  (SalesQty = 0) AND
                  (SalesAmt = 0) AND
                  (TransferOutQty = 0) AND
                  (TransferOutAmt = 0) AND
                  (PurchaseReturnQty = 0) AND
                  (PurchaseReturnAmt = 0) AND
                  (NegativeQty = 0) AND
                  (NegativeAmt = 0) AND
                  (ConsuptionQty = 0) AND
                  (ConsuptionAmt = 0) AND
                  (ClosingAmt = 0) AND
                  (ClosingQty = 0) and
                  (ConsumableConsumption = 0) and
                  (ConsumableConsumptionamt = 0) and
                  (BarENtryCons = 0) and
                  (BarEntryOut = 0) and
                  (BarENtryConsAmt = 0) and
                  (BarEntryOutAmt = 0) THEN
                    CurrReport.SKIP;
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
                field("Start date`";
                StartingDate)
                {
                    ApplicationArea = All;
                }
                field("End Date";
                EndingDate)
                {
                    ApplicationArea = All;
                }
                field("Location Code";
                LocationCode)
                {
                    TableRelation = Location.Code;
                    ApplicationArea = All;
                }
                field("Lob Code";
                GlobalDimen1)
                {
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                    ApplicationArea = All;
                }
                field("Branch Code";
                GlobalDimen2)
                {
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
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
        IF (StartingDate = 0D) OR (EndingDate = 0D) THEN
            ERROR('Start Date and End Date must have value');
        OpeningDate := CALCDATE('-1D', StartingDate);

        if VUSERID = '' then
            VUSERID := UserId;
        //MESSAGE('%1',OpeningDate);
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        VUSERID: text;
        RecItem: Record Item;
        CompanyInformation_State: code[10];
        StartingDate: Date;
        EndingDate: Date;
        LocationCode: Code[20];
        GlobalDimen1: Code[20];
        GlobalDimen2: Code[20];
        BarEntryOut: Decimal;
        BarEntryOutAmt: Decimal;
        BarENtryCons: Decimal;
        BarENtryConsAmt: Decimal;
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
        ConsumableConsumptionamt := 0;
        BarEntryOut := 0;
        BarENtryCons := 0;
        BarENtryConsAmt := 0;
        BarEntryOutAmt := 0;

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

    procedure Datefilter(PStartdate: Date; PEndingDate: Date)
    begin
        StartingDate := PStartdate;
        EndingDate := PEndingDate;
    end;

    procedure Locationfilter(Location: Code[20]; PUserID: text)
    begin
        LocationCode := Location;
        VUSERID := PUserID;
    end;
}

