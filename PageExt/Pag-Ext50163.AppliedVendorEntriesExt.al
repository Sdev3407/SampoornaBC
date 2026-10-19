pageextension 50163 AppliedVendorEntriesExt extends "Apply Vendor Entries"
{
    layout
    {
        addafter("Document No.")
        {
            field("Applied PO No."; Rec."Applied PO No.")
            {
                ApplicationArea = All;

            }

        }
        addafter(Amount)
        {

            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;

            }
            field("Line Narration"; Rec."Line Narration1")
            {
                ApplicationArea = All;
                Caption = 'Line Narration';
            }



        }
    }
    actions
    {
        modify(ActionPostApplication)
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                Message('Yes');
            end;
        }

    }



    var
        GSTGroupCodeEqualErr: Label 'GST Group Code & GST %  must be same in Advance Payment Entry No. %1 and Document Type %2, Document No %3.', Comment = '%1 = Payment Entry No., %2 = Document Type, %3 = Document No.';
        GSTWithoutPaymentErr: Label 'GST Without Payment of Duty must be same in both the Documents.';
        GSTWithFinChargeErr: Label 'You cannot apply GST entries with Finance Charge Memo entries.';
        TCSWithFinChargeErr: Label 'You cannot apply TCS entries with Finance Charge Memo entries.';
        TCSNatureOfCollectionErr: Label 'TCS Nature of Collection must be same in both documents.';
        GSTTCSEqualErr: Label 'TCS And GST Group must be same in both documents.';
        GenJnlLine: Record "Gen. Journal Line";

        SalesHeader: Record "Sales Header";


}