page 50043 "EC - GC Statement"
{
    AutoSplitKey = false;
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "GC Statement";
    SourceTableView = SORTING("Shed Type", "No.")
                      WHERE("Shed Type" = CONST(EC),
                            Posted = CONST(false));
    //   ApplicationArea = All;
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

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE(TRUE);//UPDATE
                    end;
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
                field("1st week mortality %"; Rec."1st week mortality %")
                {
                    ApplicationArea = All;
                }
                field("1st week mortality"; Rec."1st week mortality")
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
                    Caption = 'Birds Rearing (Growing) Charges for live Grown-up  Comm. Br. Bird @ Rs. 7 per Kg.';
                }
            }
            group("ADD :INCENTIVE")
            {
                Caption = 'ADD :INCENTIVE';
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
                field("EEF Incentives range from"; Rec."EEF Incentives range from")
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
                    T50020: Record "GC Rate Calculation";
                    MedicineAmt: Decimal;
                    T32: Record 32;
                    T14: Record 14;
                    T5407: Record 5407;
                    DEL: Record "Data Entry Lines";
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
                    BirdSoldCMKg: Decimal;
                    BirdSoldCMNos: Decimal;
                    BirdSoldShipmentKg: Decimal;
                    BirdSoldShipmentNos: Decimal;
                    Whicheverishigher: Decimal;
                begin
                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access EC GC Statement", '%1', UserSetup."Access EC GC Statement"::View);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You do not have permission to calculate EC GC statement');

                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access EC GC Statement", '%1', UserSetup."Access EC GC Statement"::Create);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You do not have permission to calculate EC GC statement');

                    UserSetup.RESET;
                    UserSetup.SETRANGE("User ID", USERID);
                    UserSetup.SETFILTER(UserSetup."Access EC GC Statement", '%1', UserSetup."Access EC GC Statement"::Edit);
                    IF UserSetup.FINDFIRST THEN
                        ERROR('You do not have permission to calculate EC GC statement');



                    Rec.GCCalculation1;
                    "CalculateFeedIntake&UpdateFlockMaster"(Rec."Flock No.");



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
                    //>>PRU_RPG DM_0.1
                    Companyinfo.Get;
                    if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] Then Begin
                        DimensionMaster.RESET;
                        DimensionMaster.SETRANGE("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                        DimensionMaster.SETRANGE("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                        DimensionMaster.SETRANGE("Shortcut Dimension 3 Code", Rec."Shortcut Dimension 3 Code");
                        IF NOT DimensionMaster.FINDFIRST THEN
                            ERROR('Dimension Master Does not exist');
                    End;
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
                    end;
                    //<<PRU_RPG DM_0.1

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
                        SMSSendTransferOrder.SMSSendGCStatment(GCStatement."No.");
                        RecRegion.Get(GCStatement.Region);
                        CLEAR(WhatsAppDetail);

                        Clear(GCTemplte);

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
                        // GCStatement."Mean Age", GCStatement."Average Body weight2", ROUND(GCStatement.FCR, 0.001, '='), ROUND(GCStatement.CFCR, 0.001, '='), GCStatement.EEF, ROUND(GCStatement."Sale rate", 0.01, '=')), '9988212588,7087071000,9876608880');
                        // SMSfunctions.SendWhatsappMessage(SMSfunctions.WhatsupSmsOnGC(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", GCStatement."Chick Housed", GCStatement.Mortality, GCStatement."Mortality %",
                        // GCStatement."Mean Age", GCStatement."Average Body weight2", ROUND(GCStatement.FCR, 0.001, '='), ROUND(GCStatement.CFCR, 0.001, '='), GCStatement.EEF, ROUND(GCStatement."Sale rate", 0.01, '=')), '9149662146,7023022755,7527020415');
                        // SMSfunctions.SendWhatsappMessage(SMSfunctions.WhatsupSmsOnGC(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", GCStatement."Chick Housed", GCStatement.Mortality, GCStatement."Mortality %",
                        // GCStatement."Mean Age", GCStatement."Average Body weight2", ROUND(GCStatement.FCR, 0.001, '='), ROUND(GCStatement.CFCR, 0.001, '='), GCStatement.EEF, ROUND(GCStatement."Sale rate", 0.01, '=')), '7588134854');
                        // SMSfunctions.SendWhatsappMessage(SMSfunctions.WhatsupSmsOnGC(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", GCStatement."Chick Housed", GCStatement.Mortality, GCStatement."Mortality %",
                        // GCStatement."Mean Age", GCStatement."Average Body weight2", ROUND(GCStatement.FCR, 0.001, '='), ROUND(GCStatement.CFCR, 0.001, '='), GCStatement.EEF, ROUND(GCStatement."Sale rate", 0.01, '=')), RecRegion."MobileNo.");
                        // ================ New API =====================
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
                        NumberList := RecRegion."MobileNo.".Split(',');
                        foreach Number in NumberList do begin
                            WhatsAppDetail.AirtelWhatssAppAPI(SMSfunctions.WhatsupSmsOnGCNewAPI(GetBranchName(GCStatement."Shortcut Dimension 2 Code"), GCStatement."Farm Name", GCStatement."Receipt Date", Format(GCStatement."Chick Housed"), Format(GCStatement.Mortality), Format(GCStatement."Mortality %"),
      Format(GCStatement."Mean Age"), Format(GCStatement."Average Body weight2"), Format(ROUND(GCStatement.FCR, 0.001, '=')), Format(ROUND(GCStatement.CFCR, 0.001, '=')), Format(GCStatement.EEF), Format(ROUND(GCStatement."Sale rate", 0.01, '=')), Format(Week1Mortality), Format(Week2Mortality), Format(Week3Mortality), Format(Week4Mortality), Format(Week5Mortality), Number, GCTemplte));
                        end;

                        MESSAGE('GC Statement No. %1 Posted Successfully', GCStatement."No.");
                    END;
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access EC GC Statement", '%1', UserSetup."Access EC GC Statement"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to delete EC GC Statement');
        //PRU_DD 1.10
    end;

    trigger OnInit()
    begin
        Visible := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access EC GC Statement", '%1', UserSetup."Access EC GC Statement"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
        UserSetup.RESET;

        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access EC GC Statement", '%1', UserSetup."Access EC GC Statement"::Edit);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to create EC GC Statement');
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access EC GC Statement", '%1', UserSetup."Access EC GC Statement"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to modify EC GC Statement');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Modified Date" := DT2DATE(CURRENTDATETIME);// PRU_AS 13 NOV 2019
        Rec."Last USERID" := USERID;// PRU_AS 13 NOV 2019

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access EC GC Statement", '%1', UserSetup."Access EC GC Statement"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin
        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access EC GC Statement", '%1', UserSetup."Access EC GC Statement"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open EC GC Statement');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access EC GC Statement", '%1', UserSetup."Access EC GC Statement"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10

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
        userset: Record 91;
        UserSetup: Record 91;
        Visible: Boolean;
        SMSSendTransferOrder: Codeunit 50009;
        SMSfunctions: Codeunit 50026;
        RecRegion: Record Region;
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

