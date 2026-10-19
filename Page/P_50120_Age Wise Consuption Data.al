page 50120 "Age Wise Consuption Data"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Flock Wise Master";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Flock No."; Rec."Flock No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = All;
                }
                field(Today; Rec.Today)
                {
                    ApplicationArea = All;
                }
                field(Cum; Rec.Cum)
                {
                    ApplicationArea = All;
                }
                field("Cum %"; Rec."Cum %")
                {
                    ApplicationArea = All;
                }
                field(Recieved; Rec.Recieved)
                {
                    ApplicationArea = All;
                }
                field(Consumed; Rec.Consumed)
                {
                    ApplicationArea = All;
                }
                field(Transfer; Rec.Transfer)
                {
                    ApplicationArea = All;
                }
                field("Bal. Stock"; Rec."Bal. Stock")
                {
                    ApplicationArea = All;
                }
                field("Feed Intake Actual"; Rec."Feed Intake Actual")
                {
                    ApplicationArea = All;
                }
                field("Feed Intake Std."; Rec."Feed Intake Std.")
                {
                    ApplicationArea = All;
                }
                field(Killogram; Rec.Killogram)
                {
                    ApplicationArea = All;
                }
                field("CUMFEED Actual"; Rec."CUMFEED Actual")
                {
                    ApplicationArea = All;
                }
                field("CUMFEED Std."; Rec."CUMFEED Std.")
                {
                    ApplicationArea = All;
                }
                field("Body Weight Actual"; Rec."Body Weight Actual")
                {
                    ApplicationArea = All;
                }
                field("Body Weight Std."; Rec."Body Weight Std.")
                {
                    ApplicationArea = All;
                }
                field("FCR Actual"; Rec."FCR Actual")
                {
                    ApplicationArea = All;
                }
                field("FCR Std."; Rec."FCR Std.")
                {
                    ApplicationArea = All;
                }
                field("Chick Housed"; Rec."Chick Housed")
                {
                    ApplicationArea = All;
                }
                field("Consumed Prestarter"; Rec."Consumed Prestarter")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Consumed Starter"; Rec."Consumed Starter")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Consumed Finisher"; Rec."Consumed Finisher")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

