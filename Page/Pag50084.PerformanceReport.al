page 50084 "Performance Report"
{
    Caption = 'Performance Report';
    DataCaptionExpression = '';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Start Date"; StartDate)
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                }
                field("End Date"; EndDate)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Location)
                {
                    ApplicationArea = All;
                    TableRelation = Location.Code;
                }
                field("Branch Name"; BranchName)
                {
                    ApplicationArea = All;
                    Editable = EditBranch;
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                                  Blocked = CONST(false),
                                                                  Code = FILTER(3000 .. 4000));
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Show Matrix")
            {
                Caption = '&Show Matrix';
                Image = ShowMatrix;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                var
                    MatrixForm: Page 9297;
                    i: Integer;
                    DimensionValue: Record 349;

                begin
                    CLEAR(GCStatementSummary);
                    // IF BranchName = '' THEN
                    //     BranchName := '3000..4000';
                    GCStatementSummary.Load(StartDate, EndDate, BranchName, Location);
                    DimensionValue.RESET;
                    DimensionValue.SETRANGE(DimensionValue."Global Dimension No.", 2);
                    DimensionValue.SETRANGE(DimensionValue.Blocked, FALSE);
                    //DimensionValue.SETFILTER(DimensionValue.Code,'3000','4000');
                    DimensionValue.SETFILTER(DimensionValue.Code, BranchName);
                    IF DimensionValue.FINDFIRST THEN BEGIN
                        GCStatementSummary.SETTABLEVIEW(DimensionValue);
                        //MESSAGE('Tested');
                        GCStatementSummary.RUNMODAL;
                    END;

                end;

            }
        }
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
        Location: Record Location;
    begin
        EditBranch := false;
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.FindFirst() Then begin
            BranchName := UserSetup."Global Dimension 2 Code";
            if UserSetup."Global Dimension 2 Code" = '' then
                EditBranch := True;
            Location.Reset();
            Location.SetRange("Global Dimension 2 Code", UserSetup."Global Dimension 2 Code");
            if Location.FindFirst() then
                RegionCode := Location."Region Code";

        end


    end;

    var
        EditBranch: Boolean;
        MatrixRecords: array[32] of Record 367;
        MATRIX_CaptionSet: array[32] of Text[1024];
        MATRIX_CurrentNoOfColumns: Integer;
        GLSetup: Record 98;
        InvtReportHeader: Record 5845;
        InvtReportEntry: Record 5846 temporary;
        RowIntegerLine: Record 2000000026;
        ColIntegerLine: Record 2000000026;
        LineDimCode: Text[20];
        ColumnDimCode: Text[20];
        DateFilter: Text[30];
        ItemFilter: Code[250];
        LocationFilter: Code[250];
        PeriodInitialized: Boolean;
        Text004: Label 'Income Statement';
        Text005: Label 'Balance Sheet';
        ShowWarning: Boolean;
        Text006: Label 'Expected Cost Setup';
        Text007: Label 'Post Cost to G/L';
        Text008: Label 'Compression';
        Text009: Label 'Posting Group';
        Text010: Label 'Direct Posting';
        Text011: Label 'Posting Date';
        Text012: Label 'Closed Fiscal Year';
        Text013: Label 'Similar Accounts';
        Text014: Label 'Deleted Accounts';
        CostPostingNotSelectedTxt: Label 'Expected Cost Posting to G/L is not selected in the Inventory Setup window. Therefore, inventory interim G/L accounts are empty and this causes a difference between inventory and G/L totals.';
        CostAmountsNotPostedYetTxt: Label 'Some of the cost amounts in the inventory ledger have not yet been posted to the general ledger. You must run the Post Inventory Cost to G/L batch job to reconcile the ledgers.';
        EntriesCompressedTxt: Label 'Some inventory or G/L entries have been date compressed.';
        ReassigningAccountsTxt: Label 'You may have restructured your chart of accounts by reassigning inventory related accounts in the General or Inventory Posting Setup.';
        PostedDirectlyToGLAccountTxt: Label 'Some inventory costs have been posted directly to a G/L account, bypassing the inventory subledger.';
        Text021: Label 'There is a discrepancy between the posting date of the value entry and the associated G/L entry within the reporting period.';
        PostedInClosedFiscalYearTxt: Label 'Some of the cost amounts are posted in a closed fiscal year. Therefore, the inventory-related totals are different from their related G/L accounts in the income statement.';
        Text023: Label 'You have possibly defined one G/L account for different inventory transactions.';
        DeletingAccountsTxt: Label 'You may have restructured your chart of accounts by deleting one or more inventory related G/L accounts.';
        [InDataSet]
        ShowEditable: Boolean;
        StartDate: Date;
        EndDate: Date;
        Location: Code[1024];
        BranchName: Code[1024];
        Region: Code[10];
        GCStatementSummary: Page "GC Statement Summary";
        RegionCode: Code[10];
        RecRegion: Record Region;
}


