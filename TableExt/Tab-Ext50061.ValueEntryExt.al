tableextension 50061 ValueEntryExt extends "Value Entry"
{
    fields
    {
        field(50000; "Item Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Feed,Vaccination,Medicine,Bird,Chick,Egg,GEN,Other Suppliment,Premix,Feed Suppliment,Bardana,RM,Scrap';
            OptionMembers = " ",Feed,Vaccination,Medicine,Bird,Chick,Egg,GEN,"Other Suppliment",Premix,"Feed Suppliment",Bardana,RM,Scrap;
        }
        field(50001; Consumption; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Consumption';
        }
        field(50002; "SFPL User ID"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
    }
}