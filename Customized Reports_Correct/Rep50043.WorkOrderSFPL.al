report 50043 "Work Order SFPL"
{
    UsageCategory = Administration;
    Caption = 'Work Order SFPL Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\WorkOrderSFPL.rdl';


    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            RequestFilterFields = "No.";
            column(No_ProductionOrder; "Production Order"."No.")
            {
            }
            column(TUserID; TUserID)
            { }
            column(TDateTime; TDateTime)
            { }
            column(SourceNo_ProductionOrder; "Production Order"."Source No.")
            {
            }
            column(Quantity_ProductionOrder; "Production Order".Quantity)
            {
            }
            column(Description_ProductionOrder; "Production Order".Description)
            {
            }
            column(ProdBomNo_ProductionOrder; "Production Order"."Prod. Bom No.")
            {
            }
            column(ProdBomDescription_ProductionOrder; "Production Order"."Prod. Bom Description")
            {
            }
            column(BOMVersionNo_ProductionOrder; "Production Order"."BOM Version No")
            {
            }
            column(DueDate_ProductionOrder; "Production Order"."Due Date")
            {
            }
            column(Batch_Size; "Production Order"."Batch Size")
            { }
            dataitem("Prod. Order Component"; "Prod. Order Component")
            {
                DataItemLink = "Prod. Order No." = FIELD("No.");
                //DataItemTableView = sorting(Status, "Prod. Order No.", "Prod. Order Line No.", "Line No.") where("Item Catagory Code" = FILTER('<>BARDANA'));
                column(ProdOrderNo_ProdOrderComponent; "Prod. Order Component"."Prod. Order No.")
                {
                }
                column(ItemNo_ProdOrderComponent; "Prod. Order Component"."Item No.")
                {
                }

                column(ExpectedQtyBase_ProdOrderComponent; Round(ExpectedQty, 0.001))
                {
                }
                column(Description_ProdOrderComponent; "Prod. Order Component".Description)
                {
                }
                column(UnitofMeasureCode_ProdOrderComponent; "Prod. Order Component"."Unit of Measure Code")
                {
                }
                column(Item_Catagory_Code; "Prod. Order Component"."Item Catagory Code")
                { }
                column(TotalComp; Round(TotalComp, 0.001))
                { }
                trigger OnAfterGetRecord()
                begin

                    Clear(ExpectedQty);
                    relProLine.Reset();
                    relProLine.SetRange("Version Code", "Production Order"."BOM Version No");
                    relProLine.SetRange("Production BOM No.", "Production Order"."Prod. Bom No.");
                    // relProLine.SetRange("No.", "Prod. Order Component"."Item No.");
                    if relProLine.FindFirst() then begin
                        relProLine1.Reset();
                        relProLine1.SetRange("Prod. Order No.", "Production Order"."No.");
                        relProLine1.SetRange("Line No.", "Prod. Order Component"."Prod. Order Line No.");
                        if relProLine1.FindFirst() then begin

                            if "Production Order"."Batch Size" <> "Production Order"."Batch Size"::" " Then begin
                                if "Production Order"."Batch Size" = "Production Order"."Batch Size"::"0.8" Then
                                    ExpectedQty := "Prod. Order Component"."Quantity per" * 800;
                                if "Production Order"."Batch Size" = "Production Order"."Batch Size"::"1.0" Then
                                    ExpectedQty := "Prod. Order Component"."Quantity per" * 1000;
                                if "Production Order"."Batch Size" = "Production Order"."Batch Size"::"1.5" Then
                                    ExpectedQty := "Prod. Order Component"."Quantity per" * 1500;
                                if "Production Order"."Batch Size" = "Production Order"."Batch Size"::"2.0" Then
                                    ExpectedQty := "Prod. Order Component"."Quantity per" * 2000;
                            end else
                                ExpectedQty := "Prod. Order Component"."Quantity per" * relProLine1.Quantity;
                        end;
                    END;
                    ReProComp.Reset();
                    ReProComp.SetCurrentKey("Prod. Order No.", "Line No.");
                    ReProComp.SetRange("Prod. Order No.", "Production Order"."No.");
                    ReProComp.SetRange("Prod. Order Line No.", "Prod. Order Component"."Prod. Order Line No.");
                    ReProComp.SetFilter("Item Catagory Code", '<>%1', 'BARDANA');
                    // ReProComp.SetRange("Line No.", "Prod. Order Component"."Line No.");
                    if ReProComp.FindSet() then
                        repeat
                            if ReProComp."Item Catagory Code" <> 'BARDANA' Then Begin                            //ExpectedQty := "Prod. Order Component"."Quantity per" * relProLine1.Quantity;
                                if "Production Order"."Batch Size" <> "Production Order"."Batch Size"::" " Then begin
                                    if "Production Order"."Batch Size" = "Production Order"."Batch Size"::"0.8" Then
                                        TotalComp += ReProComp."Quantity per" * 800;
                                    if "Production Order"."Batch Size" = "Production Order"."Batch Size"::"1.0" Then
                                        TotalComp += ReProComp."Quantity per" * 1000;
                                    if "Production Order"."Batch Size" = "Production Order"."Batch Size"::"1.5" Then
                                        TotalComp += ReProComp."Quantity per" * 1500;
                                    if "Production Order"."Batch Size" = "Production Order"."Batch Size"::"2.0" Then
                                        TotalComp += ReProComp."Quantity per" * 2000;
                                end else
                                    TotalComp += ReProComp."Quantity per" * relProLine1.Quantity;
                            End;


                        Until ReProComp.next = 0;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
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
        If TUserID = '' then
            TUserID := UserId;

        if TDateTime = 0DT then
            TDateTime := CurrentDateTime;
    end;

    var
        ExpectedQty: Decimal;
        relesePro: Record "Production Order";
        relProLine: Record "Production BOM Line";
        relProLine1: Record "Prod. Order Line";
        ReProComp: Record "Prod. Order Component";
        TotalComp: Decimal;
        ItemList: Page 31;
        TUserID: text;
        TDateTime: DateTime;

    Procedure GetDateTime(PuserID: Text; PDateTime: DateTime)
    Begin
        TUserID := PuserID;
        TDateTime := PDateTime;
    End;
}

