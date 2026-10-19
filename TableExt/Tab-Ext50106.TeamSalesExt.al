namespace Sampoorna_BC.Sampoorna_BC;

using Microsoft.CRM.Team;

tableextension 50106 TeamSalesExt extends "Team Salesperson"
{
    fields
    {
        field(50000; "Team Type"; Option)
        {
            OptionMembers = " ",Cattle,Poultry;
            FieldClass = Normal;
        }

        modify("Team Code")
        {
            trigger OnAfterValidate()
            var
                Teams: Record Team;
            begin
                Teams.Get("Team Code");
                "Team Type" := Teams."Team Type";
            end;

        }
    }


    keys
    {
        key(Key50000; "Team Type")
        { }
    }
}
