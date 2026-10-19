codeunit 50027 ApprovalEntryExt
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeApprovalEntryInsert', '', true, true)]
    local procedure "Approvals Mgmt._OnBeforeApprovalEntryInsert"
    (
        var ApprovalEntry: Record "Approval Entry";
        ApprovalEntryArgument: Record "Approval Entry";
        WorkflowStepArgument: Record "Workflow Step Argument";
        ApproverId: Code[50];
        var IsHandled: Boolean
    )
    var
        ApprovalRecordId: Text;
        IsVendorID_Loc: Text;
        VendorID_Loc: Text;
        CustomerRec: Record 18;
        VendorRec: Record 23;
        ItemRec: Record 27;

    begin
        //PRU_NEELESH
        IF (ApprovalEntry."Table ID" = 18) AND (ApprovalEntry."Sender ID" = ApprovalEntry."Approver ID") THEN BEGIN
            CLEAR(ApprovalRecordId);
            CLEAR(IsVendorID_Loc);
            CLEAR(ApprovalRecordId);
            ApprovalRecordId := ApprovalEntry.RecordDetails;
            IsVendorID_Loc := COPYSTR(ApprovalRecordId, 1, 9);
            IF (IsVendorID_Loc = 'Customer:') THEN BEGIN
                VendorID_Loc := COPYSTR(Format(ApprovalRecordId), 11, StrLen(Format(ApprovalRecordId)));
                IF CustomerRec.GET(VendorID_Loc) THEN BEGIN
                    CustomerRec.Status := CustomerRec.Status::Approved;
                    CustomerRec.MODIFY;
                END;
            END;
        END;

        IF (ApprovalEntry."Table ID" = 23) AND (ApprovalEntry."Sender ID" = ApprovalEntry."Approver ID") THEN BEGIN
            CLEAR(ApprovalRecordId);
            CLEAR(IsVendorID_Loc);
            CLEAR(ApprovalRecordId);
            ApprovalRecordId := ApprovalEntry.RecordDetails;
            IsVendorID_Loc := COPYSTR(ApprovalRecordId, 1, 7);
            IF (IsVendorID_Loc = 'Vendor:') THEN BEGIN
                VendorID_Loc := COPYSTR(ApprovalRecordId, 9, STRLEN(ApprovalRecordId));
                IF VendorRec.GET(VendorID_Loc) THEN BEGIN
                    VendorRec.Status := VendorRec.Status::Approved;
                    VendorRec.MODIFY;
                END;
            END;
        END;

        IF (ApprovalEntry."Table ID" = 27) AND (ApprovalEntry."Sender ID" = ApprovalEntry."Approver ID") THEN BEGIN
            CLEAR(ApprovalRecordId);
            CLEAR(IsVendorID_Loc);
            CLEAR(ApprovalRecordId);
            ApprovalRecordId := ApprovalEntry.RecordDetails;
            IsVendorID_Loc := COPYSTR(ApprovalRecordId, 1, 5);
            IF (IsVendorID_Loc = 'Item:') THEN BEGIN
                VendorID_Loc := COPYSTR(ApprovalRecordId, 7, STRLEN(ApprovalRecordId));
                IF ItemRec.GET(VendorID_Loc) THEN BEGIN
                    ItemRec.Status := ItemRec.Status::Approved;
                    ItemRec.MODIFY;
                END;
            END;
        END;

        //PRU_NEELESH
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure "Approvals Mgmt._OnPopulateApprovalEntryArgument"
    (
        var RecRef: RecordRef;
        var ApprovalEntryArgument: Record "Approval Entry";
        WorkflowStepInstance: Record "Workflow Step Instance"
    )
    var
        SalesPrice: Record 7002;
        PurchasePrice: Record 7012;
    begin
        CASE RecRef.NUMBER OF
            DATABASE::"Sales Price":
                BEGIN
                    RecRef.SETTABLE(SalesPrice);
                    ApprovalEntryArgument.Amount := SalesPrice."Unit Price";
                    ApprovalEntryArgument."Amount (LCY)" := SalesPrice."Unit Price";
                    ApprovalEntryArgument."Currency Code" := SalesPrice."Currency Code";
                END;
            // SKS MSZ Sales Price
            // SKS MSZ Purchase Price
            DATABASE::"Purchase Price":
                BEGIN
                    RecRef.SETTABLE(PurchasePrice);
                    ApprovalEntryArgument.Amount := PurchasePrice."Direct Unit Cost";
                    ApprovalEntryArgument."Amount (LCY)" := PurchasePrice."Direct Unit Cost";
                    ApprovalEntryArgument."Currency Code" := PurchasePrice."Currency Code";
                END;
        END;
        // SKS MSZ Sales Price
    end;
}