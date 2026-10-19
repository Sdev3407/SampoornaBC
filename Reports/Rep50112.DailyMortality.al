report 50112 "Daily Mortality"
{
    Caption = 'Daily Mortality';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\DailyMortality.rdl';



    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            RequestFilterFields = "Shortcut Dimension 2 Code";
            DataItemTableView = SORTING("No.")
                                    WHERE("Shortcut Dimension 1 Code" = Filter('CBF'), Status = filter(Released), Quantity = Filter(<> 0));

            column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code")
            { }
            column(CompanyName; CompanyInfo.Name)
            { }
            column(Date; Date)
            { }
            column(Age; Age)
            { }
            column(BranchName; BranchName)
            { }
            column(No_; "No.")
            { }
            column(Quantity; Quantity)
            { }
            column(RPOQty; RPOQty)
            { }
            column(Mortality; Mortality)
            { }
            column(LOCName; LOCName)
            { }
            column(MortalityPer; MortalityPer)
            { }

            trigger OnAfterGetRecord()
            var

            Begin
                Clear(Age);
                Clear(BranchName);
                LOC.Reset();
                Loc.SetRange(Code, "Location Code");
                if LOC.FindFirst() then
                    LOCName := LOC.Name;
                Dimension.Reset();
                Dimension.SetRange("Dimension Code", 'BRANCH');
                Dimension.SetRange(Code, "Production Order"."Shortcut Dimension 2 Code");
                if Dimension.FindFirst() then
                    BranchName := Dimension.Name;

                RPO.Reset();
                RPO.SetRange("Flock No.", "Production Order"."No.");
                RPO.SetRange("Item Type", RPO."Item Type"::Chick);
                RPO.SetFilter("Entry Type", '%1|%2', RPO."Entry Type"::Purchase, RPO."Entry Type"::Transfer);
                RPO.SetRange("Location Code", "Production Order"."Location Code");
                If RPO.FindFirst() Then
                    Age := Date - RPO."Posting Date";

                Clear(RPOQty);
                Clear(Mortality);
                Clear(MortalityPer);

                RPO.Reset();
                RPO.SetRange("Document No.", "Production Order"."No.");
                RPO.SetRange("Data Entry Type", RPO."Data Entry Type"::"Mortality - Chicks");
                RPO.SetRange("Posting Date", Date);
                RPO.CalcSums(Quantity);
                Mortality := ABS(RPO.Quantity);

                RPO.Reset();
                RPO.SetRange("Flock No.", "Production Order"."No.");
                RPO.SetRange("Item Type", RPO."Item Type"::Chick);
                RPO.SetFilter("Document Type", '%1|%2', RPO."Document Type"::"Purchase Receipt", RPO."Document Type"::"Transfer Receipt");
                RPO.SetRange("Location Code", "Production Order"."Location Code");
                RPO.CalcSums("Remaining Quantity");
                RPOQty := RPO."Remaining Quantity";
                RPOQty := RPOQty + Mortality;

                If (Mortality <> 0) and (RPOQty <> 0) then
                    MortalityPer := Round((Mortality / RPOQty) * 100, 0.001, '=');

            End;


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
                    field(Date; Date)
                    {
                        Caption = 'Date';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }
    trigger OnPreReport()
    var

    begin
        CompanyInfo.Get;

    end;


    var

        Date: Date;
        LOCName: text;
        MortalityPer: Decimal;
        CompanyInfo: Record "Company Information";
        PlacmentDate: Date;
        LOC: Record Location;
        RPOQty: Decimal;
        Dimension: Record "Dimension Value";
        BranchName: Text;
        ChichPLacing: Date;
        RPO: Record "Item Ledger Entry";
        Mortality: Decimal;
        Age: Integer;


    procedure SetReportFilter(PostingDate: Date)
    begin
        Date := PostingDate;
    end;
}