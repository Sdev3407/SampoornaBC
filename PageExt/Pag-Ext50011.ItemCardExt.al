pageextension 50011 ItemCardExt extends "Item Card"
{
    layout
    {
        addafter(Description)
        {
            field("Mandatory Mandi Name"; "Mandatory Mandi Name(50137)")
            {
                ApplicationArea = all;
                Caption = 'Mandatory Mandi Name';
            }
        }

        modify(Item)
        {
            Editable = EDITN;
        }
        modify(Inventory)
        {
            Editable = EDITN;
        }
        modify("Costs & Posting")
        {
            Editable = EDITN;
        }
        modify("Prices & Sales")
        {
            Editable = EDITN;
        }
        modify(Replenishment)
        {
            Editable = EDITN;
        }
        modify(Planning)
        {
            Editable = EDITN;
        }
        modify(ItemTracking)
        {
            Editable = EDITN;
        }
        modify(Warehouse)
        {
            Editable = EDITN;
        }
        modify("GST Group Code")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                Companyinfo.Get;
                if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] Then begin
                    if ((Rec."GST Group Code" = 'EXEMPT-GD') or (Rec."GST Group Code" = 'EXEMPT-SR')) then
                        Rec.Validate(Exempted, True)
                    else
                        Rec.Validate(Exempted, false);
                end;
            end;
        }


        addafter("No.")
        {
            field("Net Change"; Rec."Net Change")
            {
                ApplicationArea = All;
            }
            field("QC Enabled"; Rec."QC Enabled")
            {
                ApplicationArea = All;

            }
            field("Chicks Item"; Rec."Chicks Item")
            {
                ApplicationArea = All;

            }
            field("Item Sub Category"; Rec."Item Sub Category")

            {
                ApplicationArea = All;
            }
            field("Consumption Item"; Rec."Consumption Item")
            {
                ApplicationArea = All;

            }
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = All;

            }
            field("Item Type"; Rec."Item Type")
            {
                ApplicationArea = All;

            }
            field("Bag Item"; Rec."Bag Item")
            {
                ApplicationArea = All;

            }
            field("Item Tolerance"; Rec."Item Tolerance")
            {
                ApplicationArea = All;

            }
            field("CBF Item"; Rec."CBF Item")
            {
                ApplicationArea = All;
                Visible = SFPLVisible;

            }
            field("Feed Item"; Rec."Feed Item")
            {
                ApplicationArea = All;
                Visible = SFPLVisible;

            }
            field("Breed Code"; Rec."Breed Code")
            {
                ApplicationArea = All;

            }
            field(Status; Rec.Status)
            {
                ApplicationArea = All;

            }
            field("ALEX Item Code"; Rec."ALEX Item Code")
            {
                ApplicationArea = All;

            }
            field("GST Discription"; Rec."GST Discription")
            {
                ApplicationArea = All;
                Visible = False;

            }
            field("Item Location"; Rec."Item Location")
            {
                ApplicationArea = All;
                Visible = SFPLVisible;

            }
            field("Stock Value"; Rec."Stock Value")
            {
                ApplicationArea = All;

            }
            field("GC Rate %"; Rec."GC Rate %")
            {
                ApplicationArea = All;

            }
            field("Old No. Series"; Rec."Old No. Series")
            {
                ApplicationArea = all;
                Visible = SFPLVisible;
            }
            field(SMSItemType; SMSItemType)
            {
                ApplicationArea = All;
                Visible = SFPLVisible;
            }
            field("Item Component"; Rec.ItemComponent)
            {
                ApplicationArea = All;
                Visible = StarVisible;
            }
            field("CBF Data Entry Item filter"; "CBF Data Entry Item filter")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addbefore(RequestApproval)
        {
            action(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                Promoted = true;
                Enabled = (Not OpenApprovalEntriesExist);

                Applicationarea = All;
                trigger OnAction()
                var
                    BaseCodeunit: Codeunit "Approval Management Custom";
                    T_1501: Record 1501;
                begin
                    //PRU_NEELESH


                    IF not BaseCodeunit.CheckingItemApprovalsWorkflowEnabled(Rec) THEN begin
                        Rec.Status := Rec.Status::Approved;
                        Rec.MODIFY;
                    END else
                        Message('Approval Workflow is enabled, Please send for approval');
                    //PRU_NEELESH
                end;
            }
        }


        addafter(Identifiers)
        {
            action("Item Sampling Template List")
            {
                ApplicationArea = All;
                Image = List;
                RunObject = Page 50017;
            }
        }
        modify(Approve)

        {
            trigger OnBeforeAction()
            begin
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Item Master", '%1', UserSetup."Access Item Master"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You can not Approve the Item');
                //PRU_DD 1.10


                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Item Master", '%1', UserSetup."Access Item Master"::Create);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You can not Approve the Item');
                //PRU_DD 1.10
            end;

            trigger OnAfterAction()
            var

            begin

                Rec.Status := Rec.Status::Approved;
                Rec.Modify();

            end;
        }
        modify(Reject)
        {
            trigger OnAfterAction()
            var

            begin

                Rec.Status := Rec.Status::Open;
                Rec.Modify();

            end;
        }
        addbefore(RequestApproval)
        {

            action(Reopen)
            {
                Caption = 'Reopen';
                Image = ReOpen;
                Promoted = true;
                Enabled = Not OpenApprovalEntriesExist;
                Applicationarea = All;
                trigger OnAction()
                var

                begin

                    //if Not BaseCodeunit.CheckingItemApprovalsWorkflowEnabled(Rec) Then
                    if rec.Status = rec.Status::Approved then begin
                        Rec.Status := Rec.Status::Open;
                        Rec.MODIFY;
                    end;


                    //PRU_NEELESH
                end;
            }

        }
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                ApprovalsMgmt: Codeunit 1535;
                T_27: Record 27;
            begin
                /*IF ApprovalsMgmt.CheckItemApprovalsWorkflowEnabled(Rec) THEN
                        ApprovalsMgmt.OnSendItemForApproval(Rec);*/
                //PRU_NEELESH
                IF Rec.Status = Rec.Status::Approved THEN
                    ERROR('Item is already approved');
                //PRU_NEELESH
                IF ApprovalsMgmt.CheckItemApprovalsWorkflowEnabled(Rec) THEN
                    //ApprovalsMgmt.OnSendItemForApproval(Rec);
                    //PRU_NEELESH
                    IF T_27.GET(Rec."No.") THEN BEGIN
                        IF T_27.Status <> T_27.Status::Approved THEN BEGIN
                            T_27.Status := T_27.Status::"Pending Approval";
                            T_27.MODIFY;
                        END;
                    END;
                //PRU_NEELESH
            end;
        }
        modify(CancelApprovalRequest)
        {
            trigger OnBeforeAction()
            begin
                //PRU_NEELESH
                Rec.Status := Rec.Status::Open;
                Rec.MODIFY;
                //PRU_NEELESH
            end;
        }
    }
    trigger OnAfterGetCurrRecord()
    begin

        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        //PRU_NEELESH
        IF Rec.Status = Rec.Status::Open THEN
            EDITN := TRUE
        ELSE
            EDITN := FALSE;
        //PRU_NEELESH
    end;

    trigger OnAfterGetRecord()
    begin
        //PRU_NEELESH
        IF Rec.Status = Rec.Status::Open THEN
            EDITN := TRUE
        ELSE
            EDITN := FALSE;
        //PRU_NEELESH
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Master", '%1', UserSetup."Access Item Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Delete Item');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Master", '%1', UserSetup."Access Item Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10

        Rec.Validate("Flushing Method", Rec."Flushing Method"::Manual);
        Rec."Rounding Precision" := 0.00001;

    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Master", '%1', UserSetup."Access Item Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change Item Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Master", '%1', UserSetup."Access Item Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin
        StarVisible := false;
        SFPLVisible := true;

        //TRI A.S 19.09.13 START
        Rec.FILTERGROUP(2);
        UserSetup.GET(USERID);
        IF NOT UserSetup."HO Users" THEN
            Rec.SETFILTER("Responsibility Center", '%1|%2', UserSetup."Responsibility Center", '');
        Rec.FILTERGROUP(0);
        //TRI A.S 19.09.13 STOP
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Master", '%1', UserSetup."Access Item Master"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Item Master');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Item Master", '%1', UserSetup."Access Item Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        //PRU_NEELESH
        IF Rec.Status = Rec.Status::Open THEN
            EDITN := TRUE
        ELSE
            EDITN := FALSE;
        //PRU_NEELESH
        CompanyInfo.Get;
        If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::"Star Foods"] Then begin
            StarVisible := True;
            SFPLVisible := False;
        end;
    end;

    var
        OpenApprovalEntriesExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        myInt: Integer;
        UserSetup: Record 91;
        EDITN: Boolean;
        StarVisible: Boolean;
        SFPLVisible: Boolean;
        CompanyInfo: Record "Company Information";




}