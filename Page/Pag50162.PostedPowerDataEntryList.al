Page 50162 "Posted Power Data Entry List"
{

    CardPageID = "Posted Power Data Entry List";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Power Data Entry";
    SourceTableView = WHERE(Posted = FILTER(true));
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = all;
                }
                field("Power Units Consumed"; Rec."Power Units Consumed")
                {
                    ApplicationArea = all;
                }
                field("Diesel Quantity Consumed"; Rec."Diesel Quantity Consumed")
                {
                    ApplicationArea = all;
                }
                field("Production Details in MT "; Rec."Production Details in MT ")
                {
                    ApplicationArea = all;
                }
                field("Cost of Power and Diesel"; Rec."Cost of Power and Diesel")
                {
                    ApplicationArea = all;
                }
                field("Per Ton Power Cost "; Rec."Per Ton Power Cost ")
                {
                    ApplicationArea = all;
                }

            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        userset.GET(USERID);
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Shortcut Dimension 1 Code", userset."Global Dimension 1 Code");
        IF NOT userset."HO Users" THEN BEGIN
            Rec.SETFILTER("Shortcut Dimension 2 Code", userset."Global Dimension 2 Code");
            //Rec.SETFILTER("Shortcut Dimension 3 Code", userset."Shortcut Dimension 3 Code");
            Rec.FILTERGROUP(0);
        END;

    end;

    var
        DimMgt: Codeunit 408;
        tgUserSetup: Record 91;
        RespCntr: Record 5714;
        userset: Record 91;
}


