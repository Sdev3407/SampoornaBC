report 50091 UpdateLedger
{
    UsageCategory = Administration;
    Caption = 'Update Ledger Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\UpdateLedger.rdl';
    dataset
    {
        dataitem(DataItem1170000000; 17)
        {

            trigger OnAfterGetRecord()
            begin
                T480.RESET;//PRU-VG
                T480.SETRANGE("Dimension Set ID", "Dimension Set ID");//PRU-VG
                T480.SETRANGE(T480."Dimension Code", 'EMPLOYEE');//PRU-VG
                IF T480.FINDFIRST THEN BEGIN//PRU-VG
                    "Shortcut Dimension 4 Code" := T480."Dimension Value Code";//PRU-VG
                    MODIFY;
                END;
            end;
        }
        dataitem(DataItem1170000001; 271)
        {

            trigger OnAfterGetRecord()
            begin
                T480.RESET;//PRU-VG
                T480.SETRANGE("Dimension Set ID", "Dimension Set ID");//PRU-VG
                T480.SETRANGE(T480."Dimension Code", 'EMPLOYEE');//PRU-VG
                IF T480.FINDFIRST THEN BEGIN//PRU-VG
                    "Shortcut Dimension 4 Code" := T480."Dimension Value Code";//PRU-VG
                    MODIFY;
                END;
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

    var
        T480: Record 480;
}

