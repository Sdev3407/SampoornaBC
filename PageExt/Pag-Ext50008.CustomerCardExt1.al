pageextension 50008 CustomerCardExt1 extends "Customer Card"
{
    layout
    {
        addafter("No.")
        {
            field("Created From Vendor No."; Rec."Created From Vendor No.")
            {
                ApplicationArea = all;
                Editable = false;
            }

        }
        modify("Balance (LCY)")
        {
            Visible = DisableOnFeedPlant;
        }
        moveafter("Phone No."; MobilePhoneNo)
        addafter(MobilePhoneNo)
        {
            field("WhatsApp Mobile No."; Rec."WhatsApp Mobile No.")
            {
                ApplicationArea = All;
            }
            field("Alternate Phone No. 1"; Rec."Alternate Phone No. 1")
            {
                ApplicationArea = All;
            }
            field("Alternate Phone No. 2"; Rec."Alternate Phone No. 2")
            {
                ApplicationArea = All;
            }
            field("Alternate Phone No. 3"; Rec."Alternate Phone No. 3")
            {
                ApplicationArea = All;
            }
            field("Alternate Phone No. 4"; Rec."Alternate Phone No. 4")
            {
                ApplicationArea = All;
            }
            field("Alternate Phone No. 5"; Rec."Alternate Phone No. 5")
            {
                ApplicationArea = All;
            }
        }

        addbefore("Attached Documents")
        {
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = All;
                Caption = 'IncomingDocAttachFactBox';
                ShowFilter = false;
            }
        }
        modify("Credit Limit (LCY)")
        { ApplicationArea = All; }
        modify("Customer Disc. Group")
        {
            Visible = false;
        }
        modify("Customer Price Group")
        {
            Visible = true;

            trigger OnAfterValidate()
            var
                Cust: Record Customer;
                TempEmailItem: Record "Email Item" temporary;
                EmailScenario: Enum "Email Scenario";
                EmailCu: Codeunit Email;
                EmailMsg: Codeunit "Email Message";
                TeamSalesperson: Record "Team Salesperson";
                Team: Record Team;
                EmailRecpt: Text;
                RecRef: RecordRef;
                SalesPrice: Record "Sales Price";
                Outstr: OutStream;
                Instr: InStream;
                TempBlob: Codeunit "Temp Blob";
                SubJextText: Text;
            begin
                Clear(EmailCu);
                Clear(EmailMsg);
                if Rec."Salesperson Code" <> '' then begin
                    TeamSalesperson.Reset();
                    TeamSalesperson.SetRange(TeamSalesperson."Salesperson Code", Rec."Salesperson Code");
                    if TeamSalesperson.FindFirst() then begin
                        Team.Reset();
                        Team.SetRange(Code, TeamSalesperson."Team Code");
                        Team.SetFilter(Team."E-Mail", '<>%1', '');
                        if Team.FindFirst() then
                            EmailRecpt := Team."E-Mail";
                    end;
                end;
                EmailRecpt := EmailRecpt + ';' + 'sale.coordinator1@sampoornafeeds.in;sale@sampoornafeeds.com;karanveer.singh@sampoornafeeds.in;pankaj.bhangalia@sampoornafeeds.in;shilpa.bhatia@sampoornafeeds.in';
                EmailMsg.Create(EmailRecpt, Rec."No." + ' Changes in Customer Price Group', '');
                SalesPrice.Reset();
                SalesPrice.SetRange(SalesPrice."Sales Code", Rec."Customer Price Group");
                if SalesPrice.FindFirst() then begin
                    RecRef.GetTable(SalesPrice);
                    TempBlob.CreateOutStream(Outstr);
                    Report.SaveAs(50148, '', ReportFormat::Pdf, Outstr, RecRef);
                    TempBlob.CreateInStream(Instr);
                    EmailMsg.AddAttachment('New ' + Rec."No." + ' ' + Rec."Customer Price Group" + '.pdf', 'PDF', Instr);
                end;
                SalesPrice.Reset();
                SalesPrice.SetRange(SalesPrice."Sales Code", XRec."Customer Price Group");
                if SalesPrice.FindFirst() then begin
                    RecRef.GetTable(SalesPrice);
                    TempBlob.CreateOutStream(Outstr);
                    Report.SaveAs(50148, '', ReportFormat::Pdf, Outstr, RecRef);
                    TempBlob.CreateInStream(Instr);
                    EmailMsg.AddAttachment('Old ' + Rec."No." + ' ' + XRec."Customer Price Group" + '.pdf', 'PDF', Instr);
                end;
                EmailMsg.AppendToBody('Dear All' + ',' + '<BR><BR>');
                EmailMsg.AppendToBody('Customer Price group has been changed from ' + xRec."Customer Price Group" + ' To ' + Rec."Customer Price Group" + ' For Customer Code : ' + Rec."No." + '.<BR><BR>');
                EmailMsg.AppendToBody('This modification performed by USER and Date  :' + UserId + ' ' + Format(Today) + '<BR><BR>');
                EmailMsg.AppendToBody('Regards' + ',' + '<BR>' + 'Sampoorna Feeds Pvt. Ltd.' + '<BR><BR>');
                EmailMsg.AppendToBody('This is system generated mail. Please do not reply.<BR><BR>');
                EmailMsg.SetBodyHTMLFormatted(true);
                EmailCu.OpenInEditor(EmailMsg, EmailScenario::Default);
            end;

        }
        modify("Currency Code")
        {
            Editable = PageEditable;
        }
        modify("Language Code")
        {
            Editable = PageEditable;
        }
        modify("ARN No.")
        {
            Editable = true;
        }
        modify(General)
        {
            Editable = PageEditable;
        }
        modify("E-Mail")
        {
            ShowMandatory = true;
        }
        modify("State Code")
        {
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
                    //rec.Validate("No.", Item."No.");
                end;

            End;

        }
        modify("Address & Contact")
        {
            Editable = PageEditable;
        }
        modify(Invoicing)
        {
            Editable = PageEditable;
        }
        modify(Payments)
        {
            Editable = PageEditable;
        }
        modify(Shipping)
        {
            Editable = PageEditable;
        }
        modify(Statistics)
        {
            Editable = PageEditable;
        }
        modify("Tax Information")
        {
            Editable = PageEditable;
        }
        modify("Name 2")
        {
            Visible = true;
        }
        movefirst(General; "No.")
        moveafter(Name; "Name 2")
        moveafter("Name 2"; "Search Name")
        modify("IC Partner Code")
        {
            Visible = false;
        }
        modify(BalanceAsVendor)
        {
            Visible = false;
        }
        modify("Balance Due (LCY)")
        {
            visible = false;
        }
        addafter("Salesperson Code")
        {
            field("Salesperson Code 2"; Rec."Salesperson Code 2")
            {
                ApplicationArea = All;
            }
            field("Salesperson Code 3"; Rec."Salesperson Code 3")
            {
                ApplicationArea = All;
            }
            field("Team Code"; Rec."Team Code")
            {
                ApplicationArea = All;

            }
            field("Team Type"; Rec."Team Type")
            {
                ApplicationArea = All;
            }
            field("Old Customer No."; Rec."Old Customer No.")
            {
                ApplicationArea = all;
                Visible = false;
            }

            field("KFC Customer"; Rec."KFC Customer")
            {
                ApplicationArea = All;
                Visible = StarVisible;
            }
            field("Type of Customer"; Rec."Type of Customer")
            {
                ApplicationArea = All;
                Visible = StarVisible;
            }
            field("Activate Credit Days Limit"; rec."Activate Credit Days Limit")
            {
                ApplicationArea = All;
                Visible = StarVisible;
            }


        }
        moveafter("Responsibility Center"; Blocked)
        addafter(Blocked)
        {
            field("Outstanding SMS"; Rec."Outstanding SMS")
            {
                ApplicationArea = All;
            }
            field("Payment SMS"; Rec."Payment SMS")
            {
                ApplicationArea = all;
            }
            field("Dispatch SMS"; Rec."Dispatch SMS")
            {
                ApplicationArea = all;
            }
            field("WhatsApp SMS"; Rec."WhatsApp SMS")
            {
                ApplicationArea = all;
            }
            field("Sales Person Payment SMS"; Rec."Sales Person Payment SMS")
            {
                ApplicationArea = all;
            }
            field("Mobile App Enable"; Rec."Mobile App Enable")
            {
                ApplicationArea = all;
            }



        }

        moveafter("Outstanding SMS"; "Privacy Blocked")
        moveafter("Privacy Blocked"; "Last Date Modified")
        addafter("Last Date Modified")
        {
            field("Farmer Location"; Rec."Farmer Location")
            {
                ApplicationArea = All;

            }
            field("Customer Type"; Rec."Customer Type")
            {
                ApplicationArea = All;

            }
            field("Customer Status"; Rec."Customer Status")
            {
                ApplicationArea = All;

            }
            field(Status; rec.Status)
            {
                ApplicationArea = all;
            }
            field("Freight Term"; Rec."Freight Term")
            {
                ApplicationArea = All;

            }
            field("Broker Code"; Rec."Broker Code")
            {
                ApplicationArea = All;

            }
            field("TCS Sec 206"; Rec."TCS Sec 206")
            {
                ApplicationArea = All;

            }
            field("CDS Credit Limit"; rec."CDS Credit Limit")
            {
                ApplicationArea = All;
            }
            field("Net Change"; rec."Net Change")
            {
                ApplicationArea = All;
            }
            field("Remaining Credit Limit"; Rec."Remaining Credit Limit")
            {
                ApplicationArea = All;
            }
            field("Created From Web"; Rec."Created From Web")
            {
                ApplicationArea = All;
                Editable = True;
            }
            field("Customer Location"; Rec."Customer Location")
            {
                ApplicationArea = All;
                Visible = SFPLVisible;
            }

        }
        //>>communication
        modify("Fax No.")
        {
            Visible = False;
        }

        moveafter("Home Page"; "IC Partner Code")
        moveafter("IC Partner Code"; "Document Sending Profile")
        //.>>invoicing

        modify("EORI Number")
        {
            Visible = false;
        }
        modify("Use GLN in Electronic Document")
        {
            Visible = false;
        }
        modify("Tax Liable")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        moveafter(GLN; "Invoice Disc. Code")
        moveafter("Invoice Disc. Code"; "Copy Sell-to Addr. to Qte From")

        moveafter("Prices Including VAT"; "Prepayment %")
        //>>>prepayment
        modify("Intrastat Partner Type")
        {
            Visible = false;
        }
        //>>shipping
        modify("Ship-to Code")
        {
            Visible = false;
        }
        addafter(Shipping)
        {
            group("Foreign Trade")
            {

            }
        }
        movefirst("Foreign Trade"; "Currency Code")
        moveafter("Currency Code"; "Language Code")
        //>>tax info
        modify("Assessee Code")
        {
            Visible = false;
        }
        movefirst("Tax Information"; "Tax Liable")
        moveafter("PAN Details"; GST)
        addafter("ARN No.")
        {
            field("TAN No."; Rec."TAN No.")
            {
                ApplicationArea = all;
            }
            field("GST Name"; Rec."GST Name")
            {
                Editable = false;
                ApplicationArea = All;

            }
            field("GST Address"; Rec."GST Address")
            {
                Editable = false;
                ApplicationArea = All;

            }
            field("GST Address 2"; Rec."GST Address 2")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("GST Post Code"; Rec."GST Post Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("GST State Code"; Rec."GST State Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("GST Status"; Rec."GST Status")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Last Updated Date"; rec."Last Updated Date")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("PAN Link Status"; rec."PAN Link Status")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Pan No. is linked with Adhar card or not, if Status is activate mean PAN card is Linked with Adhar Card';
            }

        }
        addafter("P.A.N. Reference No.")
        {
            field("Aadhar No."; Rec."Aadhar No.")
            {
                ApplicationArea = All;

            }
            field("API aadhaar Seeding Status"; Rec."API aadhaar Seeding Status")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("API pan_type"; rec."API pan_type")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("API Full Name"; rec."API Full Name")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("API DOB"; rec."API DOB")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }

        modify("GST customer Type")
        {
            Editable = PageEditable;
            trigger OnAfterValidate()
            begin
                EComerceOperator;
            end;
        }
        modify("GST Registration Type")
        {
            Editable = PageEditable;
            trigger OnAfterValidate()
            begin
                EComerceOperator;
            end;
        }

        modify(GST)
        {
            Editable = PageEditable;
        }

        modify("GST Registration No.")
        {
            Editable = PageEditable;
            trigger OnAfterValidate()
            var

                UpdateGSTDetailsFromPortal: Codeunit 50023;

            begin
                EComerceOperator;
                UpdateGSTDetailsFromPortal.UpdateCustomer(Rec."No.", Rec."GST Registration No.", "GST Status", "Last Updated Date", "GST Name", "GST Address", "GST Address 2", "GST State Code", "GST Post Code", FALSE);
            end;
        }
        addafter("Aggregate Turnover")
        {
            field("Payment QR"; Rec.PaymentQR)
            {
                ApplicationArea = all;

            }
        }
    }
    actions
    {
        addafter(Contact)
        {

            action("Create Vendor")
            {
                ApplicationArea = All;
                Image = Customer;
                Promoted = true;
                trigger OnAction()
                var
                    Vendor: Record Vendor;
                    NewCustomerNo: Code[20];
                    NoSeriesMgt: Codeunit NoSeriesManagement;
                    PurchuerSetup: Record "Purchases & Payables Setup";
                begin
                    PurchuerSetup.GET();
                    Vendor.Reset();
                    Vendor.SetRange("Created From Customer No.", Rec."No.");
                    if NOT Vendor.FindFirst() then BEGIN
                        Vendor.Init();
                        Vendor.Validate("No.", NoSeriesMgt.GetNextNo(PurchuerSetup."Vendor Nos.", Today, true));
                        Vendor.Validate(Name, Rec.Name);
                        Vendor.Validate(Address, REC.Address);
                        Vendor.Validate("Address 2", Rec."Address 2");
                        Vendor.Validate(City, rEC.City);
                        Vendor.Validate("Country/Region Code", Rec."Country/Region Code");
                        Vendor.Validate("Post Code", Rec."Post Code");
                        Vendor.Validate("Phone No.", Rec."Phone No.");
                        Vendor.Validate("E-Mail", Rec."E-Mail");
                        Vendor.Validate("Payment Terms Code", Rec."Payment Terms Code");
                        Vendor.Validate("P.A.N. Status", Rec."P.A.N. Status");
                        Vendor.Validate("P.A.N. No.", Rec."P.A.N. No.");
                        Vendor.Validate("P.A.N. Reference No.", Rec."P.A.N. Reference No.");
                        Vendor.Validate("Aadhar No.", Rec."Aadhar No.");
                        Vendor.Validate("TAN No.", Rec."TAN No.");
                        Vendor.Validate("State Code", Rec."State Code");
                        Vendor."GST Name" := Rec."GST Name";
                        Vendor."Created From Customer No." := Rec."No.";
                        Vendor."GST Address" := Vendor."GST Address";
                        Vendor."GST Address 2" := Vendor."GST Address 2";
                        Vendor."GST Post Code" := Vendor."GST Post Code";
                        Vendor."GST State Code" := Vendor."GST State Code";
                        Vendor."GST Status" := Vendor."GST Status";
                        Vendor."Last Updated Date" := Rec."Last Updated Date";
                        Vendor."Gen. Bus. Posting Group" := Rec."Gen. Bus. Posting Group";
                        Vendor."Vendor Posting Group" := Rec."Customer Posting Group";
                        //Vendor."Aggregate Turnover" := Rec."Aggregate Turnover";
                        IF Rec."GST Registration No." <> '' THEN begin
                            Vendor."GST Vendor Type" := Vendor."GST Vendor Type"::Registered;
                            Vendor."GST Registration No." := Rec."GST Registration No.";
                            //Vendor.gst re := Vendor."GST Registration Type"::GSTIN;
                        end;
                        Vendor."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                        Vendor."Global Dimension 2 Code" := rEC."Global Dimension 2 Code";
                        Vendor."Responsibility Center" := Rec."Responsibility Center";
                        Vendor."Location Code" := Rec."Location Code";
                        //Vendor.Validate("GST Customer Type",Rec."GST Vendor Type");
                        Vendor.Insert();
                        Message('%1,%2', 'Vendor Created for This Customer New Vendor No Is:', Vendor."No.");
                    end
                    ELSE
                        Message('Vendor already Created For this Customer');
                end;
            }

        }
        addafter("&Customer")
        {
            action(Reopen)
            {
                ApplicationArea = All;
                Caption = 'Reopen';
                Image = ReOpen;
                Promoted = true;
                Enabled = Not OpenApprovalEntriesExist;

                trigger OnAction()
                var
                // BaseCodeunit: Codeunit BaseModificationCodeunitt;
                begin
                    //PRU_NEELESH
                    //If not BaseCodeunit.CheckCustomerApprovalsWorkflowEnabled(Rec) Then begin
                    If Rec.Status = Rec.Status::Approved Then begin
                        Rec.Status := Rec.Status::Open;
                        Rec.MODIFY;
                        //end;

                    end;
                    //   CurrPage.Update();
                    //PRU_NEELESH
                end;
            }
            action(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                Promoted = true;
                ApplicationArea = All;
                Enabled = (Not OpenApprovalEntriesExist);
                trigger OnAction()
                var
                    T_1501: Record 1501;
                    BaseCodeunit: Codeunit "Approval Management Custom";
                begin
                    //PRU_NEELESH
                    If not BaseCodeunit.CheckCustomerApprovalsWorkflowEnabled(Rec) Then begin
                        Rec.Status := Rec.Status::Approved;
                        Rec.MODIFY;
                        CurrPage.Update();
                    end Else
                        Message('Approval Workflow is enabled, Please send for approval');
                END;
                //PRU_NEELESH

            }
            action(AgedAccReceivable)
            {
                Caption = 'AgedAccReceivable';
                Image = Report;
                Promoted = true;
                ApplicationArea = All;
                RunObject = report "Aged Accounts Receivable";
            }

            group(IncomingDocument)
            {
                Caption = 'Incoming Document';
                Image = Documents;
                action(IncomingDocCard)
                {
                    ApplicationArea = All;
                    Caption = 'View Incoming Document';
                    Enabled = true;
                    Image = ViewOrder;
                    Visible = true;
                    //The property 'ToolTip' cannot be empty.
                    //ToolTip = '';

                    trigger OnAction()
                    var
                        IncomingDocument: Record 130;
                    begin
                        ShowCardFromEntryNo(Rec."Incoming Document Entry No.");
                    end;
                }
                action(SelectIncomingDoc)
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData 130 = R;
                    Caption = 'Select Incoming Document';
                    Image = SelectLineToApply;
                    //The property 'ToolTip' cannot be empty.
                    //ToolTip = '';
                    Visible = false;

                    trigger OnAction()
                    var
                        IncomingDocument: Record 130;
                    begin
                        //                        VALIDATE("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument("Incoming Document Entry No."));
                    end;
                }
                action(IncomingDocAttachFile)
                {
                    ApplicationArea = All;
                    Caption = 'Create Incoming Document from File';
                    Ellipsis = true;
                    Enabled = NOT HasIncomingDocument;
                    Image = Attach;
                    //The property 'ToolTip' cannot be empty.
                    //ToolTip = '';
                    Visible = false;
                    trigger OnAction()
                    var
                        IncomingDocumentAttachment: Record 133;
                    begin
                        //                      IncomingDocumentAttachment.NewAttachmentFromCustomerDocument(Rec);
                    end;
                }
                action(RemoveIncomingDoc)
                {
                    ApplicationArea = All;
                    Caption = 'Remove Incoming Document';
                    Enabled = HasIncomingDocument;
                    Image = RemoveLine;
                    //The property 'ToolTip' cannot be empty.
                    //ToolTip = '';
                    Visible = false;
                    trigger OnAction()
                    begin
                        Rec."Incoming Document Entry No." := 0;
                    end;
                }

            }
        }
        modify(Approve)
        {
            trigger OnBeforeAction()
            var
                UserSetup: Record "User Setup";
            begin
                //PRU_DD 1.10
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Customer Master", '%1', UserSetup."Access Customer Master"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You can not approve the customer');
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
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                T_18: Record 18;
            begin
                IF Rec.Status = Rec.Status::Approved THEN
                    ERROR('Customer is already approved');
                //PRU_NEELESH
                IF T_18.GET(Rec."No.") THEN BEGIN
                    IF T_18.Status <> T_18.Status::Approved THEN BEGIN
                        T_18.Status := T_18.Status::"Pending Approval";
                        T_18.MODIFY;
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
    trigger OnOpenPage()
    begin
        CompanyInfo.Get;
        UserSetup.Get(UserId);
        StarVisible := False;
        SFPLVisible := True;
        IF Rec.Status = Rec.Status::Open THEN begin
            // CurrPage.Editable(true);
            PageEditable := true;
        end ELSE
            //  CurrPage.Editable(false);
            PageEditable := false;


        IF Rec."GST Customer Type" = Rec."GST Customer Type"::Registered THEN
            EcomEditable := TRUE
        ELSE BEGIN
            EcomEditable := FALSE;
            Rec."e-Commerce Operator" := FALSE;
        END;
        if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::"Star Foods"] then begin
            StarVisible := True;
            SFPLVisible := False;

        end;
        DisableOnFeedPlant := True;
        if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then begin
            if UserSetup."User ID" <> 'JOBQUEUE' then
                if UserSetup."User Type" = UserSetup."User Type"::"Feed Plant" then
                    DisableOnFeedPlant := False;

        end;

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Customer Master", '%1', UserSetup."Access Customer Master"::View);
        IF UserSetup.FINDFIRST THEN
            if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::"Star Foods"] then
                CurrPage.Editable(false)
    end;



    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        IF Rec.Status = Rec.Status::Open THEN begin
            // CurrPage.Editable(true);
            PageEditable := true;
        end ELSE
            // CurrPage.Editable(false);
            PageEditable := false;
        //PRU_NEELESH
        CompanyInfo.get;
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Customer Master", '%1', UserSetup."Access Customer Master"::View);
        IF UserSetup.FINDFIRST THEN
            if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::"Star Foods"] then
                CurrPage.Editable(false)
    end;



    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
        //PRU_NEELESH
        IF Rec.Status = Rec.Status::Open THEN begin
            // CurrPage.Editable(true);
            PageEditable := true;
        end ELSE
            //     CurrPage.Editable(false);
            PageEditable := false;
        //PRU_NEELESH


        IF Rec."GST Customer Type" = Rec."GST Customer Type"::Registered THEN
            EcomEditable := TRUE
        ELSE BEGIN
            EcomEditable := FALSE;
            Rec."e-Commerce Operator" := FALSE;
        END;
    end;

    trigger OnClosePage()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        T_18: Record 18;
    begin

        // IF Rec.Status = Rec.Status::Open THEN
        //     //PRU_NEELESH
        //     // IF ApprovalsMgmt.CheckCustomerApprovalsWorkflowEnabled(Rec) THEN
        //     //     ApprovalsMgmt.OnSendCustomerForApproval(Rec);
        //     //PRU_NEELESH
        //     IF T_18.GET(Rec."No.") THEN BEGIN
        //         IF T_18.Status <> T_18.Status::Approved THEN BEGIN
        //             T_18.Status := T_18.Status::"Pending Approval";
        //             T_18.MODIFY;
        //         END;
        //     END;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Customer Master", '%1', UserSetup."Access Customer Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Delete Customer');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Customer Master", '%1', UserSetup."Access Customer Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Customer Master", '%1', UserSetup."Access Customer Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change Customer Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Customer Master", '%1', UserSetup."Access Customer Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10

        //TRI A.S 19.09.13 START
        Rec.FILTERGROUP(2);
        userset.GET(USERID);
        userset.TESTFIELD("Responsibility Center");
        IF NOT userset."HO Users" THEN BEGIN
            Rec.SETFILTER("Responsibility Center", '%1|%2', userset."Responsibility Center", '');
            IF userset."Short Close on Prod. Order" THEN
                //Rec.SETRANGE("Salesperson Code", USERID);
            Rec.FILTERGROUP(0);
        END;

        //TRI A.S 19.09.13 STOP


        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Customer Master", '%1', UserSetup."Access Customer Master"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Customer Master');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Customer Master", '%1', UserSetup."Access Customer Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        //PRU_NEELESH
        IF Rec.Status = Rec.Status::Open THEN
            EDITN := TRUE
        ELSE
            EDITN := FALSE;
        //PRU_NEELESH

        IF ((USERID <> 'SAM8') AND (USERID <> 'SAM963')) THEN
            Visible := FALSE
        ELSE
            Visible := TRUE;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        CompanyInfo.Get;
        IF Rec."No." <> '' THEN BEGIN
            Rec.TESTFIELD("P.A.N. No.");//PRU-VG1.0
            If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                Rec.TESTFIELD("Aadhar No.");//PRU-VG1.0
        END;


    end;

    local procedure EComerceOperator()
    begin
        IF Rec."GST Customer Type" = Rec."GST Customer Type"::Registered THEN
            EcomEditable := TRUE
        ELSE BEGIN
            EcomEditable := FALSE;
            Rec."e-Commerce Operator" := FALSE;
        END;
    end;


    procedure PanNoError()
    var
        T_18: Record 18;
        GeneralLedgerSetup: Record 98;
    begin
        IF (Rec."P.A.N. No." <> '') THEN BEGIN
            GeneralLedgerSetup.GET;
            // IF (GeneralLedgerSetup."Stop Blocked Dupl. PAN No." = TRUE) AND ("Responsibility Center" = 'CBF')THEN BEGIN  //PRU_KH_PANERR1.4_28022020
            IF (GeneralLedgerSetup."Stop Blocked Dupl. PAN No." = TRUE) THEN BEGIN  //PRU_KH_PANERR1.4_28022020
                T_18.RESET;
                T_18.SETRANGE(Blocked, T_18.Blocked::All);
                T_18.SETRANGE("P.A.N. No.", Rec."P.A.N. No.");
                IF T_18.FINDFIRST THEN BEGIN
                    //Address := ''; //Pru_ab
                    //Name := ''; //Pru_ab
                    //-->Pru_ab
                    Rec.Name := '';
                    Rec.Address := '';
                    Rec."Address 2" := '';
                    Rec."P.A.N. No." := '';
                    Rec."Search Name" := '';
                    Rec.MODIFY;
                    CurrPage.UPDATE(TRUE);
                    COMMIT;
                    //<--Pru_ab
                    //ERROR('P.A.N. No. %1 is already used in Vendor No. %2 & Vendor is blocked',"P.A.N. No.",T_23."No.");
                    MESSAGE('P.A.N. No. %1 is already used in Vendor No. %2 & Vendor is blocked', Rec."P.A.N. No.", T_18."No.");
                END;
            END;
        END;
        CurrPage.UPDATE(TRUE);
    end;

    local procedure UpdateColour()
    begin

        IF Rec."Customer Status" = Rec."Customer Status"::"Suit Filed Cases" THEN
            ColourCondition := TRUE
        ELSE
            ColourCondition := FALSE;
    end;

    procedure ShowCardFromEntryNo(EntryNo: Integer)
    var
        IncomRec: Record "Incoming Document";
    begin
        IF EntryNo = 0 THEN
            EXIT;
        IncomRec.GET(EntryNo);
        IncomRec.SETRECFILTER;
        PAGE.RUN(PAGE::"Incoming Documents", IncomRec);
    end;

    procedure SetControlAppearance()
    begin
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        //SetExtDocNoMandatoryCondition;
    end;


    procedure SetDocNoVisible()
    begin
        //DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::Invoice,"No.");
    end;


    procedure SetExtDocNoMandatoryCondition()
    begin
        // PurchasesPayablesSetup.GET;
        // VendorInvoiceNoMandatory := PurchasesPayablesSetup."Ext. Doc. No. Mandatory"
    end;

    var
        myInt: Integer;
        HasIncomingDocument: Boolean;
        userset: Record 91;
        UserSetup: Record 91;
        EcomEditable: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EDITN: Boolean;
        ColourCondition: Boolean;
        StyleTxt: Boolean;
        //   NODNOCHeader: Record Nod
        Visible: Boolean;
        T_18: Record 18;
        FieldVisible: Boolean;
        // NODNOCList: Page "NOD/NOC List";
        PageEditable: Boolean;
        CompanyInfo: Record "Company Information";
        StarVisible: Boolean;
        SFPLVisible: Boolean;
        DisableOnFeedPlant: Boolean;
}