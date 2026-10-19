page 50128 "Legal Case Detail Card"

{
    PageType = Card; // Specifies the page type as Card.
    SourceTable = "Legal Case Detail"; // The table the page will display data from.
    ApplicationArea = All; // Makes the page available in all application areas.
    Permissions = tabledata "Legal Case Detail" = imrd;
    SaveValues = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Serial No."; Rec."Serial No.") { ApplicationArea = All; }
                field("Case Title"; Rec."Case Title") { ApplicationArea = All; }
                field("Case Type"; Rec."Case Type") { ApplicationArea = All; }
                field(Dispute; Rec.Dispute) { ApplicationArea = All; }
                field("Sales Head"; Rec."Sales Head") { ApplicationArea = All; }
                field(Address; Rec.Address) { ApplicationArea = All; }
                field("Phone No."; Rec."Phone No.") { ApplicationArea = All; }
                field("Date Of Registration"; Rec."Date Of Registration") { ApplicationArea = All; }
                field("Case No."; Rec."Case No.") { ApplicationArea = All; }
                field("Stage Of the Case"; Rec."Stage Of the Case") { ApplicationArea = All; }
                field("Next Date Of Hearing"; Rec."Next Date Of Hearing") { ApplicationArea = All; }
                field(State; Rec.State) { ApplicationArea = All; }
                field("Distt."; Rec."Distt.") { ApplicationArea = All; }
                field("Customer Code"; Rec."Customer Code") { ApplicationArea = All; }
                field("Line Of Business"; Rec."Line Of Business") { ApplicationArea = All; }
                field("Hearing Distt."; Rec."Hearing Distt.") { ApplicationArea = All; }
                field("Case Amount;"; Rec."Case Amount;") { ApplicationArea = All; }
            }
        }
        area(factboxes)
        {
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action("MyAction")
            {

            }
        }
    }

    trigger OnInit()
    var
        myInt: Integer;
    begin
        // Rec.FindLast();
        // Rec.Init();
        // Rec."Serial No." := Rec."Serial No." + 1;
        // Rec.Insert();

    end;
    // trigger OnInsertRecord()
    // var
    //     myInt: Integer;
    // begin
    //             Rec.FindLast();
    //     Rec.Init();
    //     Rec."Serial No." := Rec."Serial No." + 1;
    //     Rec.Insert();
    // end;
}