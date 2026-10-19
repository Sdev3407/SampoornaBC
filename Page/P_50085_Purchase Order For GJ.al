
page 50085 "Purchase Order For GJ"
{

    Caption = 'Purchase Orders';
    CardPageID = "Purchase Order";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 38;
    SourceTableView = WHERE("Document Type" = CONST(Order));
    ApplicationArea = All;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(grp)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Vendor Authorization No."; Rec."Vendor Authorization No.")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Vendor GST Reg. No."; Rec."Vendor GST Reg. No.")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Completely Received"; Rec."Completely Received")
                {
                    ApplicationArea = All;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = All;
                    Visible = JobQueueActive;
                }
            }
        }
        area(factboxes)
        {

            part(IncomingDocAttachFactBox; 193)
            {
                ApplicationArea = All;
                ShowFilter = false;
                Visible = false;
            }
            part("Vendor Details"; 9093)
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Buy-from Vendor No."),
                              "Date Filter" = FIELD("Date Filter");
                Visible = true;
            }
            systempart(Links; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                Visible = false;
                action(Dimensions)
                {
                    AccessByPermission = TableData 348 = R;
                    Caption = 'Dimensions';
                    ApplicationArea = All;
                    Image = Dimensions;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                    end;
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    ApplicationArea = All;
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        Rec.OpenPurchaseOrderStatistics;
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    ApplicationArea = All;
                    Image = Approvals;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page 658;
                    begin
                        ApprovalEntries.SetRecordFilters(DATABASE::"Purchase Header", Rec."Document Type", Rec."No.");
                        ApprovalEntries.RUN;
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    ApplicationArea = All;
                    Image = ViewComments;
                    RunObject = Page 66;
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                Visible = false;
                action(Receipts)
                {
                    Caption = 'Receipts';
                    ApplicationArea = All;
                    Image = PostedReceipts;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Page 145;
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(PostedPurchaseInvoices)
                {
                    Caption = 'Invoices';
                    ApplicationArea = All;
                    Image = Invoice;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Page 146;
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(PostedPurchasePrepmtInvoices)
                {
                    Caption = 'Prepa&yment Invoices';
                    ApplicationArea = All;
                    Image = PrepaymentInvoice;
                    RunObject = Page 146;
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                }
                action("Prepayment Credi&t Memos")
                {
                    Caption = 'Prepayment Credi&t Memos';
                    ApplicationArea = All;
                    Image = PrepaymentCreditMemo;
                    RunObject = Page 147;
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                }

            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                Visible = false;
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines';
                    ApplicationArea = All;
                    Image = PickLines;
                    RunObject = Page 5774;
                    RunPageLink = "Source Document" = CONST("Purchase Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                }
                action("Whse. Receipt Lines")
                {
                    Caption = 'Whse. Receipt Lines';
                    ApplicationArea = All;
                    Image = ReceiptLines;
                    RunObject = Page 7342;
                    RunPageLink = "Source Type" = CONST(39),
                                  "Source Subtype" = FIELD("Document Type"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                }

            }
        }
        area(processing)
        {
            group(General)
            {
                Caption = 'General';
                Image = Print;
                Visible = false;
                action(Print)
                {
                    Caption = '&Print';
                    ApplicationArea = All;
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        DocPrint.PrintPurchHeader(Rec);
                    end;
                }
                action("PO Print")
                {
                    Image = "Report";
                    ApplicationArea = All;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunPageOnRec = false;

                    trigger OnAction()
                    begin
                        PurchaseHeader.RESET;
                        PurchaseHeader.SETRANGE("No.", Rec."No.");
                        IF PurchaseHeader.FINDFIRST THEN
                            REPORT.RUNMODAL(50002, TRUE, FALSE, PurchaseHeader);
                    end;
                }
            }
            group(Release1)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                Visible = false;
                action(Release)
                {
                    Caption = 'Re&lease';
                    ApplicationArea = All;
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit 415;
                    begin
                        Rec.TESTFIELD("Brokerage Code");//PRU-VG1.0
                        Rec.TESTFIELD("Payment Terms Code");//PRU-VG1.0
                        Rec.TESTFIELD("Rate Basis");//PRU-VG1.0
                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    Caption = 'Re&open';
                    ApplicationArea = All;
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit 415;
                    begin
                        UserSetup.RESET;
                        UserSetup.SETRANGE("User ID", USERID);
                        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::"Receive & Invoice");
                        IF UserSetup.FINDFIRST THEN
                            ERROR('You do not have permission to Reopen the Purchase Order');

                        UserSetup.RESET;
                        UserSetup.SETRANGE("User ID", USERID);
                        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::Invoice);
                        IF UserSetup.FINDFIRST THEN
                            ERROR('You do not have permission to Reopen the Purchase Order');

                        UserSetup.RESET;
                        UserSetup.SETRANGE("User ID", USERID);
                        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::Receive);
                        IF UserSetup.FINDFIRST THEN
                            ERROR('You do not have permission to Reopen the Purchase Order');

                        UserSetup.RESET;
                        UserSetup.SETRANGE("User ID", USERID);
                        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
                        IF UserSetup.FINDFIRST THEN
                            ERROR('You do not have permission to Reopen the Purchase Order');

                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }

            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                Visible = false;
                action("Send IC Purchase Order")
                {
                    AccessByPermission = TableData 410 = R;
                    Caption = 'Send IC Purchase Order';
                    ApplicationArea = All;
                    Image = IntercompanyOrder;

                    trigger OnAction()
                    var
                        ICInOutboxMgt: Codeunit 427;
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN
                            ICInOutboxMgt.SendPurchDoc(Rec, FALSE);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Visible = false;
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    ApplicationArea = All;
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        Rec.TESTFIELD("Brokerage Code");//PRU-VG1.0
                        Rec.TESTFIELD("Payment Terms Code");//PRU-VG1.0
                        Rec.TESTFIELD("Rate Basis");//PRU-VG1.0
                                                    //  ApprovalsMgmt.che
                                                    //    IF ApprovalsMgmt.CheckPurchaseApprovalsWorkflowEnabled(Rec) THEN
                                                    //    ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    ApplicationArea = All;
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                    end;
                }
            }
            group(Warehouse1)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                Visible = false;
                action("Create &Whse. Receipt")
                {
                    AccessByPermission = TableData 7316 = R;
                    Caption = 'Create &Whse. Receipt';
                    ApplicationArea = All;
                    Image = NewReceipt;

                    trigger OnAction()
                    var
                        GetSourceDocInbound: Codeunit 5751;
                    begin
                        GetSourceDocInbound.CreateFromPurchOrder(Rec);

                        IF NOT Rec.FIND('=><') THEN
                            Rec.INIT;
                    end;
                }
                action("Create Inventor&y Put-away/Pick")
                {
                    AccessByPermission = TableData 7340 = R;
                    Caption = 'Create Inventor&y Put-away/Pick';
                    ApplicationArea = All;
                    Ellipsis = true;
                    Image = CreatePutawayPick;

                    trigger OnAction()
                    begin
                        Rec.CreateInvtPutAwayPick;

                        IF NOT Rec.FIND('=><') THEN
                            Rec.INIT;
                    end;
                }

            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                Visible = false;
                action(TestReport)
                {
                    Caption = 'Test Report';
                    ApplicationArea = All;
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action(Post)
                {
                    Caption = 'P&ost';
                    ApplicationArea = All;
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        UserSetup.RESET;
                        UserSetup.SETRANGE("User ID", USERID);
                        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::Edit);
                        IF UserSetup.FINDFIRST THEN
                            ERROR('You can not post the Purchase Order');
                        //PRU_DD 1.10

                        UserSetup.RESET;
                        UserSetup.SETRANGE("User ID", USERID);
                        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
                        IF UserSetup.FINDFIRST THEN
                            ERROR('You can not post the Purchase Order');
                        //PRU_DD 1.10

                        Rec.TESTFIELD("Brokerage Code");//PRU-VG1.0
                        Rec.TESTFIELD("Payment Terms Code");//PRU-VG1.0
                        Rec.TESTFIELD("Rate Basis");//PRU-VG1.0

                        Rec.SendToPosting(CODEUNIT::"Purch.-Post (Yes/No)");
                    end;
                }
                action(Preview)
                {
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        PurchPostYesNo: Codeunit 91;
                    begin
                        Rec.TESTFIELD("Brokerage Code");//PRU-VG1.0
                        Rec.TESTFIELD("Payment Terms Code");//PRU-VG1.0
                        Rec.TESTFIELD("Rate Basis");//PRU-VG1.0
                        PurchPostYesNo.Preview(Rec);
                    end;
                }
                action(PostAndPrint)
                {
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        Rec.TESTFIELD("Brokerage Code");//PRU-VG1.0
                        Rec.TESTFIELD("Payment Terms Code");//PRU-VG1.0
                        Rec.TESTFIELD("Rate Basis");//PRU-VG1.0
                        Rec.SendToPosting(CODEUNIT::"Purch.-Post + Print");
                    end;
                }
                action(PostBatch)
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        Rec.TESTFIELD("Brokerage Code");//PRU-VG1.0
                        Rec.TESTFIELD("Payment Terms Code");//PRU-VG1.0
                        Rec.TESTFIELD("Rate Basis");//PRU-VG1.0
                        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Orders", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action(RemoveFromJobQueue)
                {
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = JobQueueActive;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        Rec.CancelBackgroundPosting;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnDeleteRecord(): Boolean
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not delete the Purchase Order');
        //PRU_DD 1.10
    end;
    /*
        trigger OnInsertRecord(BelowxRec: Boolean): Boolean
        begin

            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
            IF UserSetup.FINDFIRST THEN
                CurrPage.EDITABLE(FALSE);
            //PRU_DD 1.10


        end;

        trigger OnModifyRecord(): Boolean
        begin

            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
            IF UserSetup.FINDFIRST THEN
                ERROR('You can not modify the Purchase Order');
            //PRU_DD 1.10

        end;

        trigger OnNewRecord(BelowxRec: Boolean)
        begin

            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
            IF UserSetup.FINDFIRST THEN
                CurrPage.EDITABLE(FALSE);
            //PRU_DD 1.10


        end;

        trigger OnOpenPage()
        var
            PurchasesPayablesSetup: Record 312;
        begin

            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::" ");
            IF UserSetup.FINDFIRST THEN
                ERROR('You do not have permission to view Purchase Order');
            //PRU_DD 1.10

            UserSetup.RESET;
            UserSetup.SETRANGE("User ID", USERID);
            UserSetup.SETFILTER(UserSetup."Access Purchase Order", '%1', UserSetup."Access Purchase Order"::View);
            IF UserSetup.FINDFIRST THEN
                CurrPage.EDITABLE(FALSE);
            //PRU_DD 1.10


            ///SetSecurityFilterOnRespCenter;

            /////JobQueueActive := PurchasesPayablesSetup.JobQueueActive;
            //<<PRU_RC

            UserSetup.GET(USERID);
            Rec.FILTERGROUP(2);
            Rec.SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
            IF NOT UserSetup."HO Users" THEN
                Rec.SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
            Rec.SETFILTER("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
            Rec.FILTERGROUP(0);
            ///MESSAGE('%1',COUNT);
            //>>RPU_RC


        end;
    */
    var
        ReportPrint: Codeunit 228;
        DocPrint: Codeunit 229;
        [InDataSet]
        JobQueueActive: Boolean;
        OpenApprovalEntriesExist: Boolean;
        UserSetup: Record 91;
        PurchaseHeader: Record 38;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit 1535;
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
    end;


}


