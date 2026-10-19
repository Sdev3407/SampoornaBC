tableextension 50104 State extends State
{
    fields
    {
        field(50000; "From PIN Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "To PIN Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Union Territory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}