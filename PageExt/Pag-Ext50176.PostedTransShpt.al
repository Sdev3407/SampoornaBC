namespace Sampoorna_BC.Sampoorna_BC;

using Microsoft.Inventory.Transfer;
using Microsoft.Inventory.Location;
using Microsoft.Finance.GST.StockTransfer;
using System.Security.User;
using Microsoft.Purchases.Vendor;

pageextension 50176 PostedTransShpt extends "Posted Transfer Shipment"
{
    layout
    {
        modify("E-Way Bill No.")
        {
            ApplicationArea = All;
            Editable = false;
        }
        addlast(General)
        {
            field("E-Way Cancelled Date"; Rec."E-Way Cancelled Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the E-Way Cancelled Date field.', Comment = '%';
                Editable = false;
            }
            field("E-Way Generated Date"; Rec."E-Way Generated Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the E-Way Generated Date field.', Comment = '%';
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
            field("Transporter Code"; Rec."Transporter Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transporter Code field.', Comment = '%';
                Editable = true;
                // trigger OnLookup(var Text: Text): Boolean
                // var
                //     Cust: Record Vendor;
                //     CustList: Page "Vendor List";
                //     UserSetupRec: Record "User Setup";
                // begin
                //     Cust.Reset();
                //     Cust.SetFilter(Cust.Transporter, '%1', true);
                //     CustList.SETTABLEVIEW(Cust);
                //     CustList.LOOKUPMODE := TRUE;
                //     IF CustList.RUNMODAL = ACTION::LookupOK THEN begin
                //         CustList.GetRecord(Cust);
                //         Rec.Validate("Transporter Code", Cust."No.");
                //     END;
                // END;
            }
            field("Transporter Name"; Rec."Transporter Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transporter Name field.', Comment = '%';
            }

        }
    }
    actions
    {
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
        modify("Generate E-Invoice")
        {
            Visible = false;
        }
        modify("Generate IRN")
        {
            Visible = false;
        }
        modify("Import E-Invoice Response")
        {
            Visible = false;
        }
        modify("Cancel E-Invoice")
        {
            Visible = false;
        }
        addafter("Generate E-Invoice")
        {
            action("Generate EWayBill")
            {
                AccessByPermission = tableData "Transfer Shipment Header" = RIMD;
                Caption = 'Generate E-way Bill';
                Visible = true;

                trigger OnAction()
                Var
                    Cu50061: Codeunit 50061;
                    EwayBillDate: DateTime;
                    ValidUpto: DateTime;

                begin
                    if rec."E-Way Bill No." = '' then begin
                        Cu50061.GenerateEwayBill(Rec, Rec."E-Way Bill No.", Rec."E-Way Generated Date", ValidUpto);
                        //Rec.Modify();
                    end Else
                        Error('E-way bill already Generated');
                end;
            }

            action("Cancel EWayBill")
            {
                AccessByPermission = tableData "Transfer Shipment Header" = RIMD;
                Caption = 'Cancel E-way Bill';
                Visible = true;

                trigger OnAction()
                Var
                    Cu50061: Codeunit 50061;
                    Loc: Record Location;
                begin
                    Loc.Get("Transfer-from Code");
                    Loc.TestField("GST Registration No.");
                    TestField("E-Way Bill No.");
                    if Rec."Eway Cancel Reason" = Rec."Eway Cancel Reason"::" " then
                        Error('Kindly Update %1', FieldCaption("Eway Cancel Reason"));
                    if Rec."Eway Cancel Remarks" = '' then
                        Error('Kindly Update %1', FieldCaption("Eway Cancel Remarks"));

                    Cu50061.CancelEwayBill(Rec, Rec."E-Way Bill No.", rec."Eway Cancel Reason", Rec."Eway Cancel Remarks",
                    Loc."GST Registration No.", Rec."E-Way Cancelled Date");
                    // if Rec."E-Way Cancelled Date" <> 0DT then begin
                    //     Rec."E-Way Bill No." := '';
                    //     rec."E-Way Generated Date" := 0DT;
                    //     Rec.Modify();
                    // end;
                end;
            }
        }
    }
}
