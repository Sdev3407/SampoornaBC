Page 50134 "ProductionBOMVersionLines"
{
    ApplicationArea = All;
    Caption = 'Production BOM Version Lines';
    PageType = List;
    SourceTable = "Production BOM Line";
    UsageCategory = Lists;
    Editable = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                ShowCaption = false;
                field("Production BOM No."; Rec."Production BOM No.")
                {
                    ApplicationArea = Manufacturing;
                }
                field(ProdBOMDesc; ProdBONDesc)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Locationcode)
                {
                    ApplicationArea = All;
                }
                field("BOM UOM"; BOMUOM)
                {
                    ApplicationArea = All;
                }
                field("Version Code"; Rec."Version Code")
                {
                    ApplicationArea = Manufacturing;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the type of production BOM line.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the variant of the item on the line.';
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies a description of the production BOM line.';
                }
                field("Calculation Formula"; Rec."Calculation Formula")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies how to calculate the Quantity field.';
                    Visible = false;
                }
                field(Length; Rec.Length)
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the length of one item unit when measured in the specified unit of measure.';
                    Visible = false;
                }
                field(Width; Rec.Width)
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the width of one item unit when measured in the specified unit of measure.';
                    Visible = false;
                }
                field(Depth; Rec.Depth)
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the depth of one item unit when measured in the specified unit of measure.';
                    Visible = false;
                }
                field(Weight; Rec.Weight)
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the weight of one item unit when measured in the specified unit of measure.';
                    Visible = false;
                }
                field("Quantity per"; Rec."Quantity per")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies how many units of the component are required to produce the parent item.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies how each unit of the item is measured, such as in pieces or tons. By default, the value in the Base Unit of Measure field on the item card is inserted.';
                }
                field("Scrap %"; Rec."Scrap %")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the percentage of the item that you expect to be scrapped in the production process.';
                }
                field("Routing Link Code"; Rec."Routing Link Code")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the routing link code.';
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the position of the component on the bill of material.';
                    Visible = false;
                }
                field("Position 2"; Rec."Position 2")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies more exactly whether the component is to appear at a certain position in the BOM to represent a certain production process.';
                    Visible = false;
                }
                field("Position 3"; Rec."Position 3")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the third reference number for the component position on a bill of material, such as the alternate position number of a component on a print card.';
                    Visible = false;
                }
                field("Lead-Time Offset"; Rec."Lead-Time Offset")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the total number of days required to produce this item.';
                    Visible = false;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the date from which this production BOM is valid.';
                    Visible = false;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the date from which this production BOM is no longer valid.';
                    Visible = false;
                }
            }

        }
    }
    actions
    {

    }
    trigger OnAfterGetRecord()
    begin

        Clear(Locationcode);
        Clear(ProdBONDesc);
        Clear(BOMUOM);
        ProductionBOMHeader.Get(rec."Production BOM No.");
        Locationcode := ProductionBOMHeader."Location Code 1";

        ProductionBOMVersion.Reset();
        ProductionBOMVersion.SetRange("Production BOM No.", rec."Production BOM No.");
        ProductionBOMVersion.SetRange("Version Code", Rec."Version Code");
        If ProductionBOMVersion.FindFirst() Then begin
            ProdBONDesc := ProductionBOMVersion.Description;
            BOMUOM := ProductionBOMVersion."Unit of Measure Code";
        end
    end;



    trigger OnOpenPage()
    var
        userset: Record 91;
    begin

    end;

    var
        ProductionBOMVersion: Record "Production BOM Version";
        ProductionBOMHeader: Record "Production BOM Header";
        BOMUOM: Text;
        Locationcode: Text;
        ProdBONDesc: text;
}