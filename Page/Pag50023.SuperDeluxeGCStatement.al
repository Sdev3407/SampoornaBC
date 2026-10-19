page 50023 "Super Deluxe GC Statement"
{
    AutoSplitKey = false;
    DeleteAllowed = true;
    PageType = Card;
    SourceTable = "GC Statement";
    SourceTableView = SORTING("Shed Type", "No.")
                      WHERE("Shed Type" = CONST("Super Deluxe"),
                            Posted = CONST(false));
    //  ApplicationArea = All;
    // UsageCategory = Documents;
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
                field("Std. Prod Cost"; Rec."Std. Prod Cost")
                {
                    ApplicationArea = All;
                }
                field("Std. Sale Rate"; Rec."Std. Sale Rate")
                {
                    ApplicationArea = All;
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

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE(TRUE);//UPDATE
                    end;
                }
                field("Farm Name"; Rec."Farm Name")
                {
                    ApplicationArea = All;
                }
                field("Flock No."; Rec."Flock No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE(TRUE);//UPDATE
                    end;
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                    ApplicationArea = All;
                }
                field("TDS Section"; Rec."TDS Section")
                {
                    ApplicationArea = All;
                }
                field("Customer Code"; Rec."Customer Code")
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
                    trigger OnValidate()

                    begin
                        if Rec."Liquidation Date" <> Today then
                            Error('Please Seelct the Today Date only Back date is not allowed');
                    end;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE(TRUE);//UPDATE
                    end;
                }
                field(Mortality; Rec.Mortality)
                {
                    ApplicationArea = All;
                }
                field("Mortality %"; Rec."Mortality %")
                {
                    ApplicationArea = All;
                }
                field("1st week mortality %"; Rec."1st week mortality %")
                {
                    ApplicationArea = All;
                }
                field("1st week mortality"; Rec."1st week mortality")
                {
                    ApplicationArea = All;
                }
                field("Brooding Incentive"; Rec."Brooding Incentive")
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
                field("Last Modified USERID"; Rec."Last USERID")
                {
                    ApplicationArea = All;
                    Caption = 'Last Modified USERID';
                }
                field("Last Modified Date"; Rec."Modified Date")
                {
                    ApplicationArea = All;
                    Caption = 'Last Modified Date';
                }
            }
            group("CALUATION OF REARING CHARGES")
            {
                Caption = 'CALUATION OF REARING CHARGES';
                field("Birds Rearing GC"; Rec."Birds Rearing GC")
                {
                    ApplicationArea = All;
                    Caption = 'Birds Rearing (Growing) Charges for live Grown-up  Comm. Br. Bird @ Rs. 6 per Kg.';
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
                field("Max Rate Incentive Upto 2.5"; Rec."Max Rate Incentive Upto 2.5")
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
            }
            group("LESS :DEDUCTION")
            {
                Caption = 'LESS :DEDUCTION';
                Visible = true;
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
                field(Receipt; Rec.Receipt)
                {
                    ApplicationArea = All;
                }
                field("Net Payable After TDS"; Rec."Net Payable After TDS")
                {
                    ApplicationArea = All;
                    Caption = 'Net Payable';
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
            action("Gc Calculation")
            {
                Image = Group;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    T5405: Record 5405;
                    Location: Record 14;
                    T50020: Record 50020;
                    MedicineAmt: Decimal;
                    T32: Record 32;
                    T14: Record 14;
                    T5407: Record 5407;
                    DEL: Record 50005;
                    MortalityValue: Decimal;
                    SalesAmt: Decimal;
                    SSL: Record 111;
                    BirdSales: Decimal;
                    TotalSales: Decimal;
                    DiffDateSales: Integer;
                    FeedConsumption: Decimal;
                    FeedPositiveAdj: Decimal;
                    MortalityOpening: Decimal;
                    T50021: Record "GC Standard Cost";
                    Whicheverishigher: Decimal;
                    BirdSoldShipmentKg: Decimal;
                    BirdSoldShipmentNos: Decimal;
                    BirdSoldCMKg: Decimal;
                    BirdSoldCMNos: Decimal;
                    ILE: Record 32;
                    DebitNoteQty: Decimal;
                begin
                    Rec.GCCalculation1;
                    "CalculateFeedIntake&UpdateFlockMaster"(Rec."Flock No.");

                    /*
                    TESTFIELD("Flock No.");
                    Location.GET("Farm Code");
                    T50021.RESET;
                    T50021.SETRANGE("Shed Type","Shed Type");
                    T50021.SETRANGE("State Code",Location."State Code");
                    IF T50021.FINDFIRST THEN BEGIN
                      "Std. Prod Cost" := T50021."Std. Production Cost";
                      "Std. Sale Rate" := T50021."Std. Sales Rate";
                      "Std. GC Rate" := T50021."Std. GC Rate";
                    END;
                    
                    T32.RESET;
                    T32.SETCURRENTKEY("Entry Type","Flock No.","Item Type","Location Code");
                    T32.SETRANGE("Item Type",T32."Item Type"::Feed);
                    T32.SETRANGE("Location Code","Farm Code");
                    T32.CALCSUMS(Quantity);
                    IF T32.Quantity > 0 THEN
                      ERROR('GC Cannot be calculated due to feed stock available in %1 Location',"Farm Code");
                    
                    CLEAR(DebitNoteQty);
                    ILE.RESET;
                    ILE.SETCURRENTKEY("Entry Type","Flock No.","Item Type","Location Code");
                    ILE.SETRANGE("Location Code","Farm Code");
                    ILE.SETRANGE("Flock No.","Flock No.");
                    ILE.SETRANGE("Item Type",ILE."Item Type"::Chick);
                    ILE.SETRANGE("Document Type",ILE."Document Type"::"Transfer Shipment");
                    ILE.SETRANGE("Debit Note Type",ILE."Debit Note Type"::"Debit Note");
                    IF ILE.FINDFIRST THEN REPEAT
                      DebitNoteQty:=-(ILE.Quantity);
                      UNTIL ILE.NEXT=0;
                    
                    T5405.RESET;
                    T5405.SETRANGE("No.","Flock No.");
                    IF T5405.FINDFIRST THEN;
                      "Chick Housed" := ABS(ROUND(T5405.Quantity-DebitNoteQty,0.01,'='));
                    T14.GET("Farm Code");
                    T14.TESTFIELD("Liquidation Date");
                    CLEAR(MedicineAmt);
                    CLEAR(SalesAmt);
                    CLEAR(BirdSales);
                    CLEAR(TotalSales);
                    CLEAR(DiffDateSales);
                    CLEAR(FeedConsumption);
                    CLEAR(FeedPositiveAdj);
                    CLEAR(MortalityOpening);
                    CLEAR(BirdSoldCMKg);
                    CLEAR(BirdSoldCMNos);
                    CLEAR(BirdSoldShipmentKg);
                    CLEAR(BirdSoldShipmentNos);
                    "Liquidation Date" := T14."Liquidation Date";
                    "Receipt Date" := T5405."Starting Date";
                    CLEAR(MortalityValue);
                    DEL.RESET;
                    DEL.SETRANGE("Flock No.","Flock No.");
                    DEL.SETRANGE(Posted,TRUE);
                    DEL.SETFILTER("Mortality Type",'<>%1',DEL."Mortality Type"::" ");
                    DEL.SETRANGE("Exclude Quantity of Mortality",FALSE);
                    IF DEL.FINDSET THEN REPEAT
                      MortalityValue += (DEL."Actual Value"-DEL."Reverse Qty.");
                    UNTIL DEL.NEXT=0;
                    T32.RESET;
                    T32.SETCURRENTKEY("Entry Type","Flock No.","Item Type","Location Code");
                    T32.SETRANGE("Entry Type",T32."Entry Type"::Consumption);
                    T32.SETRANGE("Document No.","Flock No.");
                    T32.SETRANGE("Item Type",T32."Item Type"::Chick);
                    T32.SETRANGE("Location Code","Farm Code");
                    T32.SETFILTER("Posting Date",'<%1',010418D);
                    T32.CALCSUMS(Quantity);
                    MortalityOpening := ABS(T32.Quantity);
                    Mortality := ROUND(ABS(MortalityValue)+ ABS(MortalityOpening),0.01,'=');
                    CLEAR(FeedConsumption);
                    CLEAR(FeedPositiveAdj);
                    T32.RESET;
                    T32.SETCURRENTKEY("Entry Type","Flock No.","Item Type","Location Code");
                    T32.SETRANGE("Entry Type",T32."Entry Type"::Consumption);
                    T32.SETRANGE("Document No.","Flock No.");
                    T32.SETRANGE("Item Type",T32."Item Type"::Feed);
                    T32.SETRANGE("Location Code","Farm Code");
                    T32.CALCSUMS(Quantity);
                    FeedConsumption := ABS(T32.Quantity);
                    T32.RESET;
                    T32.SETCURRENTKEY("Entry Type","Flock No.","Item Type","Location Code");
                    T32.SETRANGE("Entry Type",T32."Entry Type"::"Positive Adjmt.");
                    T32.SETRANGE("Document No.","Flock No.");
                    T32.SETRANGE("Item Type",T32."Item Type"::Feed);
                    T32.SETRANGE("Location Code","Farm Code");
                    T32.CALCSUMS(Quantity);
                    FeedPositiveAdj := ABS(T32.Quantity);
                    "Feed Consumption(kgs)" := ROUND(FeedConsumption-FeedPositiveAdj,0.01,'=');
                    T32.RESET;
                    T32.SETCURRENTKEY("Entry Type","Flock No.","Item Type","Location Code");
                    T32.SETRANGE("Entry Type",T32."Entry Type"::Sale);
                    T32.SETRANGE("Document Type",T32."Document Type"::"Sales Shipment");
                    T32.SETRANGE("Flock No.","Flock No.");
                    T32.SETRANGE("Item Type",T32."Item Type"::Bird);
                    T32.SETRANGE("Location Code","Farm Code");
                    T32.CALCSUMS(Quantity,"Alternate Quantity");
                    BirdSoldShipmentKg := ROUND(ABS(T32.Quantity),0.01,'=');
                    BirdSoldShipmentNos := ROUND(ABS(T32."Alternate Quantity"),0.01,'=');
                    T32.RESET;
                    T32.SETCURRENTKEY("Entry Type","Flock No.","Item Type","Location Code");
                    T32.SETRANGE("Entry Type",T32."Entry Type"::Sale);
                    T32.SETRANGE("Document Type",T32."Document Type"::"Sales Credit Memo");
                    T32.SETRANGE("Flock No.","Flock No.");
                    T32.SETRANGE("Item Type",T32."Item Type"::Bird);
                    T32.SETRANGE("Location Code","Farm Code");
                    T32.CALCSUMS(Quantity,"Alternate Quantity");
                    BirdSoldCMKg := ROUND(ABS(T32.Quantity),0.01,'=');
                    BirdSoldCMNos := ROUND(ABS(T32."Alternate Quantity"),0.01,'=');
                    "Birds Sold (kg)" := BirdSoldShipmentKg - BirdSoldCMKg;
                    "Birds Sold (Nos)" := BirdSoldShipmentNos-BirdSoldCMNos;
                    SSL.RESET;
                    SSL.SETRANGE("Flock No.","Flock No.");
                    SSL.SETRANGE("Item Type",SSL."Item Type"::Bird);
                    IF SSL.FINDFIRST THEN REPEAT
                      DiffDateSales := SSL."Posting Date"-"Receipt Date";
                      BirdSales += SSL."Alternate Quantity";
                      TotalSales += SSL."Alternate Quantity"*DiffDateSales;
                    UNTIL SSL.NEXT=0;
                    "Mean Age" := ROUND(TotalSales/BirdSales,0.01,'=');
                    
                    "Mortality %" := ROUND(ABS(Mortality/"Chick Housed")*100,0.01,'=');
                    "Body Weight %" := ROUND(ABS("Birds Sold (kg)"/"Birds Sold (Nos)"),0.001,'=');
                    "Age (In Days)" := "Liquidation Date"-"Receipt Date";
                    
                    FCR := ROUND(ABS("Feed Consumption(kgs)"/"Birds Sold (kg)"),0.001,'=');
                    CFCR := ROUND(ABS((2-"Body Weight %")/4+FCR),0.001,'=');
                    EEF:=ROUND(((100-"Mortality %")*"Body Weight %"/(FCR*"Mean Age")*100),0.01,'='); //Rk-PRU
                    "Age (In Days)":="Liquidation Date"-"Receipt Date"+1; //RK-PRU
                    T32.RESET;
                    T32.SETCURRENTKEY("Entry Type","Flock No.","Item Type","Location Code");
                    T32.SETRANGE("Entry Type",T32."Entry Type"::Sale);
                    T32.SETRANGE("Flock No.","Flock No.");
                    T32.SETRANGE("Item Type",T32."Item Type"::Bird);
                    T32.SETRANGE("Location Code","Farm Code");
                    T32.SETAUTOCALCFIELDS("Sales Amount (Actual)","Sales Amount (Expected)");
                    IF T32.FINDSET THEN REPEAT
                      SalesAmt += T32."Sales Amount (Actual)"+T32."Sales Amount (Expected)";
                    UNTIL T32.NEXT=0;
                    ////
                    "Sale Amount" := ROUND(ABS(SalesAmt),0.01,'=');
                    "Sale rate" := ROUND(ABS(SalesAmt/"Birds Sold (kg)"),0.01,'=');
                    "Short Excess" := ROUND("Chick Housed" - "Birds Sold (Nos)"-Mortality,0.01,'=');
                    
                    
                    //Part2
                    IF "Shed Type" = "Shed Type"::Normal THEN
                    "Birds Rearing GC":=ROUND(ABS("Birds Sold (kg)"*"Std. GC Rate"),0.01,'=')
                    ELSE
                    IF "Shed Type" = "Shed Type"::EC THEN
                      "Birds Rearing GC" := ROUND(ABS("Birds Sold (kg)"*"Std. GC Rate"),0.01,'=');
                    IF Location."State Code" = 'JK' THEN
                      "Rate Incentive for Selling1" := 0
                    ELSE BEGIN
                    IF ("Sale rate">72)THEN BEGIN
                      IF "Sale rate"<=77 THEN
                        "Rate Incentive for Selling1":=ROUND(ABS(("Sale rate"-72.01)*0.05*"Birds Sold (kg)"),0.01,'=')
                      ELSE
                        "Rate Incentive for Selling1":=ROUND(ABS(5*0.05*"Birds Sold (kg)"),0.01,'=');
                    END ELSE
                      "Rate Incentive for Selling1":=0;
                    END;
                    
                    IF ABS("Sale rate")>77.1 THEN BEGIN
                      IF ABS("Sale rate")<=82 THEN
                        "Rate Incentive for Selling2" := ROUND(ABS(("Sale rate"-77.01)*0.1*"Birds Sold (kg)"),0.01,'=')
                      ELSE
                        IF Location."State Code" = 'JK' THEN
                          "Rate Incentive for Selling2":=ROUND(ABS(4.99*0.1*"Birds Sold (kg)"),0.01,'=')
                        ELSE
                          "Rate Incentive for Selling2":=ROUND(ABS(5*0.1*"Birds Sold (kg)"),0.01,'=');
                    END ELSE
                      "Rate Incentive for Selling2" := 0;
                    
                    IF Location."State Code"='JK' THEN BEGIN
                      IF ABS("Sale rate")>82 THEN BEGIN
                        IF ABS("Sale rate")<=150 THEN
                          "Rate Incentive for Selling3":=ROUND(ABS(("Sale rate"-82.015)*0.15*"Birds Sold (kg)"),0.01,'=')
                        ELSE
                          "Rate Incentive for Selling3":=ROUND(ABS(67.99*0.15*"Birds Sold (kg)"),0.01,'=');
                      END ELSE
                        "Rate Incentive for Selling3" := 0;
                    END ELSE BEGIN
                      IF ABS("Sale rate")>82 THEN BEGIN
                        IF ABS("Sale rate")<=110 THEN
                          "Rate Incentive for Selling3":=ROUND(ABS(("Sale rate"-82.01)*0.15*"Birds Sold (kg)"),0.01,'=')
                        ELSE
                          "Rate Incentive for Selling3":=ROUND(ABS(27.99*0.15*"Birds Sold (kg)"),0.01,'=');
                      END ELSE
                        "Rate Incentive for Selling3" := 0;
                    END;
                    
                    CLEAR(TotalRateIncentive);
                    CLEAR(RateIncentive);
                    
                    TotalRateIncentive:="Rate Incentive for Selling2"+"Rate Incentive for Selling3";
                    RateIncentive:=TotalRateIncentive/"Birds Sold (kg)";
                    IF RateIncentive>2.5 THEN
                    "Max Rate Incentive Upto 2.5":="Birds Sold (kg)"*2.5;
                    
                    IF (ABS("Mortality %")>0) AND (ABS("Mortality %")<=3) THEN
                      IF Location."State Code"='JK' THEN
                        "Summary Incentive1":=ROUND(ABS("Birds Sold (Nos)"*0.8),0.01,'=')
                      ELSE
                      "Summary Incentive1":=ROUND(ABS("Birds Sold (Nos)"*1),0.01,'=')
                    ELSE
                      "Summary Incentive1" := 0;
                    
                    IF Location."State Code"='JK' THEN BEGIN
                      IF ("Mortality %">3) AND ("Mortality %"<=4) THEN
                        "Summary Incentive2":=ROUND(ABS("Birds Sold (Nos)"*0.4),0.01,'=')
                      ELSE
                        "Summary Incentive2" := 0;
                    END ELSE BEGIN
                      IF ("Mortality %">3) AND ("Mortality %"<=5) THEN
                        "Summary Incentive2":=ROUND(ABS("Birds Sold (Nos)"*0.5),0.01,'=')
                      ELSE
                        "Summary Incentive2" := 0;
                      END;
                    IF Location."State Code"='JK' THEN
                      "Feed Unloading Charges" := 0
                    ELSE
                      "Feed Unloading Charges":=ROUND(ABS("Feed Consumption(kgs)"/1000*20),0.01,'=');
                    
                    
                    
                    //part3
                    IF Location."State Code" = 'JK' THEN BEGIN
                      IF ABS("Mortality %")>7 THEN
                        "Deduction for high Mort":=ROUND(ABS((Mortality-(7*Mortality/(Mortality/"Chick Housed"*100)))*"Body Weight %"*25),0.01,'=')
                      ELSE
                        "Deduction for high Mort" := 0;
                    END ELSE BEGIN
                    IF ABS("Mortality %")>6 THEN
                      "Deduction for high Mort":=ROUND(ABS((Mortality-(6*Mortality/(Mortality/"Chick Housed"*100)))*"Body Weight %"*24),0.01,'=')
                    ELSE
                      "Deduction for high Mort" := 0;
                    END;
                    ////vidit
                    IF(CFCR<=FCR) THEN BEGIN
                      IF (CFCR>1.7)THEN
                        "Excess FCR Over" := ((CFCR-1.7)*"Birds Sold (kg)"*31)
                      ELSE
                        "Excess FCR Over" := 0;
                    END ELSE
                    IF(FCR<CFCR) THEN BEGIN
                      IF (FCR>1.7)THEN
                        "Excess FCR Over" := ((FCR-1.7)*"Birds Sold (kg)"*31)
                      ELSE
                        "Excess FCR Over" := 0;
                    END ELSE
                      "Excess FCR Over" := 0;
                    CLEAR(Whicheverishigher);
                    IF "Sale rate" <= 65 THEN
                      Whicheverishigher := 65
                    ELSE
                      Whicheverishigher := "Sale rate";
                    IF ("Short Excess">0) THEN
                      "Deduction for Shortage":=ROUND(ABS("Short Excess"*"Body Weight %"*Whicheverishigher),0.01,'=')
                    ELSE
                      "Deduction for Shortage":=0;
                    
                    "TOTAL DEDUCTION(LESS)":=ROUND(ABS("Deduction for high Mort"+"Excess FCR Over"+"Deduction for Shortage"),0.01,'=');
                    
                    
                    //part4
                    "Chick Cost Qty":=ROUND("Chick Housed",0.01,'=');
                    Location.GET("Farm Code");
                    T50020.RESET;
                    T50020.SETRANGE("Item Type",T50020."Item Type"::Chick);
                    T50020.SETRANGE("State Code",Location."State Code");
                    IF T50020.FINDFIRST THEN
                      "Chick Cost Rate" := ROUND(T50020.Rate,0.01,'=');
                    "Chik Cost Amt.":=ROUND(ABS("Chick Cost Qty"*"Chick Cost Rate"),0.01,'=');
                    
                    "Feed Cost Qty":=ROUND(ABS("Feed Consumption(kgs)"-"Maize Cost Qty"),0.01,'=');
                    T50020.RESET;
                    T50020.SETRANGE("Item Type",T50020."Item Type"::Feed);
                    T50020.SETRANGE("State Code",Location."State Code");
                    IF T50020.FINDFIRST THEN
                      "Feed Cost Rate" := ROUND(T50020.Rate,0.01,'=');
                    "Feed Cost Amt.":=ROUND(ABS("Feed Cost Qty"*"Feed Cost Rate"),0.01,'=');
                    
                    "Maize Cost Amt.":=ROUND(ABS("Maize Cost Qty"*"Maize Cost Rate"),0.01,'=');
                    
                    T32.RESET;
                    T32.SETCURRENTKEY("Entry Type","Flock No.","Item Type","Location Code");
                    T32.SETRANGE("Entry Type",T32."Entry Type"::Consumption);
                    T32.SETRANGE("Document No.","Flock No.");
                    T32.SETFILTER("Item Type",'%1|%2',T32."Item Type"::Medicine,T32."Item Type"::Vaccination);
                    T32.SETRANGE("Location Code","Farm Code");
                    T32.SETAUTOCALCFIELDS("Cost Amount (Actual)","Cost Amount (Expected)");
                    IF T32.FINDSET THEN REPEAT
                      MedicineAmt += T32."Cost Amount (Actual)"+T32."Cost Amount (Expected)";
                    UNTIL T32.NEXT=0;
                    "Medicne Cost Amt.":=ROUND(ABS(MedicineAmt),0.01,'=');
                    
                    IF Location."State Code"='JK' THEN
                      "AdministrationCost Rs2.2/Bird2":=ROUND(ABS("Chick Cost Qty"*3.3),0.01,'=')
                    ELSE
                    "AdministrationCost Rs2.2/Bird2":=ROUND(ABS("Chick Cost Qty"*2.2),0.01,'=');
                    
                    "TOTAL COST OF PRODUCTION2":=ROUND(ABS("Chik Cost Amt."+"Feed Cost Amt."+"Maize Cost Amt."+"Medicne Cost Amt."+"AdministrationCost Rs2.2/Bird2"+
                               "Vaccine Cost Amt."),0.01,'=');
                    
                    
                    "Bird Sold IN Kg.2  Qty.":=ROUND(("Birds Sold (kg)"),0.01,'=');
                    "Bird Sold IN Kg.2  Amt.":=ROUND(("TOTAL AMOUNT PAYABLE"),0.01,'=');
                    "Bird Sold IN Kg.2  Rate":=ROUND(("TOTAL AMOUNT PAYABLE"/"Birds Sold (kg)"),0.01,'=');
                    "Cost of Prod./kg Before RC2":=ROUND(("TOTAL COST OF PRODUCTION2"/"Bird Sold IN Kg.2  Qty."),0.01,'=');
                    
                    "Bird Sold IN No. Qty.":=ROUND(("Birds Sold (Nos)"),0.01,'=');
                    
                    "Cost of Prod. After RC2":=ROUND(("TOTAL COST OF PRODUCTION2"+"Bird Sold IN Kg.2  Amt."),0.01,'=');
                    "Cost of Production Per Kg.2":=ROUND(("Cost of Prod. After RC2"/"Bird Sold IN Kg.2  Qty."),0.01,'=');
                    
                    "Cost of Production Per Bird":=ROUND(ABS("Cost of Prod. After RC2"/"Birds Sold (Nos)"),0.01,'=');
                    "F.C.R2":=ROUND(ABS(("Feed Cost Qty"+"Maize Cost Qty")/"Bird Sold IN Kg.2  Qty."),0.001,'=');
                    
                    "Average Body weight2":=ROUND(ABS("Bird Sold IN Kg.2  Qty."/"Bird Sold IN No. Qty."),0.001,'=');
                    
                    "Prod. Cost After RC2":=ROUND(ABS("Cost of Prod. After RC2"),0.01,'=');
                    "SALE AMOUNT2":=ROUND(ABS("Sale Amount"),0.01,'=');
                    
                    "NET PROFIT / (LOSS)":=ROUND(ABS("Sale Amount"-"Cost of Prod. After RC2"),0.01,'=');
                    "NET PROFIT/ (LOSS)/BIRD":=ROUND(ABS("NET PROFIT / (LOSS)"/"Chick Cost Qty"),0.01,'=');
                    "Production Cost" := ROUND("Cost of Prod./kg Before RC2",0.01,'=');
                    IF "Production Cost" > "Std. Prod Cost" THEN
                      "Incentive for Low Cost" := 0
                    ELSE
                    IF Location."State Code"='JK' THEN BEGIN
                      "Incentive for Low Cost":=ROUND(ABS(("Std. Prod Cost"-"Production Cost")*"Birds Sold (kg)"*0.4),0.01,'=');
                      END ELSE
                        "Incentive for Low Cost":=ROUND(ABS(("Std. Prod Cost"-"Production Cost")*"Birds Sold (kg)"*0.5),0.01,'=');
                    
                    IF RateIncentive < 2.5 THEN BEGIN
                    "Total Incentive (Add)":=ROUND(ABS("Birds Rearing GC"+"Incentive for Low Cost"+"Rate Incentive for Selling1"+"Rate Incentive for Selling2"+
                    "Rate Incentive for Selling3"+"Summary Incentive1"+"Summary Incentive2"+"Feed Unloading Charges"),0.01,'=')
                    END ELSE BEGIN
                    "Total Incentive (Add)":=ROUND(ABS("Birds Rearing GC"+"Incentive for Low Cost"+"Rate Incentive for Selling1"+"Max Rate Incentive Upto 2.5"+"Summary Incentive1"+"Summary Incentive2"+"Feed Unloading Charges"),0.01,'=')
                    END;
                    
                    "TOTAL AMOUNT PAYABLE":=ROUND("Total Incentive (Add)"-"TOTAL DEDUCTION(LESS)",0.01,'=');
                    IF "TOTAL AMOUNT PAYABLE">0 THEN
                    "LESS: T.D.S @ 1%":=ROUND("TOTAL AMOUNT PAYABLE"*1/100,0.01,'=');
                    "AMOUNT PAYABLE AFTER T.D.S":=ROUND("TOTAL AMOUNT PAYABLE"-"LESS: T.D.S @ 1%",0.01,'=');
                    //Receipt:=ROUND(ABS("AMOUNT PAYABLE AFTER T.D.S"-"SELF  DC NO :"),0.01,'=');
                    
                    "Net Payable After TDS" := ROUND(("AMOUNT PAYABLE AFTER T.D.S"-"SELF  DC NO :"+Receipt),0.01,'=');
                    "AMOUNT payable per bird":=ROUND("TOTAL AMOUNT PAYABLE"/"Chick Housed",0.01,'=');
                    IF "AMOUNT payable per bird"<0 THEN
                      "AMOUNT payable per bird":=0;
                      */

                end;
            }
            action("GC Post With GJ Entry")
            {
                Caption = 'GC Post With GJ Entry';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;
                ApplicationArea = All;
                trigger OnAction()
                var
                    GCStatement: Record "GC Statement";
                    DimensionMaster: Record "Dimension Master";
                    SMSSendTransferOrder: Codeunit 50009;
                    GCStatement_P: Page "GC Statement";
                begin

                    Companyinfo.Get;
                    if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] Then Begin
                        DimensionMaster.RESET;
                        DimensionMaster.SETRANGE("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                        DimensionMaster.SETRANGE("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                        DimensionMaster.SETRANGE("Shortcut Dimension 3 Code", Rec."Shortcut Dimension 3 Code");
                        IF NOT DimensionMaster.FINDFIRST THEN
                            ERROR('Dimension Master Does not exist');
                    end;
                    //<<PRU_RPG DM_0.1

                    /*
                    GCStatement.RESET;
                    GCStatement.SETRANGE("Shed Type","Shed Type");
                    GCStatement.SETRANGE("No.","No.");
                    IF GCStatement.FINDFIRST THEN BEGIN
                      GCStatement.Posted := TRUE;
                      GCStatement.MODIFY;
                      SMSSendTransferOrder.SMSSendGCStatment("No.");
                      MESSAGE('GC Statement No. %1 Posted Successfully',GCStatement."No.");
                    END;
                    END;
                    */
                    Rec.TESTFIELD("TDS Section");
                    CLEAR(GCStatement_P);
                    GCStatement_P.PostandPrint(Rec);

                end;
            }
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
            action(Post)
            {
                Caption = 'Post';
                Visible = Visible;
                ApplicationArea = All;
                trigger OnAction()
                var
                    DimensionMaster: Record "Dimension Master";
                    GCStatement: Record "GC Statement";
                    Region: Record Region;
                    WhatsAppDetail: Codeunit "WhatsApp Function";
                    GCTemplte: Text;
                    NumberList: List of [Text];
                    Number: Text;
                begin
                    Companyinfo.Get;
                    if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] Then Begin
                        DimensionMaster.RESET;
                        DimensionMaster.SETRANGE("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                        DimensionMaster.SETRANGE("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                        DimensionMaster.SETRANGE("Shortcut Dimension 3 Code", Rec."Shortcut Dimension 3 Code");
                        IF NOT DimensionMaster.FINDFIRST THEN
                            ERROR('Dimension Master Does not exist');
                        //<<PRU_RPG DM_0.1
                    End;

                    Rec.TESTFIELD("TDS Section");

                    GCStatement.RESET;
                    GCStatement.SETRANGE("Shed Type", Rec."Shed Type");
                    GCStatement.SETRANGE("No.", Rec."No.");
                    IF GCStatement.FINDFIRST THEN BEGIN
                        CLEAR(PostingDateInput);
                        PostingDateInput.RUNMODAL;
                        PostingDateInput.GetFillterValue(PostingD);
                        IF PostingD = 0D THEN
                            ERROR('Posting Date Must Have a value');
                        if PostingD <> Today then
                            Error('Please update the Today date only, Backdate is not allowed');
                        if GCStatement."Liquidation Date" <> PostingD Then begin
                            GCStatement."Liquidation Date" := PostingD;
                            GCStatement.Modify();
                            Rec.GCCalculation1;
                        end;
                        GCStatement.Posted := TRUE;
                        GCStatement.MODIFY;
                        Region.Get(GCStatement.Region);
                        //SMSSendTransferOrder.SMSSendGCStatment(Rec."No.");
                        CLEAR(WhatsAppDetail);


                        Clear(GCTemplte);
                        if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then
                            GCTemplte := '01khb4prz7yzccdh5qrb6zj491'
                        else
                            GCTemplte := '01khd5wvza3tbssnqp5c552a2t';

                        Clear(Week1Mortality);
                        Clear(Week2Mortality);
                        Clear(Week3Mortality);
                        Clear(Week4Mortality);
                        Clear(Week5Mortality);
                        ILE.Reset();
                        ILE.SetRange("Document No.", GCStatement."Flock No.");
                        ILE.SETFILTER("In-transit Mortality", '%1', FALSE);
                        ILE.SetRange("Data Entry Type", ILE."Data Entry Type"::"Mortality - Chicks");
                        ILE.SetRange("Posting Date", GCStatement."Receipt Date", (GCStatement."Receipt Date" + 7));
                        ILE.CalcSums(Quantity);
                        Week1Mortality := Round((ABS(ILE.Quantity) / GCStatement."Chick Housed") * 100, 0.001, '=');

                        ILE.Reset();
                        ILE.SetRange("Document No.", GCStatement."Flock No.");
                        ILE.SETFILTER("In-transit Mortality", '%1', FALSE);
                        ILE.SetRange("Data Entry Type", ILE."Data Entry Type"::"Mortality - Chicks");
                        ILE.SetRange("Posting Date", (GCStatement."Receipt Date" + 8), (GCStatement."Receipt Date" + 14));
                        ILE.CalcSums(Quantity);
                        Week2Mortality := Round((ABS(ILE.Quantity) / GCStatement."Chick Housed") * 100, 0.001, '=');

                        ILE.Reset();
                        ILE.SetRange("Document No.", GCStatement."Flock No.");
                        ILE.SETFILTER("In-transit Mortality", '%1', FALSE);
                        ILE.SetRange("Data Entry Type", ILE."Data Entry Type"::"Mortality - Chicks");
                        ILE.SetRange("Posting Date", (GCStatement."Receipt Date" + 15), (GCStatement."Receipt Date" + 21));
                        ILE.CalcSums(Quantity);
                        Week3Mortality := Round((ABS(ILE.Quantity) / GCStatement."Chick Housed") * 100, 0.001, '=');

                        ILE.Reset();
                        ILE.SetRange("Document No.", GCStatement."Flock No.");
                        ILE.SETFILTER("In-transit Mortality", '%1', FALSE);
                        ILE.SetRange("Data Entry Type", ILE."Data Entry Type"::"Mortality - Chicks");
                        ILE.SetRange("Posting Date", (GCStatement."Receipt Date" + 22), (GCStatement."Receipt Date" + 28));
                        ILE.CalcSums(Quantity);
                        Week4Mortality := Round((ABS(ILE.Quantity) / GCStatement."Chick Housed") * 100, 0.001, '=');

                        ILE.Reset();
                        ILE.SetRange("Document No.", GCStatement."Flock No.");
                        ILE.SETFILTER("In-transit Mortality", '%1', FALSE);
                        ILE.SetRange("Data Entry Type", ILE."Data Entry Type"::"Mortality - Chicks");
                        ILE.SetRange("Posting Date", (GCStatement."Receipt Date" + 29), (GCStatement."Receipt Date" + 36));
                        ILE.CalcSums(Quantity);
                        Week5Mortality := Round((ABS(ILE.Quantity) / GCStatement."Chick Housed") * 100, 0.001, '=');


                        // SMSfunctions.SendWhatsappMessage(SMSfunctions.WhatsupSmsOnGC(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", GCStatement."Chick Housed", GCStatement.Mortality, GCStatement."Mortality %",
                        //     GCStatement."Mean Age", GCStatement."Average Body weight2", ROUND(GCStatement.FCR, 0.001, '='), ROUND(GCStatement.CFCR, 0.001, '='), GCStatement.EEF, ROUND(GCStatement."Sale rate", 0.01, '=')), '9988212588,7087071000,9876608880');
                        // SMSfunctions.SendWhatsappMessage(SMSfunctions.WhatsupSmsOnGC(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", GCStatement."Chick Housed", GCStatement.Mortality, GCStatement."Mortality %",
                        //     GCStatement."Mean Age", GCStatement."Average Body weight2", ROUND(GCStatement.FCR, 0.001, '='), ROUND(GCStatement.CFCR, 0.001, '='), GCStatement.EEF, ROUND(GCStatement."Sale rate", 0.01, '=')), '9149662146,7023022755,7527020415');
                        // SMSfunctions.SendWhatsappMessage(SMSfunctions.WhatsupSmsOnGC(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", GCStatement."Chick Housed", GCStatement.Mortality, GCStatement."Mortality %",
                        //     GCStatement."Mean Age", GCStatement."Average Body weight2", ROUND(GCStatement.FCR, 0.001, '='), ROUND(GCStatement.CFCR, 0.001, '='), GCStatement.EEF, ROUND(GCStatement."Sale rate", 0.01, '=')), '7588134854');
                        // SMSfunctions.SendWhatsappMessage(SMSfunctions.WhatsupSmsOnGC(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", GCStatement."Chick Housed", GCStatement.Mortality, GCStatement."Mortality %",
                        //     GCStatement."Mean Age", GCStatement."Average Body weight2", ROUND(GCStatement.FCR, 0.001, '='), ROUND(GCStatement.CFCR, 0.001, '='), GCStatement.EEF, ROUND(GCStatement."Sale rate", 0.01, '=')), Region."MobileNo.");
                        // ============== New API ===============
                        WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
                           Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), '9988212588', GCTemplte));
                        WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
                                                    Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), '7087071000', GCTemplte));
                        WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
                                                    Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), '9876608880', GCTemplte));
                        WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
                                                    Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), '9149662146', GCTemplte));

                        WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
                                                    Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), '7023022755', GCTemplte));
                        WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
                                                    Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), '7527020415', GCTemplte));


                        WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
                                                   Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), '9569949996', GCTemplte));// Parveen Kumar
                        WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
                                                    Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), '7300000016', GCTemplte));// Riya Gupta


                        NumberList := Region."MobileNo.".Split(',');
                        foreach Number in NumberList do begin
                            WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
                                Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), Region."MobileNo.", GCTemplte));
                        END;
                        MESSAGE('GC Statement No. %1 Posted Successfully', GCStatement."No.");
                    END;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        Visible := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Modified Date" := DT2DATE(CURRENTDATETIME);// PRU_AS 13 NOV 2019
        Rec."Last USERID" := USERID;// PRU_AS 13 NOV 2019
    end;

    trigger OnOpenPage()
    var
        userset: Record 91;
    begin
        userset.GET(USERID);
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Shortcut Dimension 1 Code", userset."Global Dimension 1 Code");
        Rec.SETFILTER("Shortcut Dimension 2 Code", userset."Global Dimension 2 Code");
        IF NOT userset."HO Users" THEN
            Rec.SETFILTER("Shortcut Dimension 3 Code", userset."Shortcut Dimension 3 Code");
        Rec.FILTERGROUP(0);


        IF USERID = 'SAM4525' THEN BEGIN
            Visible := TRUE;
        END ELSE
            Visible := FALSE;
    end;

    var
        ILE: Record "Item Ledger Entry";
        Week5Mortality: Decimal;
        Week4Mortality: Decimal;
        Week3Mortality: Decimal;
        Week2Mortality: Decimal;
        Week1Mortality: Decimal;
        Companyinfo: Record "Company Information";
        GCConfirm: Label 'Do you want to post the GC?';
        TotalRateIncentive: Decimal;
        RateIncentive: Decimal;
        Visible: Boolean;
        SMSSendTransferOrder: Codeunit 50009;
        SMSfunctions: Codeunit 50026;

        PostingDateInput: Page "Posting Date Input";
        PostingD: Date;

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

    local procedure "CalculateFeedIntake&UpdateFlockMaster"(FlockNo: Code[20])
    var
        ProductionOrder: Record 5405;
        UpdateFeedIntakeMaster: Codeunit 50021;
        FlockWiseMaster: Record "Flock Wise Master";
        LastCumFeddActual: Decimal;
        LastConsumed: Decimal;
    begin
        //ERROR('Test');
        ProductionOrder.RESET;
        ProductionOrder.SETRANGE(ProductionOrder.Status, ProductionOrder.Status::Released);
        ProductionOrder.SETRANGE(ProductionOrder."Short Close", FALSE);
        ProductionOrder.SETRANGE(ProductionOrder."Shortcut Dimension 1 Code", 'CBF');
        ProductionOrder.SETRANGE(ProductionOrder."No.", FlockNo);
        IF ProductionOrder.FINDFIRST THEN BEGIN
            CLEAR(UpdateFeedIntakeMaster);
            UpdateFeedIntakeMaster.Code(FlockNo);
            COMMIT;
        END;
        FlockWiseMaster.RESET;
        FlockWiseMaster.SETRANGE(FlockWiseMaster."Flock No.", FlockNo);
        FlockWiseMaster.SETFILTER(FlockWiseMaster.Consumed, '<>%1', 0);
        IF FlockWiseMaster.FINDLAST THEN BEGIN
            LastConsumed := FlockWiseMaster."CUMFEED Std.";
        END;
        FlockWiseMaster.RESET;
        FlockWiseMaster.SETRANGE(FlockWiseMaster."Flock No.", FlockNo);
        IF FlockWiseMaster.FINDLAST THEN BEGIN
            LastCumFeddActual := FlockWiseMaster."CUMFEED Actual";
        END;
        IF LastConsumed <> 0 THEN
            Rec."Feed Intake" := LastCumFeddActual / LastConsumed * 100
        ELSE
            Rec."Feed Intake" := LastCumFeddActual;
        Rec."Cum. Feed Consuption" := LastCumFeddActual;
        Rec."Cum. Feed Std." := LastConsumed;

        CurrPage.UPDATE;
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

