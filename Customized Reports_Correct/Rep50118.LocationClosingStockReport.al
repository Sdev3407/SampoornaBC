report 50118 "Location Closing Stock Report"
{
    UsageCategory = Administration;
    Caption = 'Location wise Closing Stock Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\LocationClosingStockReport.rdl';
    dataset
    {
        dataitem(Location; Location)
        {
            dataitem(Item; Item)
            {
                DataItemLink = "Location Filter" = field(code);

                column(No_Item; "No.")
                {
                }
                column(Description_Item; Description)
                {
                }
                column(InventoryPostingGroup_Item; Item."Inventory Posting Group")
                {
                }
                column(LocationFilter_Item; Location.Code)
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

                    Item.SetFilter("Location Filter", Location.Code);
                    Item.SETRANGE("Date Filter", 0D, EndingDate);
                    //Item.SetAutoCalcFields("Net Change");
                    //Item.SetAutoCalcFields("Stock Value");
                    Item.CalcFields("Net Change");
                    Item.CalcFields("Stock Value");
                    ClosingQty := Item."Net Change";
                    ClosingAmt := Item."Stock Value";


                    IF (ClosingAmt = 0) AND
                      (ClosingQty = 0) THEN
                        CurrReport.SKIP;

                end;
            }
            trigger OnPreDataItem()
            begin
                if LocationCode <> '' then begin
                    Location.SetFilter(Code, LocationCode);

                end else begin
                    UserSetup.Get(UserId);
                    if UserSetup."Lob Aceess" = false then begin
                        if UserSetup."Global Dimension 1 Code" <> '' then begin
                            Location.setrange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");

                        end;
                    end;
                end;
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
                    //TableRelation = Location.Code;
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemList: Page "Location List";
                        Item: Record Location;
                        UserSetup: Record "User Setup";

                    begin
                        UserSetup.Get(UserId);
                        Item.Reset();
                        Item.SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
                        ItemList.SETTABLEVIEW(Item);
                        ItemList.LOOKUPMODE(TRUE);
                        if (ItemList.RunModal() = Action::LookupOK) then begin
                            ItemList.GetRecord(Item);
                            LocationCode := Item.Code;
                        END;
                    END;
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
        UserSetup: Record "User Setup";
        StartingDate: Date;
        EndingDate: Date;
        LocationCode: Code[2048];
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

