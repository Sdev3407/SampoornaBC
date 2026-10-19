report 50110 "Update Transfer Batch"
{
    ProcessingOnly = true;

    trigger OnInitReport()
    var
        SMSSentJob: Codeunit SmsSentjobQueue;
    Begin
        SMSSentJob.Sendemailforwhohasnotworkingwithus();
        SMSSentJob.Sendemailforwhohaworkingwithus();

    End;
}