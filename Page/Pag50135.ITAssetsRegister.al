page 50135 "IT_Assets_Register"
{
    ApplicationArea = All;

    Caption = 'IT Assets Register';
    PageType = Card;
    SourceTable = "ITAssetsRegister";
    //SourceTableView = WHERE("Fixed Assets No."= field());
    //Editable = false;

    layout
    {
        area(content)
        {
            Group(General)
            {

                field("Fixed Assets No."; Rec."Fixed Assets No.")
                {
                    ApplicationArea = All;
                    //ToolTip = 'Specifies the number of the general ledger entry where cost from the associated value entry number in this record is posted.';
                }
                field("FA Name"; Rec."FA Name")
                {
                    ApplicationArea = All;
                    //ToolTip = 'Specifies the number of the general ledger register, where the general ledger entry in this record was posted.';
                }
                field("FA Type"; Rec."FA Type")
                {
                    ApplicationArea = All;
                    //ToolTip = 'Specifies the number of the value entry that has its cost posted in the associated general ledger entry in this record.';
                }
                field("FA Vendor Code"; Rec."FA Vendor Code")
                {
                    ApplicationArea = All;

                }
                field("FA Purchase Date"; Rec."FA Purchase Date")
                {
                    ApplicationArea = All;

                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = All;

                }
                field("FA Cost with GST"; Rec."FA Cost with GST")
                {
                    ApplicationArea = All;

                }
                field("CPU Serial No."; Rec."CPU Serial No.")
                {
                    ApplicationArea = All;

                }
                field("Monitor Serial No."; Rec."Monitor Serial No.")
                {
                    ApplicationArea = All;

                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = all;
                }
                field("Standard Warranty"; Rec."Standard Warranty")
                {
                    ApplicationArea = All;

                }
                field(Processor; Rec.Processor)
                {
                    ApplicationArea = All;

                }
                field(RAM; Rec.RAM)
                {
                    ApplicationArea = All;

                }
                field(Drive; Rec.Drive)
                {
                    ApplicationArea = All;

                }
                field(Make; Rec.Make)
                {
                    ApplicationArea = All;

                }

            }
            group("Assign Detail")
            {
                Caption = 'Assign Detail';
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = All;
                }
                field(Owner; Rec.Owner)
                {
                    ApplicationArea = All;
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field("Bar Code"; Rec."Bar Code")
                {
                    ApplicationArea = all;
                }

            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Generate Bar Code")
            {
                trigger OnAction()
                Var
                    Barcode: Codeunit 50037;
                begin

                //     Barcode.FAQRCODE('FA No. : ' + "Fixed Assets No." + '%0A' +
                //    'Purchase Date :' + Format("FA Purchase Date") + '%0A' +
                //     'Vendor No. :' + "FA Vendor Code" + '%0A' +
                //     'Vendor Invoice No. :' + "Vendor Invoice No.", "Fixed Assets No.");
                //     Rec.CALCFIELDS("Bar Code")

                end;
            }
        }

    }
}