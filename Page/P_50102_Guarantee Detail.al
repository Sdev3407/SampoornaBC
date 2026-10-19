page 50102 "Guarantee Detail"
{
    PageType = List;
    SourceTable = "Guarantee Detail";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer Code"; Rec."Customer Code")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                }
                field("Bank Guarantee Amount"; Rec."Bank Guarantee Amount")
                {
                    ApplicationArea = All;
                }
                field("Bank Guarantee Document No."; Rec."Bank Guarantee Document No.")
                {
                    ApplicationArea = All;
                }
                field("Bank Guarantee Durration"; Rec."Bank Guarantee Durration")
                {
                    ApplicationArea = All;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                }
                field(Check1; Rec.Check1)
                {
                    ApplicationArea = All;
                    Caption = 'Cheque1';
                }
                field(Check2; Rec.Check2)
                {
                    ApplicationArea = All;
                    Caption = 'Cheque2';
                }
                field(Check3; Rec.Check3)
                {
                    ApplicationArea = All;
                    Caption = 'Cheque3';
                }
                field(Check4; Rec.Check4)
                {
                    ApplicationArea = All;
                    Caption = 'Cheque4';
                }
                field("Check Amount"; Rec."Check Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Cheque''s Amount';
                }
                field("Pan Card"; Rec."Pan Card")
                {
                    ApplicationArea = All;
                }
                field("Adhar Card"; Rec."Adhar Card")
                {
                    ApplicationArea = All;
                }
                field(Remark; Rec.Remark)
                {
                    ApplicationArea = All;
                }
                field("By Legal"; Rec."By Legal")
                {
                    ApplicationArea = All;
                }
                field("Profile"; Rec."Profile")
                {
                    ApplicationArea = All;
                }
                field("Photo"; rec.Photo)
                {
                    ApplicationArea = All;
                }
                field("Bank passbook"; Rec."bank passbook")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

