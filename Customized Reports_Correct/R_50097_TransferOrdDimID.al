report 50097 "Transfer Ord Dim ID"
{
    UsageCategory = Administration;
    Caption = '"Transfer Ord Dim ID Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\TransferOrdDimID.rdl';

    dataset
    {
        dataitem("Transfer Header"; "Transfer Header")
        {

            trigger OnAfterGetRecord()
            begin
                /*
                TransferLine.RESET;
                TransferLine.SETRANGE("Document No.", "No.");
                IF TransferLine.FINDSET THEN
                  REPEAT
                    TransferLine."Dimension Set ID" := "Transfer Header"."Dimension Set ID";
                    TransferLine.MODIFY(TRUE);
                    MESSAGE('%1',TransferLine."Dimension Set ID");
                  UNTIL TransferLine.NEXT = 0;
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
        TransferLine: Record 5741;
}

