table 50071 "Login Dimension"
{
    Caption = 'Login Dimension';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "User SID"; Guid)
        {
            Caption = 'User SID';
            TableRelation = User."User Security ID";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(2; "Server Instance ID"; Integer)
        {
            Caption = 'Server Instance ID';
            TableRelation = "Server Instance"."Server Instance ID";
        }
        field(3; "Session ID"; Integer)
        {
            Caption = 'Session ID';
        }
        field(4; "Server Instance Name"; Text[250])
        {
            Caption = 'Server Instance Name';
        }
        field(5; "User ID"; Text[132])
        {
            Caption = 'User ID';
        }
        field(6; "Login Datetime"; DateTime)
        {
            Caption = 'Login Datetime';
        }
        field(7; "Database Name"; Text[250])
        {
            Caption = 'Database Name';
        }
        field(8; "Session Unique ID"; Guid)
        {
            Caption = 'Session Unique ID';
        }
        field(9; "Global Dimension 1 Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(10; "Global Dimension 2 Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(11; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            Description = 'PRU-VG-RC';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));


        }
    }
    keys
    {
        key(Key1; "Server Instance ID", "Session ID")
        {
            Clustered = true;
        }
        key(Key2; "Login Datetime")
        {
        }

    }

    trigger OnDelete()
    begin
        Message('Test');
    end;


}