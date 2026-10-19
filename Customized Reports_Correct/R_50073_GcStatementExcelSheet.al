report 50073 "Gc Statement Excel Sheet"
{
    ProcessingOnly = true;
    UseRequestPage = false;
    Caption = 'Gc Statement Excel Sheet';
    UsageCategory = Administration;
    ApplicationArea = all;
    dataset
    {
        dataitem("GC Statement Excel Sheet"; "GC Statement Excel Sheet")
        {
            //DataItemTableView = WHERE(3=FILTER(<>0));

            trigger OnAfterGetRecord()
            begin
                CreateBody;
                Co += 1;
            end;

            trigger OnPreDataItem()
            begin
                CreateHeader;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        ExcelBuffer.CreateNewBook('GC Statement');
        ExcelBuffer.WriteSheet('GC Statement', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(StrSubstNo('GC Statement', CurrentDateTime, UserId));
        ExcelBuffer.OpenExcel();
        //ExcelBuffer.CreateBookAndOpenExcel('', 'GC Statement', ' ', COMPANYNAME, USERID);
        //MESSAGE('%1',Co);
    end;

    trigger OnPreReport()
    begin
        SetMatrixCaption;
    end;

    var
        MATRIX_CaptionSet: array[100] of Code[20];
        ExcelBuffer: Record "Excel Buffer" temporary;// "370"
        Stdate: Date;
        EnDate: Date;
        Co: Integer;

    local procedure CreateHeader()
    begin
        //ExcelBuffer.AddColumn('',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Performance Report', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;
        //ExcelBuffer.AddColumn('',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Report Start Date :', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Stdate, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;
        //ExcelBuffer.AddColumn('',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Report End Date :', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(EnDate, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow;
        //ExcelBuffer.AddColumn(MATRIX_CaptionSet[1],FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(MATRIX_CaptionSet[2], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(MATRIX_CaptionSet[3], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(MATRIX_CaptionSet[4], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(MATRIX_CaptionSet[5], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(MATRIX_CaptionSet[6], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(MATRIX_CaptionSet[7], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(MATRIX_CaptionSet[8], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(MATRIX_CaptionSet[9], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(MATRIX_CaptionSet[10], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(MATRIX_CaptionSet[11], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(MATRIX_CaptionSet[12], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(MATRIX_CaptionSet[13], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(MATRIX_CaptionSet[14], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(MATRIX_CaptionSet[15], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(MATRIX_CaptionSet[16], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(MATRIX_CaptionSet[17], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(MATRIX_CaptionSet[18], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(MATRIX_CaptionSet[19], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(MATRIX_CaptionSet[20], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
    end;

    local procedure CreateBody()
    begin
        ExcelBuffer.NewRow;
        // ExcelBuffer.AddColumn("GC Statement Excel Sheet"."1",FALSE,'',FALSE,FALSE,TRUE,'',ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("GC Statement Excel Sheet".Farm, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("GC Statement Excel Sheet"."3", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("GC Statement Excel Sheet"."4", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("GC Statement Excel Sheet"."5", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("GC Statement Excel Sheet"."6", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("GC Statement Excel Sheet"."7", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("GC Statement Excel Sheet"."8", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("GC Statement Excel Sheet"."9", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("GC Statement Excel Sheet"."10", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("GC Statement Excel Sheet"."11", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("GC Statement Excel Sheet"."12", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("GC Statement Excel Sheet"."13", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("GC Statement Excel Sheet"."14", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("GC Statement Excel Sheet"."15", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("GC Statement Excel Sheet"."16", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("GC Statement Excel Sheet"."17", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("GC Statement Excel Sheet"."18", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("GC Statement Excel Sheet"."19", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("GC Statement Excel Sheet"."Feed Return %", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
    end;

    local procedure SetMatrixCaption()
    begin
        //MATRIX_CaptionSet[1] := 'Area';
        MATRIX_CaptionSet[2] := 'Branch';
        MATRIX_CaptionSet[3] := 'No. Of Farm.';
        MATRIX_CaptionSet[4] := 'Chicks Housed';
        MATRIX_CaptionSet[5] := 'Feed Intake %';
        MATRIX_CaptionSet[6] := 'FCR';
        MATRIX_CaptionSet[7] := 'CFCR';
        MATRIX_CaptionSet[8] := 'Avg. Weight';
        MATRIX_CaptionSet[9] := 'Mean Age';
        MATRIX_CaptionSet[10] := 'Day Gain';
        MATRIX_CaptionSet[11] := 'Mortality %';
        MATRIX_CaptionSet[12] := 'EEF';
        MATRIX_CaptionSet[13] := 'Chick Cost';
        MATRIX_CaptionSet[14] := 'Feed Cost';
        MATRIX_CaptionSet[15] := 'Medicine Cost';
        MATRIX_CaptionSet[16] := 'Admin Cost';
        MATRIX_CaptionSet[17] := 'Prod. Cost';
        MATRIX_CaptionSet[18] := 'GC Per Kg.';
        MATRIX_CaptionSet[19] := 'GC Per Bird';
        MATRIX_CaptionSet[19] := 'GC Per Bird';
        MATRIX_CaptionSet[20] := 'Feed Return %';
    end;


    procedure GetDateFillter(Sdate: Date; Edate: Date)
    begin
        Stdate := Sdate;
        EnDate := Edate;
        //MESSAGE('%1',Sdate);
    end;
}

