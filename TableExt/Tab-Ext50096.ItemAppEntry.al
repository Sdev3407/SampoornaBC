tableextension 50096 ItemAppEntry extends "Item Application Entry"
{
    fields
    {
        field(50000; "Document No"; Code[20])
        {


            FieldClass = FlowField;
            CalcFormula = lookup("Item Ledger Entry"."Document No." where("Entry No." = field("Item Ledger Entry No.")));
        }
        field(50001; "Document Type"; Option)
        {
            OptionMembers = "Sales Shipment","Sales Invoice","Sales Return Receipt","Sales Credit Memo",,"Purchase Receipt","Purchase Invoice","Purchase Return Shipment",,"Purchase Credit Memo","Transfer Shipment","Transfer Receipt","Service Shipment","Service Invoice","Service Credit Memo","Posted Assembly","Inventory Receipt","Inventory Shipment","Direct Transfer";
            FieldClass = FlowField;
            CalcFormula = lookup("Item Ledger Entry"."Document Type" where("Entry No." = field("Item Ledger Entry No.")));

        }

        field(50002; "Item No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Item Ledger Entry"."Item No." where("Entry No." = field("Item Ledger Entry No.")));
        }
        field(50003; "Location Code"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Item Ledger Entry"."Location Code" where("Entry No." = field("Item Ledger Entry No.")));
        }
        field(50004; "Inbound Item Document No"; Code[20])
        {


            FieldClass = FlowField;
            CalcFormula = lookup("Item Ledger Entry"."Document No." where("Entry No." = field("Inbound Item Entry No.")));
        }
        field(50005; "Inbound Item Document Type"; Option)
        {
            OptionMembers = "Sales Shipment","Sales Invoice","Sales Return Receipt","Sales Credit Memo",,"Purchase Receipt","Purchase Invoice","Purchase Return Shipment",,"Purchase Credit Memo","Transfer Shipment","Transfer Receipt","Service Shipment","Service Invoice","Service Credit Memo","Posted Assembly","Inventory Receipt","Inventory Shipment","Direct Transfer";
            FieldClass = FlowField;
            CalcFormula = lookup("Item Ledger Entry"."Document Type" where("Entry No." = field("Inbound Item Entry No.")));

        }
        field(50006; "Outbound Item Document No"; Code[20])
        {


            FieldClass = FlowField;
            CalcFormula = lookup("Item Ledger Entry"."Document No." where("Entry No." = field("Outbound Item Entry No.")));
        }
        field(50007; "Outbound Item Document Type"; Option)
        {
            OptionMembers = "Sales Shipment","Sales Invoice","Sales Return Receipt","Sales Credit Memo",,"Purchase Receipt","Purchase Invoice","Purchase Return Shipment",,"Purchase Credit Memo","Transfer Shipment","Transfer Receipt","Service Shipment","Service Invoice","Service Credit Memo","Posted Assembly","Inventory Receipt","Inventory Shipment","Direct Transfer";
            FieldClass = FlowField;
            CalcFormula = lookup("Item Ledger Entry"."Document Type" where("Entry No." = field("Outbound Item Entry No.")));

        }
    }
    var
        i: Record "Item Ledger Entry";
}
