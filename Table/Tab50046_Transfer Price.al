Table 50046 "Transfer Price"
{
    Caption = 'Tranfer Price';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "From Branch"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code Where("Global Dimension No." = const(2));
        }
        field(50001; "To Branch"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code Where("Global Dimension No." = const(2));
        }
        field(50003; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                TranferPrice: Record "Transfer Price";
            begin

                //PRU-VG
                if "Start Date" <> 0D Then Begin
                    TranferPrice.RESET;
                    //TranferPrice.SetCurrentKey("Item No", "From Branch", "To Branch", "Start Date");
                    TranferPrice.SETRANGE("Item No", Rec."Item No");
                    TranferPrice.SETRANGE("From Branch", Rec."From Branch");
                    TranferPrice.SETRANGE("To Branch", Rec."To Branch");
                    TranferPrice.SetFilter("Start Date", '<%1', Rec."Start Date");
                    // TranferPrice.SETFILTER("Location Code", '%1', "Location Code");
                    TranferPrice.SETRANGE("End Date", 0D);
                    IF TranferPrice.FindSet() THEN begin
                        repeat
                            //IF TranferPrice."Start Date" < "Start Date" THEN BEGIN
                            TranferPrice."End Date" := CALCDATE('-1D', "Start Date");
                            TranferPrice.MODIFY;
                        until TranferPrice.Next() = 0;
                    END;
                END;
            end;



        }
        field(50004; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Item No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";

            trigger OnValidate()
            var
                Items: Record Item;

            begin
                Items.get(rec."Item No");
                Rec.UOM := Items."Base Unit of Measure";
                //Rec.Modify();

            end;
        }
        field(50007; "UOM"; Code[10])
        {
            DataClassification = ToBeClassified;
            //TableRelation = 
        }
    }
    keys
    {
        key(Key1; "Item No", "From Branch", "To Branch", "Start Date")
        {
            Clustered = true;
        }


    }
}