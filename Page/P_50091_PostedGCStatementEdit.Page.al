page 50091 "Posted GC Statement- Edit"
{
    PageType = List;
    SourceTable = "GC Statement";
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
                    Editable = false;
                }
                field("Farm Code"; Rec."Farm Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Farm Name"; Rec."Farm Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Region; Rec.Region)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Bank; Rec.Bank)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("IFSC Code"; Rec."IFSC Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Flock No."; Rec."Flock No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Farmer Name"; Rec."Farmer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Line; Rec.Line)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bank Branch"; Rec."Bank Branch")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("PAN No"; Rec."PAN No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Hatchery/Vendor"; Rec."Hatchery/Vendor")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(EEF; Rec.EEF)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Chick Housed"; Rec."Chick Housed")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Birds Sold (kg)"; Rec."Birds Sold (kg)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    ApplicationArea = All;
                }
                field("Birds Sold (Nos)"; Rec."Birds Sold (Nos)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Feed Consumption(kgs)"; Rec."Feed Consumption(kgs)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Accidental Mort(Recovery)"; Rec."Accidental Mort(Recovery)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("<HatcharyName>"; HatcharyName)
                {
                    ApplicationArea = All;
                    Caption = 'HatcharyName';
                }
                field("<FlockDiscription>"; FlockDiscription)
                {
                    ApplicationArea = All;
                    Caption = 'FlockDiscription';
                }
                field("Liquidation Date"; Rec."Liquidation Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Mortality; Rec.Mortality)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Mortality %"; Rec."Mortality %")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Body Weight %"; Rec."Body Weight %")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Short Excess"; Rec."Short Excess")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Mean Age"; Rec."Mean Age")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Age (In Days)"; Rec."Age (In Days)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sale rate"; Rec."Sale rate")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sale Amount"; Rec."Sale Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(FCR; Rec.FCR)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(CFCR; Rec.CFCR)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Production Cost"; Rec."Production Cost")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Birds Rearing GC"; Rec."Birds Rearing GC")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Incentive for Low Cost"; Rec."Incentive for Low Cost")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Rate Incentive for Selling1"; Rec."Rate Incentive for Selling1")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Rate Incentive for Selling2"; Rec."Rate Incentive for Selling2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Rate Incentive for Selling3"; Rec."Rate Incentive for Selling3")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Summary Incentive1"; Rec."Summary Incentive1")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Summary Incentive2"; Rec."Summary Incentive2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Feed Unloading Charges"; Rec."Feed Unloading Charges")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Incentive (Add)"; Rec."Total Incentive (Add)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Deduction for high Mort"; Rec."Deduction for high Mort")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Excess FCR Over"; Rec."Excess FCR Over")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Deduction for Shortage"; Rec."Deduction for Shortage")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("TOTAL DEDUCTION(LESS)"; Rec."TOTAL DEDUCTION(LESS)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("TOTAL AMOUNT PAYABLE"; Rec."TOTAL AMOUNT PAYABLE")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("LESS: T.D.S @ 1%"; Rec."LESS: T.D.S @ 1%")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("AMOUNT PAYABLE AFTER T.D.S"; Rec."AMOUNT PAYABLE AFTER T.D.S")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("SELF  DC NO :"; Rec."SELF  DC NO :")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("AMOUNT payable per bird"; Rec."AMOUNT payable per bird")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("G.M."; Rec."G.M.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("D.G.M"; Rec."D.G.M")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("A.G.M. Accounts"; Rec."A.G.M. Accounts")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Asst.  Manager Accounts"; Rec."Asst.  Manager Accounts")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Zone Manager"; Rec."Zone Manager")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Branch Manager"; Rec."Branch Manager")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Account Officer"; Rec."Account Officer")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Checked By"; Rec."Checked By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("I Accept the above payment"; Rec."I Accept the above payment")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Farmer Signature"; Rec."Farmer Signature")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Chick Cost Qty"; Rec."Chick Cost Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Chick Cost Rate"; Rec."Chick Cost Rate")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Chik Cost Amt."; Rec."Chik Cost Amt.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Feed Cost Qty"; Rec."Feed Cost Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Feed Cost Rate"; Rec."Feed Cost Rate")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Feed Cost Amt."; Rec."Feed Cost Amt.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Maize Cost Qty"; Rec."Maize Cost Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Maize Cost Rate"; Rec."Maize Cost Rate")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Maize Cost Amt."; Rec."Maize Cost Amt.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Medicine Cost Qty"; Rec."Medicine Cost Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Medicine Cost Rate"; Rec."Medicine Cost Rate")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Medicne Cost Amt."; Rec."Medicne Cost Amt.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vaccine Cost Qty"; Rec."Vaccine Cost Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vaccine Cost Rate"; Rec."Vaccine Cost Rate")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vaccine Cost Amt."; Rec."Vaccine Cost Amt.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("AdministrationCost Rs2.2/Bird2"; Rec."AdministrationCost Rs2.2/Bird2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("TOTAL COST OF PRODUCTION2"; Rec."TOTAL COST OF PRODUCTION2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cost of Prod./kg Before RC2"; Rec."Cost of Prod./kg Before RC2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bird Sold IN Kg.2  Qty."; Rec."Bird Sold IN Kg.2  Qty.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bird Sold IN Kg.2  Rate"; Rec."Bird Sold IN Kg.2  Rate")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bird Sold IN Kg.2  Amt."; Rec."Bird Sold IN Kg.2  Amt.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bird Sold IN No. Qty."; Rec."Bird Sold IN No. Qty.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bird Sold IN No. Rate"; Rec."Bird Sold IN No. Rate")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bird Sold IN No. Amt."; Rec."Bird Sold IN No. Amt.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cost of Prod. After RC2"; Rec."Cost of Prod. After RC2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cost of Production Per Kg.2"; Rec."Cost of Production Per Kg.2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("F.C.R2"; Rec."F.C.R2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Average Body weight2"; Rec."Average Body weight2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Prod. Cost After RC2"; Rec."Prod. Cost After RC2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("SALE AMOUNT2"; Rec."SALE AMOUNT2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("NET PROFIT / (LOSS)"; Rec."NET PROFIT / (LOSS)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("NET PROFIT/ (LOSS)/BIRD"; Rec."NET PROFIT/ (LOSS)/BIRD")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cost of Production Per Bird"; Rec."Cost of Production Per Bird")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Std. Prod Cost"; Rec."Std. Prod Cost")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Std. Sale Rate"; Rec."Std. Sale Rate")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Receipt; Rec.Receipt)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Farmer No."; Rec."Farmer No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shed Type"; Rec."Shed Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("1st week mortality %"; Rec."1st week mortality %")
                {
                    ApplicationArea = All;
                }
                field("1st week mortality"; Rec."1st week mortality")
                {
                    ApplicationArea = All;
                }
                field("Other Supplement"; Rec."Other Supplement")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(HatchDate; HatchDate)
                {
                    ApplicationArea = All;
                    Caption = 'Hatching Date';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Net Payable After TDS"; Rec."Net Payable After TDS")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Std. GC Rate"; Rec."Std. GC Rate")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Total of All Rate Incentive"; Rec."Total of All Rate Incentive")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Actual Amount"; Rec."Actual Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Rate Incentive- Actual Amount"; Rec."Rate Incentive- Actual Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("EEF Incentives range from"; Rec."EEF Incentives range from")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Max Rate Incentive Upto 2.5"; Rec."Max Rate Incentive Upto 2.5")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Min. Growing Charge"; Rec."Min. Growing Charge")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        CLEAR(FlockDiscription);

        ProductionOrder.RESET;
        ProductionOrder.SETRANGE("No.", Rec."Flock No.");
        IF ProductionOrder.FINDFIRST THEN BEGIN
            FlockDiscription := ProductionOrder."Description 2";
            HatcharyName := ProductionOrder."Hatchery Name";
            HatchDate := ProductionOrder."Hatching Date";

        END;
    end;

    var
        FlockDiscription: Text;
        ProductionOrder: Record 5405;
        HatcharyName: Text;
        HatchDate: Date;
}

