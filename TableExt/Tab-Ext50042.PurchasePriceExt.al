tableextension 50042 PurchasePriceExt extends "Purchase Price"
{
    fields
    {
        field(50000; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Open,Released,Pending Approval';
            OptionMembers = Open,Released,"Pending Approval";
        }
        field(50001; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code Where(Block = Filter(false));

            trigger OnValidate()
            var
                ItemVarient: Record "Item Variant";
            begin
                ItemVarient.Reset();
                ItemVarient.SetRange("Item No.", Rec."Item No.");
                ItemVarient.SetRange(Code, Rec."Location Code");
                if not ItemVarient.FindFirst() then begin
                    if Rec."Location Code" <> '' then begin
                        ItemVarient.Init();
                        ItemVarient."Item No." := Rec."Item No.";
                        ItemVarient.Code := Rec."Location Code";
                        ItemVarient.Insert();
                    end;
                end;
                Rec."Variant Code" := Rec."Location Code";
            end;
        }
    }

    keys
    {
        key(PK_LocationCode; "Location Code")
        { }
    }
    var
        Vend: Record 23;
        Text000: Label '%1 cannot be after %2';
        IsApprovalFlag: Boolean;

    procedure SetFromApprovalFlag(ApprovalFlag: Boolean)
    begin
        IsApprovalFlag := ApprovalFlag;
    end;


    procedure ReleaseSalePrice()
    var
        TransferLine: Record 5741;
    begin
        VALIDATE(Status, Status::Released);
    end;


    procedure ReopenSalesPrice(VendorCode: Code[30]; ItemNo: Code[30]; DocStatus: Option Open,Released,"Pending Approval")
    var
        Text000: Label 'Indent Status must be ''Indent'' in the Indent Lines';
        Text007: Label 'Can not Reopen the indent if status is Cancel/Closed.';
        Text008: Label 'Sales Price Must be Released.';
        PurchasePrice: Record 7012;
        Text009: Label 'Sales Document Reopen Sucessfully';
    begin
        IF DocStatus = DocStatus::Released THEN BEGIN
            PurchasePrice.RESET;
            //SalesPrice.SETRANGE(SalesPrice."Sales Type",SalesPrice."Sales Type"::Customer);
            PurchasePrice.SETRANGE(PurchasePrice."Vendor No.", VendorCode);
            PurchasePrice.SETRANGE(PurchasePrice."Item No.", ItemNo);
            IF PurchasePrice.FINDFIRST THEN BEGIN
                PurchasePrice.Status := PurchasePrice.Status::Open;
                PurchasePrice.MODIFY;
            END;
            MESSAGE(Text009);
        END ELSE
            ERROR(Text008);
    end;
}
