tableextension 50019 ShiptoAddressExt extends "Ship-to Address"
{
    fields
    {
        field(50001; "AXT Location Code"; Code[10])
        {
            Caption = 'Lob Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false)); //, "Responsibility Center" = filter('CBF')
            trigger OnValidate()
            var
                Location: Record Location;
            begin
                Location.Get("AXT Location Code");
                //Name := copystr(Location.Name + '-' + Location.Code, 1, 100);
                "Name 2" := Location."Name 2";
                Address := Location.Address;
                "Address 2" := Location."Address 2";
                "Post Code" := Location."Post Code";
                City := Location.City;
            end;
        }
        field(50002; "Landmark"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Landmark';
        }
    }
    trigger OnBeforeInsert()
    var
        UserSetup: Record 91;
        Cust: Record Customer;
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Ship to Address", '%1', UserSetup."Access Ship to Address"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have Permission to enter new Ship-to-Address');
        //PRU_DD 1.10

        Cust.GET("Customer No.");
        Name := Cust.Name;
    end;
}