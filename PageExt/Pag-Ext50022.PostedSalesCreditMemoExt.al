pageextension 50022 PostedSalesCreditMemoExt extends "Posted Sales Credit Memos"
{
    layout
    {
        modify(Paid)
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
        modify("Bill-to Name")
        {
            Visible = true;
        }
        moveafter("Amount Including VAT"; "Bill-to Name")
        moveafter("Remaining Amount"; "Due Date")
        moveafter("No. Printed"; "Document Exchange Status")
        addafter("Document Exchange Status")
        {
            field("E-Invoice Status"; rec."E-Invoice Status")
            {
                ApplicationArea = all;
            }
            field("E-Invoice No."; rec."E-Invoice No.")
            {
                ApplicationArea = all;
            }
            field("E-Invoice Date"; rec."E-Invoice Date")
            {
                ApplicationArea = all;
            }
            field("E-Invoice QR Code"; rec."E-Invoice QR Code")
            {
                ApplicationArea = all;
            }
            field("E-Invoice Cancel Date"; rec."E-Invoice Cancel Date")
            {
                ApplicationArea = all;
            }
        }
        // addafter("Sell-to Customer Name")
        // // {
        // //     field("Sell-to Customer No."; "Sell-to Customer No.")
        // //     {
        // //         ApplicationArea = All;

        // //     }

        // // }
    }
    actions
    {
        addafter(IncomingDoc)
        {
            action("Generate E-Invoice No.")
            {
                Image = Interaction;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;

                Applicationarea = All;
                trigger OnAction()
                var
                    // cuSalesPost: Codeunit "Sales Post Ext";
                    cuSalesPost: Codeunit 50025;
                begin
                    CLEAR(cuSalesPost);
                    cuSalesPost.GenerateSalesCrMemoEInvoice(Rec);
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
                    // cuSalesPost: Codeunit "Sales Post Ext";
                    cuSalesPost: Codeunit 50025;
                begin
                    CLEAR(cuSalesPost);
                    cuSalesPost.CancelSalesCrMemoEInvoice(Rec);
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
            Rec.SETFILTER("Shortcut Dimension 3 Code", UserSetup."Shortcut Dimension 3 Code");
        Rec.FILTERGROUP(0);
    end;

    var

    var

        UserSetup: Record 91;

}
