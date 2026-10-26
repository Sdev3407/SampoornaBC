tableextension 50038 ItemExt extends Item
{
    fields
    {

        field(50000; "QC Enabled"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_DD_New Field Added';
        }
        field(50001; "Chicks Item"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU 1.0';
        }
        field(50004; "Consumption Item"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Responsibility Center";
        }
        field(50006; "Item Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            OptionCaption = ' ,Feed,Vaccination,Medicine,Bird,Chick,Egg,GEN,Other Suppliment,Premix,Feed Suppliment,Bardana,RM,Scrap';
            OptionMembers = " ",Feed,Vaccination,Medicine,Bird,Chick,Egg,GEN,"Other Suppliment",Premix,"Feed Suppliment",Bardana,RM,Scrap;
        }
        field(50007; "Bag Item"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50008; "Item Tolerance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "CBF Item"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Feed Item"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Breed Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD-New Field Added';
            TableRelation = "Breed Master";
        }
        field(50012; Status; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_NEELESH';
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved';
            OptionMembers = Open,"Pending Approval",Approved;
        }
        field(50013; "ALEX Item Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_NEELESH 1.1';
        }
        field(50014; "GST Discription"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Item Location"; Code[100])
        {
            DataClassification = ToBeClassified;

        }
        field(50016; "Stock Value"; Decimal)
        {
            CalcFormula = Sum("Value Entry"."Cost Amount (Actual)" WHERE("Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                          "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                          "Location Code" = FIELD("Location Filter"),
                                                                          "Posting Date" = FIELD("Date Filter"),
                                                                          "Variant Code" = FIELD("Variant Filter"),
                                                                          "Item No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50017; "GC Rate %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Old No. Series"; Code[20])
        {
            TableRelation = "No. Series".Code;
            DataClassification = ToBeClassified;
        }
        field(50019; "GST Exempt"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //SIM
        field(50020; "SalesPerson Filter"; Code[20])
        {
            Caption = 'SalesPerson Filter';
            FieldClass = FlowFilter;
            TableRelation = "Salesperson/Purchaser";
        }
        field(50021; SMSItemType; Option)
        {
            Caption = 'SMS Item Type';
            OptionMembers = " ",BF,LF,LLP,CF,BRF,SW,CBF;
        }
        field(50022; ItemComponent; Text[100])
        {
            Caption = 'Item Component';
            DataClassification = ToBeClassified;
        }
        field(50023; "Item Sub Category"; Code[20])
        {
            Caption = 'Item Sub Category';
            //DataClassification = ToBeClassified;
            TableRelation = "Item Sub Category".Code where("Item Category" = field("Item Category Code"));
        }
        field(50024; "CBF Data Entry Item filter"; Option)
        {
            OptionCaption = ' ,Chicks,Feed,Medicine,Vaccine,Other,Bird,EGG';
            OptionMembers = " ",Chicks,Feed,Medicine,Vaccine,Other,Bird,EGG;
        }
        field(50025; "DMR Item Type"; Option)
        {
            OptionCaption = ' ,LLP,Commercial Feed,CBF,CATTLE,SWINE';
            OptionMembers = " ",LLP,"Commercial Feed",CBF,CATTLE,SWINE;
        }
        field(50026; "Mandatory Mandi Name(50137)"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60000; "Prod. Forecast Qty (Base) New"; Decimal)
        {
            CalcFormula = sum("Production Forecast Entry"."Forecast Quantity (Base)" where("Item No." = field("No."),
                                                                                            "Production Forecast Name" = field("Production Forecast Name"),
                                                                                            "Forecast Date" = field("Date Filter"),
                                                                                            "Location Code" = field("Location Filter"),
                                                                                            "Component Forecast" = field("Component Forecast"),
                                                                                            "Variant Code" = field("Variant Filter"),
                                                                                            "SalesPerson Code" = field("SalesPerson Filter")));
            Caption = 'Prod. Forecast Quantity (Base)';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
        }
        //SIM

    }

    trigger OnBeforeInsert()
    var
        usersetup: Record "User Setup";
    begin
        usersetup.RESET;
        usersetup.SETRANGE("User ID", USERID);
        usersetup.SETFILTER(usersetup."Access Item Master", '%1', usersetup."Access Item Master"::View);
        IF usersetup.FINDFIRST THEN
            ERROR('You can not create new Item');
        //PRU_DD 1.10
    end;

    trigger OnAfterInsert()
    var
        usersetup: Record "User Setup";
    begin
        //PRU-VG
        usersetup.GET(USERID);
        VALIDATE("Responsibility Center", usersetup."Responsibility Center");
        //PRU-VG
    end;
}