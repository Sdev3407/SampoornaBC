report 50128 "Item Availabilty By Location"
{
    ApplicationArea = All;
    Caption = 'Item Availabilty By Location';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'ReportLayout\ItemAvailabiltyByLocation.rdl';

    dataset
    {
        dataitem(TempData; "Item Loc Inventory Temp")
        {
            UseTemporary = true;
            DataItemTableView = sorting("Item No.", "Location Code");

            column(EndDate; EndDate) { }
            column(VUserID; VUserID) { }
            column(Item_UOM; "Item UOM") { }
            column(ItemNo; "Item No.") { }
            column(LocationCode; "Location Code") { }
            column(Location_Name; "Location Name") { }
            column(Inventory; Inventory) { }
            column(CostAmountActual_TempData; "Cost Amount (Actual)")
            {
            }
            column(InventoryPostingGroup_TempData; "Inventory Posting Group")
            {
            }
            column(ItemDescription_TempData; "Item Description")
            {
            }
            column(ResponsibiltyCenter_TempData; "Responsibilty Center")
            {
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filters)
                {
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                    field(ItemNo; ItemNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Item No.';
                        TableRelation = Item;
                    }
                    field(LocationCode; LocationCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Location Code';
                        TableRelation = Location;
                    }
                    field(ResponsibiltyCenter; ResponsibiltyCenter)
                    {
                        ApplicationArea = All;
                        Caption = 'Responsibilty Center';
                        TableRelation = "Responsibility Center";
                    }
                }
            }

        }
    }

    trigger OnPreReport()
    var
        QItemLocationInventory: Query "Item Location Inventory";
        ValueEntryQueuery: Query "ValueEntr by Item-Location";
        TempRec: Record "Item Loc Inventory Temp" temporary;
        Item: Record Item;
        Location: Record Location;
        Responsiblity_Txt: Text;
        ResponsiblityCenterList: list of [Text];
    begin
        VUserID := UserID;
        if LocationCode <> '' then
            ValueEntryQueuery.SetFilter(ValueEntryQueuery.LocationCode, LocationCode);
        if ItemNo <> '' then
            ValueEntryQueuery.SetFilter(ValueEntryQueuery.ItemNo, ItemNo);

        if EndDate <> 0D then
            ValueEntryQueuery.SetFilter(ValueEntryQueuery.Posting_Date, '..%1', EndDate);
        ValueEntryQueuery.Open();
        while ValueEntryQueuery.Read() do begin
            if not TempRec2.Get(ValueEntryQueuery.ItemNo, ValueEntryQueuery.LocationCode) then begin
                TempRec2.Init();
                TempRec2."Item No." := ValueEntryQueuery.ItemNo;
                TempRec2."Location Code" := ValueEntryQueuery.LocationCode;
                TempRec2."Cost Amount (Actual)" := ValueEntryQueuery.CostAmount;
                TempRec2.Insert();
            end else begin
                TempRec2."Cost Amount (Actual)" += ValueEntryQueuery.CostAmount;
                TempRec2.Modify();
            end;
        end;

        Responsiblity_Txt := ResponsibiltyCenter;
        ResponsiblityCenterList := Responsiblity_Txt.Split('|');

        if LocationCode <> '' then
            QItemLocationInventory.SetFilter(QItemLocationInventory.LocationCode, LocationCode);
        if ItemNo <> '' then
            QItemLocationInventory.SetFilter(QItemLocationInventory.ItemNo, ItemNo);
        if EndDate <> 0D then
            QItemLocationInventory.SetFilter(QItemLocationInventory.Posting_Date, '..%1', EndDate);
        QItemLocationInventory.Open;
        while QItemLocationInventory.Read() do begin
            Location.Reset();
            if Location.Get(QItemLocationInventory.LocationCode) then;
            if Item.get(QItemLocationInventory.ItemNo) then;
            if Item.Type = Item.Type::Inventory then
                if (ResponsiblityCenterList.Contains(Location."Responsibility Center")) or
                (ResponsibiltyCenter = '') then begin
                    if not TempRec.Get(QItemLocationInventory.ItemNo, QItemLocationInventory.LocationCode) then begin
                        TempRec.Init();
                        TempRec."Item No." := QItemLocationInventory.ItemNo;
                        TempRec."Location Code" := QItemLocationInventory.LocationCode;
                        TempRec.Inventory := QItemLocationInventory.Inventory;
                        TempRec."Cost Amount (Actual)" := GetCostAmount(TempRec);
                        TempRec."Item Description" := Item.Description;
                        TempRec."Item UOM" := Item."Base Unit of Measure";
                        TempRec."Location Name" := Location.Name;
                        TempRec."Inventory Posting Group" := Item."Inventory Posting Group";
                        TempRec."Responsibilty Center" := Location."Responsibility Center";
                        TempRec.Insert();
                    end else begin
                        TempRec.Inventory += QItemLocationInventory.Inventory;
                        TempRec.Modify();
                    end;
                end;
        end;
        TempRec.Reset();
        TempRec.SetRange(Inventory, 0);
        TempRec.DeleteAll();

        TempRec.Reset();
        TempData.Copy(TempRec, true);
    end;

    local procedure GetCostAmount(ItemLocation: Record "Item Loc Inventory Temp"): Decimal
    var
        ValueEntryQueuery: Query "ValueEntr by Item-Location";
    begin
        TempRec2.Reset();
        if TempRec2.Get(ItemLocation."Item No.", ItemLocation."Location Code") then
            exit(TempRec2."Cost Amount (Actual)");
        exit(0);
    end;

    var
        TempRec2: Record "Item Loc Inventory Temp" temporary;
        LocationCode: code[1024];
        ItemNo: Code[1024];
        ResponsibiltyCenter: Code[1024];
        EndDate: Date;
        VUserID: text;

    procedure GetDateLOC(PEnddate: Date; Plcode: Code[1024]; PItemNo: Code[1024])
    begin
        Enddate := PEnddate;
        LocationCode := Plcode;
        ItemNo := PItemNo;
    end;
}

