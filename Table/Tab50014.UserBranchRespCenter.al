table 50014 "User Branch Resp. Center"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "User Setup"."User ID";


        }
        field(2; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(3; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            begin
                IF "Responsibility Center" <> '' THEN BEGIN
                    ResponsibilityCenter.GET("Responsibility Center");
                    "Responsibility Center Name" := ResponsibilityCenter.Name;
                    "Global Dimension 1 Code" := ResponsibilityCenter.Code;
                END ELSE
                    "Responsibility Center Name" := '';
            end;
        }
        field(4; "Responsibility Center Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                DV.GET('BRANCH', "Global Dimension 2 Code");
                "Branch Name" := DV.Name;
            end;
        }
        field(6; "Branch Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "User ID", "Global Dimension 1 Code", "Global Dimension 2 Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        UserMgt: Codeunit 418;
        ResponsibilityCenter: Record 5714;
        DV: Record 349;
}

