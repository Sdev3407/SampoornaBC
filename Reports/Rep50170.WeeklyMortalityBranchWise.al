report 50170 "Weekly Mortality % Branch Wise"
{
    Caption = 'Weekly Mortality % Branch Wise';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\WeeklyMortalityBranchWise.rdl';



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
            column(BranchName; BranchName)
            { }
            column(No_; "No.")
            { }
            column(Quantity; Quantity)
            { }
            column(RPOQty; RPOQty)
            { }
            column(Week1; Week1)
            { }
            column(Week2; Week2)
            { }
            column(Week3; Week3)
            { }
            column(Week4; Week4)
            { }
            column(Week5; Week5)
            { }


            trigger OnAfterGetRecord()
            var

            Begin
                Dimension.Reset();
                Dimension.SetRange("Dimension Code", 'BRANCH');
                Dimension.SetRange(Code, "Production Order"."Shortcut Dimension 2 Code");
                if Dimension.FindFirst() then
                    BranchName := Dimension.Name;
                Clear(RPOQty);
                RPO.Reset();
                RPO.SetRange("Flock No.", "Production Order"."No.");
                RPO.Setfilter("Entry Type", '%1|%2', RPO."Entry Type"::Purchase, RPO."Entry Type"::Transfer);
                RPO.SetFilter("Location Code", '<>%1', 'IN-TRANSIT');
                RPO.SetRange("Item Type", RPO."Item Type"::Chick);
                RPO.CalcSums(Quantity);
                RPOQty += RPO.Quantity;
                if RPO.FindFirst() Then
                    PlacmentDate := RPO."Posting Date";
                Clear(Week1);
                Clear(Week2);
                Clear(Week3);
                Clear(Week4);
                Clear(Week5);

                RPO.Reset();
                RPO.SetRange("Document No.", "Production Order"."No.");
                RPO.SetRange("Data Entry Type", RPO."Data Entry Type"::"Mortality - Chicks");
                if RPO.FindFirst() then
                    repeat

                        if (RPO."Posting Date" - PlacmentDate) <= 7 then
                            Week1 += ABS(RPO.Quantity);

                        if ((RPO."Posting Date" - PlacmentDate) < 14) then
                            Week2 += ABS(RPO.Quantity);

                        if ((RPO."Posting Date" - PlacmentDate) < 21) then
                            Week3 += ABS(RPO.Quantity);

                        if ((RPO."Posting Date" - PlacmentDate) < 28) then
                            Week4 += ABS(RPO.Quantity);

                        if ((RPO."Posting Date" - PlacmentDate) < 29) then
                            Week5 += ABS(RPO.Quantity);

                    Until RPO.Next() = 0;
            End;
        }

    }
    trigger OnPreReport()
    var

    begin
        CompanyInfo.Get;

    end;

    var
        CompanyInfo: Record "Company Information";
        PlacmentDate: Date;
        RPOQty: Decimal;
        Dimension: Record "Dimension Value";
        BranchName: Text;
        ChichPLacing: Date;
        RPO: Record "Item Ledger Entry";
        Week1: Decimal;
        Week2: Decimal;
        Week3: Decimal;
        Week4: Decimal;
        Week5: Decimal;



}