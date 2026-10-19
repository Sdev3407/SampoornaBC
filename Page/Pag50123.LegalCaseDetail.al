
page 50123 "Legal Case Detail"
{
    Caption = 'Legal Case Detail';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Legal Case Detail";
    CardPageID = "Legal Case Detail Card";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Case Title"; Rec."Case Title")
                {
                    ApplicationArea = All;
                }
                field(Dispute; Rec.Dispute)
                {
                    ApplicationArea = All;
                }
                field("Sales Head"; Rec."Sales Head")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Date Of Registration"; Rec."Date Of Registration")
                {
                    ApplicationArea = All;
                }
                field("Case No."; Rec."Case No.")
                {
                    ApplicationArea = All;
                }
                field("Stage Of the Case"; Rec."Stage Of the Case")
                {
                    ApplicationArea = All;
                }
                field("Next Date Of Hearing"; Rec."Next Date Of Hearing")
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field("Distt."; Rec."Distt.")
                {
                    ApplicationArea = All;
                }
                field("Customer Code"; Rec."Customer Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        Cust: Record Customer;
                    begin
                        Cust.Get(Rec."Customer Code");
                        Rec.Address := Cust.Address + ' ' + Cust."Address 2" + ' ' + Cust.City + ' ' + Cust."State Code" + '-' + CUst."Post Code";
                    end;
                }
                field("Line Of Business"; Rec."Line Of Business")
                {
                    ApplicationArea = All;
                }
                field("Hearing Distt."; Rec."Hearing Distt.")
                {
                    ApplicationArea = All;
                }
                field("Case Amount;"; Rec."Case Amount;")
                {
                    ApplicationArea = All;
                }
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
            action(Send)
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    Farm: Codeunit "Farm Location Expire";
                begin
                    Farm.CaseAlert();
                end;
            }
        }
    }
    var


}
