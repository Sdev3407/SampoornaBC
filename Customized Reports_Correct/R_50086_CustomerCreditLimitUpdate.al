report 50086 "Customer Credit Limit Update"
{
    UsageCategory = Administration;
    Caption = 'Customer Credit Limit Update Report';
    ApplicationArea = All;
    //DefaultLayout = RDLC;
    ProcessingOnly = true;
    // RDLCLayout = 'ReportLayout\CustomerCreditLimitUpdate.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {

            trigger OnAfterGetRecord()
            begin
                "Remaining Credit Limit" := 0;
                CALCFIELDS("Balance (LCY)", "Shipped Not Invoiced (LCY)");
                IF "Credit Limit (LCY)" <> 0 THEN BEGIN
                    IF ("Credit Limit (LCY)" - ("Balance (LCY)" + "Shipped Not Invoiced (LCY)")) < 0 THEN BEGIN
                        Customer."Credit Limit (LCY)" := 0;
                        Customer."Remaining Credit Limit" := 0;
                        Customer.Modify();
                    END
                    ELSE
                        Customer."Remaining Credit Limit" := "Credit Limit (LCY)" - ("Balance (LCY)" + "Shipped Not Invoiced (LCY)");
                END ELSE begin
                    Customer."Remaining Credit Limit" := 0;
                    Customer.MODIFY;
                END;
                ///PRU-VG
            end;
        }
    }

    /* requestpage
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
     }*/
}

