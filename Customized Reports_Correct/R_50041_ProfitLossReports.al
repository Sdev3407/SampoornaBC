report 50041 "Profit Loss Reports"
{
    UsageCategory = Administration;
    Caption = 'Profit Loss Reports';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\ProfitLossReports.rdl';
    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            RequestFilterFields = "Global Dimension 1 Code", "Global Dimension 2 Code", "Shortcut Dimension 3 Code", "Posting Date";
            column(GLAccountNo_GLEntry; "G/L Entry"."G/L Account No.")
            {
            }
            column(Description_GLEntry; "G/L Entry".Description)
            {
            }
            column(GroupByCode; GroupByCode)
            {
            }
            column(Amount_GLEntry; "G/L Entry".Amount)
            {
            }
            column(AccountTyp; AccountTyp)
            {
            }
            column(IncomeB; IncomeB)
            {
            }
            column(GroupBy_GLEntry; "G/L Entry"."Group by Shorting")
            {
            }
            column(GlName; GlName)
            {
            }
            column(GroupBy_GLEntry1; "G/L Entry"."Group By")
            {
            }

            trigger OnAfterGetRecord()
            begin
                GlName := '';
                IncomeB := '';
                AccountTyp := '';
                "G/L Entry".CALCFIELDS("Group by Shorting");
                "G/L Entry".CALCFIELDS("Group By");
                IF Dimension1 THEN
                    GroupByCode := "G/L Entry"."Global Dimension 1 Code";
                IF Dimension2 THEN
                    GroupByCode := "G/L Entry"."Global Dimension 2 Code";
                IF Dimension3 THEN
                    GroupByCode := "G/L Entry"."Shortcut Dimension 3 Code";
                GLAccount.RESET;
                IF GLAccount.GET("G/L Entry"."G/L Account No.") THEN BEGIN
                    AccountTyp := FORMAT(GLAccount."Account Type");
                    IncomeB := FORMAT(GLAccount."Income/Balance");
                    GlName := GLAccount.Name;
                END;
                IF (AccountTyp <> 'Posting') OR (IncomeB <> 'Income Statement') THEN
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                StartDate := "G/L Entry".GETRANGEMIN("Posting Date");
                EndDate := "G/L Entry".GETRANGEMAX("Posting Date");
                //MESSAGE('%1,%2',StartDate,EndDate);
                IF (Dimension1 <> TRUE) AND (Dimension2 <> TRUE) AND (Dimension3 <> TRUE) THEN
                    ERROR('Please Select Any Filter');
                Dimension1Filter := "G/L Entry".GETFILTER("Global Dimension 1 Code");
                Dimension2Filter := "G/L Entry".GETFILTER("Global Dimension 2 Code");
                Dimension3Filter := "G/L Entry".GETFILTER("Shortcut Dimension 3 Code");
                IF Dimension1 THEN BEGIN
                    IF (Dimension2Filter <> '') OR (Dimension3Filter <> '') THEN
                        ERROR('Invalid Filters');
                END;
                IF Dimension2 THEN BEGIN
                    IF (Dimension1Filter <> '') OR (Dimension3Filter <> '') THEN
                        ERROR('Invalid Filters');
                END;
                IF Dimension3 THEN BEGIN
                    IF (Dimension2Filter <> '') OR (Dimension1Filter <> '') THEN
                        ERROR('Invalid Filters');
                END;
            end;
        }
        dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
        {
            column(Amount_TransferShipmentLine; "Transfer Shipment Line".Amount)
            {
            }
            column(ShortcutDimension1Code_TransferShipmentLine; "Transfer Shipment Line"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_TransferShipmentLine; "Transfer Shipment Line"."Shortcut Dimension 2 Code")
            {
            }
            column(TransferfromCode_TransferShipmentLine; "Transfer Shipment Line"."Transfer-from Code")
            {
            }
            column(GroupByCodeTS; GroupByCodeTS)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Dimension1 THEN
                    GroupByCodeTS := "Transfer Shipment Line"."Shortcut Dimension 1 Code";
                IF Dimension2 THEN
                    GroupByCodeTS := "Transfer Shipment Line"."Shortcut Dimension 2 Code";
                IF Dimension3 THEN
                    GroupByCodeTS := "Transfer Shipment Line"."Transfer-from Code";
            end;

            trigger OnPreDataItem()
            begin
                "Transfer Shipment Line".CALCFIELDS("Posting Date");
                "Transfer Shipment Line".SETRANGE("Posting Date", StartDate, EndDate);
            end;
        }
        dataitem("Transfer Receipt Line"; "Transfer Receipt Line")
        {
            column(TransfertoCode_TransferReceiptLine; "Transfer Receipt Line"."Transfer-to Code")
            {
            }
            column(ShortcutDimension1Code_TransferReceiptLine; "Transfer Receipt Line"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_TransferReceiptLine; "Transfer Receipt Line"."Shortcut Dimension 2 Code")
            {
            }
            column(Amount_TransferReceiptLine; "Transfer Receipt Line".Amount)
            {
            }
            column(GroupByCodeTR; GroupByCodeTR)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Dimension1 THEN
                    GroupByCodeTR := "Transfer Receipt Line"."Shortcut Dimension 1 Code";
                IF Dimension2 THEN
                    GroupByCodeTR := "Transfer Receipt Line"."Shortcut Dimension 2 Code";
                IF Dimension3 THEN
                    GroupByCodeTR := "Transfer Receipt Line"."Transfer-to Code";
            end;

            trigger OnPreDataItem()
            begin
                "Transfer Receipt Line".CALCFIELDS("Posting Date");
                "Transfer Receipt Line".SETRANGE("Posting Date", StartDate, EndDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("LOB Wise"; Dimension1)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF Dimension1 THEN BEGIN
                            Dimension2 := FALSE;
                            Dimension3 := FALSE;
                        END;
                    end;
                }
                field("BRANCH Wise"; Dimension2)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        IF Dimension2 THEN BEGIN
                            Dimension1 := FALSE;
                            Dimension3 := FALSE;
                        END;
                    end;
                }
                field("LOC Wise"; Dimension3)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        IF Dimension3 THEN BEGIN
                            Dimension1 := FALSE;
                            Dimension2 := FALSE;
                        END;
                    end;
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

    var
        Dimension1: Boolean;
        Dimension2: Boolean;
        Dimension3: Boolean;
        SrNo: Integer;
        GroupByCode: Code[20];
        AccountTyp: Text;
        IncomeB: Text;
        GLAccount: Record 15;
        GlName: Text;
        Dimension1Filter: Text;
        Dimension2Filter: Text;
        Dimension3Filter: Text;
        GroupByCodeTS: Text;
        GroupByCodeTR: Text;
        StartDate: Date;
        EndDate: Date;
}

