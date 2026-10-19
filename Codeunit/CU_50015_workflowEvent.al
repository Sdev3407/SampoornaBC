codeunit 50015 WorkflowEventExt
{
    trigger OnRun()
    begin

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; Var Variant: Variant; Var IsHandled: Boolean)
    var
        TransHead: Record "Transfer Header";

    begin
        case RecRef.Number of
            DATABASE::"Transfer Header":
                begin
                    RecRef.SetTable(TransHead);
                    TransHead."Approval Status" := TransHead."Approval Status"::"Pending For Approval";
                    TransHead.Modify;
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', true, true)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        VarFilter: Text;
        EmployeeCodeVar: Code[20];
        EntryNoVarText: Text;
        EntryNoVar: Integer;
        approvalm: Codeunit "Approvals Mgmt.";
        TransHead: Record "Transfer Header";
    begin
        case ApprovalEntry."Table ID" of
            DATABASE::"Transfer Header":
                begin
                    // Message(Format(ApprovalEntry."Record ID to Approve"));
                    VarFilter := Format(ApprovalEntry."Record ID to Approve");
                    Message(VarFilter);
                    EmployeeCodeVar := CopyStr(VarFilter, 15, StrLen(VarFilter));
                    //EntryNoVarText := SelectStr(2, DelChr(CONVERTSTR(SelectStr(1, VarFilter), ':', ','), '=', ' '));
                    TransHead.reset();
                    TransHead.SetRange("No.", EmployeeCodeVar);
                    TransHead.SetRange("Approval Status", TransHead."Approval Status"::"Pending For Approval"); //PENDING 
                    if TransHead.FindFirst() then begin
                        TransHead."Approval Status" := TransHead."Approval Status"::Open;
                        TransHead.Modify();
                    end;

                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', true, true)]
    local procedure OnApproveApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        TransHead: Record "Transfer Header";
        VarFilter: Text;
        EmployeeCodeVar: Code[20];
        EntryNoVarText: Text;
        EntryNoVar: Integer;
        approvalm: Codeunit "Approvals Mgmt.";
        AppEnRec: Record "Approval Entry";
    begin
        case ApprovalEntry."Table ID" of
            DATABASE::"Transfer Header":
                begin
                    // Message(Format(ApprovalEntry."Record ID to Approve"));
                    VarFilter := Format(ApprovalEntry."Record ID to Approve");
                    EmployeeCodeVar := CopyStr(VarFilter, 15, StrLen(VarFilter));
                    //EntryNoVarText := SelectStr(2, DelChr(CONVERTSTR(SelectStr(1, VarFilter), ':', ','), '=', ' '));
                    TransHead.reset();
                    TransHead.SetRange("No.", EmployeeCodeVar);
                    TransHead.SetRange("Approval Status", TransHead."Approval Status"::"Pending For Approval");
                    if TransHead.FindFirst() then begin
                        TransHead."Approval Status" := TransHead."Approval Status"::Approved;
                        TransHead.Modify();
                    end;


                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    Procedure AddEventToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendTransHeadRequestDocForApprovalCode(), DATABASE::"Transfer Header", 'Approval of a Transfer order Request is requested.', 0, FALSE);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelTransHeadRequestApprovalRequestCode(), DATABASE::"Transfer Header", 'An Approval request for a Transfer order is cancelled.', 0, FALSE);
    end;


    procedure RunWorkflowOnSendTransHeadRequestDocForApprovalCode(): code[128]
    var
        myInt: Integer;
    begin
        EXIT(UPPERCASE('RunWorkflowOnSendTransHeadRequestDocForApproval'));
    end;

    procedure RunWorkflowOnCancelTransHeadRequestApprovalRequestCode(): Code[128]
    var
        myInt: Integer;
    begin
        EXIT(UPPERCASE('RunWorkflowOnCancelTransHeadRequestApprovalRequest'));
    end;

    procedure RunWorkflowOnAfterReleaseTransHeadRequestDocCode(): Code[128]
    var
        myInt: Integer;
    begin
        EXIT(UPPERCASE('RunWorkflowOnAfterReleaseTransHeadRequestDoc'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management Custom", 'OnCancelTransHeadrequestForApproval', '', false, false)]
    Procedure RunWorkflowOnCancelTransHeadrequestApprovalRequest(var TransHead: Record "Transfer Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelTransHeadRequestApprovalRequestCode, TransHead);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management Custom", 'OnSendTransHeadrequestForApproval', '', false, false)]
    Procedure RunWorkflowOnSendTransHeadrequestForApproval(var TransHead: Record "Transfer Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendTransHeadRequestDocForApprovalCode, TransHead);
    end;



    // Start Pru Sh20042022
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', true, true)]

    local procedure OnAfterGetPageID(RecordRef: RecordRef; var PageID: Integer)
    var

    begin
        if PageID = 0 then
            PageID := GetConditionalCardPageID(RecordRef);
    end;

    local procedure GetConditionalCardPageID(RecordRef: RecordRef): Integer
    begin
        case RecordRef.Number of
            Database::"Transfer Header":
                exit(Page::"Transfer Order");
        end;
    end;
    // End Pru Sh20042022
    var
        myInt: Integer;

        worlfloeeven: Codeunit 1520;
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";
        pageMgt: Codeunit "Page Management";

}