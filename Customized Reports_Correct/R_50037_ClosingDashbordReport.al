report 50037 "Closing Dashbord Report"
{
    UsageCategory = Administration;
    Caption = 'Closing Dashbord Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\ClosingDashbordReport.rdl';
    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = ORDER(Ascending)
                                WHERE("Shortcut Dimension 1 Code" = FILTER('CBF'),
                                      Status = FILTER(Released),
                                      "Short Close" = FILTER(false));
            RequestFilterFields = "Shortcut Dimension 2 Code";
            column(ProNo; "Production Order"."No.")
            {
            }
            column(ProDescription; "Production Order".Description)
            {
            }
            column(Quantity; "Production Order".Quantity)
            {
            }
            column(ShortcutDimension1Code; "Production Order"."Shortcut Dimension 1 Code")
            {
            }
            column(LocationCode; "Production Order"."Location Code")
            {
            }
            column(ShortcutDimension2Code; "Production Order"."Shortcut Dimension 2 Code")
            {
            }
            column(BranchName; BranchName)
            {
            }
            column(LocName; LocName)
            {
            }
            column(MORQTY; MORQTY)
            {
            }
            column(QTY; QTY)
            {
            }
            column(InvoiceQTY; InvoiceQTY)
            {
            }
            column(AlternateQTY; AlternateQTY)
            {
            }
            column(HatchingDate; "Production Order"."Hatching Date")
            {
            }
            column(FeedConSumptionQTY; FeedConSumptionQTY)
            {
            }
            column(ClosingBird; ClosingBird)
            {
            }
            column(BirdSoldKG; BirdSoldKG)
            {
            }
            column(Started_QTY; Started_QTY)
            {
            }
            column(Started_Chicks; Started_Chicks)
            {
            }
            column(LastEntrydate; LastEntrydate)
            {
            }
            column(TotalMORQTY; TotalMORQTY)
            {
            }

            trigger OnAfterGetRecord()
            begin
                GCStatement.RESET;
                GCStatement.SETRANGE("Flock No.", "Production Order"."No.");
                IF GCStatement.FINDSET THEN
                    IF "Production Order"."No." = GCStatement."Flock No." THEN
                        CurrReport.SKIP;
                //
                CLEAR(BranchName);
                DimensionValue.RESET;
                DimensionValue.SETRANGE(Code, "Production Order"."Shortcut Dimension 2 Code");
                IF DimensionValue.FINDFIRST THEN
                    BranchName := DimensionValue.Name;

                CLEAR(LocName);
                Location.RESET;
                Location.SETRANGE(Code, "Production Order"."Location Code");
                IF Location.FINDFIRST THEN
                    LocName := Location.Name;

                //IF (StartDate<>0D) OR (EndDate<>0D) THEN
                //"Item Ledger Entry".SETRANGE("Posting Date",StartDate,EndDate);
                //================Mortality QTY=======================================================
                CLEAR(MORQTY);
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Posting Date", 0D, EndDate);
                ItemLedgerEntry.SETRANGE("Flock No.", "Production Order"."No.");
                ItemLedgerEntry.SETRANGE("Location Code", "Production Order"."Location Code");
                ItemLedgerEntry.SETRANGE("Item Type", ItemLedgerEntry."Item Type"::Chick);
                ItemLedgerEntry.SETRANGE("Data Entry Type", ItemLedgerEntry."Data Entry Type"::"Mortality - Chicks");
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        MORQTY += ItemLedgerEntry.Quantity;
                    UNTIL ItemLedgerEntry.NEXT = 0;

                //Total
                CLEAR(TotalMORQTY);
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Posting Date", 0D, EndDate);
                ItemLedgerEntry.SETRANGE("Flock No.", "Production Order"."No.");
                ItemLedgerEntry.SETRANGE("Global Dimension 2 Code", "Production Order"."Shortcut Dimension 2 Code");
                ItemLedgerEntry.SETRANGE("Item Type", ItemLedgerEntry."Item Type"::Chick);
                ItemLedgerEntry.SETRANGE("Data Entry Type", ItemLedgerEntry."Data Entry Type"::"Mortality - Chicks");
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        TotalMORQTY += ItemLedgerEntry.Quantity;
                    UNTIL ItemLedgerEntry.NEXT = 0;

                //===================== Started Bird==================================================
                CLEAR(Started_QTY);
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Posting Date", 0D, EndDate);
                ItemLedgerEntry.SETRANGE("Flock No.", "Production Order"."No.");
                ItemLedgerEntry.SETRANGE("Location Code", "Production Order"."Location Code");
                ItemLedgerEntry.SETRANGE("Item Type", ItemLedgerEntry."Item Type"::Chick);
                ItemLedgerEntry.SETRANGE("Document Type", ItemLedgerEntry."Document Type"::"Transfer Receipt");
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        Started_QTY += ItemLedgerEntry.Quantity;
                    UNTIL ItemLedgerEntry.NEXT = 0;

                CLEAR(Intransit_Motality);
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Posting Date", 0D, EndDate);
                ItemLedgerEntry.SETRANGE("Flock No.", "Production Order"."No.");
                ItemLedgerEntry.SETRANGE("Location Code", "Production Order"."Location Code");
                ItemLedgerEntry.SETRANGE("Item Type", ItemLedgerEntry."Item Type"::Chick);
                ItemLedgerEntry.SETRANGE("In-transit Mortality", TRUE);
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        Intransit_Motality += ItemLedgerEntry.Quantity;
                    UNTIL ItemLedgerEntry.NEXT = 0;
                //MESSAGE('B-%1',QTY);
                CLEAR(Started_Chicks);
                Started_Chicks := Started_QTY + Intransit_Motality;

                //==================FeedConsumption==========================
                CLEAR(FeedConSumptionQTY);
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Posting Date", 0D, EndDate);
                ItemLedgerEntry.SETRANGE("Flock No.", "Production Order"."No.");
                ItemLedgerEntry.SETRANGE("Location Code", "Production Order"."Location Code");
                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
                ItemLedgerEntry.SETRANGE("Item Type", ItemLedgerEntry."Item Type"::Feed);
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        FeedConSumptionQTY += ItemLedgerEntry.Quantity;
                    UNTIL ItemLedgerEntry.NEXT = 0;
                //MESSAGE('C-%1',FeedConSumptionQTY);
                //====================Alternate QTY=============
                CLEAR(AlternateQTY);
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Posting Date", 0D, EndDate);
                ItemLedgerEntry.SETRANGE("Flock No.", "Production Order"."No.");
                ItemLedgerEntry.SETRANGE("Location Code", "Production Order"."Location Code");
                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                ItemLedgerEntry.SETRANGE("Item Type", ItemLedgerEntry."Item Type"::Bird);
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        AlternateQTY += ItemLedgerEntry."Alternate Quantity";
                    UNTIL ItemLedgerEntry.NEXT = 0;
                //=====================Bird Sold KG================
                CLEAR(BirdSoldKG);
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Posting Date", 0D, EndDate);
                ItemLedgerEntry.SETRANGE("Flock No.", "Production Order"."No.");
                ItemLedgerEntry.SETRANGE("Location Code", "Production Order"."Location Code");
                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                ItemLedgerEntry.SETRANGE("Item Type", ItemLedgerEntry."Item Type"::Bird);
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        BirdSoldKG += ItemLedgerEntry.Quantity;
                    UNTIL ItemLedgerEntry.NEXT = 0;
                //MESSAGE('E-%1',InvoiceQTY);
                //
                ////=====================Closing Bird====================
                CLEAR(ClosingBird);
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Posting Date", 0D, EndDate);
                ItemLedgerEntry.SETRANGE("Flock No.", "Production Order"."No.");
                ItemLedgerEntry.SETRANGE("Location Code", "Production Order"."Location Code");
                ItemLedgerEntry.SETRANGE("Item Type", ItemLedgerEntry."Item Type"::Chick);
                IF ItemLedgerEntry.FINDSET THEN
                    REPEAT
                        ClosingBird += ItemLedgerEntry.Quantity;
                    UNTIL ItemLedgerEntry.NEXT = 0;

                //========================Last Entry  Date=================
                CLEAR(LastEntrydate);
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Posting Date", 0D, EndDate);
                ItemLedgerEntry.SETRANGE("Flock No.", "Production Order"."No.");
                ItemLedgerEntry.SETRANGE("Location Code", "Production Order"."Location Code");
                ItemLedgerEntry.SETFILTER("Item Type", '%1|%2', ItemLedgerEntry."Item Type"::Chick, ItemLedgerEntry."Item Type"::Feed);
                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
                IF ItemLedgerEntry.FINDLAST THEN
                    LastEntrydate := ItemLedgerEntry."Posting Date";


                IF "Production Order"."No." <> ItemLedgerEntry."Flock No." THEN
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                /*IF "Production Order"."No." = GCStatement."Flock No." THEN
                  CurrReport.SKIP;*/

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(EndDate; EndDate)
                    {
                        Caption = 'EndDate';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        EndDate := TODAY;
    end;

    var
        DimensionValue: Record 349;
        BranchName: Text;
        Location: Record 14;
        LocName: Text;
        ItemLedgerEntry: Record 32;
        MORQTY: Decimal;
        StartDate: Date;
        EndDate: Date;
        Started_QTY: Decimal;
        AlternateQTY: Decimal;
        SalesInvoiceLine: Record 113;
        BirdSoldKG: Decimal;
        AsOnDate_gDte: Date;
        FeedConSumptionQTY: Decimal;
        GCStatement: Record 50015;
        Intransit_Motality: Decimal;
        Started_Chicks: Decimal;
        QTY: Decimal;
        ClosingBird: Decimal;
        InvoiceQTY: Decimal;
        LastEntrydate: Date;
        TotalMORQTY: Decimal;
}

