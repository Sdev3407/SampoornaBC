namespace Sampoorna_BC.Sampoorna_BC;

using Microsoft.Sales.Customer;
using System.Utilities;
using System.Email;
using System.Text;
using Microsoft.Sales.History;
using System.IO;
using Microsoft.CRM.Team;

report 50017 SendMailCust
{
    ApplicationArea = All;
    Caption = 'Send Email Customers';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(Customer; Customer)

        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                if not Customer."Disable Customer Statement" then
                    SendEMail(Customer);
            end;

            trigger OnPreDataItem()
            begin
                if StartDate <> 0D then
                    if EndDate = 0D then
                        EndDate := 99991231D;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Starting Date';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    //SIM -----Code Added---->>>>>>----------
    procedure SendEmail(Cust: Record Customer) "MailSent": Boolean;
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        ListTo: List of [Text];
        CCTo: List of [Text];
        SalesPerson: Record "Salesperson/Purchaser";
        ZipInstream: InStream;
        FileMgmt: Codeunit "File Management";
        ZipFileName: Text;
        TempBlob: Codeunit "Temp Blob";
        outStreamReport: OutStream;
        inStreamReport: InStream;
        Recordr: RecordRef;
        ZipoutStream: OutStream;
        FullFileName: Text;
        SalesInvHeader: Record "Sales Invoice Header";
        SalesInvHeader1: Record "Sales Invoice Header";
        ZipMgmt: Codeunit "Data Compression";
        txtB64: Text;
        EmailBody: Text;
        Subject: Text;

    begin
        //Adding Receipients & CC Mail
        ListTo.Add(Cust."E-Mail");

        If Cust."Salesperson Code" <> '' then
            if SalesPerson.Get(Cust."Salesperson Code") then
                CCTo.Add(SalesPerson."E-Mail");
        //Creating Mail
        Clear(EmailBody);
        Clear(Subject);

        Subject := Customer.Name + 'Invoice From' + Format(StartDate) + 'to' + Format(EndDate);
        //EmailBody := 


        EmailMessage.Create(ListTo, Customer.Name + ' Invoices _' + Format(Today), 'This is the body', true);

        //Add Attachment 
        Clear(ZipFileName);
        SalesInvHeader.Reset();
        SalesInvHeader.SetRange("Sell-to Customer No.", Cust."No.");
        if (EndDate <> 0D) then
            SalesInvHeader.SetRange("Posting Date", StartDate, EndDate);
        if SalesInvHeader.FindSet(false) then begin
            ZipFileName := 'Invoices_' + Format(CurrentDateTime) + '.zip';
            ZipMgmt.CreateZipArchive();
            repeat
                SalesInvHeader1.Reset();
                SalesInvHeader1.SetRange("No.", SalesInvHeader."No.");
                if SalesInvHeader1.FindFirst() then;
                Clear(Recordr);
                Clear(outStreamReport);
                Clear(inStreamReport);
                Recordr.Open(Database::"Sales Invoice Header");
                Recordr.GetTable(SalesInvHeader1);
                TempBlob.CreateOutStream(outStreamReport);

                if Report.SaveAs(50001, '', ReportFormat::Pdf, outStreamReport, Recordr) then begin
                    TempBlob.CreateInStream(inStreamReport);
                    // txtB64 := cnv64.ToBase64(inStreamReport, true);
                    FullFileName := SalesInvHeader."No." + '.pdf';
                    ZipMgmt.AddEntry(inStreamReport, FullFileName);
                End;
            until SalesInvHeader.Next() = 0;
            Clear(TempBlob);
            Clear(ZipoutStream);
            Clear(ZipinStream);
            TempBlob.CreateOutStream(ZipoutStream);
            ZipMgmt.SaveZipArchive(ZipoutStream);
            TempBlob.CreateInStream(ZipinStream);
        end;

        EmailMessage.AddAttachment(ZipFileName, FileMgmt.GetExtension(ZipFileName), ZipinStream);

        //Send Mail
        MailSent := Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

        //Error Message
        if not MailSent then
            Error(GetLastErrorText());
    end;
    //SIM -----Code Added---->>>>>>----------
    var
        StartDate: Date;
        EndDate: Date;
}
