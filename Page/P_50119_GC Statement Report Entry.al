page 50119 "GC Statement Report Entry"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
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
                }
                field("Farm Code"; Rec."Farm Code")
                {
                    ApplicationArea = All;
                }
                field("Farm Name"; Rec."Farm Name")
                {
                    ApplicationArea = All;
                }
                field(Region; Rec.Region)
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field(Bank; Rec.Bank)
                {
                    ApplicationArea = All;
                }
                field("IFSC Code"; Rec."IFSC Code")
                {
                    ApplicationArea = All;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = All;
                }
                field("Flock No."; Rec."Flock No.")
                {
                    ApplicationArea = All;
                }
                field("Farmer Name"; Rec."Farmer Name")
                {
                    ApplicationArea = All;
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = All;
                }
                field(Line; Rec.Line)
                {
                    ApplicationArea = All;
                }
                field("Bank Branch"; Rec."Bank Branch")
                {
                    ApplicationArea = All;
                }
                field("PAN No"; Rec."PAN No")
                {
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
                field("Feed Intake"; Rec."Feed Intake")
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
                field("Birds Rearing GC"; Rec."Birds Rearing GC")
                {
                    ApplicationArea = All;
                }
                field("Incentive for Low Cost"; Rec."Incentive for Low Cost")
                {
                    ApplicationArea = All;
                }
                field("Rate Incentive for Selling1"; Rec."Rate Incentive for Selling1")
                {
                    ApplicationArea = All;
                }
                field("Rate Incentive for Selling2"; Rec."Rate Incentive for Selling2")
                {
                    ApplicationArea = All;
                }
                field("Rate Incentive for Selling3"; Rec."Rate Incentive for Selling3")
                {
                    ApplicationArea = All;
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
                field("Deduction for high Mort"; Rec."Deduction for high Mort")
                {
                    ApplicationArea = All;
                }
                field("Excess FCR Over"; Rec."Excess FCR Over")
                {
                    ApplicationArea = All;
                }
                field("Deduction for Shortage"; Rec."Deduction for Shortage")
                {
                    ApplicationArea = All;
                }
                field("TOTAL DEDUCTION(LESS)"; Rec."TOTAL DEDUCTION(LESS)")
                {
                    ApplicationArea = All;
                }
                field("TOTAL AMOUNT PAYABLE"; Rec."TOTAL AMOUNT PAYABLE")
                {
                    ApplicationArea = All;
                }
                field("LESS: T.D.S @ 1%"; Rec."LESS: T.D.S @ 1%")
                {
                    ApplicationArea = All;
                }
                field("AMOUNT PAYABLE AFTER T.D.S"; Rec."AMOUNT PAYABLE AFTER T.D.S")
                {
                    ApplicationArea = All;
                }
                field("SELF  DC NO :"; Rec."SELF  DC NO :")
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
                field("Maize Cost Qty"; Rec."Maize Cost Qty")
                {
                    ApplicationArea = All;
                }
                field("Maize Cost Rate"; Rec."Maize Cost Rate")
                {
                    ApplicationArea = All;
                }
                field("Maize Cost Amt."; Rec."Maize Cost Amt.")
                {
                    ApplicationArea = All;
                }
                field("Medicine Cost Qty"; Rec."Medicine Cost Qty")
                {
                    ApplicationArea = All;
                }
                field("Medicine Cost Rate"; Rec."Medicine Cost Rate")
                {
                    ApplicationArea = All;
                }
                field("Medicne Cost Amt."; Rec."Medicne Cost Amt.")
                {
                    ApplicationArea = All;
                }
                field("Vaccine Cost Qty"; Rec."Vaccine Cost Qty")
                {
                    ApplicationArea = All;
                }
                field("Vaccine Cost Rate"; Rec."Vaccine Cost Rate")
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
                field("Std. Prod Cost"; Rec."Std. Prod Cost")
                {
                    ApplicationArea = All;
                }
                field("Std. Sale Rate"; Rec."Std. Sale Rate")
                {
                    ApplicationArea = All;
                }
                field(Receipt; Rec.Receipt)
                {
                    ApplicationArea = All;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                }
                field("Farmer No."; Rec."Farmer No.")
                {
                    ApplicationArea = All;
                }
                field("Shed Type"; Rec."Shed Type")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Net Payable After TDS"; Rec."Net Payable After TDS")
                {
                    ApplicationArea = All;
                }
                field("Std. GC Rate"; Rec."Std. GC Rate")
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }
                field("Cum. Feed Consuption"; Rec."Cum. Feed Consuption")
                {
                    ApplicationArea = All;
                }
                field("Cum. Feed Std."; Rec."Cum. Feed Std.")
                {
                    ApplicationArea = All;
                }
                field("Total of All Rate Incentive"; Rec."Total of All Rate Incentive")
                {
                    ApplicationArea = All;
                }
                field("Actual Amount"; Rec."Actual Amount")
                {
                    ApplicationArea = All;
                }
                field("Rate Incentive- Actual Amount"; Rec."Rate Incentive- Actual Amount")
                {
                    ApplicationArea = All;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = All;
                }
                field("EEF Incentives range from"; Rec."EEF Incentives range from")
                {
                    ApplicationArea = All;
                }
                field("Max Rate Incentive Upto 2.5"; Rec."Max Rate Incentive Upto 2.5")
                {
                    ApplicationArea = All;
                }
                field("1st week mortality %"; Rec."1st week mortality %")
                {
                    ApplicationArea = All;
                }
                field("Brooding Incentive"; Rec."Brooding Incentive")
                {
                    ApplicationArea = All;
                }
                field("1st week mortality"; Rec."1st week mortality")
                {
                    ApplicationArea = All;
                }
                field("Bird Rearing Charge for CB-New"; Rec."Bird Rearing Charge for CB-New")
                {
                    ApplicationArea = All;
                }
                field("Std. Admin Cost"; Rec."Std. Admin Cost")
                {
                    ApplicationArea = All;
                }
                field("Last USERID"; Rec."Last USERID")
                {
                    ApplicationArea = All;
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    ApplicationArea = All;
                }
                field("FEED Freight Charges"; Rec."FEED Freight Charges")
                {
                    ApplicationArea = All;
                }
                field("Deduction for high Prod. Cost"; Rec."Deduction for high Prod. Cost")
                {
                    ApplicationArea = All;
                }
                field("Min. Growing Charge"; Rec."Min. Growing Charge")
                {
                    ApplicationArea = All;
                }
                field("Other Supplement"; Rec."Other Supplement")
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

