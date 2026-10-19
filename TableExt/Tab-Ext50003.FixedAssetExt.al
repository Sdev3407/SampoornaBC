tableextension 50003 FixedAssetExt extends "Fixed Asset"
{
    fields
    {
        field(50000; "WIP Assets"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Old No. Series"; Code[20])
        {
            TableRelation = "No. Series".Code;
            DataClassification = ToBeClassified;
        }
        field(50002; "Project Code"; Code[10])
        {
            TableRelation = Project."Project Code" Where(Location = field("Location Code"));
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Pro: Record Project;
            begin
                Pro.Reset();
                Pro.SetRange("Project Code", "Project Code");
                Pro.SetRange(Location, "Location Code");
                If Pro.FindFirst() then
                    "Project Name" := Pro."Project Name";
            end;
        }
        field(50003; "Project Name"; Text[50])
        {
            //TableRelation = Project."Project Code" Where(Location = field("Location Code"));
            DataClassification = ToBeClassified;
        }
        field(50004; "Sub Location"; Code[10])
        {
            TableRelation = "Sub Location"."Sub Location Code" Where("Project Code" = field("Project Code"));
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Pro: Record "Sub Location";
            begin
                If "Project Code" <> '' Then begin
                    Pro.Reset();
                    Pro.SetRange("Project Code", "Project Code");
                    Pro.SetRange(Pro."Sub Location Code", "Sub Location");
                    If Pro.FindFirst() then
                        "Sub Location Name" := Pro."Sub Location Name"
                end;
            end;
        }
        field(50005; "Sub Location Name"; Text[50])
        {
            //TableRelation = Project."Project Code" Where(Location = field("Location Code"));
            DataClassification = ToBeClassified;
        }
        field(50006; "Section"; Code[10])
        {
            TableRelation = Section."Section Code" Where("Sub Location Code" = field("Sub Location"));
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Pro: Record Section;
            begin
                Pro.Reset();
                Pro.SetRange("Sub Location Code", "Sub Location");
                Pro.SetRange(Pro."Section Code", Section);
                If Pro.FindFirst() then
                    "Section Name" := Pro."Section Name"
            end;
        }
        field(50007; "Section Name"; Text[50])
        {
            //TableRelation = Project."Project Code" Where(Location = field("Location Code"));
            DataClassification = ToBeClassified;
        }
    }
}