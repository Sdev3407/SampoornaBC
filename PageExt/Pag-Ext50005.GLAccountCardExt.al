pageextension 50005 "GLAccountCard_Ext" extends "G/L Account Card"
{

    layout
    {
        modify(General)
        {
            Editable = Pageedit;
        }
        modify(Posting)
        {
            Editable = Pageedit;
        }
        modify(Consolidation)
        {
            Editable = Pageedit;
        }
        modify(Reporting)
        {
            Editable = Pageedit;
        }
        modify("Cost Accounting")
        {
            Editable = Pageedit;
        }

        addafter(Name)
        {
            field("SMS Alert Mobile No."; Rec."SMS Alert Mobile No.")
            {
                ApplicationArea = All;
                Visible = false;

            }
            field(Required; Rec.Required)
            {
                ApplicationArea = All;

            }
            field(Status; Rec.Status)
            {
                ApplicationArea = All;

                trigger OnValidate()
                var

                begin
                    IF Rec.Status = Rec.Status::Open THEN begin
                        // CurrPage.Editable(true);
                        CurrPage.Editable(true);
                    end ELSE
                        // CurrPage.Editable(false);
                        CurrPage.Editable(false);
                end;

            }

            field("Prevent Negative Balance"; Rec."Prevent Negative Balance")
            {
                ApplicationArea = All;

            }
            field("FEED Freight Charge"; Rec."FEED Freight Charge")
            {
                ApplicationArea = All;

            }
            field("Group By"; Rec."Group By")
            {
                ApplicationArea = All;

            }
            field("Group by Shorting"; Rec."Group by Shorting")
            {
                ApplicationArea = All;

            }
        }

    }

    actions
    {
        addafter("Apply Template")
        {
            action(Release)
            {
                ApplicationArea = All;
                Caption = 'Release';
                Image = ReleaseDoc;
                Promoted = True;
                Enabled = (NOT OpenApprovalEntriesExist);
                trigger OnAction()
                var
                    BaseCodeunit: Codeunit "Approval Management Custom";
                begin
                    //PRU_NEELESH
                    IF not BaseCodeunit.CheckingGLAccountApprovalsWorkflowEnabled(Rec) THEN begin
                        Rec.Status := Rec.Status::Approved;
                        Rec.MODIFY;
                    end else
                        Message('Approval Workflow is enabled, Please send for approval');

                    //PRU_NEELESH
                end;
            }
            action(ReOpen)
            {
                ApplicationArea = All;
                Caption = 'Open';
                Image = ReOpen;
                Promoted = True;
                Enabled = (NOT OpenApprovalEntriesExist);
                trigger OnAction()
                var
                //BaseCodeunit: Codeunit BaseModificationCodeunit;

                begin
                    //PRU_NEELESH
                    if rec.Status = rec.Status::Approved then begin
                        Rec.Status := Rec.Status::Open;
                        Rec.MODIFY;
                    end;
                    //PRU_NEELESH
                end;
            }


        }
        addafter("A&ccount")
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistCurrUser;
                    Promoted = True;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify();
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistCurrUser;
                    Promoted = True;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify();
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistCurrUser;
                    Promoted = True;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = (NOT OpenApprovalEntriesExist) AND CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    Promoted = True;
                    ToolTip = 'Request approval to change the record.';

                    trigger OnAction()
                    var
                        BaseCodeunit: Codeunit "Approval Management Custom";
                    begin
                        if BaseCodeunit.CheckingGLAccountApprovalsWorkflowEnabled(Rec) then begin
                            IF T_15.GET(Rec."No.") THEN BEGIN
                                IF T_15.Status <> T_15.Status::Approved THEN BEGIN
                                    T_15.Status := T_15.Status::"Pending Approval";
                                    T_15.MODIFY;
                                END;
                            END;
                            BaseCodeunit.OnSendglaccountForApproval(Rec);
                            SetWorkFlowEnabled();
                        end;
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist OR CanCancelApprovalForFlow;
                    Image = CancelApprovalRequest;
                    Promoted = True;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
                        BaseCodeunit: Codeunit "Approval Management Custom";
                    begin
                        //ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);

                        BaseCodeunit.OnCancelglaccountApprovalRequest(Rec);
                        WorkflowWebhookManagement.FindAndCancel(Rec.RecordId);
                        Rec.Status := Rec.Status::Open;
                        Rec.MODIFY;
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistCurrUser;
                    Promoted = True;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
        }

    }
   
    




    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Chart of Account", '%1', UserSetup."Chart of Account"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Delete the G/L Account');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Chart of Account", '%1', UserSetup."Chart of Account"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Chart of Account", '%1', UserSetup."Chart of Account"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to change the G/L Account Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.SetupNewGLAcc(xRec, BelowxRec);
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Chart of Account", '%1', UserSetup."Chart of Account"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Chart of Account", '%1', UserSetup."Chart of Account"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open G/L Account');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Chart of Account", '%1', UserSetup."Chart of Account"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        //PRU_NEELESH

        IF UserSetup.GET(USERID) THEN BEGIN
            IF UserSetup."Access G\L Account" <> '' THEN BEGIN
                Rec.FILTERGROUP(2);
                Rec.SETFILTER("No.", UserSetup."Access G\L Account");
                Rec.FILTERGROUP(0);
            END;
        END;
        // IF Rec.Status = Rec.Status::Open THEN begin
        //     CurrPage.Editable(true);
        // end ELSE
        //     CurrPage.Editable(false);
        //PRU_NEELESH
    end;

    trigger OnAfterGetCurrRecord()
    begin

        IF Rec.Status = Rec.Status::Open THEN begin
            // CurrPage.Editable(true);
            Pageedit := True
        end ELSE
            // CurrPage.Editable(false);
            Pageedit := false;
        //PRU_NEELESH
    end;



    trigger OnAfterGetRecord()
    begin

        IF Rec.Status = Rec.Status::Open THEN begin
            // CurrPage.Editable(true);
            Pageedit := True
        end ELSE
            // CurrPage.Editable(false);
            Pageedit := false;
        //PRU_NEELESH
OnAfterGetCurrRecordFunc();


    end;

    
    var
        WorkFlowEventFilter: Text;
        EnabledApprovalWorkflowsExist: Boolean;
        AnyWorkflowExists: Boolean;
        T_15: Record "G/L Account";
        PageEditable: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        OpenApprovalEntriesExistCurrUser: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        UserSetup: Record 91;
        myInt: Integer;
        Pageedit: Boolean;


        Local procedure OnAfterGetCurrRecordFunc()
    var
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
    begin
        //CreateItemFromTemplate();

        // if CRMIntegrationEnabled then begin
        //     CRMIsCoupledToRecord := CRMCouplingManagement.IsRecordCoupledToCRM(Rec.RecordId);
        //     if Rec."No." <> xRec."No." then
        //         CRMIntegrationManagement.SendResultNotification(Rec);
        // end;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        OpenApprovalEntriesExistCurrUser := false;
        if OpenApprovalEntriesExist then
            OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);

        // ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RecordId);
        WorkflowWebhookManagement.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);

    end;

    local procedure SetWorkFlowEnabled()
    var
        WorkflowManagement: Codeunit "Workflow Management";
    begin
        AnyWorkflowExists := WorkflowManagement.AnyWorkflowExists();
        EnabledApprovalWorkflowsExist := WorkflowManagement.EnabledWorkflowExist(DATABASE::"G/L Account", WorkFlowEventFilter);
    end;


}