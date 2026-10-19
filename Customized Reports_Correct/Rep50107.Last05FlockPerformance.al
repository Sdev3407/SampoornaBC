report 50107 Last05FlockPerformance
{
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Last 05 Flock Performance';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\Last05FlockPerformance.rdl';

    dataset
    {
        dataitem(GCstatement1; "GC Statement")
        {
            DataItemTableView = Where("Flock No." = filter(<> ''), Posted = filter(True));
            RequestFilterFields = "Liquidation Date", "Shortcut Dimension 2 Code";
            column(Code; loc.Code)
            { }
            column(LOCNAME; loc.Name)
            { }
            column(Shortcut_Dimension_2_Code; BranchCode)
            { }
            column(BranchName; BranchName)
            { }
            column(ChickedHoused1; ChickedHoused1)
            { }
            column(MortalityGrater20days1; ABS(MortalityGrater20days1))
            { }
            column(MortalityLess20days1; ABS(MortalityLess20days1))
            { }
            column(MortalityPer1; MortalityPer1)
            { }
            column(ABW1; ABW1)
            { }
            column(EEF1; EEF1)
            { }
            column(FCR1; FCR1)
            { }
            column(COP1; COP1)
            { }
            column(ChickedHoused2; ChickedHoused2)
            { }
            column(MortalityGrater20days2; ABS(MortalityGrater20days2))
            { }
            column(MortalityLess20days2; ABS(MortalityLess20days2))
            { }
            column(MortalityPer2; MortalityPer2)
            { }
            column(ABW2; ABW2)
            { }
            column(EEF2; EEF2)
            { }
            column(FCR2; FCR2)
            { }
            column(COP2; COP2)
            { }
            column(ChickedHoused3; ChickedHoused3)
            { }
            column(MortalityGrater20days3; ABS(MortalityGrater20days3))
            { }
            column(MortalityLess20days3; ABS(MortalityLess20days3))
            { }
            column(MortalityPer3; MortalityPer3)
            { }
            column(ABW3; ABW3)
            { }
            column(EEF3; EEF3)
            { }
            column(FCR3; FCR3)
            { }
            column(COP3; COP3)
            { }
            column(ChickedHoused4; ChickedHoused4)
            { }
            column(MortalityGrater20days4; ABS(MortalityGrater20days4))
            { }
            column(MortalityLess20days4; ABS(MortalityLess20days4))
            { }
            column(MortalityPer4; MortalityPer4)
            { }
            column(ABW4; ABW4)
            { }
            column(EEF4; EEF4)
            { }
            column(FCR4; FCR4)
            { }
            column(COP4; COP4)
            { }
            column(ChickedHoused5; ChickedHoused5)
            { }
            column(MortalityGrater20days5; Abs(MortalityGrater20days5))
            { }
            column(MortalityLess20days5; ABS(MortalityLess20days5))
            { }
            column(MortalityPer5; MortalityPer5)
            { }
            column(ABW5; ABW5)
            { }
            column(EEF5; EEF5)
            { }
            column(FCR5; FCR5)
            { }
            column(COP5; COP5)
            { }
            column(Grade1; Grade1)
            { }
            column(Grade2; Grade2)
            { }
            column(Grade3; Grade3)
            { }
            column(Grade4; Grade4)
            { }
            column(Grade5; Grade5)
            { }
            column(FlockNo1; FlockNo1)
            { }
            column(FlockNo2; FlockNo2)
            { }
            column(FlockNo3; FlockNo3)
            { }
            column(FlockNo4; FlockNo4)
            { }
            column(FlockNo5; FlockNo5)
            { }
            column(CloseMonth1; CloseMonth1)
            { }
            column(CloseMonth2; CloseMonth2)
            { }
            column(CloseMonth3; CloseMonth3)
            { }
            column(CloseMonth4; CloseMonth4)
            { }
            column(CloseMonth5; CloseMonth5)
            { }

            trigger OnAfterGetRecord()
            var
                Counter: Integer;
            begin
                CLearvariable();
                GCstatement.Reset();
                GCstatement.SetCurrentKey("No.");
                GCstatement.Ascending(false);
                //GCstatement.SetRange("Shed Type", GCstatement."Shed Type"::Normal);
                GCstatement.SetRange(Posted, true);
                GCstatement.SetRange("Farm Code", GCstatement1."Farm Code");
                GCstatement.SetFilter("Flock No.", '<>%1', '');
                if GCstatement.FindSet() then begin
                    Counter := 0;
                    repeat
                        Counter += 1;
                        Loc.Get(GCstatement."Farm Code");
                        DimenValue.Reset();
                        DimenValue.SetRange(code, GCstatement."Shortcut Dimension 2 Code");
                        DimenValue.SetRange("Dimension Code", 'BRANCH');
                        if DimenValue.FindFirst() then
                            BranchName := DimenValue.Name;
                        BranchCode := GCstatement."Shortcut Dimension 2 Code";
                        ILE.Reset();
                        ile.SetRange("Entry Type", ILE."Entry Type"::Consumption);
                        ILE.SetRange("Data Entry Type", ILE."Data Entry Type"::"Mortality - Chicks");
                        ILE.SetRange("Document No.", GCstatement."Flock No.");
                        if Counter = 1 then begin
                            ChickedHoused1 := GCstatement."Chick Housed";
                            MortalityPer1 := GCstatement."Mortality %";
                            ABW1 := GCstatement."Average Body weight2";
                            FCR1 := GCstatement.FCR;
                            EEF1 := GCstatement.EEF;
                            COP1 := GCstatement."Production Cost";
                            CloseMonth1 := Format(Date2DMY(GCstatement."Liquidation Date", 2)) + '-' + Format(Date2DMY(GCstatement."Liquidation Date", 3)); // 2 = Month

                            ILE.SetRange("Posting Date", 0D, GCstatement."Receipt Date" + 20);
                            if ILE.FindSet() then begin
                                ILE.CalcSums(Quantity);
                                MortalityLess20days1 := Round((ABS(ILE.Quantity) / GCstatement."Chick Housed") * 100, 0.001, '=');
                            end;
                            FlockNo1 := GCstatement."Flock No.";

                            ILE.SetRange("Posting Date", GCstatement."Receipt Date" + 21, Today());
                            if ILE.FindSet() then begin
                                ILE.CalcSums(Quantity);
                                MortalityGrater20days1 := Round((ABS(ILE.Quantity) / GCstatement."Chick Housed") * 100, 0.001, '=');
                            end;
                            If GCstatement."Production Cost" <= 76 then
                                Grade1 := 'O'
                            else
                                if (GCstatement."Production Cost" >= 76.01) and (GCstatement."Production Cost" <= 77.99) then
                                    Grade1 := 'A'
                                else
                                    if (GCstatement."Production Cost" >= 78) and (GCstatement."Production Cost" <= 80.99) then
                                        Grade1 := 'B+'
                                    else
                                        if (GCstatement."Production Cost" = 80.3) then
                                            Grade1 := 'B'
                                        else
                                            if (GCstatement."Production Cost" >= 80.31) and (GCstatement."Production Cost" <= 82) then
                                                Grade1 := 'B-'
                                            else
                                                if (GCstatement."Production Cost" >= 82.01) and (GCstatement."Production Cost" <= 85) then
                                                    Grade1 := 'C'
                                                else
                                                    if (GCstatement."Production Cost" >= 85.01) and (GCstatement."Production Cost" <= 88) then
                                                        Grade1 := 'D'
                                                    else
                                                        if (GCstatement."Production Cost" >= 88.01) then
                                                            Grade1 := 'E';

                            if Date2DMY(GCstatement."Liquidation Date", 2) = 1 then
                                CloseMonth1 := 'JAN'
                            else
                                if Date2DMY(GCstatement."Liquidation Date", 2) = 2 then
                                    CloseMonth1 := 'FEB'
                                else
                                    if Date2DMY(GCstatement."Liquidation Date", 2) = 3 then
                                        CloseMonth1 := 'MAR'
                                    else
                                        if Date2DMY(GCstatement."Liquidation Date", 2) = 4 then
                                            CloseMonth1 := 'APR'
                                        else
                                            if Date2DMY(GCstatement."Liquidation Date", 2) = 5 then
                                                CloseMonth1 := 'MAY'
                                            else
                                                if Date2DMY(GCstatement."Liquidation Date", 2) = 6 then
                                                    CloseMonth1 := 'JUN'
                                                else
                                                    if Date2DMY(GCstatement."Liquidation Date", 2) = 7 then
                                                        CloseMonth1 := 'JUL'
                                                    else
                                                        if Date2DMY(GCstatement."Liquidation Date", 2) = 8 then
                                                            CloseMonth1 := 'AUG'
                                                        else
                                                            if Date2DMY(GCstatement."Liquidation Date", 2) = 9 then
                                                                CloseMonth1 := 'SEP'
                                                            else
                                                                if Date2DMY(GCstatement."Liquidation Date", 2) = 10 then
                                                                    CloseMonth1 := 'OCT'
                                                                else
                                                                    if Date2DMY(GCstatement."Liquidation Date", 2) = 11 then
                                                                        CloseMonth1 := 'NOV'
                                                                    else
                                                                        if Date2DMY(GCstatement."Liquidation Date", 2) = 12 then
                                                                            CloseMonth1 := 'DEC';

                            CloseMonth1 := CloseMonth1 + '-' + Format(Date2DMY(GCstatement."Liquidation Date", 3)); // 2 = Month
                        end;
                        if Counter = 2 then begin
                            ChickedHoused2 := GCstatement."Chick Housed";
                            MortalityPer2 := GCstatement."Mortality %";
                            ABW2 := GCstatement."Average Body weight2";
                            FCR2 := GCstatement.FCR;
                            EEF2 := GCstatement.EEF;
                            COP2 := GCstatement."Production Cost";
                            CloseMonth2 := Format(Date2DMY(GCstatement."Liquidation Date", 2)) + '-' + Format(Date2DMY(GCstatement."Liquidation Date", 3)); // 2 = Month
                            ILE.SetRange("Posting Date", 0D, GCstatement."Receipt Date" + 20);
                            if ILE.FindSet() then begin
                                ILE.CalcSums(Quantity);
                                MortalityLess20days2 := Round((ABS(ILE.Quantity) / GCstatement."Chick Housed") * 100, 0.001, '=');
                            end;
                            FlockNo2 := GCstatement."Flock No.";

                            ILE.SetRange("Posting Date", GCstatement."Receipt Date" + 21, Today());
                            if ILE.FindSet() then begin
                                ILE.CalcSums(Quantity);
                                MortalityGrater20days2 := Round((ABS(ILE.Quantity) / GCstatement."Chick Housed") * 100, 0.001, '=');
                            end;
                            If GCstatement."Production Cost" <= 76 then
                                Grade2 := 'O'
                            else
                                if (GCstatement."Production Cost" >= 76.01) and (GCstatement."Production Cost" <= 77.99) then
                                    Grade2 := 'A'
                                else
                                    if (GCstatement."Production Cost" >= 78) and (GCstatement."Production Cost" <= 80.99) then
                                        Grade2 := 'B+'
                                    else
                                        if (GCstatement."Production Cost" = 80.3) then
                                            Grade2 := 'B'
                                        else
                                            if (GCstatement."Production Cost" >= 80.31) and (GCstatement."Production Cost" <= 82) then
                                                Grade2 := 'B-'
                                            else
                                                if (GCstatement."Production Cost" >= 82.01) and (GCstatement."Production Cost" <= 85) then
                                                    Grade2 := 'C'
                                                else
                                                    if (GCstatement."Production Cost" >= 85.01) and (GCstatement."Production Cost" <= 88) then
                                                        Grade2 := 'D'
                                                    else
                                                        if (GCstatement."Production Cost" >= 88.01) then
                                                            Grade2 := 'E';

                            if Date2DMY(GCstatement."Liquidation Date", 2) = 1 then
                                CloseMonth2 := 'JAN'
                            else
                                if Date2DMY(GCstatement."Liquidation Date", 2) = 2 then
                                    CloseMonth2 := 'FEB'
                                else
                                    if Date2DMY(GCstatement."Liquidation Date", 2) = 3 then
                                        CloseMonth2 := 'MAR'
                                    else
                                        if Date2DMY(GCstatement."Liquidation Date", 2) = 4 then
                                            CloseMonth2 := 'APR'
                                        else
                                            if Date2DMY(GCstatement."Liquidation Date", 2) = 5 then
                                                CloseMonth2 := 'MAY'
                                            else
                                                if Date2DMY(GCstatement."Liquidation Date", 2) = 6 then
                                                    CloseMonth2 := 'JUN'
                                                else
                                                    if Date2DMY(GCstatement."Liquidation Date", 2) = 7 then
                                                        CloseMonth2 := 'JUL'
                                                    else
                                                        if Date2DMY(GCstatement."Liquidation Date", 2) = 8 then
                                                            CloseMonth2 := 'AUG'
                                                        else
                                                            if Date2DMY(GCstatement."Liquidation Date", 2) = 9 then
                                                                CloseMonth2 := 'SEP'
                                                            else
                                                                if Date2DMY(GCstatement."Liquidation Date", 2) = 10 then
                                                                    CloseMonth2 := 'OCT'
                                                                else
                                                                    if Date2DMY(GCstatement."Liquidation Date", 2) = 11 then
                                                                        CloseMonth2 := 'NOV'
                                                                    else
                                                                        if Date2DMY(GCstatement."Liquidation Date", 2) = 12 then
                                                                            CloseMonth2 := 'DEC';

                            CloseMonth2 := CloseMonth2 + '-' + Format(Date2DMY(GCstatement."Liquidation Date", 3)); // 2 = Month
                        end;
                        if Counter = 3 then begin
                            ChickedHoused3 := GCstatement."Chick Housed";
                            MortalityPer3 := GCstatement."Mortality %";
                            ABW3 := GCstatement."Average Body weight2";
                            FCR3 := GCstatement.FCR;
                            EEF3 := GCstatement.EEF;
                            COP3 := GCstatement."Production Cost";

                            ILE.SetRange("Posting Date", 0D, GCstatement."Receipt Date" + 20);
                            if ILE.FindSet() then begin
                                ILE.CalcSums(Quantity);
                                MortalityLess20days3 := Round((ABS(ILE.Quantity) / GCstatement."Chick Housed") * 100, 0.001, '=');
                            end;
                            FlockNo3 := GCstatement."Flock No.";

                            ILE.SetRange("Posting Date", GCstatement."Receipt Date" + 21, Today());
                            if ILE.FindSet() then begin
                                ILE.CalcSums(Quantity);
                                MortalityGrater20days3 := Round((ABS(ILE.Quantity) / GCstatement."Chick Housed") * 100, 0.001, '=');
                            end;
                            If GCstatement."Production Cost" <= 76 then
                                Grade3 := 'O'
                            else
                                if (GCstatement."Production Cost" >= 76.01) and (GCstatement."Production Cost" <= 77.99) then
                                    Grade3 := 'A'
                                else
                                    if (GCstatement."Production Cost" >= 78) and (GCstatement."Production Cost" <= 80.99) then
                                        Grade3 := 'B+'
                                    else
                                        if (GCstatement."Production Cost" = 80.3) then
                                            Grade3 := 'B'
                                        else
                                            if (GCstatement."Production Cost" >= 80.31) and (GCstatement."Production Cost" <= 82) then
                                                Grade3 := 'B-'
                                            else
                                                if (GCstatement."Production Cost" >= 82.01) and (GCstatement."Production Cost" <= 85) then
                                                    Grade3 := 'C'
                                                else
                                                    if (GCstatement."Production Cost" >= 85.01) and (GCstatement."Production Cost" <= 88) then
                                                        Grade3 := 'D'
                                                    else
                                                        if (GCstatement."Production Cost" >= 88.01) then
                                                            Grade3 := 'E';
                            if Date2DMY(GCstatement."Liquidation Date", 2) = 1 then
                                CloseMonth3 := 'JAN'
                            else
                                if Date2DMY(GCstatement."Liquidation Date", 2) = 2 then
                                    CloseMonth3 := 'FEB'
                                else
                                    if Date2DMY(GCstatement."Liquidation Date", 2) = 3 then
                                        CloseMonth3 := 'MAR'
                                    else
                                        if Date2DMY(GCstatement."Liquidation Date", 2) = 4 then
                                            CloseMonth3 := 'APR'
                                        else
                                            if Date2DMY(GCstatement."Liquidation Date", 2) = 5 then
                                                CloseMonth3 := 'MAY'
                                            else
                                                if Date2DMY(GCstatement."Liquidation Date", 2) = 6 then
                                                    CloseMonth3 := 'JUN'
                                                else
                                                    if Date2DMY(GCstatement."Liquidation Date", 2) = 7 then
                                                        CloseMonth3 := 'JUL'
                                                    else
                                                        if Date2DMY(GCstatement."Liquidation Date", 2) = 8 then
                                                            CloseMonth3 := 'AUG'
                                                        else
                                                            if Date2DMY(GCstatement."Liquidation Date", 2) = 9 then
                                                                CloseMonth3 := 'SEP'
                                                            else
                                                                if Date2DMY(GCstatement."Liquidation Date", 2) = 10 then
                                                                    CloseMonth3 := 'OCT'
                                                                else
                                                                    if Date2DMY(GCstatement."Liquidation Date", 2) = 11 then
                                                                        CloseMonth3 := 'NOV'
                                                                    else
                                                                        if Date2DMY(GCstatement."Liquidation Date", 2) = 12 then
                                                                            CloseMonth3 := 'DEC';

                            CloseMonth3 := CloseMonth3 + '-' + Format(Date2DMY(GCstatement."Liquidation Date", 3)); // 2 = Month

                        end;
                        if Counter = 4 then begin
                            ChickedHoused4 := GCstatement."Chick Housed";
                            MortalityPer4 := GCstatement."Mortality %";
                            ABW4 := GCstatement."Average Body weight2";
                            FCR4 := GCstatement.FCR;
                            EEF4 := GCstatement.EEF;
                            COP4 := GCstatement."Production Cost";
                            CloseMonth4 := Format(Date2DMY(GCstatement."Liquidation Date", 2)) + '-' + Format(Date2DMY(GCstatement."Liquidation Date", 3)); // 2 = Month
                            ILE.SetRange("Posting Date", 0D, GCstatement."Receipt Date" + 20);
                            if ILE.FindSet() then begin
                                ILE.CalcSums(Quantity);
                                MortalityLess20days4 := Round((ABS(ILE.Quantity) / GCstatement."Chick Housed") * 100, 0.001, '=');
                            end;
                            FlockNo4 := GCstatement."Flock No.";

                            ILE.SetRange("Posting Date", GCstatement."Receipt Date" + 21, Today());
                            if ILE.FindSet() then begin
                                ILE.CalcSums(Quantity);

                            end;
                            If GCstatement."Production Cost" <= 76 then
                                Grade4 := 'O'
                            else
                                if (GCstatement."Production Cost" >= 76.01) and (GCstatement."Production Cost" <= 77.99) then
                                    Grade4 := 'A'
                                else
                                    if (GCstatement."Production Cost" >= 78) and (GCstatement."Production Cost" <= 80.99) then
                                        Grade4 := 'B+'
                                    else
                                        if (GCstatement."Production Cost" = 80.3) then
                                            Grade4 := 'B'
                                        else
                                            if (GCstatement."Production Cost" >= 80.31) and (GCstatement."Production Cost" <= 82) then
                                                Grade4 := 'B-'
                                            else
                                                if (GCstatement."Production Cost" >= 82.01) and (GCstatement."Production Cost" <= 85) then
                                                    Grade4 := 'C'
                                                else
                                                    if (GCstatement."Production Cost" >= 85.01) and (GCstatement."Production Cost" <= 88) then
                                                        Grade4 := 'D'
                                                    else
                                                        if (GCstatement."Production Cost" >= 88.01) then
                                                            Grade4 := 'E';

                            if Date2DMY(GCstatement."Liquidation Date", 2) = 1 then
                                CloseMonth4 := 'JAN'
                            else
                                if Date2DMY(GCstatement."Liquidation Date", 2) = 2 then
                                    CloseMonth4 := 'FEB'
                                else
                                    if Date2DMY(GCstatement."Liquidation Date", 2) = 3 then
                                        CloseMonth4 := 'MAR'
                                    else
                                        if Date2DMY(GCstatement."Liquidation Date", 2) = 4 then
                                            CloseMonth4 := 'APR'
                                        else
                                            if Date2DMY(GCstatement."Liquidation Date", 2) = 5 then
                                                CloseMonth4 := 'MAY'
                                            else
                                                if Date2DMY(GCstatement."Liquidation Date", 2) = 6 then
                                                    CloseMonth4 := 'JUN'
                                                else
                                                    if Date2DMY(GCstatement."Liquidation Date", 2) = 7 then
                                                        CloseMonth4 := 'JUL'
                                                    else
                                                        if Date2DMY(GCstatement."Liquidation Date", 2) = 8 then
                                                            CloseMonth4 := 'AUG'
                                                        else
                                                            if Date2DMY(GCstatement."Liquidation Date", 2) = 9 then
                                                                CloseMonth4 := 'SEP'
                                                            else
                                                                if Date2DMY(GCstatement."Liquidation Date", 2) = 10 then
                                                                    CloseMonth4 := 'OCT'
                                                                else
                                                                    if Date2DMY(GCstatement."Liquidation Date", 2) = 11 then
                                                                        CloseMonth4 := 'NOV'
                                                                    else
                                                                        if Date2DMY(GCstatement."Liquidation Date", 2) = 12 then
                                                                            CloseMonth4 := 'DEC';

                            CloseMonth4 := CloseMonth4 + '-' + Format(Date2DMY(GCstatement."Liquidation Date", 3)); // 2 = Month
                        end;
                        if Counter = 5 then begin
                            ChickedHoused5 := GCstatement."Chick Housed";
                            MortalityPer5 := GCstatement."Mortality %";
                            ABW5 := GCstatement."Average Body weight2";
                            FCR5 := GCstatement.FCR;
                            EEF5 := GCstatement.EEF;
                            COP5 := GCstatement."Production Cost";

                            ILE.SetRange("Posting Date", 0D, GCstatement."Receipt Date" + 20);
                            if ILE.FindSet() then begin
                                ILE.CalcSums(Quantity);
                                MortalityLess20days5 := Round((ABS(ILE.Quantity) / GCstatement."Chick Housed") * 100, 0.001, '=');
                            end;
                            FlockNo5 := GCstatement."Flock No.";

                            ILE.SetRange("Posting Date", GCstatement."Receipt Date" + 21, Today());
                            if ILE.FindSet() then begin
                                ILE.CalcSums(Quantity);
                                MortalityGrater20days5 := Round((ABS(ILE.Quantity) / GCstatement."Chick Housed") * 100, 0.001, '=');
                            end;
                            If GCstatement."Production Cost" <= 76 then
                                Grade5 := 'O'
                            else
                                if (GCstatement."Production Cost" >= 76.01) and (GCstatement."Production Cost" <= 77.99) then
                                    Grade5 := 'A'
                                else
                                    if (GCstatement."Production Cost" >= 78) and (GCstatement."Production Cost" <= 80.99) then
                                        Grade5 := 'B+'
                                    else
                                        if (GCstatement."Production Cost" = 80.3) then
                                            Grade5 := 'B'
                                        else
                                            if (GCstatement."Production Cost" >= 80.31) and (GCstatement."Production Cost" <= 82) then
                                                Grade5 := 'B-'
                                            else
                                                if (GCstatement."Production Cost" >= 82.01) and (GCstatement."Production Cost" <= 85) then
                                                    Grade5 := 'C'
                                                else
                                                    if (GCstatement."Production Cost" >= 85.01) and (GCstatement."Production Cost" <= 88) then
                                                        Grade5 := 'D'
                                                    else
                                                        if (GCstatement."Production Cost" >= 88.01) then
                                                            Grade5 := 'E';

                            if Date2DMY(GCstatement."Liquidation Date", 2) = 1 then
                                CloseMonth5 := 'JAN'
                            else
                                if Date2DMY(GCstatement."Liquidation Date", 2) = 2 then
                                    CloseMonth5 := 'FEB'
                                else
                                    if Date2DMY(GCstatement."Liquidation Date", 2) = 3 then
                                        CloseMonth5 := 'MAR'
                                    else
                                        if Date2DMY(GCstatement."Liquidation Date", 2) = 4 then
                                            CloseMonth5 := 'APR'
                                        else
                                            if Date2DMY(GCstatement."Liquidation Date", 2) = 5 then
                                                CloseMonth5 := 'MAY'
                                            else
                                                if Date2DMY(GCstatement."Liquidation Date", 2) = 6 then
                                                    CloseMonth5 := 'JUN'
                                                else
                                                    if Date2DMY(GCstatement."Liquidation Date", 2) = 7 then
                                                        CloseMonth5 := 'JUL'
                                                    else
                                                        if Date2DMY(GCstatement."Liquidation Date", 2) = 8 then
                                                            CloseMonth5 := 'AUG'
                                                        else
                                                            if Date2DMY(GCstatement."Liquidation Date", 2) = 9 then
                                                                CloseMonth5 := 'SEP'
                                                            else
                                                                if Date2DMY(GCstatement."Liquidation Date", 2) = 10 then
                                                                    CloseMonth5 := 'OCT'
                                                                else
                                                                    if Date2DMY(GCstatement."Liquidation Date", 2) = 11 then
                                                                        CloseMonth5 := 'NOV'
                                                                    else
                                                                        if Date2DMY(GCstatement."Liquidation Date", 2) = 12 then
                                                                            CloseMonth5 := 'DEC';

                            CloseMonth5 := CloseMonth5 + '-' + Format(Date2DMY(GCstatement."Liquidation Date", 3)); // 2 = Month
                        end;

                    until (Counter = 5) or (GCstatement.Next() = 0);
                end;
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                //Location.SetFilter(Code, LocationCode);
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

    trigger OnPreReport()
    begin

    end;

    var
        Loc: Record Location;
        BranchCode: text;
        BranchName: Text;
        DimenValue: Record "Dimension Value";
        LocationCode: Code[2048];
        Branch: Code[2048];
        GCstatement: Record "GC Statement";
        ILE: Record "Item Ledger Entry";
        ChickedHoused1: Decimal;
        ChickedHoused2: Decimal;
        ChickedHoused3: Decimal;
        ChickedHoused4: Decimal;
        ChickedHoused5: Decimal;
        MortalityLess20days1: Decimal;
        MortalityLess20days2: Decimal;
        MortalityLess20days3: Decimal;
        MortalityLess20days4: Decimal;
        MortalityLess20days5: Decimal;
        MortalityGrater20days1: Decimal;
        MortalityGrater20days2: Decimal;
        MortalityGrater20days3: Decimal;
        MortalityGrater20days4: Decimal;
        MortalityGrater20days5: Decimal;
        MortalityPer1: Decimal;
        MortalityPer2: Decimal;
        MortalityPer3: Decimal;
        MortalityPer4: Decimal;
        MortalityPer5: Decimal;
        ABW1: Decimal;
        ABW2: Decimal;
        ABW3: Decimal;
        ABW4: Decimal;
        ABW5: Decimal;
        FCR1: Decimal;
        FCR2: Decimal;
        FCR3: Decimal;
        FCR4: Decimal;
        FCR5: Decimal;
        EEF1: Decimal;
        EEF2: Decimal;
        EEF3: Decimal;
        EEF4: Decimal;
        EEF5: Decimal;
        COP1: Decimal;
        COP2: Decimal;
        COP3: Decimal;
        COP4: Decimal;
        COP5: Decimal;
        Grade: Option "O","A","B","B+","B-","C","D","E";
        Grade1: Text;
        Grade2: Text;
        Grade3: Text;
        Grade4: Text;
        Grade5: Text;
        FlockNo1: Text;
        FlockNo2: Text;
        FlockNo3: Text;
        FlockNo4: Text;
        FlockNo5: Text;
        CloseMonth1: Text;
        CloseMonth2: Text;
        CloseMonth3: Text;
        CloseMonth4: Text;
        CloseMonth5: Text;

    procedure CLearvariable()

    begin

        Clear(ChickedHoused1);
        Clear(ChickedHoused2);
        Clear(ChickedHoused3);
        Clear(ChickedHoused4);
        Clear(ChickedHoused5);
        Clear(MortalityLess20days1);
        Clear(MortalityLess20days2);
        Clear(MortalityLess20days3);
        Clear(MortalityLess20days4);
        Clear(MortalityLess20days5);
        Clear(MortalityGrater20days1);
        Clear(MortalityGrater20days2);
        Clear(MortalityGrater20days3);
        Clear(MortalityGrater20days4);
        Clear(MortalityGrater20days5);
        Clear(MortalityPer1);
        Clear(MortalityPer2);
        Clear(MortalityPer3);
        Clear(MortalityPer4);
        Clear(MortalityPer5);
        Clear(ABW1);
        Clear(ABW2);
        Clear(ABW3);
        Clear(ABW4);
        Clear(ABW5);
        Clear(FCR1);
        Clear(FCR2);
        Clear(FCR3);
        Clear(FCR4);
        Clear(FCR5);
        Clear(EEF1);
        Clear(EEF2);
        Clear(EEF3);
        Clear(EEF4);
        Clear(EEF5);
        Clear(COP1);
        Clear(COP2);
        Clear(COP3);
        Clear(COP4);
        Clear(COP5);
        Clear(Grade1);
        Clear(Grade2);
        Clear(Grade3);
        Clear(Grade4);
        Clear(Grade5);
        Clear(FlockNo1);
        Clear(FlockNo2);
        Clear(FlockNo3);
        Clear(FlockNo4);
        Clear(FlockNo5);
        Clear(CloseMonth1);
        Clear(CloseMonth2);
        Clear(CloseMonth3);
        Clear(CloseMonth4);
        Clear(CloseMonth5);
    end;
}

