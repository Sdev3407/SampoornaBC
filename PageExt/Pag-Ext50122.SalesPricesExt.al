pageextension 50122 SalesPricesExt extends "Sales Prices"
{
    layout
    {
        addafter("Item No.")
        {
            field("Discount Type"; Rec."Discount Type")
            {
                ApplicationArea = All;

            }
            field("Discount Perc/Amount"; Rec."Discount Perc/Amount")
            {
                ApplicationArea = All;

            }
            field(Description; Rec.Description)
            {
                ApplicationArea = All;

            }
            field("Entry No."; Rec."Entry No.")
            {
                ApplicationArea = All;

            }
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;

            }
            field(Status; Rec.Status)
            {
                ApplicationArea = All;

            }
            field("Approval Required"; Rec."Approval Required")
            {
                ApplicationArea = All;

            }
            field(MRP; Rec.MRP)
            {
                ApplicationArea = all;
            }
            field("MRP PRICE"; Rec."MRP PRICE")
            {
                ApplicationArea = all;
            }
            // field("From Location"; Rec."From Location")
            // {
            //     ApplicationArea = All;
            // }
            // field("to Location"; Rec."to Location")
            // {
            //     ApplicationArea = All;
            // }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter(CopyPrices)
        {
            action(SalesPrice1)
            {
                ApplicationArea = all;
                Caption = 'Sales Price Import';
                Image = Export;
                Promoted = true;
                PromotedCategory = Category9;
                RunObject = xmlport 50002;
            }
            action(SalesPrice)
            {
                ApplicationArea = all;
                Caption = 'Item Varient Import';
                Image = Export;
                Promoted = true;
                PromotedCategory = Category9;
                RunObject = xmlport 50001;
            }
            action(SendApprovalRequest)
            {
                ApplicationArea = all;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category9;
                ToolTip = 'Send an approval request.';

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit 1535;
                    T_14: Record 14;
                    Count1: Integer;
                    Count2: Integer;
                    WorkflowEventHandling: Codeunit 1520;
                    Workflow: Record 1501;
                    Tab_14: Record 14;
                    GeneralLedgerSetup: Record 98;
                begin
                    // IF ApprovalsMgmt.CheckPriceApprovalsWorkflowEnabled(Rec) THEN
                    //   WorkflowEventHandling.RunWorkflowOnSendPriceDocForApproval(Rec);
                    Rec."Approval Required" := FALSE;
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = all;
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                ToolTip = 'Cancel the approval request.';

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit 1535;
                    WorkflowEventHandling: Codeunit 1520;
                    Workflow: Record 1501;
                begin
                    //PRU_NEELESH
                    Workflow.RESET;
                    Workflow.SETRANGE(Code, 'SALESPRICE');
                    Workflow.SETRANGE(Enabled, TRUE);
                    IF Workflow.FINDFIRST THEN BEGIN
                        // WorkflowEventHandling.RunWorkflowOnCancelPriceApprovalRequest(Rec);
                    END;
                    //PRU_NEELESH
                    Rec."Approval Required" := TRUE;
                end;
            }
            action("Re&open")
            {
                ApplicationArea = all;
                Caption = 'Re&open';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ReleaseSalesDoc: Codeunit 414;
                begin
                    SalesPrice.ReopenSalesPrice(Rec."Sales Code", Rec."Item No.", Rec.Status);
                end;
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        // IF (Rec."Approval Required" = TRUE) AND (Rec.Status= Rec.Status::Open) THEN
        //  ERROR(Text002);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if Rec."Location Code" <> '' then
            if Rec."Variant Code" = '' then
                Error('Please insert the varient code first');
    end;

    trigger OnModifyRecord(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        //if UserId <> 'SAM304' then
        //  Error('Please connect with administrator');
    end;

    var
        myInt: Integer;
        SalesPrice: Record 7002;
        Text002: Label 'Please Send Approval Of Current Sales Price Line';
}