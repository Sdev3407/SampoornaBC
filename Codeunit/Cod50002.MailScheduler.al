codeunit 50002 "Mail Scheduler"
{

    trigger OnRun()
    begin
        InsuranceAlertmail;
        //CU50005.CreateattachmentforDMR();

    end;

    local procedure InsuranceAlertmail()
    var
        T50016: Record 50016;
        Subject: Text;
        FA: Record 5600;
        Location: Record 14;
        Email: Codeunit Email;
        vendor: Record Vendor;

    begin
        T50016.RESET;
        T50016.SetFilter("Ins. Policy Alert Date", '<%1', TODAY);
        T50016.SetFilter("Ins. Policy Renewal Date", '>=%1', Today);
        T50016.SetRange(Sold, false);
        T50016.SetRange(Renewed, false);
        // T50016.SetFilter("Insurance No.", '%1', '106024/31/25/000318');
        //T50016.SetRange("Insurance No.", 'C2312792-E009');
        IF T50016.FINDSET THEN
            REPEAT
                Subject := 'Alert!! Renew of Insurance Policy No. ' + T50016."Insurance No.";  //PRU_RPG
                                                                                               //     SMTPMail.Create('Renew Insurance Policy', SMTPMailSetup."User ID", T50016."E-Mail ID", Subject, '', TRUE);  // PRU SH 250822
                SMTPMail.Create(T50016."E-Mail ID", Subject, '', true);
                SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'abhay@sampoornafeeds.in');
                SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'parveen.k@sampoornafeeds.com');
                //SMTPMail.AppendToBody('<br><br>');
                SMTPMail.AppendToBody('Dear Concern,' + '<br><br>');  //PRU_RPG
                                                                      //SMTPMail.AppendToBody(',');
                                                                      // SMTPMail.AppendToBody('<br><br>');
                IF T50016.Type = T50016.Type::"Fixed Asset" THEN BEGIN
                    FA.GET(T50016."No.");
                    SMTPMail.AppendToBody('Insurance of ' + FA."No." + ' - ' + FA.Description);//PRU-VG
                END ELSE //BEGIN
                    IF T50016.Type = T50016.Type::Location THEN BEGIN
                        Location.GET(T50016."No.");
                        SMTPMail.AppendToBody(Location.Code + ' - ' + Location.Name);
                    END ELSE
                        if T50016.Type = T50016.Type::" " then begin
                            SMTPMail.AppendToBody('The Policy');
                        end;
                ;
                SMTPMail.AppendToBody(' is going to expire on - ');//PRU-VG
                SMTPMail.AppendToBody(FORMAT(T50016."Ins. Policy Renewal Date") + ',' + '<br><br>');
                //SMTPMail.AppendToBody('<br><br>');

                SMTPMail.AppendToBody('Kindly renew your Insurance Policy No. ');
                SMTPMail.AppendToBody(T50016."Insurance No." + '<br><br>');
                //SMTPMail.AppendToBody('<br><br>');
                //SMTPMail.AppendToBody('<br><br>');
                // Suman/03-03-2024
                SMTPMail.AppendToBody('<table  border="1">');
                SMTPMail.AppendToBody('<tr>');
                SMTPMail.AppendToBody('<th>' + 'Policy No.' + '</th>');
                SMTPMail.AppendToBody('<th>' + 'Description' + '</th>');
                SMTPMail.AppendToBody('<th>' + 'Vendor' + '</th>');
                SMTPMail.AppendToBody('<th>' + 'Premium Amount' + '</th>');
                SMTPMail.AppendToBody('<th>' + 'Insured Amount' + '</th>');
                SMTPMail.AppendToBody('<th>' + 'Location' + '</th>');
                SMTPMail.AppendToBody('<th>' + 'Type' + '</th>');
                SMTPMail.AppendToBody('<th>' + 'Insurance Type' + '</th>');
                SMTPMail.AppendToBody('<th>' + 'No.' + '</th>');
                SMTPMail.AppendToBody('<th>' + 'Policy Expiry Date' + '</th>');

                SMTPMail.AppendToBody('</tr>');
                SMTPMail.AppendToBody('<tr>');
                SMTPMail.AppendToBody('<td align = center>' + Format(T50016."Insurance No.") + '</td>');
                SMTPMail.AppendToBody('<td align = center>' + Format(T50016.Description) + '</td>');
                If T50016."Vendor Code" <> '' Then
                    vendor.get(T50016."Vendor Code");
                SMTPMail.AppendToBody('<td align = center>' + Format(vendor.Name) + '</td>');
                SMTPMail.AppendToBody('<td align = center>' + Format(T50016."Premium Amount") + '</td>');
                SMTPMail.AppendToBody('<td align = center>' + Format(T50016."Insured Amount") + '</td>');
                If T50016."Location Code" <> '' Then
                    Location.Get(T50016."Location Code");
                SMTPMail.AppendToBody('<td align = center>' + Format(Location.Name) + '</td>');
                SMTPMail.AppendToBody('<td align = center>' + Format(T50016.Type) + '</td>');
                SMTPMail.AppendToBody('<td align = center>' + Format(T50016."Insurance Type") + '</td>');
                SMTPMail.AppendToBody('<td align = center>' + Format(T50016."No.") + '</td>');
                SMTPMail.AppendToBody('<td align = center>' + Format(T50016."Ins. Policy Renewal Date") + '</td>');
                SMTPMail.AppendToBody('</tr>');
                SMTPMail.AppendToBody('</table>');
                // Suman/03-03-2024
                SMTPMail.AppendToBody('<br><br>');
                SMTPMail.AppendToBody('This is a system generated mail., kindly do not reply on this email IDs, if you have any queries please contact dealing desk' + '<br><br>');
                //SMTPMail.AppendToBody('<br><br>');
                SMTPMail.AppendToBody('Thanks & Regards,' + '<br>');//PRU-VG

                //SMTPMail.AppendToBody('<br><br>');
                SMTPMail.AppendToBody('Team Sampoorna ');//PRU-VG
                //SIM -----Code Added---->>>>>>----------
                AddAtatchment(T50016);
                //SIM -----Code Added---->>>>>>----------
                Email.Send(SMTPMail, Enum::"Email Scenario"::Default);
                SLEEP(100);
            UNTIL T50016.NEXT = 0;
    end;
    //SIM -----Code Added---->>>>>>----------
    local procedure AddAtatchment(T50016: Record 50016): Boolean;
    var
        DocumentAttachment: Record "Document Attachment";
        TempBlobAtc: Array[10] of Codeunit "Temp Blob";
        i: Integer;
        outStreamReportAtc: Array[10] of OutStream;
        inStreamReportAtc: Array[10] of InStream;
        FullFileName: Text;
    begin
        // Clear(i);
        i := 1;
        //Get attachment from the document - streams
        DocumentAttachment.Reset();
        DocumentAttachment.setrange("Table ID", Database::"Insurance Expiration Alert");
        DocumentAttachment.setrange("No.", T50016."Insurance No.");
        if DocumentAttachment.FindSet() then begin
            repeat
                if DocumentAttachment."Document Reference ID".HasValue then begin
                    TempBlobAtc[i].CreateOutStream(outStreamReportAtc[i]);
                    TempBlobAtc[i].CreateInStream(inStreamReportAtc[i]);
                    FullFileName := DocumentAttachment."File Name" + '.' + DocumentAttachment."File Extension";
                    if DocumentAttachment."Document Reference ID".ExportStream(outStreamReportAtc[i]) then begin
                        //Mail Attachments
                        SMTPMail.AddAttachment(FullFileName, DocumentAttachment."File Extension", inStreamReportAtc[i]);
                        // SMTPMail.AddAttachmentStream(inStreamReportAtc[i], FullFileName);
                    end;
                    i += 1;
                end;
            until DocumentAttachment.NEXT = 0;
            exit(true)
        end;
        exit(false);
    end;
    //SIM -----Code Added---->>>>>>----------
    var
        SMTPMail: Codeunit "Email Message";
        Email: Codeunit Email;
        CU50005: Codeunit "Farm Location Expire";
}


