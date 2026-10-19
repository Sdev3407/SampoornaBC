codeunit 50016 "Approval Management Custom"
{
    trigger OnRun()
    begin

    end;

    

    [IntegrationEvent(false, false)]
    procedure OnSendTransHeadrequestForApproval(Var TransHead: Record "Transfer Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelTransHeadrequestForApproval(Var TransHead: Record "Transfer Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelglaccountApprovalRequest(var "G/L Account": Record "G/L Account")
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management Custom", 'OnCancelglaccountApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelGlaccountApprovalRequest(var "G/L Account": Record "G/L Account")

    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelGLAccountApprovalRequestCode(), "G/L Account");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management Custom", 'OnSendglaccountForApproval', '', false, false)]
    procedure GLOnSendglaccountForApproval(var "G/L Account": Record "G/L Account")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendGLAccountForApprovalCode(), "G/L Account");
    end;

    procedure CheckTransHeadrequestApprovalsWorkflowEnabled(var TransHead: Record "Transfer Header"): Boolean
    begin
        IF NOT WorkflowManagement.CanExecuteWorkflow(TransHead, Subscriber_CU.RunWorkflowOnSendTransHeadrequestDocForApprovalCode) then
            ERROR(NoWorkflowEnabledErr);

        EXIT(TRUE);
    end;

    procedure CheckingGLAccountApprovalsWorkflowEnabled(var "G/L Account": Record "G/L Account"): Boolean
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        if not WorkflowManagement.CanExecuteWorkflow("G/L Account", RunWorkflowOnSendGLAccountForApprovalCode()) then begin
            if WorkflowManagement.EnabledWorkflowExist(DATABASE::"G/L Account", RunWorkflowOnGLAccountChangedCode()) then
                exit(false);
            //Error(NoWorkflowEnabledErr);
        end;
        exit(true);
    end;

    procedure RunWorkflowOnSendGLAccountForApprovalCode(): Code[128]
    begin
        exit('RUNWORKFLOWONGLACCOUNTCHANGEDCODE');

    end;

    procedure RunWorkflowOnGLAccountChangedCode(): Code[128]
    begin
        exit('RUNWORKFLOWONSENDGLACCOUNTFORAPPROVAL');
    end;

    procedure RunWorkflowOnCancelGLAccountApprovalRequestCode(): Code[128]
    begin
        exit('RUNWORKFLOWONCANCELGLACCOUNTAPPROVALREQUEST');
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendlocationForApproval(var Location: Record Location)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancellocationApprovalRequest(var Location: Record Location)
    begin
    end;

    

    

    procedure RunWorkflowOnSendlocationForApprovalCode(): Code[128]
    begin
        exit('RUNWORKFLOWONSENDLOCATIONFORAPPROVAL');
    end;

    procedure RunWorkflowOnCancelLocationApprovalRequestCode(): Code[128]
    begin
        exit('RUNWORKFLOWONCANCELLOCATIONAPPROVALREQUEST');
    end;

    procedure RunWorkflowOnLocationChangedCode(): Code[128]
    begin
        exit('RUNWORKFLOWONLOCATIONCHANGEDCODE');
    end;

    




    procedure CheckLocationApprovalsWorkflowEnabled(var Location: Record Location): Boolean
    begin
        if not WorkflowManagement.CanExecuteWorkflow(Location, RunWorkflowOnSendLocationForApprovalCode()) then begin
            if WorkflowManagement.EnabledWorkflowExist(DATABASE::Location, RunWorkflowOnLocationChangedCode()) then
                exit(false);
            Error(NoWorkflowEnabledErr);
        end;
        exit(true);
    end;

    procedure CheckGLaccountApprovalsWorkflowEnabled(var "G/L Account": Record "G/L Account"): Boolean
    begin
        if not WorkflowManagement.CanExecuteWorkflow("G/L Account", RunWorkflowOnSendGLAccountForApprovalCode()) then begin
            if WorkflowManagement.EnabledWorkflowExist(DATABASE::"G/L Account", RunWorkflowOnGLAccountChangedCode()) then
                exit(false);
            Error(NoWorkflowEnabledErr);
        end;
        exit(true);
    end;

    procedure CheckingItemApprovalsWorkflowEnabled(var Item: Record Item): Boolean
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        if not WorkflowManagement.CanExecuteWorkflow(Item, WorkflowEventHandling.RunWorkflowOnSendItemForApprovalCode()) then begin
            if WorkflowManagement.EnabledWorkflowExist(DATABASE::Item, WorkflowEventHandling.RunWorkflowOnItemChangedCode()) then
                exit(false);
            //Error(NoWorkflowEnabledErr);
        end;
        exit(true);
    end;



    procedure CheckCustomerApprovalsWorkflowEnabled(var Customer: Record Customer) Result: Boolean
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        if not WorkflowManagement.CanExecuteWorkflow(Customer, WorkflowEventHandling.RunWorkflowOnSendCustomerForApprovalCode()) then begin
            if WorkflowManagement.EnabledWorkflowExist(DATABASE::Customer, WorkflowEventHandling.RunWorkflowOnCustomerChangedCode()) then
                exit(false);
            //Error(NoWorkflowEnabledErr);
        end;
        Result := true;
        //OnAfterCheckCustomerApprovalsWorkflowEnabled(Customer, Result);

    end;

    procedure CheckVendorApprovalsWorkflowEnabled(var Vendor: Record Vendor) Result: Boolean
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        if not WorkflowManagement.CanExecuteWorkflow(Vendor, WorkflowEventHandling.RunWorkflowOnSendVendorForApprovalCode()) then begin
            if WorkflowManagement.EnabledWorkflowExist(DATABASE::Vendor, WorkflowEventHandling.RunWorkflowOnVendorChangedCode()) then
                exit(false);
            //Error(NoWorkflowEnabledErr);
        end;
        Result := true;

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management Custom", 'OnSendlocationForApproval', '', false, false)]
    procedure RunWorkflowOnSendlocationForApproval(Location: Record Location)
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendlocationForApprovalCode(), Location);
    end;

    
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management Custom", 'OnCancelLocationApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelLocationApprovalRequest(var Location: Record Location)

    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLocationApprovalRequestCode(), Location);
    end;


    var
        myInt: Integer;
        NoWorkflowEnabledErr: TextConst ENU = 'This record is not supported by related approval workflow.';
        WorkflowManagement: Codeunit "Workflow Management";
        Subscriber_CU: Codeunit 50015;

    [IntegrationEvent(false, false)]
    procedure OnSendglaccountForApproval(var "G/L Account": Record "G/L Account")
    begin
    end;

}