pageextension 50156 ProdBOM extends "Production BOM List"
{
    layout
    {
        addafter(Status)
        {
            field(ActiveVersionCode; ActiveVersionCode)
            {
                ApplicationArea = Manufacturing;
                Caption = 'Active Version';
                Editable = false;
                ToolTip = 'Specifies which version of the production BOM is valid.';

                trigger OnLookup(var Text: Text): Boolean
                var
                    ProdBOMVersion: Record "Production BOM Version";
                begin
                    ProdBOMVersion.SetRange("Production BOM No.", Rec."No.");
                    ProdBOMVersion.SetRange("Version Code", ActiveVersionCode);
                    PAGE.RunModal(PAGE::"Production BOM Version", ProdBOMVersion);
                    ActiveVersionCode := VersionMgt.GetBOMVersion(Rec."No.", WorkDate(), true);
                end;
            }
        }
    }
    actions
    {
        addafter("Quantity Explosion of BOM")
        {
            action("Print Production BOM")
            {
                ApplicationArea = All;
                Image = ProductDesign;
                Promoted = true;
                PromotedCategory = Report;
                trigger OnAction()
                begin
                    ProductionBomHeader.Reset();
                    CurrPage.SetSelectionFilter(ProductionBomHeader);
                    if ProductionBomHeader.FindSet() then
                        repeat
                            ProductionBomHeader1.Reset();
                            ProductionBomHeader1.SetRange(ProductionBomHeader1."No.", ProductionBomHeader."No.");
                            if ProductionBomHeader1.FindFirst() then
                                Report.RunModal(50132, false, false, ProductionBomHeader1);
                        until ProductionBomHeader.Next() = 0
                end;
            }
        }

    }
    trigger OnAfterGetRecord()
    begin
        ActiveVersionCode := VersionMgt.GetBOMVersion(Rec."No.", WorkDate(), true);
    end;

    Var
        ProductionBomHeader1: Record "Production BOM Header";
        ProdBOMHeader: Record "Production BOM Header";
        ProductionBOMCopy: Codeunit "Production BOM-Copy";
        VersionMgt: Codeunit VersionManagement;
        ProdBOMWhereUsed: Page "Prod. BOM Where-Used";
        ActiveVersionCode: Code[20];
        ProductionBomHeader: Record "Production BOM Header";

}