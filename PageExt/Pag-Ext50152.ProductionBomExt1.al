pageextension 50152 ProductionBomExt1 extends "Production BOM"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("Item No."; Rec."Item No.")
            {
                ApplicationArea = all;
                Editable = CustomFieldsEdit;
            }
            field("Item Description"; Rec."Item Description")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Location Code 1"; Rec."Location Code 1")
            {
                ApplicationArea = all;
                Editable = CustomFieldsEdit;
            }

        }

    }
    actions
    {
        modify("Copy &BOM")
        {
            Visible = false;
        }
        addafter("Copy &BOM")
        {
            action("Print Production BOM")
            {
                ApplicationArea = All;
                Image = ProductDesign;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    ProductionBomHeader.Reset();
                    ProductionBomHeader.SetRange(ProductionBomHeader."No.", Rec."No.");
                    if ProductionBomHeader.FindFirst() then begin
                        Report.RunModal(50132, true, false, ProductionBomHeader);
                    end;
                end;
            }
            action("Copy Prod BOM")
            {
                ApplicationArea = Manufacturing;
                //Caption = 'Copy &BOM';
                Ellipsis = true;
                Promoted = True;
                Image = CopyBOM;
                ToolTip = 'Copy an existing production BOM to quickly create a similar BOM.';

                trigger OnAction()
                begin
                    Rec.TestField("No.");
                    if PAGE.RunModal(0, ProdBOMHeader) = ACTION::LookupOK then begin
                        ProdBOMVersion.Reset();
                        ProdBOMVersion.SetRange("Production BOM No.", ProdBOMHeader."No.");
                        if PAGE.RunModal(0, ProdBOMVersion) = ACTION::LookupOK then
                            ProductionBOMCopy.CopyBOM(ProdBOMHeader."No.", ProdBOMVersion."Version Code", Rec, '');

                    end;
                end;

            }
            action("Import Prod BOM")
            {
                ApplicationArea = All;
                RunObject = report ImportProdBom;
            }
        }

    }
    var
        CustomFieldsEdit: Boolean;
        ProdBOMHeader: Record "Production BOM Header";
        ProdBOMVersion: Record "Production BOM Version";
        ProductionBOMCopy: Codeunit "Production BOM-Copy";
        VersionMgt: Codeunit VersionManagement;
        ProductionBomHeader: Record "Production BOM Header";

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";

    begin
        UserSetup.GET(USERID);
        IF NOT UserSetup."Allow Prod. BOM Usage" THEN
            ERROR('You do not have permission to view Production BOM');
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Prod. BOM", '%1', UserSetup."Access Prod. BOM"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Production BOM');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Prod. BOM", '%1', UserSetup."Access Prod. BOM"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10

        //Pru_P0272 >>
        IF (Rec.Status = Rec.Status::Certified) OR (Rec.Status = Rec.Status::Closed) THEN
            CustomFieldsEdit := FALSE
        ELSE
            CustomFieldsEdit := TRUE;
        //<<
    end;

    trigger OnAfterGetRecord()
    var
        UserSetup: Record "User Setup";
    begin
        // ActiveVersionCode := VersionMgt.GetBOMVersion("No.", WORKDATE, TRUE);
        UserSetup.GET(USERID);
        IF NOT UserSetup."Allow Prod. BOM Usage" THEN
            ERROR('You do not have permission to view Production BOM');

        //Pru_P0272 >>
        IF (Rec.Status = Rec.Status::Certified) OR (Rec.Status = Rec.Status::Closed) THEN
            CustomFieldsEdit := FALSE
        ELSE
            CustomFieldsEdit := TRUE;
        //<<
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Prod. BOM", '%1', UserSetup."Access Prod. BOM"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Prod. BOM", '%1', UserSetup."Access Prod. BOM"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Prod. BOM", '%1', UserSetup."Access Prod. BOM"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Create Production BOM');
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Prod. BOM", '%1', UserSetup."Access Prod. BOM"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change Production BOM');
        //PRU_DD 1.10
    end;

    trigger OnDeleteRecord(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Prod. BOM", '%1', UserSetup."Access Prod. BOM"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Delete Production BOM');
        //PRU_DD 1.10
    end;
}