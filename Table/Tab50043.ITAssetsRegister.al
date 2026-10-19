table 50043 ITAssetsRegister
{
    DataClassification = ToBeClassified;
    Caption = 'IT Assets Register';
    fields
    {
        field(1; "Fixed Assets No."; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                FA: Record "Fixed Asset";
            begin
                if FA.Get("Fixed Assets No.") then
                    "FA Name" := FA.Description;
            end;
        }
        field(2; "FA Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Owner"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Location"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "FA Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Laptop,Desktop,Printer,AccessPoint,Firewall,EthernetSwitch;
            OptionCaption = ' ,Laptop,Desktop,Printer,Access Point,Firewall,Ethernet Switch';
        }
        field(6; "FA Purchase Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(7; "FA Vendor Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;

        }
        field(8; "FA Cost with GST"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(9; "Issue Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(10; "Employee Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "FA Assign" where("FA No." = field("Fixed Assets No."));

            trigger OnValidate()
            var
                Employee: Record Employee;
                faassign: Record "FA Assign";
            begin
                if Employee.Get("Employee Code") then
                    Owner := Employee.FullName();

                faassign.Reset();
                faassign.SetRange("FA No.", "Fixed Assets No.");
                faassign.SetRange("Employee Code", "Employee Code");
                if faassign.FindLast() then
                    "Issue Date" := faassign."Effective Date";

            end;

        }
        field(11; "Standard Warranty"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(12; "CPU Serial No."; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(13; "Monitor Serial No."; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(14; "Department"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Sale,Purchase,Production,Accounts,Dispatch,HR,IT,QC,Legal,Store,Admin';
            OptionMembers = ,Sale,Purchase,Production,Accounts,Dispatch,HR,IT,QC,Legal,Store,Admin;
        }
        field(15; "Processor"; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(16; "RAM"; Text[2])
        {
            DataClassification = ToBeClassified;

        }
        field(17; "Drive"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(19; "Make"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(20; "Vendor Invoice No."; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(21; "Serial No."; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(22; "Bar Code"; Blob)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;

        }



    }
    keys
    {
        key(Key1; "Fixed Assets No.")
        {
            Clustered = true;
        }
    }

}