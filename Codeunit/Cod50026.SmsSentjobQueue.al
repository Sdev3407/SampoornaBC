codeunit 50026 SmsSentjobQueue
{
    // Permissions = tabledata "Sales Invoice Header" r
    var
        SalesInvoiceHeader: record "Sales Invoice Header";
        Salesperson: Record "Salesperson/Purchaser";
        SalesInvoiceHeader1: record "Sales Invoice Header";
        Customer: Record Customer;
        EmailBody: Text;
        SMTPMail: Codeunit "Email Message";
        RecRef: RecordRef;
        TempBlob: Codeunit "Temp Blob";
        Email: Codeunit Email;
        Outstr: OutStream;
        Instr: InStream;
        DuplicateBranch: Code[10];


    trigger OnRun()
    begin
        SendInvoice();

    end;

    procedure SendInvoice()
    var

    Begin
        // IF SalesInvHdrNo <> '' THEN BEGIN
        SalesInvoiceHeader.RESET;
        SalesInvoiceHeader.SETRANGE("Sms Sent", FALSE);
        IF SalesInvoiceHeader.FINDSET THEN BEGIN
            REPEAT

                SalesInvoiceHeader1.RESET;
                SalesInvoiceHeader1.SETRANGE("No.", SalesInvoiceHeader."No.");
                IF SalesInvoiceHeader1.FindFirst() THEN BEGIN
                    Customer.RESET;
                    Customer.SETRANGE("No.", SalesInvoiceHeader1."Sell-to Customer No.");
                    Customer.SETFILTER("E-Mail", '<>%1', '');
                    IF Customer.FINDFIRST THEN BEGIN
                        Clear(SMTPMail);
                        Clear(Email);
                        EmailBody := ('Dear Sir' + ',');
                        EmailBody += ('<br><br>');
                        EmailBody += ('Please find enclosed herewith your Invoice as per above mentioned subject for your kind perusal. If you found any discrepancy kindly let us know within 7 days after receiving the mail.');
                        EmailBody += ('<br><br>');
                        EmailBody += ('For any further information, please feel free to contact our dedicated executive.');
                        EmailBody += ('<br><br>');
                        SMTPMail.Create(Customer."E-Mail", 'Invoice' + ' ' + '(' + SalesInvoiceHeader1."No." + ')', EmailBody, true);
                        //   SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, Customer."E-Mail");
                        Salesperson.RESET;
                        Salesperson.SetRange(Code, SalesInvoiceHeader1."Salesperson Code");
                        if Salesperson.FindFirst() then
                            if Salesperson.Code = 'ARVIND' then
                                SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, Salesperson."E-Mail");

                        RecRef.GetTable(SalesInvoiceHeader1);
                        TempBlob.CreateOutStream(Outstr);
                        Report.SaveAs(Report::"Sales Invoice New-GST", '', ReportFormat::Pdf, Outstr, RecRef);
                        TempBlob.CreateInStream(Instr);
                        SMTPMail.AddAttachment(SalesInvoiceHeader1."No." + '.pdf', 'PDF', Instr);

                        //  SMTPMail.AddAttachment(ReportPath, 'Invoice_' + DELCHR(SalesInvoiceHeader1."No.", '=', '/') + '.pdf');
                        SMTPMail.AppendToBody('With best regards!' + ',');
                        SMTPMail.AppendToBody('<BR>');
                        SMTPMail.AppendToBody('Sampoorna Team');
                        SMTPMail.AppendToBody('<BR><BR>');
                        SMTPMail.AppendToBody('Note : This is computer generated mail, please do-not reply on this.<BR><BR>');
                        Email.Send(SMTPMail, Enum::"Email Scenario"::Default);
                        SalesInvoiceHeader."SMS Sent" := TRUE;
                        SalesInvoiceHeader.modify;
                    END;
                END;
            // DuplicateBranch := SalesInvoiceHeader."Sell-to Customer No.";
            // END;

            UNTIL SalesInvoiceHeader.NEXT = 0;

        END;

    End;

    procedure Sendemailforwhohaworkingwithus()
    var
        SMTPMail: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        RecRef: RecordRef;
        EmailR: Codeunit Email;
        Outstr: OutStream;
        Instr: InStream;
        SalesPerson: Record "Salesperson/Purchaser";
        FileName: Text;
        FileManagement: Codeunit "File Management";

    begin
        Clear(SMTPMail);
        Clear(FileName);
        Clear(FileManagement);
        FileName := 'D:\MSZ Reports\DespatchReconcilation\' + 'Sales Person Wise Detail' + '.xlsx';
        SMTPMail.Create('deepak.dhapke@sampoornafeeds.in', 'Detail of Sales Person who have the party and Outstanding', '', true);
        SMTPMail.AppendToBody('Dear All' + ',' + '<BR><BR>');
        SMTPMail.AppendToBody('Please find attached excel file of that Detail of Sales Person who have the party and Outstanding as on date ' + '.<BR><BR>');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Bcc, 'sumandev@sampoornafeeds.com');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'parveen.k@sampoornafeeds.com');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'vasu@sampoornafeeds.com');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'RISHABH.GUPTA@sampoornafeeds.in');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'ritu@sampoornafeeds.com');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'riya@sampoornafeeds.com');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Bcc, 'sanjay.tiwari@sampoornafeeds.in');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'sale.coordinator3@sampoornafeeds.in');
        //SMTPMail.AddBCC('RISHABH.GUPTA@sampoornafeeds.in;sumandev@sampoornafeeds.in');
        //RecRef.GetTable(PurcRcpLine);
        Clear(Outstr);
        Clear(Instr);
        RecRef.GetTable(SalesPerson);
        TempBlob.CreateOutStream(Outstr);
        //TempBlob.CreateOutStream(Outstr1);
        //Report.SaveAs(50138, '', ReportFormat::Excel, Outstr);
        Report.SaveAs(50013, '', ReportFormat::Excel, Outstr, RecRef);
        FileManagement.BLOBExportToServerFile(TempBlob, FileName);

        FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
        TempBlob.CreateInStream(Instr);
        //SMTPMail.AddAttachment('Pending MRN' + '.xlsx', 'xlsx', Instr);
        SMTPMail.AddAttachment('Sales Person Wise Detail' + '.xlsx', 'xlsx', Instr);
        SMTPMail.AppendToBody('Regards' + ',' + '<BR>' + 'Sampoorna Feeds Pvt. Ltd.' + '<BR><BR>');
        SMTPMail.AppendToBody('This is system generated mail. Please do not reply.<BR><BR>');
        EmailR.Send(SMTPMail, Enum::"Email Scenario"::Default);
        Erase(FileName);
    end;

    procedure Sendemailforwhohasnotworkingwithus()
    var
        SMTPMail: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        RecRef: RecordRef;
        EmailR: Codeunit Email;
        Outstr: OutStream;
        Instr: InStream;
        SalesPerson: Record "Salesperson/Purchaser";
        FileName: Text;
        FileManagement: Codeunit "File Management";

    begin
        Clear(SMTPMail);
        Clear(FileName);
        Clear(FileManagement);
        FileName := 'D:\MSZ Reports\DespatchReconcilation\' + 'Inactive Customer and Sales Prson Wise Detail with Outstanding' + '.xlsx';
        SMTPMail.Create('deepak.dhapke@sampoornafeeds.in', 'Detail of party who has not working with us and they have the Outstanding', '', true);
        SMTPMail.AppendToBody('Dear All' + ',' + '<BR><BR>');
        SMTPMail.AppendToBody('Please find attached excel file of that Detail of inactive party and Outstanding as on date, ' + '.<BR><BR>');

        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'ritu@sampoornafeeds.com');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'vasu@sampoornafeeds.com');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'RISHABH.GUPTA@sampoornafeeds.in');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'parveen.k@sampoornafeeds.com');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'riya@sampoornafeeds.com');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Bcc, 'Sumandev@sampoornafeeds.com');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Bcc, 'sanjay.tiwari@sampoornafeeds.in');
        SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'sale.coordinator3@sampoornafeeds.in');
        //RecRef.GetTable(PurcRcpLine);

        Clear(Outstr);
        Clear(Instr);
        RecRef.GetTable(SalesPerson);
        TempBlob.CreateOutStream(Outstr);
        //TempBlob.CreateOutStream(Outstr1);
        //Report.SaveAs(50138, '', ReportFormat::Excel, Outstr);
        Report.SaveAs(50087, '', ReportFormat::Excel, Outstr, RecRef);
        FileManagement.BLOBExportToServerFile(TempBlob, FileName);

        FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
        TempBlob.CreateInStream(Instr);
        //SMTPMail.AddAttachment('Pending MRN' + '.xlsx', 'xlsx', Instr);
        SMTPMail.AddAttachment('Inactive Customer and Sales Prson Wise Detail with Outstanding' + '.xlsx', 'xlsx', Instr);
        SMTPMail.AppendToBody('Regards' + ',' + '<BR>' + 'Sampoorna Feeds Pvt. Ltd.' + '<BR><BR>');
        SMTPMail.AppendToBody('This is system generated mail. Please do not reply.<BR><BR>');
        EmailR.Send(SMTPMail, Enum::"Email Scenario"::Default);
        Erase(FileName);
    end;



    procedure SendWhatsappMessage(WebMessageBody: Text; PhoneNo: Code[100])
    var
        StringBuilder: DotNet StringBuilder;
        StringWriter: DotNet StringWriter;
        JsonTextWriter: DotNet JsonTextWriter;
        JsonFormatting: DotNet Formatting;
        HttpWebRequestMgt: Codeunit 1297;
        MessageText: Text;
        StringReader: DotNet StringReader;
        JsonTextReader: DotNet JsonTextReader;
        JsonFile: File;
        OutStrm: OutStream;
        Json: DotNet String;
        ResponseInStream_L: InStream;
        HttpStatusCode_L: DotNet HttpStatusCode;
        ResponseHeaders_L: DotNet NameValueCollection;
        ResponseText: Text;
        HttpStatusCode: DotNet HttpStatusCode;
        ResponseHeader: DotNet NameValueCollection;
        JSONResponse: Text;
        errorCode: Text;
        JObject: DotNet JObject;
        JSONManagement: Codeunit 5459;
        JsonText: Text;
        JsonUpdatedText: Text;
        Len: Integer;
        Pos: Integer;
        SalesReceivablesSetup: Record 311;
        Customer: Record 18;
        ErrorMsg: Text;
        Vendor: Record 23;
        StatusError: Text;
        AccessTockenKey: Text;
        InStr: InStream;
        Result: Text;
        tokentype: Text;
        ErrorMessage: Text;
        WebURL: Text;
        WebClient: DotNet WebClient;
        SmsURL1: Text;
    begin
        //MESSAGE(PhoneNo);
        WebURL := 'http://web.cloudwhatsapp.com/wapp/api/send?apikey=7bf2c8462d67493e8a79cbd09cc7523e&mobile=' + PhoneNo + '&msg=' + WebMessageBody;
        //MESSAGE(WebURL);
        WebClient := WebClient.WebClient;
        SmsURL1 := WebClient.DownloadString(WebURL);
        //MESSAGE(SmsURL1);
    end;

    procedure WhatsupSmsOnGC(BranchName: Text; FarmName: Text; ChickPlacementDate: Date; ChickQty: Decimal; Mortality: Decimal; "Mortality%": Decimal; MeanAge: Decimal; AverageBodyWeight: Decimal; FCR: Decimal; CFCR: Decimal; EEF: Decimal; AvgSellingRate: Decimal) WebMessageBody: Text
    begin
        WebMessageBody := 'Branch Name  :  ' + BranchName + '%0A' +
              'Farm Name  :  ' + FarmName + '%0A' +
              'Chick Placement Date  :  ' + FORMAT(ChickPlacementDate) + '%0A' +
              'Chick Qty  :  ' + FORMAT(ChickQty) + '%0A' +
              'Mortality  :  ' + FORMAT(Mortality) + '%0A' +
              'Mortality% : ' + FORMAT("Mortality%") + '%0A' +
              'Mean Age  :  ' + FORMAT(MeanAge) + '%0A' +
              'Average Body Weight  :  ' + FORMAT(AverageBodyWeight) + '%0A' +
              'FCR  :  ' + FORMAT(FCR) + '%0A' +
              'CFCR  :  ' + FORMAT(CFCR) + '%0A' +
              'EEF  :  ' + FORMAT(EEF) + '%0A' +
              'Average Selling Rate : ' + Format(AvgSellingRate);
    end;

    procedure WhatsupSmsOnGCNewAPI(BranchName: Text; FarmName: Text; ChickPlacementDate: Date; ChickQty: Text; Mortality: Text; "Mortality%": Text; MeanAge: Text; AverageBodyWeight: Text; FCR: Text; CFCR: Text; EEF: Text; AvgSellingRate: Text; Week1Mortality: Text; Week2Mortality: Text; Week3Mortality: Text; Week4Mortality: Text; Week5Mortality: Text; MobileNo: Text; TemplateNo: Text) JSONPayload: Text
    var
        PayloadObj: JsonObject;
        MessageObj: JsonObject;
        VariablesArr: JsonArray;
        PayloadArr: JsonArray;
        ResultText: Text;
    begin
        // Root object
        PayloadObj.Add('templateId', TemplateNo);
        PayloadObj.Add('to', MobileNo);
        PayloadObj.Add('from', '9056969873');

        // Message object
        VariablesArr.Add(BranchName);
        VariablesArr.Add(FarmName);
        VariablesArr.Add(ChickPlacementDate);
        VariablesArr.Add(ChickQty);
        VariablesArr.Add(Mortality);
        VariablesArr.Add("Mortality%");
        VariablesArr.Add(MeanAge);
        VariablesArr.Add(AverageBodyWeight);
        VariablesArr.Add(FCR);
        VariablesArr.Add(CFCR);
        VariablesArr.Add(EEF);
        VariablesArr.Add(AvgSellingRate);
        VariablesArr.Add(Week1Mortality);
        VariablesArr.Add(Week2Mortality);
        VariablesArr.Add(Week3Mortality);
        VariablesArr.Add(Week4Mortality);
        VariablesArr.Add(Week5Mortality);
        PayloadArr.Add('5000');
        MessageObj.Add('variables', VariablesArr);
        MessageObj.Add('payload', PayloadArr);
        PayloadObj.Add('message', MessageObj);
        // Convert to text
        PayloadObj.WriteTo(ResultText);
        exit(ResultText);
    end;
    // Var
    //     JsonObjectRes: JsonObject;
    //     JsonObjectRes1: JsonObject;
    //     JsonObjectRes2: JsonObject;
    //     JsonObjectRes3: JsonObject;
    //     JsonObjectParameter: JsonObject;
    //     JsonObjectParameter2: JsonObject;
    //     JsonArrayItem: JsonArray;
    //     JsonArrayItem2: JsonArray;
    //     JsonArrayItem3: JsonArray;
    //     Payload: Text;
    // begin
    //     Clear(JsonObjectRes);
    //     Clear(JsonArrayItem);
    //     Clear(JsonObjectParameter);

    //     JsonObjectParameter.Add('type', 'text');
    //     JsonObjectParameter.Add('text', BranchName);
    //     JsonArrayItem.Add(JsonObjectParameter);
    //     Clear(JsonObjectParameter);
    //     JsonObjectParameter.Add('type', 'text');
    //     JsonObjectParameter.Add('text', FarmName);
    //     JsonArrayItem.Add(JsonObjectParameter);
    //     Clear(JsonObjectParameter);
    //     JsonObjectParameter.Add('type', 'text');
    //     JsonObjectParameter.Add('text', ChickPlacementDate);
    //     JsonArrayItem.Add(JsonObjectParameter);
    //     Clear(JsonObjectParameter);
    //     JsonObjectParameter.Add('type', 'text');
    //     JsonObjectParameter.Add('text', ChickQty);
    //     JsonArrayItem.Add(JsonObjectParameter);
    //     Clear(JsonObjectParameter);
    //     JsonObjectParameter.Add('type', 'text');
    //     JsonObjectParameter.Add('text', Mortality);
    //     JsonArrayItem.Add(JsonObjectParameter);
    //     Clear(JsonObjectParameter);
    //     JsonObjectParameter.Add('type', 'text');
    //     JsonObjectParameter.Add('text', "Mortality%");
    //     JsonArrayItem.Add(JsonObjectParameter);
    //     Clear(JsonObjectParameter);
    //     JsonObjectParameter.Add('type', 'text');
    //     JsonObjectParameter.Add('text', MeanAge);
    //     JsonArrayItem.Add(JsonObjectParameter);
    //     Clear(JsonObjectParameter);
    //     JsonObjectParameter.Add('type', 'text');
    //     JsonObjectParameter.Add('text', AverageBodyWeight);
    //     JsonArrayItem.Add(JsonObjectParameter);
    //     Clear(JsonObjectParameter);
    //     JsonObjectParameter.Add('type', 'text');
    //     JsonObjectParameter.Add('text', FCR);
    //     JsonArrayItem.Add(JsonObjectParameter);
    //     Clear(JsonObjectParameter);
    //     JsonObjectParameter.Add('type', 'text');
    //     JsonObjectParameter.Add('text', CFCR);
    //     JsonArrayItem.Add(JsonObjectParameter);
    //     Clear(JsonObjectParameter);
    //     JsonObjectParameter.Add('type', 'text');
    //     JsonObjectParameter.Add('text', EEF);
    //     JsonArrayItem.Add(JsonObjectParameter);
    //     Clear(JsonObjectParameter);
    //     JsonObjectParameter.Add('type', 'text');
    //     JsonObjectParameter.Add('text', AvgSellingRate);
    //     JsonArrayItem.Add(JsonObjectParameter);
    //     Clear(JsonObjectParameter);
    //     JsonObjectParameter.Add('type', 'text');
    //     JsonObjectParameter.Add('text', Week1Mortality);
    //     JsonArrayItem.Add(JsonObjectParameter);
    //     Clear(JsonObjectParameter);
    //     JsonObjectParameter.Add('type', 'text');
    //     JsonObjectParameter.Add('text', Week2Mortality);
    //     JsonArrayItem.Add(JsonObjectParameter);
    //     Clear(JsonObjectParameter);
    //     JsonObjectParameter.Add('type', 'text');
    //     JsonObjectParameter.Add('text', Week3Mortality);
    //     JsonArrayItem.Add(JsonObjectParameter);
    //     Clear(JsonObjectParameter);
    //     JsonObjectParameter.Add('type', 'text');
    //     JsonObjectParameter.Add('text', Week4Mortality);
    //     JsonArrayItem.Add(JsonObjectParameter);
    //     Clear(JsonObjectParameter);
    //     JsonObjectParameter.Add('type', 'text');
    //     JsonObjectParameter.Add('text', Week5Mortality);
    //     JsonArrayItem.Add(JsonObjectParameter);
    //     Clear(JsonObjectParameter);
    //     JsonObjectParameter2.Add('policy', 'deterministic');
    //     JsonObjectParameter2.Add('code', 'en');

    //     JsonObjectRes.Add('type', 'body');
    //     JsonObjectRes.Add('parameters', JsonArrayItem);
    //     JsonArrayItem2.Add(JsonObjectRes);

    //     //Clear(JsonArrayItem);
    //     JsonObjectRes3.Add('language', JsonObjectParameter2);
    //     JsonObjectRes3.Add('name', TemplateNo);
    //     JsonObjectRes3.Add('components', JsonArrayItem2);

    //     JsonObjectRes2.Add('to', MobileNo);
    //     JsonObjectRes2.Add('type', 'template');
    //     JsonObjectRes2.Add('template', JsonObjectRes3);
    //     JsonObjectRes2.WriteTo(Payload);
    //     //Message(Payload);
    //     exit(Payload);
    // end;


}