tableextension 50050 ReturnShipmentHeaderExt extends "Return Shipment Header"
{
    fields
    {
        field(50007; "Line Narration1"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_NEELESH';
        }
        field(50008; "Mandi Name"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Pru_GK MND_0.1';
            Editable = false;
        }
        field(50009; "File No."; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'Pru_gk MDN_0.1';
            Editable = false;
        }
        field(50013; "P.A.N No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Same GST"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "SFPL User ID"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        //SIM-----------Code Added-------------
        field(50050; "Transporter Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "LR/RR No."; code[20])
        {
            DataClassification = EndUserIdentifiableInformation;
        }
        field(50052; "LR/RR Date"; Date)
        {
            DataClassification = EndUserIdentifiableInformation;
        }
        //SIM-----------Code Added-------------
    }
}
