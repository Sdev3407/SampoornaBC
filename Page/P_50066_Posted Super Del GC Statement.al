page 50066 "Posted Super Del GC Statement"
{
    AutoSplitKey = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "GC Statement";
    SourceTableView = SORTING("Shed Type", "No.")
                      WHERE("Shed Type" = CONST("Super Deluxe"),
                            Posted = CONST(true));
    ApplicationArea = All;
    UsageCategory = Documents;

    layout
    {
        area(content)
        {
            group(General)
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
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
                field("Hatchery/Vendor"; Rec."Hatchery/Vendor")
                {
                    ApplicationArea = All;
                }
                field(EEF; Rec.EEF)
                {
                    ApplicationArea = All;
                }
                field("Chick Housed"; Rec."Chick Housed")
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
                field("Feed Consumption(kgs)"; Rec."Feed Consumption(kgs)")
                {
                    ApplicationArea = All;
                }
                field("Accidental Mort(Recovery)"; Rec."Accidental Mort(Recovery)")
                {
                    ApplicationArea = All;
                }
                field("Liquidation Date"; Rec."Liquidation Date")
                {
                    ApplicationArea = All;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    ApplicationArea = All;
                }
                field(Mortality; Rec.Mortality)
                {
                    ApplicationArea = All;
                }
                field("Mortality %"; Rec."Mortality %")
                {
                    ApplicationArea = All;
                }
                field("Body Weight %"; Rec."Body Weight %")
                {
                    ApplicationArea = All;
                }
                field("Short Excess"; Rec."Short Excess")
                {
                    ApplicationArea = All;
                }
                field("Mean Age"; Rec."Mean Age")
                {
                    ApplicationArea = All;
                }
                field("Age (In Days)"; Rec."Age (In Days)")
                {
                    ApplicationArea = All;
                }
                field("Sale rate"; Rec."Sale rate")
                {
                    ApplicationArea = All;
                }
                field("Sale Amount"; Rec."Sale Amount")
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
                field("Production Cost"; Rec."Production Cost")
                {
                    ApplicationArea = All;
                }
                field("PAN No"; Rec."PAN No")
                {
                    ApplicationArea = All;
                }
                field("SELF  DC NO :"; Rec."SELF  DC NO :")
                {
                    ApplicationArea = All;
                    Caption = 'SELF  DC Amount';
                }
                field("Net Payable After TDS"; Rec."Net Payable After TDS")
                {
                    ApplicationArea = All;
                }
                field("TOTAL AMOUNT PAYABLE"; Rec."TOTAL AMOUNT PAYABLE")
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
            group("CALUATION OF REARING CHARGES")
            {
                Caption = 'CALUATION OF REARING CHARGES';
                field("Birds Rearing GC"; Rec."Birds Rearing GC")
                {
                    ApplicationArea = All;
                    Caption = 'Birds Rearing (Growing) Charges for live Grown-up  Comm. Br. Bird @ Rs. 7 per Kg.';
                }
            }
            group("ADD :INCENTIVE")
            {
                Caption = 'ADD :INCENTIVE';
                Visible = false;
                field("Incentive for Low Cost"; Rec."Incentive for Low Cost")
                {
                    ApplicationArea = All;
                }
                field("Rate Incentive for Selling1"; Rec."Rate Incentive for Selling1")
                {
                    ApplicationArea = All;
                    Caption = 'Rate Incentive for Selling price above  Rs. 72.01 to Rs. 77.00 @ Rs. 0.05 for every one Rupee per Kg. Live Bird';
                }
                field("Rate Incentive for Selling2"; Rec."Rate Incentive for Selling2")
                {
                    ApplicationArea = All;
                    Caption = 'Rate Incentive for Selling price above  Rs. 77.01  Rs.82.00 to above @ Rs. 0.10 for every one Rupee per Kg. Live Bird';
                }
                field("Rate Incentive for Selling3"; Rec."Rate Incentive for Selling3")
                {
                    ApplicationArea = All;
                    Caption = 'Rate Incentive for Selling price above  Rs. 82.01  to 93.67 @ Rs. 0.15 for every one Rupee per Kg. Live Bird';
                }
                field("Summary Incentive1"; Rec."Summary Incentive1")
                {
                    ApplicationArea = All;
                }
                field("Summary Incentive2"; Rec."Summary Incentive2")
                {
                    ApplicationArea = All;
                }
                field("Feed Unloading Charges"; Rec."Feed Unloading Charges")
                {
                    ApplicationArea = All;
                }
                field("Total Incentive (Add)"; Rec."Total Incentive (Add)")
                {
                    ApplicationArea = All;
                }
            }
            group("LESS :DEDUCTION")
            {
                Caption = 'LESS :DEDUCTION';
                Visible = false;
                field("Deduction for high Mort"; Rec."Deduction for high Mort")
                {
                    ApplicationArea = All;
                    Caption = 'Deduction for high mortality @ Rs*average Body weight for every Mortality above subject to maximum No. of Birds*Body weight * Rs/-';
                    MultiLine = true;
                    Width = 500;
                }
                field("Excess FCR Over"; Rec."Excess FCR Over")
                {
                    ApplicationArea = All;
                }
                field("Deduction for Shortage"; Rec."Deduction for Shortage")
                {
                    ApplicationArea = All;
                    Caption = 'Deduction for Shortage Average Body weight of Flock * Rate65or prevailing market price whichever is higher';
                }
                field("LESS: T.D.S @ 1%"; Rec."LESS: T.D.S @ 1%")
                {
                    ApplicationArea = All;
                }
                field("TOTAL DEDUCTION(LESS)"; Rec."TOTAL DEDUCTION(LESS)")
                {
                    ApplicationArea = All;
                }
                field("AMOUNT PAYABLE AFTER T.D.S"; Rec."AMOUNT PAYABLE AFTER T.D.S")
                {
                    ApplicationArea = All;
                }
                field("AMOUNT payable per bird"; Rec."AMOUNT payable per bird")
                {
                    ApplicationArea = All;
                }
                field("G.M."; Rec."G.M.")
                {
                    ApplicationArea = All;
                }
                field("D.G.M"; Rec."D.G.M")
                {
                    ApplicationArea = All;
                }
                field("A.G.M. Accounts"; Rec."A.G.M. Accounts")
                {
                    ApplicationArea = All;
                }
                field("Asst.  Manager Accounts"; Rec."Asst.  Manager Accounts")
                {
                    ApplicationArea = All;
                }
                field("Zone Manager"; Rec."Zone Manager")
                {
                    ApplicationArea = All;
                }
                field("Branch Manager"; Rec."Branch Manager")
                {
                    ApplicationArea = All;
                }
                field("Account Officer"; Rec."Account Officer")
                {
                    ApplicationArea = All;
                }
                field("Checked By"; Rec."Checked By")
                {
                    ApplicationArea = All;
                }
                field("I Accept the above payment"; Rec."I Accept the above payment")
                {
                    ApplicationArea = All;
                }
                field("Farmer Signature"; Rec."Farmer Signature")
                {
                    ApplicationArea = All;
                }
            }
            group(COSTING)
            {
                Caption = 'COSTING';
                field("Other Supplement"; Rec."Other Supplement")
                {
                    ApplicationArea = All;
                    Caption = 'Other Supplement Cost Amt.';
                }
                field("Chick Cost Qty"; Rec."Chick Cost Qty")
                {
                    ApplicationArea = All;
                }
                field("Chick Cost Rate"; Rec."Chick Cost Rate")
                {
                    ApplicationArea = All;
                }
                field("Chik Cost Amt."; Rec."Chik Cost Amt.")
                {
                    ApplicationArea = All;
                    Caption = 'Chick Cost Amt.';
                }
                field("Feed Cost Qty"; Rec."Feed Cost Qty")
                {
                    ApplicationArea = All;
                }
                field("Feed Cost Rate"; Rec."Feed Cost Rate")
                {
                    ApplicationArea = All;
                }
                field("Feed Cost Amt."; Rec."Feed Cost Amt.")
                {
                    ApplicationArea = All;
                }
                field("Maize Cost Amt."; Rec."Maize Cost Amt.")
                {
                    ApplicationArea = All;
                }
                field("Medicne Cost Amt."; Rec."Medicne Cost Amt.")
                {
                    ApplicationArea = All;
                }
                field("Vaccine Cost Amt."; Rec."Vaccine Cost Amt.")
                {
                    ApplicationArea = All;
                }
                field("AdministrationCost Rs2.2/Bird2"; Rec."AdministrationCost Rs2.2/Bird2")
                {
                    ApplicationArea = All;
                }
                field("TOTAL COST OF PRODUCTION2"; Rec."TOTAL COST OF PRODUCTION2")
                {
                    ApplicationArea = All;
                }
                field("Cost of Prod./kg Before RC2"; Rec."Cost of Prod./kg Before RC2")
                {
                    ApplicationArea = All;
                }
            }
            group("REARING CHARGES")
            {
                Caption = 'REARING CHARGES';
                field("Bird Sold IN Kg.2  Qty."; Rec."Bird Sold IN Kg.2  Qty.")
                {
                    ApplicationArea = All;
                }
                field("Bird Sold IN Kg.2  Rate"; Rec."Bird Sold IN Kg.2  Rate")
                {
                    ApplicationArea = All;
                }
                field("Bird Sold IN Kg.2  Amt."; Rec."Bird Sold IN Kg.2  Amt.")
                {
                    ApplicationArea = All;
                }
                field("Bird Sold IN No. Qty."; Rec."Bird Sold IN No. Qty.")
                {
                    ApplicationArea = All;
                }
                field("Bird Sold IN No. Rate"; Rec."Bird Sold IN No. Rate")
                {
                    ApplicationArea = All;
                }
                field("Bird Sold IN No. Amt."; Rec."Bird Sold IN No. Amt.")
                {
                    ApplicationArea = All;
                }
                field("Cost of Prod. After RC2"; Rec."Cost of Prod. After RC2")
                {
                    ApplicationArea = All;
                }
                field("Cost of Production Per Kg.2"; Rec."Cost of Production Per Kg.2")
                {
                    ApplicationArea = All;
                }
                field("F.C.R2"; Rec."F.C.R2")
                {
                    ApplicationArea = All;
                }
                field("Average Body weight2"; Rec."Average Body weight2")
                {
                    ApplicationArea = All;
                }
                field("Prod. Cost After RC2"; Rec."Prod. Cost After RC2")
                {
                    ApplicationArea = All;
                }
                field("SALE AMOUNT2"; Rec."SALE AMOUNT2")
                {
                    ApplicationArea = All;
                }
                field("NET PROFIT / (LOSS)"; Rec."NET PROFIT / (LOSS)")
                {
                    ApplicationArea = All;
                }
                field("NET PROFIT/ (LOSS)/BIRD"; Rec."NET PROFIT/ (LOSS)/BIRD")
                {
                    ApplicationArea = All;
                }
                field("Cost of Production Per Bird"; Rec."Cost of Production Per Bird")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("GC Report")
            {
                Caption = 'GC Report';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                ApplicationArea = All;
                trigger OnAction()
                var
                    GCStatement: Record "GC Statement";
                begin

                    OptionTypeReport;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        userset.GET(USERID);
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Shortcut Dimension 1 Code", userset."Global Dimension 1 Code");
        Rec.SETFILTER("Shortcut Dimension 2 Code", userset."Global Dimension 2 Code");
        IF NOT userset."HO Users" THEN
            Rec.SETFILTER("Shortcut Dimension 3 Code", userset."Shortcut Dimension 3 Code");
        Rec.FILTERGROUP(0);
    end;

    var
        userset: Record 91;

    local procedure OptionTypeReport()
    var
        Selection: Integer;
        Oldgcreport: Boolean;
        Gcreport: Boolean;
        GCStatement: Record "GC Statement";
        Text000: Label '&Print New GC Report,&Print Old GC Report';
    begin
        CLEAR(Gcreport);
        CLEAR(Oldgcreport);
        Selection := STRMENU(Text000, 1);
        IF Selection = 0 THEN
            EXIT;

        Gcreport := Selection IN [1, 3];
        Oldgcreport := Selection IN [2, 3];


        IF Gcreport = TRUE THEN BEGIN
            GCStatement.RESET;
            GCStatement.SETRANGE("Shed Type", Rec."Shed Type");
            GCStatement.SETRANGE("No.", Rec."No.");
            IF GCStatement.FINDFIRST THEN
                REPORT.RUNMODAL(50019, TRUE, FALSE, GCStatement);
        END;

        IF Oldgcreport = TRUE THEN BEGIN
            GCStatement.RESET;
            GCStatement.SETRANGE("Shed Type", Rec."Shed Type");
            GCStatement.SETRANGE("No.", Rec."No.");
            IF GCStatement.FINDFIRST THEN
                REPORT.RUNMODAL(50024, TRUE, FALSE, GCStatement);
        END;
    end;
}

