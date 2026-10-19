report 50059 "Print Barcode"
{
    UsageCategory = Administration;
    Caption = 'Print Barcode Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\PrintBarcode.rdl';
    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            column(BatchBarcode_ProductionOrder; "Production Order"."Batch Barcode")
            {
            }
            column(DueDate_ProductionOrder; "Production Order"."Due Date")
            {
            }
            column(Status_ProductionOrder; "Production Order".Status)
            {
            }
            column(No; "Production Order"."No.")
            {
            }
            column(Blob; "Production Order"."Batch Barcode")
            { }

            column(No2; "Production Order"."No.")
            {
            }

            trigger OnAfterGetRecord()
            begin

                //BarcodeWebServices.Generate2DBarcode("Production Order"."No.");
                //  SalesPost.QRcodeForLotNo('http://bc.sampoornafeeds.in:7038/BCLIVE/WS/Sampoorna%20Feeds%20Pvt.%20Ltd/Codeunit/BarcodeWebService', "Production Order"."No.");  //PRU SH
                SalesPost.QRcodeForLotNo('https://bar.sampoornafeeds.in/NavBatch/?batchno=' + "Production Order"."No.", "Production Order"."No.");  //PRU SH
                "Production Order".CALCFIELDS("Batch Barcode")
            end;

            trigger OnPreDataItem()
            begin
                //
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
        BarcodeWebServices: Codeunit 50013;
        // recTmpBlob: Record 99008535 temporary;  //PRU SH
        SalesPost: Codeunit 50037;


}

