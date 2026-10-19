codeunit 50017 "Workflow Response HandlingExt"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocument(RecRef: RecordRef; Var Handled: Boolean)
    var
        TransHead: Record "Transfer Header";
    begin
        case RecRef.Number of
            DATABASE::"Transfer Header":
                begin
                    RecRef.SetTable(TransHead);
                    TransHead."Approval Status" := TransHead."Approval Status"::Open;
                    TransHead.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        TransHead: Record "Transfer Header";
    begin
        case RecRef.Number of
            DATABASE::"Transfer Header":
                begin
                    RecRef.SetTable(TransHead);
                    TransHead."Approval Status" := TransHead."Approval Status"::Approved;
                    TransHead.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[128])
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling"; //1521;
        WorkflowEventHandlingCust: Codeunit 50015; // 50112;
    begin
        case ResponseFunctionName of
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandlingCust.RunWorkflowOnSendTransHeadRequestDocForApprovalCode);
                end;


            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandlingCust.RunWorkflowOnSendTransHeadrequestDocForApprovalCode);
                end;
            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandlingCust.RunWorkflowOnCancelTransHeadRequestApprovalRequestCode);
                end;
            WorkflowResponseHandling.OpenDocumentCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandlingCust.RunWorkflowOnCancelTransHeadRequestApprovalRequestCode);
                END;

        end;
    end;

    var
        myInt: Integer;
}