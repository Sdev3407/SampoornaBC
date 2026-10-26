pageextension 50142 VendorCardEx extends "Vendor Card"
{
    layout
    {
        modify("GST Registration No.")
        {
            trigger OnAfterValidate()
            var

                UpdateGSTDetailsFromPortal: Codeunit 50023;
            begin
                UpdateGSTDetailsFromPortal.UpdateVendor("No.", Rec."GST Registration No.", "GST Status", "Last Updated Date", "GST Name", "GST Address", "GST Address 2", "GST State Code", "GST Post Code", "Last Updated Date");
            end;
        }

        modify(General)
        {
            Editable = EDITN;
        }
        modify("Address & Contact")
        {
            Editable = EDITN;
        }
        modify(Invoicing)
        {
            Editable = EDITN;
        }
        modify(Payments)
        {
            Editable = EDITN;
        }
        modify(Receiving)
        {
            Editable = EDITN;
        }
        modify("Tax Information")
        {
            Editable = EDITN;
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


        addbefore("Attached Documents")
        {
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = All;
                Caption = 'IncomingDocAttachFactBox';
                ShowFilter = false;
            }
        }
        modify("Name 2")
        {
            Visible = true;
        }
        moveafter(Name; "Name 2")
        modify("IC Partner Code")
        {
            Visible = false;
        }
        moveafter("Search Name"; "Balance (LCY)")
        moveafter("Purchaser Code"; "Responsibility Center")
        moveafter("Responsibility Center"; Blocked)
        moveafter(Blocked; "Last Date Modified")
        moveafter("Last Date Modified"; Transporter)
        addafter(Transporter)
        {
            field(Farmer; Rec.Farmer)
            {
                ApplicationArea = All;

            }
            field(Broker; Rec.Broker)
            {
                ApplicationArea = All;
                Visible = true;
            }
            field(MSME; Rec.MSME)
            {
                ApplicationArea = All;

            }
            field("Created From Web"; Rec."Created From Web")
            {
                ApplicationArea = All;
                Editable = true;
            }
            field("Type of Enterprise"; Rec."Type of Enterprise")
            {
                ApplicationArea = All;

            }
            field("Constitution of Business"; Rec."Constitution of Business")
            {
                ApplicationArea = All;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = All;

            }

            field("Creditors Type"; Rec."Creditors Type")
            {
                ApplicationArea = All;

            }
            field("TDS 194Q"; Rec."TDS 194Q")
            {
                ApplicationArea = All;

            }
            field("Old Vendor No."; Rec."Old Vendor No.")
            {
                ApplicationArea = all;
            }
            field("Transporter ID"; Rec."Transporter ID")
            {
                ApplicationArea = all;
            }
        }
        modify(MobilePhoneNo)
        {
            Visible = false;
        }
        moveafter("Fax No."; "E-Mail")
        moveafter("Home Page"; "IC Partner Code")
        //>>
        movefirst(Invoicing; "Pay-to Vendor No.")
        moveafter("Pay-to Vendor No."; "VAT Registration No.")
        modify("Tax Area Code")
        {
            Visible = false;
        }
        moveafter("Vendor Posting Group"; "Invoice Disc. Code")
        moveafter("Invoice Disc. Code"; "Prices Including VAT")
        moveafter("Prices Including VAT"; "Prepayment %")
        ////>>>Payment
        moveafter("Application Method"; "Partner Type")
        moveafter(Priority; "Cash Flow Payment Terms Code")
        moveafter("Cash Flow Payment Terms Code"; "Our Account No.")
        moveafter("Our Account No."; "Block Payment Tolerance")
        moveafter("Block Payment Tolerance"; "Creditor No.")
        moveafter("Creditor No."; "Preferred Bank Account Code")
        //>>receiving
        modify("Over-Receipt Code")
        {
            Visible = false;
        }

        //tax information
        addafter("P.A.N. Reference No.")
        {
            field("Aadhar No."; rec."Aadhar No.")
            {
                ApplicationArea = all;
            }
            field("TAN No."; Rec."TAN No.")
            { ApplicationArea = all; }
            field("API aadhaar Seeding Status"; Rec."API aadhaar Seeding Status")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("API Pan Type"; rec."API PAN Type")
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
        moveafter("PAN Details"; Subcontractor)
        addafter("ARN No.")
        {
            field("PAN Link Status"; rec."PAN Link Status")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Pan No. is linked with Adhar card or not, if Status is activate mean PAN card is Linked with Adhar Card';
            }
            field("GST Name"; rec."GST Name")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("GST Address"; rec."GST Address")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("GST Address 2"; rec."GST Address 2")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("GST Post Code"; rec."GST Post Code")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("GST State Code"; rec."GST State Code")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("GST Status"; rec."GST Status")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("Last Updated Date"; rec."Last Updated Date")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("SFPL_POS as Vendor State"; Rec."SFPL_POS as Vendor State")
            {
                ApplicationArea = all;
                Caption = 'POS as Vendor State';
            }
        }
        //.>>foreign trade

    }

    actions
    {
        addlast(Documents)
        {
            action(Release)
            {
                ApplicationArea = All;
                Caption = 'Release';
                Image = ReleaseDoc;
                Promoted = true;
                Enabled = (Not OpenApprovalEntriesExist);

                trigger OnAction()
                var
                    BaseCodeunit: Codeunit "Approval Management Custom";
                begin
                    //PRU_NEELESH

                    IF not BaseCodeunit.CheckVendorApprovalsWorkflowEnabled(Rec) THEN begin
                        Rec.Status := Rec.Status::Approved;
                        Rec.MODIFY;
                    END else
                        Message('Approval Workflow is enabled, Please send for approval');
                END;
                //PRU_NEELESH

            }
        }
        // Add changes to page actions here
        addafter("Ven&dor")
        {

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
            }

        }
        addlast(Documents)
        {
            action(Reopen)
            {
                Caption = 'Reopen';
                Image = ReOpen;
                Promoted = true;
                ApplicationArea = All;
                Enabled = (Not OpenApprovalEntriesExist);
                trigger OnAction()
                begin
                    //PRU_NEELESH
                    Rec.Status := Rec.Status::Open;
                    Rec.MODIFY;
                    //PRU_NEELESH
                end;


                //PRU_NEELESH

            }

        }

        modify(Approve)
        {
            trigger OnBeforeAction()
            begin
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Vendor Master", '%1', UserSetup."Access Vendor Master"::Create);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You can not approve new Vendor');
                UserSetup.RESET;
                UserSetup.SETRANGE("User ID", USERID);
                UserSetup.SETFILTER(UserSetup."Access Vendor Master", '%1', UserSetup."Access Vendor Master"::View);
                IF UserSetup.FINDFIRST THEN
                    ERROR('You can not approve new Vendor');
            end;

            trigger OnAfterAction()
            var
                myInt: Integer;
            begin
                Rec.Status := Rec.Status::Approved;
                Rec.Modify()
            end;
        }
        modify(Reject)
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
            begin
                Rec.Status := Rec.Status::Open;
                Rec.Modify();
            end;
        }
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                T_23: Record 23;
            begin
                /*IF ApprovalsMgmt.CheckVendorApprovalsWorkflowEnabled(Rec) THEN
                  ApprovalsMgmt.OnSendVendorForApproval(Rec);*/
                //PRU_NEELESH
                IF Rec.Status = Rec.Status::Approved THEN
                    ERROR('Vendor is already approved');
                //PRU_NEELESH

                //PRU_NEELESH
                IF T_23.GET(Rec."No.") THEN BEGIN
                    IF T_23.Status <> T_23.Status::Approved THEN BEGIN
                        T_23.Status := T_23.Status::"Pending Approval";
                        T_23.MODIFY;
                    END;
                END;


                //PRU_NEELESH
            end;
        }
        modify(CancelApprovalRequest)
        {
            trigger OnAfterAction()
            begin
                //PRU_NEELESH
                Rec.Status := Rec.Status::Open;
                Rec.MODIFY;
                //PRU_NEELESH
            end;
        }
        addafter("Vendor - Balance to Date")
        {

            action("Vendor Statement New_SFPL")
            {
                ApplicationArea = All;
                Caption = 'Vendor Statement New_SFPL';
                Image = "Report";

                trigger OnAction()
                var
                    VendorRec: Record 23;
                begin
                    VendorRec.RESET;
                    VendorRec.SETRANGE("No.", Rec."No.");
                    IF VendorRec.FINDFIRST THEN
                        REPORT.RUNMODAL(50147, TRUE, TRUE, VendorRec);
                end;
            }

            action("Send Email(Vendor Statement)")
            {
                ApplicationArea = All;
                Image = SendAsPDF;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CLEAR(VLEAccountStatement);
                    VLEAccountStatement.SavePDF(TRUE);
                    VLEAccountStatement.RUN;
                end;
            }
            action("Save PDF(Vendor Statement)")
            {
                ApplicationArea = All;
                Image = PreviewChecks;

                trigger OnAction()
                begin
                    CLEAR(VLEAccountStatement);
                    VLEAccountStatement.SetReportPreview(TRUE);
                    VLEAccountStatement.RUN;
                end;
            }

            action("Send Email(Balance Confirmation)")
            {
                ApplicationArea = All;
                Image = SendAsPDF;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CLEAR(BalanceConfirmation_Vendor);
                    BalanceConfirmation_Vendor.SendEmailAsPdf(TRUE);
                    BalanceConfirmation_Vendor.RUN;
                end;
            }
        }
        addafter("TDS Concessional Codes")
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
                begin
                    SalesSetup.GET();
                    //NewCustomerNo := NoSeriesMgt.GetNextNo(SalesSetup."Customer Nos.", Today, true);
                    Customer.Reset();
                    Customer.SetRange("Created From Vendor No.", Rec."No.");
                    if NOT Customer.FindFirst() then BEGIN
                        Customer.Init();
                        Customer.Validate("No.", NoSeriesMgt.GetNextNo(SalesSetup."Customer Nos.", Today, true));
                        Customer.Validate(Name, Rec.Name);
                        Customer.Validate(Address, REC.Address);
                        Customer.Validate("Address 2", Rec."Address 2");
                        Customer.Validate(City, rEC.City);
                        Customer.Validate("Country/Region Code", Rec."Country/Region Code");
                        Customer.Validate("Post Code", Rec."Post Code");
                        Customer.Validate("Phone No.", Rec."Phone No.");
                        Customer.Validate("E-Mail", Rec."E-Mail");
                        Customer.Validate("Payment Terms Code", Rec."Payment Terms Code");
                        Customer.Validate("P.A.N. Status", Rec."P.A.N. Status");
                        Customer.Validate("P.A.N. No.", Rec."P.A.N. No.");
                        Customer.Validate("P.A.N. Reference No.", Rec."P.A.N. Reference No.");
                        Customer.Validate("Aadhar No.", Rec."Aadhar No.");
                        Customer.Validate("TAN No.", Rec."TAN No.");
                        Customer."GST Name" := Rec."GST Name";
                        Customer."Created From Vendor No." := Rec."No.";
                        Customer."GST Address" := Customer."GST Address";
                        Customer."GST Address 2" := Customer."GST Address 2";
                        Customer."GST Post Code" := Customer."GST Post Code";
                        Customer."GST State Code" := Customer."GST State Code";
                        Customer."GST Status" := Customer."GST Status";
                        Customer."Last Updated Date" := Rec."Last Updated Date";
                        Customer."Gen. Bus. Posting Group" := Rec."Gen. Bus. Posting Group";
                        Customer."Customer Posting Group" := Rec."Vendor Posting Group";
                        //Customer."Aggregate Turnover" := Rec."Aggregate Turnover";
                        IF Rec."GST Registration No." <> '' THEN begin
                            Customer."GST Customer Type" := Customer."GST Customer Type"::Registered;
                            Customer."GST Registration No." := Rec."GST Registration No.";
                            Customer."GST Registration Type" := Customer."GST Registration Type"::GSTIN;
                        end;
                        Customer."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                        Customer."Global Dimension 2 Code" := rEC."Global Dimension 2 Code";
                        Customer."Responsibility Center" := Rec."Responsibility Center";
                        Customer."Location Code" := Rec."Location Code";
                        //Customer.Validate("GST Customer Type",Rec."GST Vendor Type");
                        Customer.Insert();
                        Message('%1,%2', 'Customer Created for This vendor New Customer No Is:', Customer."No.");
                    end
                    ELSE
                        Message('Customer already Created For this Vendor');
                end;
            }
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
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);

    end;


    trigger OnAfterGetRecord()
    begin
        ActivateFields;
        SetControlAppearance;
        // PRU_AS - 12 NOV 2019 - START
        IF Rec."Type of Enterprise" = Rec."Type of Enterprise"::" " THEN BEGIN
            MSMEEditable := FALSE;
            Rec.MSME := '';
        END;

        IF Rec."Type of Enterprise" <> Rec."Type of Enterprise"::" " THEN BEGIN
            MSMEEditable := TRUE;
        END;
        // PRU_AS - 12 NOV 2019 - END
        //PRU_NEELESH
        IF Rec.Status = Rec.Status::Open THEN
            EDITN := TRUE
        ELSE
            EDITN := FALSE;
        //PRU_NEELESH
    end;

    trigger OnClosePage()
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Vendor Master", '%1', UserSetup."Access Vendor Master"::Create);
        IF UserSetup.FINDFIRST THEN BEGIN
            IF Rec.MSME = '' THEN
                MESSAGE('Please Check the MSEME');
        END;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Vendor Master", '%1', UserSetup."Access Vendor Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Delete Vendor');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Vendor Master", '%1', UserSetup."Access Vendor Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Vendor Master", '%1', UserSetup."Access Vendor Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to Change Vendor Details');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Vendor Master", '%1', UserSetup."Access Vendor Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    var
        MapMgt: Codeunit 802;
    begin
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
        UserSetup.SETFILTER(UserSetup."Access Vendor Master", '%1', UserSetup."Access Vendor Master"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Vendor Card');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Vendor Master", '%1', UserSetup."Access Vendor Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        //PRU_NEELESH
        IF Rec.Status = Rec.Status::Open THEN
            EDITN := TRUE
        ELSE
            EDITN := FALSE;


        //PRU_NEELESH
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        p_gText: Text[30];
        p_gText1: Text[30];
        p_gText2: Text[30];
        p_gTextG: Text[30];
        p_gTextG1: Text[30];
        p_gTextG2: Text[30];
        p_gTextG3: Text[30];
        p_gTextG4: Text[30];
        p_gTextG5: Text[30];
        p_gTextG6: Text[30];

        Text50000: Label 'P.A.N. no. should not be less then 10 characters.';
    begin
        CompanyInfo.Get;
        IF Rec."No." <> '' THEN BEGIN
            If CompanyInfo.SFPLCompany = CompanyInfo.SFPLCompany::Sampoorna then
                Rec.TESTFIELD("Aadhar No.");//PRU-VG1.0
            Rec.TESTFIELD("P.A.N. No.");//PRU-VG1.0
            Rec.TestField("GST Vendor Type");//Suman 15-12-2023
        END;

    end;

    local procedure ActivateFields()
    begin
        // SetSocialListeningFactboxVisibility;
        //ContactEditable := "Primary Contact No." = '';
        //"P.A.N. No.Editable" := "P.A.N. Status" = 0;
    end;

    local procedure PanNoError()
    var
        T_23: Record 23;
        GeneralLedgerSetup: Record 98;
    begin
        IF (Rec."P.A.N. No." <> '') THEN BEGIN
            GeneralLedgerSetup.GET;
            //  IF (GeneralLedgerSetup."Stop Blocked Dupl. PAN No." = TRUE) AND ("Responsibility Center" = 'CBF')THEN BEGIN  //PRU_KH_PANERR1.4_28022020
            IF (GeneralLedgerSetup."Stop Blocked Dupl. PAN No." = TRUE) THEN BEGIN  //PRU_KH_PANERR1.4_28022020
                T_23.RESET;
                T_23.SETRANGE(Blocked, T_23.Blocked::All);
                T_23.SETRANGE("P.A.N. No.", Rec."P.A.N. No.");
                IF T_23.FINDFIRST THEN BEGIN
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
                    MESSAGE('P.A.N. No. %1 is already used in Vendor No. %2 & Vendor is blocked', Rec."P.A.N. No.", T_23."No.");
                END;
            END;
        END;
        CurrPage.UPDATE(TRUE);
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

    var
        OpenApprovalEntriesExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        myInt: Integer;
        UserSetup: Record 91;
        MSMEEditable: Boolean;
        EDITN: Boolean;
        HasIncomingDocument: Boolean;

        Vendor: Record 23;
        VLEAccountStatement: Report 50015;
        BalanceConfirmation_Vendor: Report 50031;
        CompanyInfo: Record "Company Information";

}