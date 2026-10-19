report 50119 UpdateGLENyry
{
    UsageCategory = Administration;
    Caption = 'Update GL Entry Report';
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            trigger OnPreDataItem()
            begin
                SetRange("Document No.", DOCNo);
            end;

            trigger OnAfterGetRecord()
            begin
                "Cust. Ledger Entry"."Global Dimension 1 Code" := 'CATTLE';
                "Cust. Ledger Entry"."Global Dimension 2 Code" := '1012';
                "Cust. Ledger Entry"."Shortcut Dimension 3 Code" := 'SFPL0054';
                "Cust. Ledger Entry"."Shortcut Dimension 3Code" := 'SFPL0054';
                "Cust. Ledger Entry"."Dimension Set ID" := 4846;
                "Cust. Ledger Entry".MODIFY;

            end;
        }
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {

            trigger OnPreDataItem()
            begin
                SetRange("Document No.", DOCNo);
            end;

            trigger OnAfterGetRecord()
            begin

                "Bank Account Ledger Entry"."Global Dimension 1 Code" := 'CATTLE';
                "Bank Account Ledger Entry"."Global Dimension 2 Code" := '1012';
                "Bank Account Ledger Entry"."Shortcut Dimension 3 Code" := 'SFPL0054';
                "Bank Account Ledger Entry"."Shortcut Dimension 3Code" := 'SFPL0054';
                "Bank Account Ledger Entry"."Dimension Set ID" := 4846;
                "Bank Account Ledger Entry".MODIFY;


            end;
        }
        dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
        {
            trigger OnPreDataItem()
            begin
                SetRange("Document No.", DOCNo);
            end;

            trigger OnAfterGetRecord()
            begin


                "Detailed Cust. Ledg. Entry"."Initial Entry Global Dim. 1" := 'CATTLE';
                "Detailed Cust. Ledg. Entry"."Initial Entry Global Dim. 2" := '1012';

                "Detailed Cust. Ledg. Entry".MODIFY;
            end;
        }
        dataitem("G/L Entry"; "G/L Entry")
        {
            trigger OnPreDataItem()
            begin
                SetRange("Document No.", DOCNo);
            end;

            trigger OnAfterGetRecord()
            begin
                "G/L Entry"."Global Dimension 1 Code" := 'CATTLE';
                "G/L Entry"."Global Dimension 2 Code" := '1012';
                "G/L Entry"."Shortcut Dimension 3 Code" := 'SFPL0054';
                "G/L Entry"."Shortcut Dimension 3Code" := 'SFPL0054';
                "G/L Entry"."Dimension Set ID" := 4846;
                "G/L Entry".MODIFY;
            end;
        }

    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(DOCNo; DOCNo)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'DOC No';
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
        ILE: Record 32;
        DOCNo: Code[20];
}

