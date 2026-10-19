report 50126 "PendingGateEntry"
{
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    //ProcessingOnly = true;
    Caption = 'Pending Gate Entry Report';
    RDLCLayout = 'ReportLayout\PendingGateEntry.rdl';
    dataset
    {
        dataitem("Posted Gate Entry Line"; "Posted Gate Entry Line")
        {
            DataItemTableView = sorting("Entry Type", "Gate Entry No.", "Line No.") order(ascending) Where(Status = filter(Open), "Entry Type" = filter(Inward));
            column(Gate_Entry_No_; "Gate Entry No.")
            {
            }
            column(Source_No_; "Source No.")
            {
            }
            column(Source_Name; "Source Name")
            {
            }
            column(postingDate; postingDate)
            {
            }
            column(LocationCode; LocationCode)
            {

            }
            column(Name; Name)
            {

            }

            trigger OnAfterGetRecord()

            begin

                If postedgateentryheader.Get("Posted Gate Entry Line"."Entry Type"::Inward, "Posted Gate Entry Line"."Gate Entry No.") then begin
                    postingDate := postedgateentryheader."Posting Date";
                    LocationCode := postedgateentryheader."Location Code";
                    RecLocation.get(LocationCode);
                    Name := RecLocation.Name;


                End;

            end;





        }

    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {

            }
        }
    }

    var
        postingDate: Date;
        postedgateentryheader: Record "Posted Gate Entry Header";
        LocationCode: Code[10];
        RecLocation: record Location;
        Name: Text;

}