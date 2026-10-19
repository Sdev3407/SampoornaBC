table 50038 "Flock Wise Master"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Flock No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Age; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Today; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Today Mortality';
        }
        field(5; Cum; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Cumm. Mortality';
        }
        field(6; "Cum %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Cum Mortality  %';
        }
        field(7; Recieved; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Feed Recieved';
        }
        field(8; Consumed; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Feed Consumed';
        }
        field(9; Transfer; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Feed Transfer';
        }
        field(10; "Bal. Stock"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Feed Intake Actual"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Feed Intake Std."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }
        field(13; Killogram; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Cumm Feed KG';
        }
        field(14; "CUMFEED Actual"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "CUMFEED Std."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }
        field(16; "Body Weight Actual"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Body Weight Std."; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 3 : 3;
        }
        field(18; "FCR Actual"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "FCR Std."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Chick Housed"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Consumed Prestarter"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Consumed Starter"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Consumed Finisher"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Flock No.", Date)
        {
            Clustered = true;
        }
        key(Key2; Date)
        {
        }
    }

    fieldgroups
    {
    }
}

