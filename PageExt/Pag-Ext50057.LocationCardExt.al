pageextension 50057 LocationCardExt extends "Location Card"
{
    layout
    {
        addafter(Code)
        {
            field("Send mail Report 50136"; "Send mail Report 50136")
            {
                ApplicationArea = all;
            }
        }
        modify(Bins)
        {
            Visible = VisibleStarFoods;
        }
        modify(Warehouse)
        {
            Visible = VisibleStarFoods;
        }
        modify("Bin Policies")
        {
            Visible = VisibleStarFoods;
        }
        modify("State Code")
        {
            AssistEdit = true;
            Editable = false;

            trigger OnAssistEdit()
            var
                State: Page States;
                RecState: Record State;
                PIN: text;
            Begin

                PIN := CopyStr(Rec."Post Code", 1, 3);
                RecState.Reset();
                recState.SetFilter("From PIN Code", '<=%1', PIN);
                RecState.SetFilter("To PIN Code", '>=%1', PIN);
                if RecState.FindFirst() then
                    State.SETTABLEVIEW(RecState);
                State.LOOKUPMODE(TRUE);
                if (State.RunModal() = Action::LookupOK) then begin
                    State.GetRecord(RecState);
                    rec.Validate("State Code", RecState.Code);
                end;

            End;

            trigger OnLookup(var Text: Text): Boolean
            var
                State: Page States;
                RecState: Record State;
                PIN: text;
            Begin

                PIN := CopyStr(Rec."Post Code", 1, 3);
                RecState.Reset();
                recState.SetFilter("From PIN Code", '<=%1', PIN);
                RecState.SetFilter("To PIN Code", '>=%1', PIN);
                if RecState.FindFirst() then
                    State.SETTABLEVIEW(RecState);
                State.LOOKUPMODE(TRUE);
                if (State.RunModal() = Action::LookupOK) then begin
                    State.GetRecord(RecState);
                    rec.Validate("State Code", RecState.Code);
                end;

            End;


        }

        addafter("Address & Contact")
        {


            group(SFPL)
            {

                field("Farm Type"; Rec."Farm Type")
                {
                    ApplicationArea = All;

                }
                field(Farmer; Rec.Farmer)
                {
                    ApplicationArea = All;

                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;

                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;

                }
                field("Region Code"; Rec."Region Code")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;

                }
                field("Flock Prefix"; Rec."Flock Prefix")
                {
                    ApplicationArea = All;

                }
                field("Farmer Name"; Rec."Farmer Name")
                {
                    ApplicationArea = All;

                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;

                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;

                }
                field("IFSC Code"; Rec."IFSC Code")
                {
                    ApplicationArea = All;

                }

                field("Aadhar No."; Rec."Aadhar No.")
                {
                    ApplicationArea = All;

                }
                field("Farmer Group"; Rec."Farmer Group")
                {
                    ApplicationArea = All;

                }
                field("Payment Type"; Rec."Payment Type")
                {
                    ApplicationArea = All;

                }
                field("Total Sq.Ft Area"; Rec."Total Sq.Ft Area")
                {
                    ApplicationArea = All;

                }
                field("Tds%"; Rec."Tds%")
                {
                    ApplicationArea = All;

                }
                field("P.A.N"; Rec."P.A.N")
                {
                    ApplicationArea = All;

                }
                field("Security Check 1"; Rec."Security Check 1")
                {
                    ApplicationArea = All;

                }
                field("Security Check 2"; Rec."Security Check 2")
                {
                    ApplicationArea = All;

                }
                field("Security Amount"; Rec."Security Amount")
                {
                    ApplicationArea = All;

                }
                field("Bank Branch"; Rec."Bank Branch")
                {
                    ApplicationArea = All;

                }
                field(Mandal; Rec.Mandal)
                {
                    ApplicationArea = All;

                }
                field("Date of Agreement"; Rec."Date of Agreement")
                {
                    ApplicationArea = All;

                }
                field(Own; Rec.Own)
                {
                    ApplicationArea = All;

                }
                field(Lease; Rec.Lease)
                {
                    ApplicationArea = All;

                }
                field("Own Rental"; Rec."Own Rental")
                {
                    ApplicationArea = All;

                }
                field("Agreement End Date"; Rec."Agreement End Date")
                {
                    ApplicationArea = All;

                }
                field("Incoming Document Entry No."; Rec."Incoming Document Entry No.")
                {
                    ApplicationArea = All;

                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;

                }
                field(Block; Rec.Block)
                {
                    ApplicationArea = All;

                }
                field("Per Bird Sq. Ft"; Rec."Per Bird Sq. Ft")
                {
                    ApplicationArea = All;

                }
                field(Capicity; Rec.Capicity)
                {
                    ApplicationArea = All;

                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;

                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;

                }
                field("Rejection Location"; Rec."Rejection Location")
                {
                    ApplicationArea = All;

                }
                field("Farmer Code"; Rec."Farmer Code")
                {
                    ApplicationArea = All;

                }
                field("Liquidation Date"; Rec."Liquidation Date")
                {
                    ApplicationArea = All;

                }
                field("Shed Type"; Rec."Shed Type")
                {
                    ApplicationArea = All;

                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = All;

                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;

                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;

                }
                field("Location Type"; Rec."Location Type")
                {
                    ApplicationArea = All;

                }
                field("Location Mail ID"; Rec."Location Mail ID")
                {
                    ApplicationArea = All;

                }
                field("Electricity Connection Number"; Rec."Electricity Connection Number")
                {
                    ApplicationArea = All;

                }
                field("Farm address"; Rec."Farm address")
                {
                    ApplicationArea = All;

                }
                field("Farm address 2"; Rec."Farm address 2")
                {
                    ApplicationArea = All;

                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;

                }
                field("Old Location No."; Rec."Old Location No.")
                {
                    ApplicationArea = all;
                }
            }
        }


        addafter(Control1905767507)
        {
            part("Attached Documents"; "AXT Location Document Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(14),
                              "No." = FIELD("Code"), "Document Type" = filter(Order);
            }
        }
    }

    actions
    {
        addafter("Online Map")
        {
            action("Create Customer")
            {
                ApplicationArea = All;
                Image = Vendor;
                Promoted = true;
                trigger OnAction()
                var
                    Customer: Record customer;
                    NewCustomerNo: Code[20];
                    NoSeriesMgt: Codeunit NoSeriesManagement;
                    SalesSetup: Record "Sales & Receivables Setup";
                    Location: Record Location;
                    PostConfirmQst: Label 'Customer Already Created Against this Location Do you wants to check Customer List and create Again %1?';
                    PostConfirmQst1: Label 'You have checked the customer list Still do you wants to Create Customer %1?';
                    ConfirmManagement: Codeunit "Confirm Management";
                begin
                    SalesSetup.GET();
                    //NewCustomerNo := NoSeriesMgt.GetNextNo(SalesSetup."Customer Nos.", Today, true);
                    Location.Reset();
                    Location.SetRange(Code, Rec.Code);
                    if Location.FindFirst() then BEGIN
                        Customer.Reset();
                        Customer.SetRange(Customer."P.A.N. No.", Location."P.A.N");
                        if Customer.FindFirst() then begin
                            if not ConfirmManagement.GetResponseOrDefault(StrSubstNo(PostConfirmQst, Customer.Count), true) then
                                exit
                            else begin
                                Clear(CustomerPage);
                                CustomerPage.SetTableView(Customer);
                                CustomerPage.Run();
                                if not ConfirmManagement.GetResponseOrDefault(StrSubstNo(PostConfirmQst1, Customer.Count), true) then
                                    exit
                            end;
                            Customer.Init();
                            Customer.Validate("No.", NoSeriesMgt.GetNextNo(SalesSetup."Customer Nos.", Today, true));
                            Customer.Validate(Name, Rec.Name);
                            Customer.Validate(Address, REC.Address);
                            Customer.Validate("Address 2", Rec."Address 2");
                            Customer.Validate(City, rEC.City);
                            Customer.Validate("Country/Region Code", Rec."Country/Region Code");
                            Customer.Validate("Post Code", Rec."Post Code");
                            Customer.Validate("Phone No.", Rec."Phone No.");
                            Customer."P.A.N. No." := Rec."P.A.N";
                            IF Rec."GST Registration No." <> '' THEN begin
                                Customer."GST Customer Type" := Customer."GST Customer Type"::Registered;
                                Customer."GST Registration No." := Rec."GST Registration No.";
                                Customer."GST Registration Type" := Customer."GST Registration Type"::GSTIN;
                            end;
                            Customer.Insert();
                            Message('%1,%2', 'Customer Created for This vendor New Customer No Is:', Customer."No.");
                        end else begin
                            Customer.Init();
                            Customer.Validate("No.", NoSeriesMgt.GetNextNo(SalesSetup."Customer Nos.", Today, true));
                            Customer.Validate(Name, Rec.Name);
                            Customer.Validate(Address, REC.Address);
                            Customer.Validate("Address 2", Rec."Address 2");
                            Customer.Validate(City, rEC.City);
                            Customer.Validate("Country/Region Code", Rec."Country/Region Code");
                            Customer.Validate("Post Code", Rec."Post Code");
                            Customer.Validate("Phone No.", Rec."Phone No.");
                            Customer."P.A.N. No." := Rec."P.A.N";
                            IF Rec."GST Registration No." <> '' THEN begin
                                Customer."GST Customer Type" := Customer."GST Customer Type"::Registered;
                                Customer."GST Registration No." := Rec."GST Registration No.";
                                Customer."GST Registration Type" := Customer."GST Registration Type"::GSTIN;
                            end;
                            Customer.Insert();
                        end;
                    end
                end;
            }
        }

        addafter("&Location")
        {
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
                    ToolTip = 'Request approval to change the record.';

                    trigger OnAction()
                    var
                        BaseCodeunit: Codeunit "Approval Management Custom";
                    begin


                        if BaseCodeunit.CheckLocationApprovalsWorkflowEnabled(Rec) then
                            BaseCodeunit.OnSendlocationForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist OR CanCancelApprovalForFlow;
                    Image = CancelApprovalRequest;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
                        BaseCodeunit: Codeunit "Approval Management Custom";
                    begin
                        //ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);

                        BaseCodeunit.OnCancellocationApprovalRequest(Rec);
                        WorkflowWebhookManagement.FindAndCancel(Rec.RecordId);
                    end;
                }
            }
        }
        // Add changes to page actions here
        addafter("Online Map")
        {

            action("Attachements")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Attachements';
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = page "AXT Location Document Attached";
                RunPageLink = "Table ID" = filter(14), "No." = field(Code), "Document Type" = const(Order);
            }

            group(IncomingDocument)
            {
                Caption = 'Incoming Document';
                Image = Documents;
                action(IncomingDocCard)
                {
                    Caption = 'View Incoming Document';
                    Enabled = HasIncomingDocument;
                    Image = ViewOrder;
                    //The property 'ToolTip' cannot be empty.
                    //ToolTip = '';

                    Applicationarea = All;
                    trigger OnAction()
                    var
                        IncomingDocument: Record 130;
                    begin
                        IncomingDocument.ShowCardFromEntryNo(Rec."Incoming Document Entry No.");
                    end;
                }
                action(SelectIncomingDoc)
                {
                    AccessByPermission = TableData 130 = R;
                    Caption = 'Select Incoming Document';
                    Image = SelectLineToApply;
                    //The property 'ToolTip' cannot be empty.
                    //ToolTip = '';

                    Applicationarea = All;
                    trigger OnAction()
                    var
                        IncomingDocument: Record 130;
                    begin
                        //  VALIDATE("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument("Incoming Document Entry No."));
                    end;
                }
                action(IncomingDocAttachFile)
                {
                    Caption = 'Create Incoming Document from File';
                    Ellipsis = true;
                    Enabled = NOT HasIncomingDocument;
                    Image = Attach;
                    //The property 'ToolTip' cannot be empty.
                    //ToolTip = '';

                    Applicationarea = All;
                    trigger OnAction()
                    var
                        IncomingDocumentAttachment: Record 133;
                    begin
                        //  IncomingDocumentAttachment.NewAttachmentFromLocation(Rec);
                    end;
                }
                action(RemoveIncomingDoc)
                {
                    Caption = 'Remove Incoming Document';
                    Enabled = HasIncomingDocument;
                    Image = RemoveLine;
                    //The property 'ToolTip' cannot be empty.
                    //ToolTip = '';

                    Applicationarea = All;
                    trigger OnAction()
                    begin
                        Rec."Incoming Document Entry No." := 0;
                    end;
                }


            }

        }


    }



    trigger OnAfterGetCurrRecord()
    begin
        SetControlVisibility();
        OnAfterGetCurrRecordFunc();

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Location Master", '%1', UserSetup."Access Location Master"::View);
        IF UserSetup.FINDFIRST THEN
            BoolTest := FALSE
        ELSE
            BoolTest := TRUE;

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Location Master", '%1', UserSetup."Access Location Master"::View);
        UserSetup.SETRANGE("Liquidation Date", TRUE);
        IF UserSetup.FINDFIRST THEN
            BoolTest1 := TRUE;

        IF Rec.Status = Rec.Status::Open THEN begin
            // CurrPage.Editable(true);
            CurrPage.Editable(true);
        end ELSE
            // CurrPage.Editable(false);
            CurrPage.Editable(false);

    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Location Master", '%1', UserSetup."Access Location Master"::View);
        IF UserSetup.FINDFIRST THEN
            BoolTest := FALSE
        ELSE
            BoolTest := TRUE;


        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Location Master", '%1', UserSetup."Access Location Master"::View);
        UserSetup.SETRANGE("Liquidation Date", TRUE);
        IF UserSetup.FINDFIRST THEN
            BoolTest1 := TRUE;

        IF Rec.Status = Rec.Status::Open THEN begin
            // CurrPage.Editable(true);
            CurrPage.Editable(true);
        end ELSE
            // CurrPage.Editable(false);
            CurrPage.Editable(false);
    end;



    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Location Master", '%1', UserSetup."Access Location Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Delete Location');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Location Master", '%1', UserSetup."Access Location Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Location Master", '%1', UserSetup."Access Location Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change Location Details');
        //PRU_DD 1.10


    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //PRU_GK 1.10

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Location Master", '%1', UserSetup."Access Location Master"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to Create Location Master')
        //PRU_GK 1.10
    end;

    trigger OnOpenPage()
    begin
        //TRI A.S 19.09.13 START
        // Rec.FILTERGROUP(2);
        // userset.GET(USERID);
        // userset.TESTFIELD("Responsibility Center");
        // Rec.SETFILTER("Responsibility Center", '%1|%2', userset."Responsibility Center", '');
        // Rec.FILTERGROUP(0);
        //TRI A.S 19.09.13 STOP

        CompanyInfo.Get;

        VisibleSampoorna := false;
        VisibleStarFoods := False;

        If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then
            VisibleSampoorna := true
        else
            VisibleStarFoods := True;



        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Location Master", '%1', UserSetup."Access Location Master"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Location Master');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Location Master", '%1', UserSetup."Access Location Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10

        ///Pru_gk
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Location Master", '%1', UserSetup."Access Location Master"::View);
        IF UserSetup.FINDFIRST THEN
            BoolTest := FALSE
        ELSE
            BoolTest := TRUE;

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        //UserSetup.SETFILTER(UserSetup."Access Location Master",'%1',UserSetup."Access Location Master"::View);
        UserSetup.SETRANGE("Liquidation Date", TRUE);
        IF UserSetup.FINDFIRST THEN BEGIN
            BoolTest1 := TRUE;
        END;
        /////Pru_gk

    end;





    local procedure SetControlAppearance()
    begin
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        //SetExtDocNoMandatoryCondition;
    end;


    local procedure SetDocNoVisible()
    begin
        //DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::Invoice,"No.");
    end;


    local procedure SetExtDocNoMandatoryCondition()
    begin
        // PurchasesPayablesSetup.GET;
        // VendorInvoiceNoMandatory := PurchasesPayablesSetup."Ext. Doc. No. Mandatory"
    end;

    local procedure SetControlVisibility()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        WorkflowWebhookManagement.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;

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




    var

        myInt: Integer;
        UserSetup: Record 91;
        HasIncomingDocument: Boolean;
        userset: Record 91;
        BoolTest: Boolean;
        BoolTest1: Boolean;

        VisibleStarFoods: Boolean;
        VisibleSampoorna: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        OpenApprovalEntriesExistCurrUser: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CompanyInfo: Record "Company Information";
        CustomerPage: Page "Customer List";
}