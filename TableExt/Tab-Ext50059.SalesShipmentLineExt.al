tableextension 50059 SalesShipmentLineExt extends "Sales Shipment Line"
{
    fields
    {
        field(50000; "Chicks Item"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'RK-PRU';
        }
        field(50001; "Alternate UOM"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            TableRelation = "Unit of Measure";
        }
        field(50002; "Alternate Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50003; "Flock No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            TableRelation = "Production Order"."No." WHERE(Status = FILTER(Released | Finished));
        }
        field(50004; "Item Type"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            OptionCaption = ' ,Feed,Vaccination,Medicine,Bird,Chick,Egg,GEN,Other Supplement,Premix,Feed Suppliment,Bardana,RM,Scrap';
            OptionMembers = " ",Feed,Vaccination,Medicine,Bird,Chick,Egg,GEN,"Other Supplement",Premix,"Feed Suppliment",Bardana,RM,Scrap;
        }
        field(50005; "Bird Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(50006; "Male Brid Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50007; "Female Bird Qty."; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50008; "Freight Reimbursment Discount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50011; "Amt. to Customer"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50012; "Shipment Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50013; "Location State Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            //   CalcFormula = Lookup(Location."State Code" WHERE (Code=FIELD("Location Code")));
            Description = 'PRU_AS';
            // FieldClass = FlowField;
        }
        field(50014; "Price Discount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "MRP Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Total MRP"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "GST Exempt"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Order Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
}