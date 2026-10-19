table 50010 "Terms and Conditions1"
{
    DataClassification = ToBeClassified;
    Caption = 'Terms and Conditions';
    DrillDownPageID = 50019;
    LookupPageID = 50019;

    fields
    {
        field(1; Terms; Code[25])
        {
            DataClassification = ToBeClassified;
            Caption = 'Code';

            trigger OnValidate()
            begin
                /*IF Term.GET(Terms) THEN
                  Conditions:=Term.Conditions;*/

            end;
        }
        field(2; Conditions; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Comment';
        }
        field(3; Conditions2; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Terms)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
    //      Term: Record 50006;


    procedure SetUpNewLine()
    var
        PurchCommentLine: Record 43;
    begin
        /*
                PurchCommentLine.SETRANGE("Document Type", "No.");
                PurchCommentLine.SETRANGE("No.", "Line No.");
                PurchCommentLine.SETRANGE("Document Line No.", "Document Line No.");
                PurchCommentLine.SETRANGE(Date, WORKDATE);
                IF NOT PurchCommentLine.FINDFIRST THEN
                    Conditions := WORKDATE;
        */

    end;
}

