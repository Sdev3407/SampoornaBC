tableextension 50031 CustLedgerEntryExt extends "Cust. Ledger Entry"
{
    fields
    {
        field(50000; "CustomerName"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Shortcut Dimension 3Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(50003; "Line Narration1"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_AS0.005';
        }

        field(50005; "Order Qty"; Decimal)
        {
            CalcFormula = Sum("Sales Invoice Line"."Quantity (Base)" WHERE("Document No." = FIELD("Document No."),
                                                                            Type = FILTER(Item)));
            FieldClass = FlowField;
        }
        field(50006; "Order Memo Qty"; Decimal)
        {
            CalcFormula = Sum("Sales Cr.Memo Line"."Quantity (Base)" WHERE("Document No." = FIELD("Document No."),
                                                                            Type = FILTER(Item)));
            FieldClass = FlowField;
        }
        field(50007; State; Code[30])
        {
            CalcFormula = Lookup(Customer."GST State Code" WHERE("No." = FIELD("Customer No.")));
            FieldClass = FlowField;
        }
        field(50008; "Team Code"; Code[20])
        {
            Caption = 'Team Code';
            DataClassification = ToBeClassified;
        }
        field(50009; "SFPL User ID"; text[20])
        {
            DataClassification = ToBeClassified;
        }

    }
}