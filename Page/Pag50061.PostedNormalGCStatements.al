page 50061 "Posted Normal GC Statements"
{
    CardPageID = "Posted GC Statement";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "GC Statement";
    SourceTableView = WHERE("Shed Type" = CONST(Normal),
                            Posted = CONST(true));
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

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Farmer No."; Rec."Farmer No.")
                {
                    ApplicationArea = All;
                }
                field("Farmer Name"; Rec."Farmer Name")
                {
                    ApplicationArea = All;
                }
                field("Farm Code"; Rec."Farm Code")
                {
                    ApplicationArea = All;
                }
                field("Farm Name"; Rec."Farm Name")
                {
                    ApplicationArea = All;
                }
                field("Flock No."; Rec."Flock No.")
                {
                    ApplicationArea = All;
                }
                field("TOTAL AMOUNT PAYABLE"; Rec."TOTAL AMOUNT PAYABLE")
                {
                    ApplicationArea = All;
                }
                field("Net Payable After TDS"; Rec."Net Payable After TDS")
                {
                    ApplicationArea = All;
                }
                field("PAN No"; Rec."PAN No")
                {
                    ApplicationArea = All;
                }
                field("Liquidation Date"; Rec."Liquidation Date")
                {
                    ApplicationArea = All;
                }
                field("Birds Sold (kg)"; Rec."Birds Sold (kg)")
                {
                    ApplicationArea = All;
                }
                field("Birds Sold (Nos)"; Rec."Birds Sold (Nos)")
                {
                    ApplicationArea = All;
                }
                field("SELF  DC NO :"; Rec."SELF  DC NO :")
                {
                    ApplicationArea = All;
                    Caption = 'Self DC Amt.';
                }
                field(EEF; Rec.EEF)
                {
                    ApplicationArea = All;
                }
                field(FCR; Rec.FCR)
                {
                    ApplicationArea = All;
                }
                field(CFCR; Rec.CFCR)
                {
                    ApplicationArea = All;
                }
                field("Last Modified USERID"; Rec."Last USERID")
                {
                    ApplicationArea = All;
                    Caption = 'Last Modified USERID';
                    Editable = false;
                }
                field("Last Modified Date"; Rec."Modified Date")
                {
                    ApplicationArea = All;
                    Caption = 'Last Modified Date';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Send Whatsapp")
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    WhatsAppDetail: Codeunit "WhatsApp Function";
                    SMSfunctions: Codeunit SmsSentjobQueue;

                begin

                    // WhatsAppDetail.WhatsAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(Rec."Shortcut Dimension 2 Code"), Rec."Farm Name", Rec."Receipt Date", Rec."Chick Housed", Rec.Mortality, Rec."Mortality %",
                    //                        Rec."Mean Age", Rec."Average Body weight2", ROUND(Rec.FCR, 0.001, '='), ROUND(Rec.CFCR, 0.001, '='), Rec.EEF, ROUND(Rec."Sale rate", 0.01, '='), '9759785217'));
                end;


            }
        }
    }



    trigger OnOpenPage()
    var
        userset: Record 91;
    begin
        userset.GET(USERID);
        ///IF NOT userset."HO Users" THEN BEGIN
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Shortcut Dimension 1 Code", userset."Global Dimension 1 Code");
        Rec.SETFILTER("Shortcut Dimension 2 Code", userset."Global Dimension 2 Code");
        IF NOT userset."HO Users" THEN
            Rec.SETFILTER("Shortcut Dimension 3 Code", userset."Shortcut Dimension 3 Code");
        Rec.FILTERGROUP(0);
        ///END;
    end;

    local procedure GetBranchName(DimCode: Code[20]): Text
    var
        DimensionValue: Record 349;
    begin
        DimensionValue.RESET;
        DimensionValue.SETRANGE(DimensionValue."Global Dimension No.", 2);
        DimensionValue.SETRANGE(DimensionValue."Dimension Code", 'BRANCH');
        DimensionValue.SETRANGE(DimensionValue.Code, DimCode);
        IF DimensionValue.FINDFIRST THEN
            EXIT(DimensionValue.Name);
    end;
}

