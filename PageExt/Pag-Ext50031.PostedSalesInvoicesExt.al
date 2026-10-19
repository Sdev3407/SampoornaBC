pageextension 50031 PostedSalesInvoicesExt extends "Posted Sales Invoices"
{
    layout
    {

        modify("Due Date")
        {
            Visible = false;
        }
        modify("Remaining Amount")
        {
            Visible = false;
        }
        modify(Closed)
        {
            Visible = false;
        }
        modify(Cancelled)
        {
            Visible = false;
        }
        modify(Corrective)
        {
            Visible = false;
        }
        modify(Amount)
        {
            Visible = DisableOnFeedPlant;
        }
        modify("Amount Including VAT")
        {
            Visible = DisableOnFeedPlant;
        }
        modify("Order No.")
        {
            Visible = true;
        }
        modify("External Document No.")
        {
            Visible = true;
        }
        moveafter("Currency Code"; Amount)
        moveafter(Amount; "Amount Including VAT")
        moveafter("Amount Including VAT"; "Order No.")
        addafter("Order No.")
        {
            field("Order Date"; rec."Order Date")
            {
                ApplicationArea = all;
            }
            field("Customer Price Group"; rec."Customer Price Group")
            {
                ApplicationArea = all;
                Visible = DisableOnFeedPlant;
            }
            field("LR/RR No."; rec."LR/RR No.")
            {
                ApplicationArea = all;
            }
            field("LR/RR Date"; rec."LR/RR Date")
            {
                ApplicationArea = all;
            }
            field("Transporter Code"; Rec."Transporter Code")
            {
                ApplicationArea = All;

            }
        }



        addafter("No. Printed")
        {
            field("Invoice Type"; rec."Invoice Type")
            {
                ApplicationArea = All;
            }
            field("Gross Weight"; rec."Gross Weight")
            {
                ApplicationArea = All;
            }
            field("Tier Weight"; rec."Tier Weight")
            {
                ApplicationArea = All;
            }
            field("Net Weight"; rec."Net Weight")
            {
                ApplicationArea = All;
            }
            field("Vehicle No."; rec."Vehicle No.")
            {
                ApplicationArea = All;
            }
            field("E-Invoice Status"; rec."E-Invoice Status")
            {
                ApplicationArea = All;
            }
            field("E-Invoice No."; rec."E-Invoice No.")
            {
                ApplicationArea = All;
            }
            field("E-Invoice Date"; rec."E-Invoice Date")
            {
                ApplicationArea = All;
            }
            field("E-Invoice QR Code"; rec."E-Invoice QR Code")
            {
                ApplicationArea = All;
            }
            field("E-Invoice Cancel Date"; rec."E-Invoice Cancel Date")
            {
                ApplicationArea = All;
            }
            field("E-Way Bill No."; "E-Way Bill No.")
            {
                ApplicationArea = All;
            }
            field("Payment QR Code"; rec."Payment QR Code")
            {
                ApplicationArea = All;
            }
        }


    }
    actions
    {
        addbefore(SendCustom)

        {
            action("PrintJob")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print For Job Work';
                Ellipsis = true;
                Visible = DisableOnFeedPlant;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    TrShipment: Record "Sales Invoice Header";
                begin
                    TrShipment.RESET;
                    TrShipment.SETRANGE(TrShipment."No.", Rec."No.");
                    IF TrShipment.FINDFIRST THEN BEGIN
                        REPORT.RUNMODAL(50117, TRUE, TRUE, TrShipment);
                    END;
                end;
            }
        }
        modify(Print)
        {
            Visible = DisableOnFeedPlant;
        }
        modify(Email)
        {
            Visible = DisableOnFeedPlant;
        }
        modify(SendCustom)
        {
            Visible = DisableOnFeedPlant;
        }
        modify(AttachAsPDF)
        {
            Visible = DisableOnFeedPlant;
        }

        addafter(Dimensions)
        {

        }
        addafter(IncomingDoc)
        {
            action("Generate E-Invoice No.")
            {
                Image = Interaction;
                ApplicationArea = All;
                Promoted = true;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;

                trigger OnAction()
                var
                    //cuSalesPost: Codeunit 50055;
                    cuSalesPost: Codeunit 50025;

                begin
                    CLEAR(cuSalesPost);
                    cuSalesPost.GenerateSalesEInvoice(Rec);
                end;
            }
            action("Cancel E-Invoice No.")
            {
                Image = Interaction;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                ApplicationArea = All;
                Promoted = true;

                trigger OnAction()
                var
                    //cuSalesPost: Codeunit 50055;
                    cuSalesPost: Codeunit 50025;
                begin
                    CLEAR(cuSalesPost);
                    cuSalesPost.CancelSalesEInvoice(Rec);
                end;
            }
            action("E-Invoice Checking")
            {
                Image = "Report";
                RunObject = Report 50042;
                ApplicationArea = All;
                Promoted = true;
            }
            action("Generate EWayBill")
            {
                AccessByPermission = tableData "Sales Invoice Header" = RIMD;
                Caption = 'Generate E-way Bill';
                Visible = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                Var
                    Cu50061: Codeunit 50061;
                    EwayBillDate: DateTime;
                    ValidUpto: DateTime;

                begin
                    CompanyInfo.Get;
                    If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::"Star Foods"] then
                        if Rec."Sell-to Customer No." = 'C0463' then
                            Error('E-Way Bill not applicable on Cash Customer');
                    if rec."E-Way Bill No." = '' then begin
                        Cu50061.GenerateEwayBill(Rec, Rec."E-Way Bill No.", Rec."E-Way Generated Date", ValidUpto);
                        //Rec.Modify();
                    end Else
                        Error('E-way bill already Generated');
                    // end;
                end;
            }

            action("Update EWay Vehcile Details")
            {
                AccessByPermission = tableData "Sales Invoice Header" = RIMD;
                Caption = 'Update E-Way Vehcile Details';
                Visible = true;

                trigger OnAction()
                Var
                    Cu50061: Codeunit 50061;
                    EwayBillDate: DateTime;
                    ValidUpto: DateTime;

                begin
                    if Rec."E-Way Bill No." <> '' then begin
                        Cu50061.UpdateVehicleDetails(Rec."No.", Rec."E-Way Bill No.", false);
                    end;
                end;
            }

            action("Update EWay Transporter")
            {
                AccessByPermission = tableData "Sales Invoice Header" = RIMD;
                Caption = 'Update E-Way Bill Transporter';
                Visible = true;

                trigger OnAction()
                Var
                    Cu50061: Codeunit 50061;
                    EwayBillDate: DateTime;
                    ValidUpto: DateTime;

                begin
                    if Rec."E-Way Bill No." <> '' then begin
                        Cu50061.UpdateVehicleDetails(Rec."No.", Rec."E-Way Bill No.", true);
                    end;
                end;
            }

            action("Cancel EWayBill")
            {
                AccessByPermission = tableData "Sales Invoice Header" = RIMD;
                Caption = 'Cancel E-way Bill';
                Visible = true;

                trigger OnAction()
                Var
                    Cu50061: Codeunit 50061;
                begin

                    TestField("Location GST Reg. No.");
                    TestField("E-Way Bill No.");
                    if Rec."Eway Cancel Reason" = Rec."Eway Cancel Reason"::" " then
                        Error('Kindly Update %1', Rec.FieldCaption("Eway Cancel Reason"));
                    if Rec."Eway Cancel Remarks" = '' then
                        Error('Kindly Update %1', Rec.FieldCaption("Eway Cancel Remarks"));

                    Cu50061.CancelEwayBill(Rec, Rec."E-Way Bill No.", rec."Eway Cancel Reason", Rec."Eway Cancel Remarks",
                    REc."Location GST Reg. No.", Rec."E-Way Cancelled Date");
                    // if Rec."E-Way Cancelled Date" <> 0DT then
                    //     Rec.Modify();
                end;

            }

        }
        addbefore(SendCustom)
        {
            action("&Print")
            {
                Applicationarea = All;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;


                trigger OnAction()
                var
                    SalesInvHeader: Record 112;
                begin
                    SalesInvHeader := Rec;
                    CurrPage.SETSELECTIONFILTER(SalesInvHeader);
                    SalesInvHeader.PrintRecords(TRUE);
                end;
            }
        }
        addlast(ActionGroupCRM)
        {
            action(SaveQR)
            {

                Applicationarea = All;
                trigger OnAction()
                var
                    SMSfunctions: Codeunit 50018;

                begin
                    /*
                    CLEAR(SMSfunctions);
                    SMSfunctions.GenerateVertualPayQR(Rec."No.");
                    MESSAGE('Done');
                    */
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."Posting Date", 20211001D, Today);
                    //011021D, TODAY);
                    SalesInvoiceHeader.SETRANGE("Pay QR Created", FALSE);
                    //SalesInvoiceHeader.SETRANGE("No.",'PBH2122/00355');
                    IF SalesInvoiceHeader.FINDSET THEN
                        REPEAT
                        //  SMSfunctions.GenerateVertualPayQR(SalesInvoiceHeader."No.");
                        UNTIL SalesInvoiceHeader.NEXT = 0;
                    MESSAGE('Done');

                end;
            }
        }

    }
    trigger OnAfterGetRecord()
    begin
        // IF UserSetup."Salesperson User" THEN
        //    Rec.SETRANGE("Salesperson Code", UserSetup."Sales Person Code");
        //Rec.SETRANGE("Salesperson Code", USERID); Suman 15-03-2025
    end;

    trigger OnOpenPage()
    var

    begin
        //<<PRU_RC
        Companyinfo.Get;
        UserSetup.GET(USERID);
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        IF NOT UserSetup."HO Users" THEN BEGIN
            Rec.SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
            Rec.SETFILTER("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");

        END;
        IF UserSetup."Salesperson User" THEN
            Rec.SETFILTER("Salesperson Code", UserSetup."Sales Person Code");
        Rec.FILTERGROUP(0);


        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETRANGE("Salesperson User", TRUE);
        IF UserSetup.FINDFIRST THEN
            Visible := FALSE
        ELSE
            Visible := TRUE;
        DisableOnFeedPlant := false;
        if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] then
            DisableOnFeedPlant := True;
        if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] then
            if UserSetup."User Type" = UserSetup."User Type"::"Feed Plant" then
                DisableOnFeedPlant := False;
    end;

    var
        UserSetup: Record 91;
        Visible: Boolean;
        SalesPost: Codeunit 80;
        // TempBlob: Record 99008535;
        SalesInvoiceHeader: Record 112;
        DisableOnFeedPlant: Boolean;
        Companyinfo: record "Company Information";


}