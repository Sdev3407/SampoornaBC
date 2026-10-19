page 50030 "RGP Gate Pass"
{
    PageType = Card;
    SourceTable = "Gate Pass Header";
    UsageCategory = Tasks;
    ApplicationArea = all;
    SourceTableView = SORTING("Document Type", "No.")
                      ORDER(Ascending)
                      WHERE("Document Type" = FILTER(RGP),
                            Posted = FILTER(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Style = Standard;
                    StyleExpr = TRUE;
                    Caption = 'RGP No.';

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Location Code"; Rec."Location Code")
                {
                    ShowMandatory = true;
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                // field("

                field("Type"; Rec."Type")
                {
                    ShowMandatory = True;
                }
                field("Code"; Rec."Code")
                {
                    ShowMandatory = True;
                }
                field("Party Name"; Rec."Party Name")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                { }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                { }


                field("Posting Date"; Rec."Posting Date")
                {
                    ShowMandatory = True;
                }
                field("LR Date"; Rec."LR Date")
                {
                }
                field("LR No."; Rec."LR/RR No.")
                {
                    Caption = 'LR No.';
                }

                field("Pending Qty"; Rec."Pending Qty")
                {
                    Visible = false;
                }
                field("Total Qty"; Rec."Total Qty")
                {
                }
                field("Date Of Return"; Rec."Date Of Return")
                {
                    // Caption = 'Due Date';

                    trigger OnValidate()
                    begin
                        IF Rec."Date Of Return" < TODAY THEN
                            ERROR('Due date must be greater than current date!');
                    end;
                }
            }
            part(RGPLine; "Gate pass Subform")
            {
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
            }
            group("Other Information")
            {
                Caption = 'Other Information';
                field("Mode of Transport"; Rec."Mode of Transport")
                {
                }
                field("Road Permit No."; Rec."Road Permit No.")
                {
                }
                field("Transport Company"; Rec."Transport Company")
                {
                }
                field("Truck Number"; Rec."Truck Number")
                {
                }
                field("Driver Name"; Rec."Driver Name")
                {
                }
                field("Driver Phone No."; Rec."Driver Phone No.")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';

                action("Dimension")
                {
                    Image = Dimensions;
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        rec.ShowDocDim;
                        CurrPage.SAVERECORD;

                    end;
                }
            }
            group("&Post")
            {
                Caption = '&Post';
                action(Post)
                {
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        LOCATION: Record Location;
                    begin
                        Rec.TestField(Posted, false);
                        Rec.CheckPostedDocNo;
                        // IF Rec.Posted = FALSE THEN BEGIN
                        IF NOT (CONFIRM(Text_0008, FALSE)) THEN
                            EXIT;

                        //Disha
                        GatePassLine.RESET;
                        GatePassLine.SETRANGE(GatePassLine."Document Type", Rec."Document Type");
                        GatePassLine.SETRANGE(GatePassLine."Document No.", Rec."No.");
                        IF GatePassLine.FINDSET THEN begin
                            REPEAT
                                GatePassLine."Document Date" := Rec."Posting Date";
                                GatePassLine.Posted := TRUE;
                                GatePassLine.MODIFY;
                            UNTIL GatePassLine.NEXT = 0;
                            Rec.Posted := true;
                            Message('RGP Document %1 is Posted', Rec."No.");
                            CurrPage.Update();
                        end else
                            Error('No Lines exist for the Document No. %1', Rec."No.");
                    END;
                }
                separator("...............................")
                {
                    Caption = '...............................';
                }
                action(Report)
                {
                    Caption = 'Report';
                    Visible = false;

                    trigger OnAction()
                    begin
                        GatePassHeader := Rec;
                        GatePassHeader.SETRECFILTER;
                        REPORT.RUNMODAL(REPORT::"RGP/NRGP/RRGP Report", TRUE, FALSE, GatePassHeader);
                    end;
                }
            }
        }
    }


    trigger OnAfterGetRecord()
    begin
        Rec.SETRANGE("Document Type");
    end;

    var
        GatePassHeader: Record "Gate Pass Header";
        GatePassLine: Record "Gate Pass Line";
        Text_0008: Label 'Do you wants to Post?';
}

