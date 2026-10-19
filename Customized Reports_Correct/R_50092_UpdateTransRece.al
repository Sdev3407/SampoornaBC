report 50092 UpdateTransRece
{
    UsageCategory = Administration;
    Caption = 'Update TransRece Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\UpdateTransRece.rdl';
    dataset
    {
        dataitem(DataItem1170000005; "Item Ledger Entry")
        {

            trigger OnAfterGetRecord()
            var
                Loc: Record 14;
            begin
                /*IF "Item Ledger Entry"."Item Name" = '' THEN BEGIN
                  T27.GET("Item Ledger Entry"."Item No.");
                  "Item Ledger Entry"."Item Name"  := T27.Description;
                  "Item Ledger Entry".MODIFY;
                END;
                */
                T480.RESET;//PRU-VG
                T480.SETRANGE("Dimension Set ID", "Dimension Set ID");//PRU-VG
                T480.SETRANGE(T480."Dimension Code", 'LOC');//PRU-VG
                IF T480.FINDFIRST THEN BEGIN//PRU-VG
                    "Shortcut Dimension 3 Code" := T480."Dimension Value Code";//PRU-VG
                    MODIFY;
                END;
                /*
                Loc.GET("Item Ledger Entry"."Location Code");
                "Item Ledger Entry"."Location Name" := Loc.Name;
                "Item Ledger Entry".MODIFY;
                */

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
        T18: Record 18;
        T23: Record 23;
        T27: Record 27;
}

