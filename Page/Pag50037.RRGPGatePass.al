page 50037 "RRGP Gate Pass"
{
    PageType = Card;
    ApplicationArea = ALL;
    UsageCategory = Tasks;
    SourceTable = "Gate Pass Header";
    SourceTableView = SORTING("Document Type", "No.")
                      ORDER(Ascending)
                      WHERE("Document Type" = FILTER(RRGP),
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

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("RGP No."; Rec."RGP No.")
                {


                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE(true);
                        CurrPage.RRGPLine.Page.Update(true);
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Style = Standard;
                    StyleExpr = TRUE;
                    Editable = FALSE;
                }



                field("Type"; Rec."Type")
                {
                    Editable = FALSE;
                }
                field("Code"; Rec."Code")
                {
                    Editable = FALSE;
                }
                field("Party Name"; Rec."Party Name")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }


                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("LR Date"; Rec."LR Date")
                {
                }
                field("LR/RR No."; Rec."LR/RR No.")
                {
                }

                field("Total Qty"; Rec."Total Qty")
                {
                }
                field("Pending Qty"; Rec."Pending Qty")
                { }


                field("Date Of Return"; Rec."Date Of Return")
                {
                }
            }
            part(RRGPLine; "Gate pass Subform")
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
                    begin
                        Rec.TESTFIELD("Posting Date");

                        GatePassHeader.RESET;
                        GatePassHeader.SETRANGE(GatePassHeader."Document Type", GatePassHeader."Document Type"::RGP);
                        GatePassHeader.SETRANGE(GatePassHeader."No.", Rec."RGP No.");
                        IF GatePassHeader.FIND('-') THEN BEGIN
                            IF GatePassHeader."Posting Date" > Rec."Posting Date" THEN
                                ERROR('RGP Gate pass date is %1 so you cannot post RRGP in %2', GatePassHeader."Posting Date", Rec."Posting Date");
                        END;

                        GatePassLine.RESET;
                        GatePassLine.SETRANGE(GatePassLine."Document Type", Rec."Document Type");
                        GatePassLine.SETRANGE(GatePassLine."Document No.", Rec."No.");
                        IF GatePassLine.FIND('-') THEN begin
                            REPEAT
                                RGPGatePassLine.RESET;
                                RGPGatePassLine.SETRANGE(RGPGatePassLine."Document Type", RGPGatePassLine."Document Type"::RGP);
                                RGPGatePassLine.SETRANGE(RGPGatePassLine."Document No.", Rec."RGP No.");
                                RGPGatePassLine.SETRANGE(RGPGatePassLine."Line No.", GatePassLine."RGP Line No.");
                                IF RGPGatePassLine.FIND('-') THEN BEGIN
                                    IF GatePassLine."Unit Cost" <> RGPGatePassLine."Unit Cost" THEN BEGIN
                                        ERROR('Unit Cost should be %1 for Line No. %2', RGPGatePassLine."Unit Cost", GatePassLine."Line No.");
                                    END;
                                END;
                            UNTIL GatePassLine.NEXT = 0;
                        end else
                            Error('No Lines exist for the Document No. %1', Rec."No.");

                        GatePassLine.RESET;
                        GatePassLine.SETCURRENTKEY("Document Type", "Document No.");
                        GatePassLine.SETRANGE("Document Type", Rec."Document Type");
                        GatePassLine.SETRANGE("Document No.", Rec."No.");
                        IF GatePassLine.FIND('-') THEN
                            REPEAT
                                RGPLine.RESET;
                                RGPLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                                RGPLine.SETRANGE("Document Type", RGPLine."Document Type"::RGP);
                                RGPLine.SETRANGE("Document No.", GatePassLine."RGP No.");
                                RGPLine.SETRANGE("Line No.", GatePassLine."RGP Line No.");
                                IF RGPLine.FIND('-') THEN BEGIN
                                    IF RGPLine."Pending Qty" - GatePassLine.Quantity < 0 THEN
                                        ERROR('You cannot Post more than Quantity %1 for Line No.', RGPLine."Pending Qty", GatePassLine."Line No.");
                                    RGPLine."Pending Qty" -= GatePassLine.Quantity;
                                    RGPLine.MODIFY;
                                END;
                            UNTIL GatePassLine.NEXT = 0;

                        Rec.TestField(Posted, false);
                        // IF Rec.Posted = FALSE THEN BEGIN
                        IF NOT (CONFIRM(Text_0008, FALSE)) THEN
                            EXIT;

                        GatePassLine.RESET;
                        GatePassLine.SETRANGE(GatePassLine."Document Type", Rec."Document Type");
                        GatePassLine.SETRANGE(GatePassLine."Document No.", Rec."No.");
                        IF GatePassLine.FINDSET THEN
                            REPEAT
                                GatePassLine."Document Date" := Rec."Posting Date";
                                GatePassLine.Posted := TRUE;
                                GatePassLine.MODIFY;
                            UNTIL GatePassLine.NEXT = 0;
                        // END;
                        Rec.Posted := true;
                        GatePassHeader."RRGP POSTED" := true;
                        GatePassHeader.Modify();
                        Message('RRGP Document %1 is Posted', Rec."No.");
                        CurrPage.Update(true);
                    end;
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


    var
        GatePassHeader: Record "GATE PASS HEADER";
        GatePassLine: Record "GATE PASS LINE";
        Text_0008: Label 'Do you wants to Post?';
        RGPLine: Record "GATE PASS LINE";
        RGPGatePassLine: Record "GATE PASS LINE";

}

