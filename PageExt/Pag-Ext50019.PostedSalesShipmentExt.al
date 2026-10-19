pageextension 50019 PostedSalesShipmentExt extends "Posted Sales Shipments"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("Transporter Code"; Rec."Transporter Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("No. Printed")
        {
            field("LR/RR No."; rec."LR/RR No.")
            {
                ApplicationArea = all;
            }
            field("Vehicle No."; Rec."Vehicle No.")
            {
                ApplicationArea = All;
            }
            field("LR/RR Date"; rec."LR/RR Date")
            {
                ApplicationArea = all;
            }
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("&Print")
        {
            action("Print")
            {

                Caption = 'Print For Job Work';
                Ellipsis = true;
                Image = Print;
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    TrShipment: Record "Sales Shipment Header";
                begin
                    TrShipment.RESET;
                    TrShipment.SETRANGE(TrShipment."No.", Rec."No.");
                    IF TrShipment.FINDFIRST THEN BEGIN
                        REPORT.RUNMODAL(50099, TRUE, TRUE, TrShipment);
                    END;
                end;
            }
        }

        addafter("&Navigate")
        {
            action("Change Log")
            {
                ApplicationArea = All;
                Image = Log;
                RunObject = Page 595;
                RunPageLink = "Primary Key Field 2 Value" = FIELD("Order No.");

            }


            action("OTP Varify")
            {
                ApplicationArea = all;

                trigger OnAction()
                var
                    salesshipment: Record "Sales Shipment Header";
                    salesshipment2: Record "Sales Shipment Header";
                    OtpDilog: Page "OTP Dialog Page";
                begin
                    salesshipment.Reset();
                    salesshipment.SetRange("No.", Rec."No.");
                    if salesshipment.FindFirst() then begin
                        salesshipment2.Get(salesshipment."No.");
                        if (salesshipment2."OTP Varified at" <> 0DT) and (salesshipment2."OTP Varified by" <> '') then
                            Error('It is already Varified the Delivery by %1 on %2', salesshipment2."OTP Varified by", salesshipment2."OTP Varified at");
                        Clear(OtpDilog);
                        OtpDilog.StoreOTP(salesshipment2.OTP, Rec."No.");
                        OtpDilog.RunModal();

                    end;


                end;
            }

            action("Dispatch Reconcilation")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 50031;
            }
            action("Ship to Sticker")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                //Visible = False;
                PromotedCategory = "Report";
                //RunObject = Report 50096;

                trigger OnAction()
                var
                    PostedSalesShipment: Record "Sales Shipment Header";
                begin
                    PostedSalesShipment.RESET;
                    PostedSalesShipment.SETRANGE("No.", Rec."No.");
                    IF PostedSalesShipment.FINDFIRST THEN
                        REPORT.RUNMODAL(50096, TRUE, TRUE, PostedSalesShipment);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        UserSetup: Record "User Setup";

    begin
        // UserSetup.Get(UserId);
        // IF UserSetup."Salesperson User" THEN
        //     Rec.SETRANGE("Salesperson Code", UserSetup."Sales Person Code");
        //Rec.SETRANGE("Salesperson Code", USERID);// Suman 15-03-2025

    end;

    trigger OnOpenPage()
    begin

        //<<PRU_RC
        UserSetup.GET(USERID);
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        Rec.SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
        IF NOT UserSetup."HO Users" THEN
            Rec.SETFILTER("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
        IF UserSetup."Salesperson User" THEN
            Rec.SETFILTER("Salesperson Code", UserSetup."Sales Person Code");
        Rec.FILTERGROUP(0);

        if UserSetup."Salesperson User" Then begin
            Rec.SetFilter("Posting Date", '>=%1', 20241226D);
            Rec.SetFilter(OTP, '<>%1', 0);
            Rec.SetRange("OTP Varified", false);

        end;
    end;

    trigger OnDeleteRecord(): Boolean
    Begin
        Error('Can Not Delete the Document')
    End;

    var

        UserSetup: Record 91;
}
