table 50034 "Agreement Detail"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Vendor No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                CLEAR(Vendor);
                CLEAR("Vendor Name");
                Vendor.RESET;
                IF Vendor.GET("Vendor No.") THEN
                    "Vendor Name" := Vendor.Name;
            end;
        }
        field(50001; "Vendor Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Agreement Starting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(50003; "Agreement Ending Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Security Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Monthly Rent"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Building Owner Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Building Owner Phone No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Building Owner Email"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Jurisdiction City"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Owner Adhar Card"; Text[12])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Owner Pan Card"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Owner GST No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Agreement For"; Option)
        {
            DataClassification = ToBeClassified;
            //  OptionCaption = ' ,Guest House,Branch,Processing Plant,Godown';
            OptionMembers = " ","Guest House",Branch,"Processing Plant",Godown;
        }
        field(50014; "Bank Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Bank Account No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "IFSC No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Bank Branch"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Electricity Consumer No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Electricity Consumer Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Property Adderss"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Vendor No.", "Vendor Name", "Agreement Starting Date", "Agreement Ending Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Vendor: Record Vendor;
}

