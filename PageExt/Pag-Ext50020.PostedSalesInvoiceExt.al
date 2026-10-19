pageextension 50020 PostedSalesInvoiceExt extends "Posted Sales Invoice"

{


    layout
    {
        modify("Distance (Km)")
        {
            ApplicationArea = All;
            Editable = true;
        }
        modify("E-Way Bill No.")
        {
            ApplicationArea = All;
            Editable = false;
        }
        modify("IRN Hash")
        {
            ApplicationArea = All;
            Editable = false;
        }
        modify("Vehicle No.")
        {
            Editable = True;
        }
        addafter("Order No.")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = all;
            }
            field("Transporter Code"; Rec."Transporter Code")
            {
                ApplicationArea = All;
                trigger OnLookup(var Text: Text): Boolean
                var
                    Cust: Record Vendor;
                    CustList: Page "Vendor List";
                    UserSetupRec: Record "User Setup";
                begin
                    Cust.Reset();
                    Cust.SetFilter(Cust.Transporter, '%1', true);
                    CustList.SETTABLEVIEW(Cust);
                    CustList.LOOKUPMODE := TRUE;
                    IF CustList.RUNMODAL = ACTION::LookupOK THEN begin
                        CustList.GetRecord(Cust);
                        Rec.Validate("Transporter Code", Cust."No.");
                    END;
                    //exit(LookupBuyFromVendorName(Text));
                END;
            }
            field("Transporter Name"; "Transporter Name")
            {
                ApplicationArea = All;
            }
            field("Payment QR Code1"; Rec."Payment QR Code1")
            {
                Visible = false;
                ApplicationArea = all;
            }
            field("Driver Mobile No."; Rec."Driver Mobile No.")
            {
                ApplicationArea = All;

            }
            field("Freight Value"; Rec."Freight Value")
            {
                ApplicationArea = all;
            }
        }
        ///shipping
        moveafter("Mode of Transport"; "Vehicle No.")
        moveafter("Vehicle No."; "Vehicle Type")
        moveafter("Vehicle Type"; "LR/RR No.")
        moveafter("LR/RR No."; "LR/RR Date")
        //SIM
        addafter("E-Way Bill No.")
        {
            field("E-Way Generated Date"; Rec."E-Way Generated Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the E-Way Generated Date field.', Comment = '%';
            }
            field("E-Way Cancelled Date"; Rec."E-Way Cancelled Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the E-Way Cancelled Date field.', Comment = '%';
                Editable = false;
            }
            field("Eway Cancel Reason"; Rec."Eway Cancel Reason")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Eway Cancel Reason field.', Comment = '%';
                Editable = true;
            }

            field("Eway Cancel Remarks"; Rec."Eway Cancel Remarks")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Eway Cancel Remarks field.', Comment = '%';
                Editable = true;
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
                Image = Print;
                Promoted = true;
                Visible = DisableOnFeedPlant;
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

        addafter("&Invoice")
        {
            action("Generate Pay Qr")
            {
                Image = Interaction;
                ApplicationArea = All;
                Promoted = true;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;

            }

            Action("Payment QR Code")
            {
                ApplicationArea = All;
                Promoted = True;

            }
            action("Bulk Pay QR")
            {
                Image = Interaction;
                ApplicationArea = All;
                trigger OnAction()
                var
                    //cuSalesPost: Codeunit 50055;
                    cuSalesPost: Codeunit 50025;
                    CU50017: Codeunit 50024;
                    SIH: Record "Sales Invoice Header";
                begin
                    SIH.Reset();
                    SIH.SetRange("No.", Rec."No.");
                    SIH.SetRange("Posting Date", 0D, Today());
                    SIH.SetRange("Pay QR Created", false);
                    if SIH.FindSet() then
                        repeat
                            CU50017.GetAccessToken(SIH."No.");
                        until SIH.Next() = 0;
                end;
            }


            action("Posted Reference Invoice No.")
            {
                Caption = 'Posted Reference Invoice No.';
                Image = ApplyEntries;
                Promoted = true;
                PromotedCategory = Process;

                Applicationarea = All;
                trigger OnAction()
                var
                    ReferenceInvoiceNo: Record "Reference Invoice No.";
                    PostedReferenceInvoiceNo: Page "Posted Reference Invoice No";
                begin
                    ReferenceInvoiceNo.SETCURRENTKEY("Document No.", "Document Type", "Source No.", "Reference Invoice Nos.");
                    ReferenceInvoiceNo.SETRANGE("Document No.", Rec."No.");
                    IF ReferenceInvoiceNo.FINDFIRST THEN BEGIN
                        PostedReferenceInvoiceNo.SETTABLEVIEW(ReferenceInvoiceNo);
                        PostedReferenceInvoiceNo.SETRECORD(ReferenceInvoiceNo);
                        PostedReferenceInvoiceNo.LOOKUPMODE(TRUE);
                        IF PostedReferenceInvoiceNo.RUNMODAL = ACTION::LookupOK THEN
                            PostedReferenceInvoiceNo.GETRECORD(ReferenceInvoiceNo)
                    END;
                end;
            }


        }

        addbefore(SendCustom)
        {
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
                        Error('Kindly Update %1', FieldCaption("Eway Cancel Reason"));
                    if Rec."Eway Cancel Remarks" = '' then
                        Error('Kindly Update %1', FieldCaption("Eway Cancel Remarks"));

                    Cu50061.CancelEwayBill(Rec, Rec."E-Way Bill No.", rec."Eway Cancel Reason", Rec."Eway Cancel Remarks",
                    REc."Location GST Reg. No.", Rec."E-Way Cancelled Date");
                    // if Rec."E-Way Cancelled Date" <> 0DT then begin
                    //     Rec."E-Way Bill No." := '';
                    //     rec."E-Way Generated Date" := 0DT;
                    //     Rec.Modify();
                    //end
                end;
            }
            // action("Reject EWayBill")
            // {
            //     AccessByPermission = tableData "Sales Invoice Header" = RIMD;
            //     Caption = 'Reject E-way Bill';
            //     Visible = False; //API Not working

            //     trigger OnAction()
            //     Var
            //         Cu50061: Codeunit 50061;
            //     begin

            //         TestField("Location GST Reg. No.");
            //         TestField("E-Way Bill No.");
            //         Cu50061.RejectEwayBill(Rec."E-Way Bill No.", REc."Location GST Reg. No.", Rec.ew);

            //         if Rec. <> '' then
            //             Rec.Modify();
            //     end;

            // }


            action("Export Json File Eway")
            {
                Caption = 'Export Json File Eway';
                Image = EditForecast;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                Applicationarea = All;
                trigger OnAction()
                var
                    eInvoice: Codeunit 50020;
                begin
                    SalesInvHeader.RESET;
                    SalesInvHeader.SETRANGE("No.", Rec."No.");
                    IF SalesInvHeader.FINDFIRST THEN BEGIN
                        eInvoice.SetSalesInvHeader(SalesInvHeader);
                        eInvoice.RUN;
                    END;
                end;
            }

        }
    }
    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Invoice", '%1', UserSetup."Access Sales Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to delete the record');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Invoice", '%1', UserSetup."Access Sales Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Invoice", '%1', UserSetup."Access Sales Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to modify the record');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Invoice", '%1', UserSetup."Access Sales Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    var
        CRMIntegrationManagement: Codeunit 5330;
        UserSetup: Record 91;
    begin
        Companyinfo.Get;
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Invoice", '%1', UserSetup."Access Sales Invoice"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Sales Invoice');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Sales Invoice", '%1', UserSetup."Access Sales Invoice"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        //<<PRU_RC

        UserSetup.GET(USERID);
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        IF NOT UserSetup."HO Users" THEN BEGIN
            Rec.SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
            Rec.SETFILTER("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
            Rec.FILTERGROUP(0);
        END;

        DisableOnFeedPlant := false;
        if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] then
            DisableOnFeedPlant := True;
        if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] then
            if UserSetup."User Type" = UserSetup."User Type"::"Feed Plant" then
                DisableOnFeedPlant := False;
    end;

    var
        UserSetup: Record 91;
        SalesInvHeader: Record "Sales Invoice Header";
        CompanyInfo: Record "Company Information";
        DisableOnFeedPlant: Boolean;

    procedure LookupBuyFromVendorName(var VendorName: Text): Boolean
    var
        Vendor: Record Vendor;
        LookupStateManager: Codeunit "Lookup State Manager";
        RecVariant: Variant;
        SearchVendorName: Text;
    begin
        SearchVendorName := VendorName;
        Vendor.Setrange(Transporter, true);
        if Rec."Transporter Code" <> '' then
            Vendor.Get(Rec."Transporter Code");

        if Vendor.LookupVendor(Vendor) then begin
            if Rec."Transporter Code" = Vendor.Name then
                VendorName := SearchVendorName
            else
                VendorName := Vendor.Name;
            RecVariant := Vendor;
            LookupStateManager.SaveRecord(RecVariant);
            exit(true);
        end;
    end;
}