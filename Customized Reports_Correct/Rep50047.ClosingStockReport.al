report 50047 "Closing Stock Report"
{
    UsageCategory = Administration;
    Caption = 'Closing Stock Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\ClosingStockReport.rdl';
    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = Where(Type = filter('Inventory'));
            column(No_Item; "No.")
            {
            }
            column(Description_Item; Description)
            {
            }
            column(InventoryPostingGroup_Item; Item."Inventory Posting Group")
            {
            }
            column(LocationFilter_Item; Item."Location Filter")
            {
            }
            column(ClosingQty; ClosingQty)
            {
            }
            column(ClosingAmt; ClosingAmt)
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

            trigger OnAfterGetRecord()
            begin
                Error('This report no longer accesible, Please use the Item Availabilty By Location report');
                InitializeFunction;  // Clear all Variables

                Item.SETRANGE("Location Filter", LocationCode);
                Item.SETRANGE("Date Filter", 0D, EndingDate);
                Item.CALCFIELDS("Net Change");
                Item.CALCFIELDS("Stock Value");
                ClosingQty := Item."Net Change";
                ClosingAmt := Item."Stock Value";

                // << Calculate Opening and Closing
                /*
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date",0D,EndingDate);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.",Item."No.");
                //ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code",'SFPL0021');
                //ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 1 Code",GlobalDimen1);
                //ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 2 Code",GlobalDimen2);
                IF ItemLedgerEntry.FINDSET THEN
                  REPEAT
                    //ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                    //OpeningQty += ItemLedgerEntry.Quantity;
                    //OpeningAmt += ItemLedgerEntry."Cost Amount (Actual)";
                    ClosingQty += ItemLedgerEntry.Quantity;
                    ClosingAmt += ItemLedgerEntry."Cost Amount (Actual)";
                  UNTIL ItemLedgerEntry.NEXT=0;
                //  Calculate Opening and Closing >>
                */
                // << Calculate Purchase and Closing
                /*
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date",StartingDate,EndingDate);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.",Item."No.");
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code",LocationCode);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 1 Code",GlobalDimen1);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 2 Code",GlobalDimen2);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type",ItemLedgerEntry."Entry Type"::Purchase);
                ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Document Type",'%1|%2|%3',ItemLedgerEntry."Document Type"::"Purchase Receipt",ItemLedgerEntry."Document Type"::"Purchase Invoice",ItemLedgerEntry."Document Type"::" ");
                IF ItemLedgerEntry.FINDSET THEN
                  REPEAT
                    ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                    PurchaseQty += ItemLedgerEntry.Quantity;
                    PurchaseAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                    ClosingQty += ItemLedgerEntry.Quantity;
                    ClosingAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                  UNTIL ItemLedgerEntry.NEXT=0;
                //  Calculate Purchase and Closing >>
                
                 ItemLedgerEntry.RESET;
                  ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date",StartingDate,EndingDate);
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.",Item."No.");
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code",LocationCode);
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 1 Code",GlobalDimen1);
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 2 Code",GlobalDimen2);
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type",ItemLedgerEntry."Entry Type"::Transfer);
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Document Type",ItemLedgerEntry."Document Type"::"Transfer Receipt");
                 IF ItemLedgerEntry.FINDSET THEN
                  REPEAT
                    ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                    TransferInQty += ItemLedgerEntry.Quantity;
                    TransferInAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                    ClosingQty += ItemLedgerEntry.Quantity;
                    ClosingAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                  UNTIL ItemLedgerEntry.NEXT=0;
                
                 ItemLedgerEntry.RESET;
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date",StartingDate,EndingDate);
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.",Item."No.");
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code",LocationCode);
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 1 Code",GlobalDimen1);
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 2 Code",GlobalDimen2);
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type",ItemLedgerEntry."Entry Type"::Sale);
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Document Type",'%1|%2',ItemLedgerEntry."Document Type"::"Sales Credit Memo",ItemLedgerEntry."Document Type"::"Sales Return Receipt");
                 IF ItemLedgerEntry.FINDSET THEN
                  REPEAT
                    ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                    SalesReturnQty += ItemLedgerEntry.Quantity;
                    SalesReturnAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                    ClosingQty += ItemLedgerEntry.Quantity;
                    ClosingAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                  UNTIL ItemLedgerEntry.NEXT=0;
                
                 ItemLedgerEntry.RESET;
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date",StartingDate,EndingDate);
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.",Item."No.");
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code",LocationCode);
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 1 Code",GlobalDimen1);
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 2 Code",GlobalDimen2);
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type",ItemLedgerEntry."Entry Type"::"Positive Adjmt.");
                 //ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Document Type",ItemLedgerEntry."Document Type"::"Sales Credit Memo",ItemLedgerEntry."Document Type"::"Sales Return Receipt");
                 IF ItemLedgerEntry.FINDSET THEN
                  REPEAT
                    ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                    PositiveQty += ItemLedgerEntry.Quantity;
                    PositiveAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                    ClosingQty += ItemLedgerEntry.Quantity;
                    ClosingAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                  UNTIL ItemLedgerEntry.NEXT=0;
                
                 ItemLedgerEntry.RESET;
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date",StartingDate,EndingDate);
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.",Item."No.");
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code",LocationCode);
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 1 Code",GlobalDimen1);
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 2 Code",GlobalDimen2);
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type",ItemLedgerEntry."Entry Type"::Output);
                 //ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Document Type",ItemLedgerEntry."Document Type"::"Sales Credit Memo",ItemLedgerEntry."Document Type"::"Sales Return Receipt");
                 IF ItemLedgerEntry.FINDSET THEN
                  REPEAT
                    ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                    OutputQty += ItemLedgerEntry.Quantity;
                    OutputAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                    ClosingQty += ItemLedgerEntry.Quantity;
                    ClosingAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                  UNTIL ItemLedgerEntry.NEXT=0;
                
                 ItemLedgerEntry.RESET;
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date",StartingDate,EndingDate);
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.",Item."No.");
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code",LocationCode);
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 1 Code",GlobalDimen1);
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 2 Code",GlobalDimen2);
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type",ItemLedgerEntry."Entry Type"::Sale);
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Document Type",'%1|%2',ItemLedgerEntry."Document Type"::"Sales Invoice",ItemLedgerEntry."Document Type"::"Sales Shipment");
                 IF ItemLedgerEntry.FINDSET THEN
                  REPEAT
                    ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                    SalesQty += ItemLedgerEntry.Quantity;
                    SalesAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                    ClosingQty += ItemLedgerEntry.Quantity;
                    ClosingAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                  UNTIL ItemLedgerEntry.NEXT=0;
                
                 ItemLedgerEntry.RESET;
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date",StartingDate,EndingDate);
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.",Item."No.");
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code",LocationCode);
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 1 Code",GlobalDimen1);
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 2 Code",GlobalDimen2);
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type",ItemLedgerEntry."Entry Type"::Transfer);
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Document Type",ItemLedgerEntry."Document Type"::"Transfer Shipment");
                 IF ItemLedgerEntry.FINDSET THEN
                  REPEAT
                    ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                    TransferOutQty += ItemLedgerEntry.Quantity;
                    TransferOutAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                    ClosingQty += ItemLedgerEntry.Quantity;
                    ClosingAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                  UNTIL ItemLedgerEntry.NEXT=0;
                
                 ItemLedgerEntry.RESET;
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date",StartingDate,EndingDate);
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.",Item."No.");
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code",LocationCode);
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 1 Code",GlobalDimen1);
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 2 Code",GlobalDimen2);
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type",ItemLedgerEntry."Entry Type"::Purchase);
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Document Type",'%1|%2',ItemLedgerEntry."Document Type"::"Purchase Credit Memo",ItemLedgerEntry."Document Type"::"Purchase Return Shipment");
                 IF ItemLedgerEntry.FINDSET THEN
                  REPEAT
                    ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                    PurchaseReturnQty += ItemLedgerEntry.Quantity;
                    PurchaseReturnAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                    ClosingQty += ItemLedgerEntry.Quantity;
                    ClosingAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                  UNTIL ItemLedgerEntry.NEXT=0;
                
                 ItemLedgerEntry.RESET;
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date",StartingDate,EndingDate);
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.",Item."No.");
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code",LocationCode);
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 1 Code",GlobalDimen1);
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 2 Code",GlobalDimen2);
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type",ItemLedgerEntry."Entry Type"::"Negative Adjmt.");
                 //ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Document Type",'%1|%2',ItemLedgerEntry."Document Type"::"Purchase Credit Memo",ItemLedgerEntry."Document Type"::"Purchase Return Shipment");
                 IF ItemLedgerEntry.FINDSET THEN
                  REPEAT
                    ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                    NegativeQty += ItemLedgerEntry.Quantity;
                    NegativeAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                    ClosingQty += ItemLedgerEntry.Quantity;
                    ClosingAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                  UNTIL ItemLedgerEntry.NEXT=0;
                
                 ItemLedgerEntry.RESET;
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date",StartingDate,EndingDate);
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.",Item."No.");
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Location Code",LocationCode);
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 1 Code",GlobalDimen1);
                 ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Global Dimension 2 Code",GlobalDimen2);
                 ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type",ItemLedgerEntry."Entry Type"::Consumption);
                 //ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Document Type",'%1|%2',ItemLedgerEntry."Document Type"::"Purchase Credit Memo",ItemLedgerEntry."Document Type"::"Purchase Return Shipment");
                 IF ItemLedgerEntry.FINDSET THEN
                  REPEAT
                    ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                    ConsuptionQty += ItemLedgerEntry.Quantity;
                    ConsuptionAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                    ClosingQty += ItemLedgerEntry.Quantity;
                    ClosingAmt += ItemcostByValueEntry(ItemLedgerEntry."Entry No.");
                  UNTIL ItemLedgerEntry.NEXT=0;
                  */
                IF (ClosingAmt = 0) AND
                  (ClosingQty = 0) THEN
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
                field("End Date"; EndingDate)
                {
                    ApplicationArea = all;
                }
                field("Location Code"; LocationCode)
                {
                    TableRelation = Location.Code;
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
        IF (EndingDate = 0D) THEN
            ERROR('Start Date and End Date must have value');
        //OpeningDate := CALCDATE('-1D',StartingDate);
        //MESSAGE('%1',OpeningDate);
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        StartingDate: Date;
        EndingDate: Date;
        LocationCode: Code[100];
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
        CompanyInformation: Record 79;

    local procedure InitializeFunction()
    begin
        ClosingAmt := 0;
        ClosingQty := 0;
    end;

    local procedure ItemcostByValueEntry(ItemLedgerNo: Integer) CostValue: Decimal
    var
        ValueEntry: Record 5802;
    begin
        CostValue := 0;
        ValueEntry.RESET;
        ValueEntry.SETRANGE(ValueEntry."Item Ledger Entry No.", ItemLedgerNo);
        ValueEntry.SETRANGE(ValueEntry."Posting Date", 0D, EndingDate);
        IF ValueEntry.FINDSET THEN BEGIN
            REPEAT
                CostValue += ValueEntry."Cost Amount (Actual)";
            UNTIL ValueEntry.NEXT = 0;
        END;
    end;
}

