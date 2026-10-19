codeunit 50011 "Customer Statement On WhatsApp"
{

    trigger OnRun()
    Var
        Customer: Record Customer;
        i: Integer;

    begin
        CustomerFreze();

        Customer.Reset();
        Customer.SetRange(Freeze, false);
        Customer.Setfilter("Customer Status", '%1|%2', Customer."Customer Status"::Regular, Customer."Customer Status"::SettledContinue);
        Customer.CalcFields("Net Change");
        Customer.Setfilter("Net Change", '>=%1', 100000);
        Customer.SetFilter("Responsibility Center", 'FEED|CATTLE');
        Customer.SetRange("Disable Customer Statement", false);
        //Customer.SetRange("Salesperson Code", 'SAM3035');
        if Customer.FindSet() then
            repeat
                SOASendonWhatsapp(Customer."No.");
            until Customer.Next() = 0;

    end;

    procedure SOASendonWhatsapp(No: Code[10])
    var
        // OStream: 
        Cust: Record Customer;
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Rep50026: Report 50026;
        Outstr: OutStream;
        FileManagement: Codeunit "File Management";
        WebMessageBody: Text;
        WhatsApp: Codeunit "WhatsApp Function";
        PhoneNo: text;

    begin

        Clear(FileName);
        Clear(FileManagement);
        //FileCOde := FileString.GeneratePassword(20);
        FileName := 'D:\Whatsapp\' + 'StatementOfAccount' + No + DelChr(Format(Today()), '=', '/\-:') + '.pdf';

        Clear(Outstr);
        Cust.RESET;
        Cust.SETRANGE(Cust."No.", No);
        // PDFVendor.SetRange("Date Filter", StartD, EndD);
        IF Cust.FINDFIRST THEN BEGIN
            RecRef.GetTable(Cust);
            TempBlob.CreateOutStream(Outstr);
            Rep50026.SetReportFilter(CalcDate('-CM', (CalcDate('-CM', WorkDate()) - 1)), CalcDate('-CM', WorkDate()) - 1);
            Rep50026.SetNarration(true);
            Rep50026.SavePDF(false);
            Rep50026.SaveAs('', ReportFormat::Pdf, Outstr, RecRef);
            FileManagement.BLOBExportToServerFile(TempBlob, FileName);
            if Cust."WhatsApp Mobile No." <> '' then
                PhoneNo := Cust."WhatsApp Mobile No."
            else
                PhoneNo := Cust."Phone No.";
            //WhatsApp.WhatsAppAPI(WhatsApp.WhatsAppSOA('9759785217', Cust.Name, CalcDate('-CM', (CalcDate('-CM', WorkDate()) - 1)), CalcDate('-CM', WorkDate()) - 1, 'https://sfplwhatsapp.sampoornafeeds.in/' + 'StatementOfAccount' + No + '.pdf', No));
            WhatsApp.AirtelWhatssAppAPI(WhatsApp.WhatsAppSOA(PhoneNo, Cust.Name, CalcDate('-CM', (CalcDate('-CM', WorkDate()) - 1)), CalcDate('-CM', WorkDate()) - 1, 'https://sfplwhatsapp.sampoornafeeds.in/' + 'StatementOfAccount' + No + DelChr(Format(Today()), '=', '/\-:') + '.pdf', No));
            //FarmExpirt.SendWhatsAppAttachment(Cust."Phone No.", 'StatementOfAccount' + No + '.pdf', WebMessageBody);
            //Erase(FileName);
        end;
    end;

    procedure CustomerFreze()
    var
        Customer: Record Customer;
        CLE: Record "Cust. Ledger Entry";
    begin
        Customer.Reset();
        if Customer.FindSet() Then
            repeat
                CLE.Reset();
                CLE.SetRange("Customer No.", Customer."No.");
                CLE.SetFilter("Document Type", '%1|%2', CLE."Document Type"::Invoice, CLE."Document Type"::Payment);
                CLE.SetRange("Posting Date", WorkDate() - 60, WorkDate());
                if CLE.FindFirst() then
                    Customer.Freeze := false
                else
                    Customer.Freeze := true;
                Customer.Modify();
            until Customer.Next() = 0;
    end;


    var
        Desc: array[8] of Text;
        R1401: Report 1401;
        SOA: Report "Customer Statement_N";
        FileName: Text;
        FarmExpirt: Codeunit "Farm Location Expire";
}

