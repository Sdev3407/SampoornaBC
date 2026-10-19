tableextension 50067 InventorySetupExt extends "Inventory Setup"
{
    fields
    {
        field(50000; "Auto Consumption Batch Name"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = CONST('ITEM'),
                                                             "Template Type" = CONST(Item));
        }
        field(50001; NRGP; Code[20])
        {
            Description = '//Gate Pass';
            TableRelation = "No. Series";
            Enabled = false;
        }
        field(50002; RGP; Code[20])
        {
            Description = '//Gate Pass';
            TableRelation = "No. Series";
        }
        field(50003; RRGP; Code[20])
        {
            Description = '//Gate Pass';
            TableRelation = "No. Series";
        }
    }
}