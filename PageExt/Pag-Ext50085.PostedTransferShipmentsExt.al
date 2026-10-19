pageextension 50085 PostedTransferShipmentsExt extends "Posted Transfer Shipments"
{
    layout
    {
        addafter("No.")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = All;

            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;

            }
            field("New Shortcut Dimension 1 Code"; Rec."New Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;

            }
            field("New Shortcut Dimension 2 Code"; Rec."New Shortcut Dimension 2 Code")
            {
                ApplicationArea = All;

            }
            field("Debit Note Type"; Rec."Debit Note Type")
            {
                ApplicationArea = All;

            }
            field("E-Invoice Status"; Rec."E-Invoice Status")
            {
                ApplicationArea = All;

            }
            field("E-Invoice No."; Rec."E-Invoice No.")
            {
                ApplicationArea = All;

            }
            field("E-Invoice Date"; Rec."E-Invoice Date")
            {
                ApplicationArea = All;

            }
            field("E-Way Bill No."; Rec."E-Way Bill No.")
            {
                ApplicationArea = All;
            }
            field("E-Invoice QR Code"; Rec."E-Invoice QR Code")
            {
                ApplicationArea = All;

            }
            field("E-Invoice Cancel Date"; Rec."E-Invoice Cancel Date")
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("&Print")
        {
            action("Print")
            {
                ApplicationArea = Location;
                Caption = 'Print For Job Work';
                Ellipsis = true;
                Image = Print;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    TrShipment: Record "Transfer Shipment Header";
                begin
                    TrShipment.RESET;
                    TrShipment.SETRANGE(TrShipment."No.", Rec."No.");
                    IF TrShipment.FINDFIRST THEN BEGIN
                        REPORT.RUNMODAL(50115, TRUE, TRUE, TrShipment);
                    END;
                end;
            }
        }
        addafter(Dimensions)
        {
            action("Generate E-Invoice No.")
            {
                Image = Interaction;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                Caption = 'Gen. E-Invoice No.';

                Applicationarea = All;
                trigger OnAction()
                var
                    //cuSalesPost: Codeunit 50055;
                    cuSalesPost: Codeunit 50025;
                begin
                    CLEAR(cuSalesPost);
                    cuSalesPost.GenerateTransferEInvoice(Rec);
                end;
            }
            action("Cancel E-Invoice No.")
            {
                Image = Interaction;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;

                Applicationarea = All;
                trigger OnAction()
                var
                    //cuSalesPost: Codeunit 50055;
                    cuSalesPost: Codeunit 50025;
                begin
                    CLEAR(cuSalesPost);
                    cuSalesPost.CancelTransferEInvoice(Rec);
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        //<<PRU_RC
        UserSetup.GET(USERID);
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Shortcut Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        Rec.SETFILTER("Shortcut Dimension 2 Code", UserSetup."Global Dimension 2 Code");
        IF NOT UserSetup."HO Users" THEN
            Rec.SETFILTER("Transfer-from Code", UserSetup."Shortcut Dimension 3 Code");
        Rec.FILTERGROUP(0);
    end;

    var
        myInt: Integer;
        UserSetup: Record 91;
}