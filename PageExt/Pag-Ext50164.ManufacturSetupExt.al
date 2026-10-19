pageextension 50164 ManufacturSetupExt extends "Manufacturing Setup"
{
    layout
    {
        addafter("Cost Incl. Setup")
        {
            field("Consumption Batch Name"; Rec."Consumption Batch Name")
            {
                ApplicationArea = all;
            }
            field("Output Batch Name"; Rec."Output Batch Name")
            {
                ApplicationArea = all;
            }
            field("Capacity Batch Name"; Rec."Capacity Batch Name")
            {
                ApplicationArea = all;
            }
            field("Breeder Consumption Batch"; Rec."Breeder Consumption Batch")
            {
                ApplicationArea = All;

            }
            field("Breeder Capacity Batch Name"; Rec."Breeder Capacity Batch Name")
            {
                ApplicationArea = all;
            }
            field("Breeder Output Batch"; Rec."Breeder Output Batch")
            {
                ApplicationArea = All;

            }
            field("CBF Consumption Batch"; Rec."CBF Consumption Batch")
            {
                ApplicationArea = All;

            }
            field("CBF Capacity Batch Name"; Rec."CBF Capacity Batch Name")
            {
                ApplicationArea = All;

            }
            field("CBF Output Batch"; Rec."CBF Output Batch")
            {
                ApplicationArea = all;
            }

            field("Hatch Consumption Batch"; Rec."Hatch Consumption Batch")
            {
                ApplicationArea = All;

            }
            field("Hatch Capacity Batch Name"; Rec."Hatch Capacity Batch Name")
            {
                ApplicationArea = All;

            }
            field("Hatch Output Batch"; Rec."Hatch Output Batch")
            {
                ApplicationArea = all;
            }

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