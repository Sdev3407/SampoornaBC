tableextension 50022 TrackingSpecificationExt extends "Tracking Specification"
{
    fields
    {
        field(50000; Fertility; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD-New Field Added';
        }
        field(50001; Age; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD-New Field Added';
        }
        field(50002; "Breed Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD-New Field Added';
            TableRelation = "Breed Master";
        }
        field(50003; "Lay Day Comment"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG 4.0';
        }
        field(50004; "Lot Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Suman 07/09/2024';
            trigger OnValidate()
            var
                PeriodYear: Integer;
                StartDate: Date;
                EndDate: Date;
                NoofDaysInYear: Integer;
                BatchMaster: Record "Batch Master";

            Begin
                //TESTFIELD(Status, Status::Released);

                TESTFIELD(rec."Lot Type");
                PeriodYear := DATE2DMY(Rec."Lot Date", 3);
                StartDate := DMY2DATE(1, 1, PeriodYear);
                EndDate := DMY2DATE(31, 12, PeriodYear);
                NoofDaysInYear := EndDate - StartDate;

                "Lot No." := FORMAT(PeriodYear) + '/' + FORMAT(Rec."Lot Type") + '-' + FORMAT((EndDate - Rec."Lot Date") + 1);

                BatchMaster.Reset();
                BatchMaster.SetRange("Batch No.", "Lot No.");
                if not BatchMaster.FindFirst() then begin
                    BatchMaster.Init();
                    BatchMaster."Batch Date" := Rec."Lot Date";
                    BatchMaster."Batch No." := Rec."Lot No.";
                    BatchMaster."Batch Type" := Rec."Lot Type";
                    BatchMaster.Insert();
                end;
            End;
        }
        field(50005; "Lot Type"; Option)
        {
            //DataClassification = ToBeClassified;
            Description = 'Suman 07/09/2024';
            OptionMembers = " ",TP,LB,RP;
        }
        field(50006; "Manufacturing Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50007; "New Manufacturing Date"; Date)
        {
            Caption = 'New Manufacturing Date';
            DataClassification = CustomerContent;
        }
    }
}