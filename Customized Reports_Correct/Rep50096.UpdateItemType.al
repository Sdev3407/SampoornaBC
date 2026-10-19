report 50096 UpdateItemType
{
    //UsageCategory = Administration;
    Caption = 'ShiptoSticker';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\ShiptoSticker.rdl';
    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            RequestFilterFields = "No.";

            column(No_; "No.")
            { }
            column(Ship_to_Name; (ShiptoName + ' ' + ShiptoName2))
            { }
            column(Ship_to_Address; ShipToAdd)
            { }
            column(Ship_to_Address_2; ShipToAdd2)
            { }
            column(Ship_to_City; ShipToCity)
            { }
            column(Ship_to_Post_Code; ShiptoCode)
            { }
            column(GST_Ship_to_State_Code; ShiptoState)
            { }
            column(PhoenNo; ShiptoPhone)
            { }

            trigger OnAfterGetRecord()
            var
            //SHiptocode: Record "Ship-to Address";
            begin

                // if "Sales Shipment Header"."Ship-to Code" <> '' then begin
                //     SHiptocode.Reset();
                //     SHiptocode.SetRange("Customer No.", "Sell-to Customer No.");
                //     SHiptocode.SetRange(Code, "Ship-to Code");
                //     if SHiptocode.FindFirst() Then begin
                //         PhoenNo := SHiptocode."Phone No.";
                //     end;
                // end;
                Cust.Get("Sales Shipment Header"."Bill-to Customer No.");

                ShiptoAddRec.RESET;
                ShiptoAddRec.SETRANGE(Code, "Sales Shipment Header"."Ship-to Code");
                IF ShiptoAddRec.FINDFIRST THEN
                    PhoenNo := ShiptoAddRec."Phone No.";

                IF "Sales Shipment Header"."Ship-to Name" = '' THEN BEGIN
                    ShiptoName := "Sales Shipment Header"."Bill-to Name";
                    ShiptoName2 := "Sales Shipment Header"."Bill-to Name 2";
                    ShipToAdd := "Sales Shipment Header"."Bill-to Address";
                    ShipToAdd2 := "Sales Shipment Header"."Bill-to Address 2";
                    ShipToCity := "Sales Shipment Header"."Bill-to City";
                    ShiptoCode := "Sales Shipment Header"."Bill-to Post Code";
                    ShiptoState := StateName;
                    ShiptoCountry := CountryName;
                    ShiptoPhone := Cust."Phone No.";
                END ELSE BEGIN
                    ShiptoName := "Sales Shipment Header"."Ship-to Name";
                    ShiptoName2 := "Sales Shipment Header"."Ship-to Name 2";
                    ShipToAdd := "Sales Shipment Header"."Ship-to Address";
                    ShipToAdd2 := "Sales Shipment Header"."Ship-to Address 2";
                    ShipToCity := "Sales Shipment Header"."Ship-to City";
                    ShiptoCode := "Sales Shipment Header"."Ship-to Post Code";
                    ShiptoPhone := "Phone No.";

                    IF T222.GET("Sales Shipment Header"."Bill-to Customer No.", "Sales Shipment Header"."Ship-to Code") THEN BEGIN
                        IF T222."Country/Region Code" <> '' THEN
                            countrReg.GET(T222."Country/Region Code");
                        IF T222.State <> '' THEN
                            State1.GET(T222.State);
                        ShiptoCountry := countrReg.Name;
                        ShiptoState := State1.Description;
                    END;
                    //ShiptoState := StateName;
                    //ShiptoCountry := CountryName;
                end;

            end;



        }

    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Cust: Record Customer;
        ILE: Record 32;
        PhoenNo: Text;
        T222: Record 222;
        ShiptoAddRec: Record 222;
        ShiptoName: Text;
        ShiptoName2: Text;
        ShipToAdd: Text;
        ShipToAdd2: Text;
        ShipToCity: text;
        ShiptoCode: Code[20];
        ShiptoState: Text;
        ShiptoCountry: Text;
        ShiptoPhone: Text;
        StateName: Text;
        CountryName: Text;
        countrReg: Record 9;
        State1: Record State;

}

