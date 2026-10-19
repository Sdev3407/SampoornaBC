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

    }
    trigger OnAfterGetRecord()
    begin
        ActiveVersionCode := VersionMgt.GetBOMVersion(Rec."No.", WorkDate(), true);
    end;

    Var
        ProdBOMHeader: Record "Production BOM Header";
        ProductionBOMCopy: Codeunit "Production BOM-Copy";
        VersionMgt: Codeunit VersionManagement;
        ProdBOMWhereUsed: Page "Prod. BOM Where-Used";
        ActiveVersionCode: Code[20];

}