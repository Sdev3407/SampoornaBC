codeunit 50010 "Tax Invoice Automailer"
{

    trigger OnRun()
    Var
        RecCust: Record Customer;
    begin
        RecCust.Reset();
        RecCust.Setfilter("Responsibility Center", '%1', 'FEED');
        RecCust.CALCFIELDS("Net Change");
        RecCust.Setfilter("Net Change", '>=%1', 200000);
        //RecCust.SetFilter("E-Mail", '<>%1', '');
        RecCust.Setfilter("Customer Status", '%1|%2', RecCust."Customer Status"::Regular, RecCust."Customer Status"::SettledContinue);
        //RecCust.SetRange("No.", 'SFC02598');
        if RecCust.FindFirst() then
            repeat
                forInactivePartieswithdues45Days(RecCust."No.");
                forInActivePartieswithdues60Daysolder(RecCust."No.");
                forInActivePartieswithdues90Daysolder(RecCust."No.");
                if System.Date2DWY(WorkDate(), 1) = 1 then
                    CustomerReminderafter120Oldoutstanding(RecCust."No.")

            Until RecCust.Next() = 0;
    end;


    procedure forInactivePartieswithdues45Days("No.": Code[20])
    var
        Cust: Record Customer;
        SalesPerson: Record "Salesperson/Purchaser";
        TeamSales: Record "Team Salesperson";
        Teams: Record Team;
        OutstandingBalance: Decimal;
        NumberList: List of [Text];
        Number: Text;
    begin
        Company.Get;
        Cust.Get("No.");
        if Cust."Salesperson Code" <> '' then begin
            SalesPerson.Get(Cust."Salesperson Code");
            TeamSales.Reset();
            TeamSales.SetRange("Salesperson Code", SalesPerson.Code);
            if TeamSales.FindFirst() then
                Teams.Get(TeamSales."Team Code")
        end;
        Clear(Subject);
        CustLedgerEntry.Reset();
        CustLedgerEntry.SetRange("Customer No.", "No.");
        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
        if CustLedgerEntry.FindLast() then
            if (WorkDate() - (CustLedgerEntry."Posting Date")) = 45 then begin
                CLE2.Reset();
                CLE2.SetRange("Customer No.", "No.");
                CLE2.SetRange("Document Type", CLE2."Document Type"::Invoice);
                CLE2.SetFilter("Remaining Amount", '<>%1', 0);
                if CLE2.FindFirst() then begin
                    Subject := 'Your Business and Bill Due' + '(' + (Cust."No.") + '_' + Cust.Name + ')';  //PRU_RPG
                                                                                                           //     SMTPMail.Create('Renew Insurance Policy', SMTPMailSetup."User ID", T50016."E-Mail ID", Subject, '', TRUE);  // PRU SH 250822
                    SMTPMail.Create(Cust."E-Mail", Subject, '', true);
                    SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, SalesPerson."E-Mail");
                    SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, Teams."E-Mail");
                    SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'head.legal@sampoornafeeds.in');
                    SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'sanjay.tiwari@sampoornafeeds.in');

                    SMTPMail.AppendToBody('Dear Sir/Madam,' + '<br><br>');
                    SMTPMail.AppendToBody('We are thankful for your patronage with us, we appreciate your business with us.');//PRU-VG
                    SMTPMail.AppendToBody('<br><br>');
                    SMTPMail.AppendToBody('We value your business relationship and look forward to long term business.');
                    SMTPMail.AppendToBody('<br><br>');
                    SMTPMail.AppendToBody('We have noticed that there is an overdue amount which is pending in your account since last 45 days, details of which is as under:-');
                    SMTPMail.AppendToBody('<br><br>');
                    SMTPMail.AppendToBody('<table  border="1">');
                    SMTPMail.AppendToBody('<tr>');
                    SMTPMail.AppendToBody('<th>' + 'Our Bill No.' + '</th>');
                    SMTPMail.AppendToBody('<th>' + 'Date' + '</th>');
                    SMTPMail.AppendToBody('<th>' + 'Amount' + '</th>');
                    SMTPMail.AppendToBody('<th>' + 'Destination' + '</th>');
                    CLE.Reset();
                    CLE.SetRange("Customer No.", "No.");
                    CLE.SetFilter("Remaining Amount", '<>%1', 0);
                    CLE.SetRange("Document Type", CLE."Document Type"::Invoice);
                    if CLE.FindFirst() then
                        repeat
                            CLE.CalcFields("Remaining Amount");
                            OutstandingBalance += CLE."Remaining Amount";
                            SMTPMail.AppendToBody('</tr>');
                            SMTPMail.AppendToBody('<tr>');
                            SMTPMail.AppendToBody('<td align = center>' + Format(CLE."Document No.") + '</td>');
                            SMTPMail.AppendToBody('<td align = center>' + Format(CLE."Posting Date") + '</td>');
                            SMTPMail.AppendToBody('<td align = center>' + Format(CLE."Remaining Amount") + '</td>');
                            SMTPMail.AppendToBody('<td align = center>' + Format('') + '</td>');
                            SMTPMail.AppendToBody('</tr>');
                        Until CLE.Next() = 0;
                    SMTPMail.AppendToBody('</table>');
                    SMTPMail.AppendToBody('<br><br>');
                    SMTPMail.AppendToBody('We request you to please payment this amount on priority.');
                    SMTPMail.AppendToBody('<br><br>');
                    SMTPMail.AppendToBody('With warm regards,' + '<br>');//PRU-VG
                    if Cust."Responsibility Center" = 'FEED' Then Begin
                        SMTPMail.AppendToBody('Dr. Deepak Dhapke' + '<br>');
                        SMTPMail.AppendToBody('Vice President Sales' + '<br>');
                    End else begin
                        if Cust."Responsibility Center" = 'CATTLE' Then Begin
                            SMTPMail.AppendToBody('Sunil Kapoor' + '<br>');
                            SMTPMail.AppendToBody('DGM Sales' + '<br>');
                        end;
                    end;
                    SMTPMail.AppendToBody(Company.Name + '<br>');
                    SMTPMail.AppendToBody(Company.Address + ' ' + Company."Address 2" + ' ' + Company.City + '<br>');
                    SMTPMail.AppendToBody(Company."State Code" + ' ' + Company."Post Code" + '<br>');
                    SMTPMail.AppendToBody('Date' + ' ' + Format(WorkDate()));
                    Clear(SMSBody);
                    SMSBody := 'Dear Sir/Madam, We find that your account with us shows a debit balance of Rs. ' + Format(OutstandingBalance) + ' since ' + Format(WorkDate() - 45) + '. Kindly pay the dues immediately in the interest of mutual relationship. From: Sampoorna Feeds Pvt Ltd.';
                    //WhatsApp.SendSMS(Cust."Phone No.", SMSBody, '', Cust."No.", '1307175074447606494');
                    SMSDetail.APISMSMultipleNo(Cust."Phone No.", Cust."Mobile Phone No.", Cust."WhatsApp Mobile No.", Cust."Alternate Phone No. 1", Cust."Alternate Phone No. 2", Cust."Alternate Phone No. 3", '', SMSBody, '', Cust."No.", '1307175074447606494');// Airtel
                    NumberList := Cust."Phone No.".Split(',');
                    foreach Number in NumberList do begin
                        WhatsApp.AirtelWhatssAppAPI(WhatsApp.CustomerOutstandingReminder(Number, Format(OutstandingBalance), Format(WorkDate() - 45), '01khb7cc1tbs2fsprazansrznr'));
                    end;
                    Email.Send(SMTPMail, Enum::"Email Scenario"::Default);
                    SLEEP(100);
                end;
            end

    end;

    procedure forInActivePartieswithdues60Daysolder("No.": COde[20])
    var
        Cust: Record Customer;
        SalesPerson: Record "Salesperson/Purchaser";
        TeamSales: Record "Team Salesperson";
        Teams: Record Team;
        OutstandingBalance: Decimal;
        NumberList: List of [Text];
        Number: Text;
    begin
        Company.Get;
        Cust.Get("No.");
        if Cust."Salesperson Code" <> '' then begin
            SalesPerson.Get(Cust."Salesperson Code");
            TeamSales.Reset();
            TeamSales.SetRange("Salesperson Code", SalesPerson.Code);
            if TeamSales.FindFirst() then
                Teams.Get(TeamSales."Team Code");
        end;
        Clear(Subject);
        Company.Get;
        Clear(Subject);
        CustLedgerEntry.Reset();
        CustLedgerEntry.SetRange("Customer No.", "No.");
        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
        if CustLedgerEntry.FindLast() then
            if (WorkDate() - (CustLedgerEntry."Posting Date")) = 60 then begin
                CLE2.Reset();
                CLE2.SetRange("Customer No.", "No.");
                //CLE2.SetRange("Posting Date", WorkDate() - 60);
                CLE2.SetRange("Document Type", CLE2."Document Type"::Invoice);
                CLE2.SetFilter("Remaining Amount", '<>%1', 0);
                if CLE2.FindFirst() then begin


                    Subject := 'Your Business and Bill Due' + '(' + (Cust."No.") + '_' + Cust.Name + ')';  //PRU_RPG
                                                                                                           //     SMTPMail.Create('Renew Insurance Policy', SMTPMailSetup."User ID", T50016."E-Mail ID", Subject, '', TRUE);  // PRU SH 250822
                    SMTPMail.Create(Cust."E-Mail", Subject, '', true);
                    SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, SalesPerson."E-Mail");
                    SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, Teams."E-Mail");
                    SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'head.legal@sampoornafeeds.in');
                    SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'sanjay.tiwari@sampoornafeeds.in');


                    SMTPMail.AppendToBody('Dear Sir/Madam,' + '<br><br>');
                    SMTPMail.AppendToBody('We are thankful for your patronage with us, we appreciate your business with us.');//PRU-VG
                    SMTPMail.AppendToBody('<br><br>');
                    SMTPMail.AppendToBody('We value your business relationship and look forward to long term business.');
                    SMTPMail.AppendToBody('<br><br>');
                    SMTPMail.AppendToBody('This is a reminder message to our earlier message with regard to outstanding amount which is now pending since last 60 days, details of which is as under :-');
                    SMTPMail.AppendToBody('<br><br>');
                    SMTPMail.AppendToBody('<table  border="1">');
                    SMTPMail.AppendToBody('<tr>');
                    SMTPMail.AppendToBody('<th>' + 'Our Invoice No.' + '</th>');
                    SMTPMail.AppendToBody('<th>' + 'Date' + '</th>');
                    SMTPMail.AppendToBody('<th>' + 'Amount' + '</th>');
                    SMTPMail.AppendToBody('<th>' + 'Destination' + '</th>');
                    OutstandingBalance := 0;
                    CLE.Reset();
                    CLE.SetRange("Customer No.", "No.");
                    CLE.SetFilter("Remaining Amount", '<>%1', 0);
                    CLE.SetRange("Document Type", CLE."Document Type"::Invoice);
                    //CLE.SetRange("Posting Date", WorkDate() - 60);
                    if CLE.FindSet() then
                        repeat
                            CLE.CalcFields("Remaining Amount");
                            OutstandingBalance += CLE."Remaining Amount";
                            SMTPMail.AppendToBody('</tr>');
                            SMTPMail.AppendToBody('<tr>');
                            SMTPMail.AppendToBody('<td align = center>' + Format(CLE."Document No.") + '</td>');
                            SMTPMail.AppendToBody('<td align = center>' + Format(CLE."Posting Date") + '</td>');
                            SMTPMail.AppendToBody('<td align = center>' + Format(CLE."Remaining Amount") + '</td>');
                            SMTPMail.AppendToBody('<td align = center>' + Format('') + '</td>');
                            SMTPMail.AppendToBody('</tr>');
                        Until CLE.Next() = 0;
                    SMTPMail.AppendToBody('</table>');
                    SMTPMail.AppendToBody('<br><br>');
                    SMTPMail.AppendToBody('We once again request you to please look into it and payment this amount on urgent to avoid any unpleasant action from our side.');
                    SMTPMail.AppendToBody('<br><br>');
                    SMTPMail.AppendToBody('Thanking you for the same in advance.');
                    SMTPMail.AppendToBody('<br><br>');
                    SMTPMail.AppendToBody('With warm regards,' + '<br>');//PRU-VG
                    if Cust."Responsibility Center" = 'FEED' Then Begin
                        SMTPMail.AppendToBody('Dr. Deepak Dhapke' + '<br>');
                        SMTPMail.AppendToBody('Vice President Sales' + '<br>');
                    End else begin
                        if Cust."Responsibility Center" = 'CATTLE' Then Begin
                            SMTPMail.AppendToBody('Sunil Kapoor' + '<br>');
                            SMTPMail.AppendToBody('DGM Sales' + '<br>');
                        end;
                    end;
                    SMTPMail.AppendToBody(Company.Name + '<br>');
                    SMTPMail.AppendToBody(Company.Address + ' ' + Company."Address 2" + ' ' + Company.City + '<br>');
                    SMTPMail.AppendToBody(Company."State Code" + ' ' + Company."Post Code" + '<br>');
                    SMTPMail.AppendToBody('Date' + ' ' + Format(WorkDate()));
                    //SMTPMail.AppendToBody(Format(WorkDate()) + '<br>');
                    Clear(SMSBody);
                    SMSBody := 'Dear Sir/Madam, We find that your account with us shows a debit balance of Rs. ' + Format(OutstandingBalance) + ' since ' + Format(WorkDate() - 60) + '. Kindly pay the dues immediately in the interest of mutual relationship. From: Sampoorna Feeds Pvt Ltd.';
                    // WhatsApp.SendSMS(Cust."Phone No.", SMSBody, '', Cust."No.", '1307175074447606494');
                    SMSDetail.APISMSMultipleNo(Cust."Phone No.", Cust."Mobile Phone No.", Cust."WhatsApp Mobile No.", Cust."Alternate Phone No. 1", Cust."Alternate Phone No. 2", Cust."Alternate Phone No. 3", '', SMSBody, '', Cust."No.", '1307175074447606494');// Airtel
                    NumberList := Cust."Phone No.".Split(',');
                    foreach Number in NumberList do begin
                        WhatsApp.AirtelWhatssAppAPI(WhatsApp.CustomerOutstandingReminder(Number, Format(OutstandingBalance), Format(WorkDate() - 60), '01khb7cc1tbs2fsprazansrznr'));
                    End;
                    Email.Send(SMTPMail, Enum::"Email Scenario"::Default);
                    SLEEP(100);
                end;
            end;
    end;

    procedure forInActivePartieswithdues90Daysolder("No.": COde[20])
    var
        Cust: Record Customer;
        SalesPerson: Record "Salesperson/Purchaser";
        TeamSales: Record "Team Salesperson";
        Teams: Record Team;
        OutstandingBalance: Decimal;
        NumberList: List of [Text];
        Number: Text;
    begin
        Company.Get;
        Cust.Get("No.");
        if Cust."Salesperson Code" <> '' then begin
            SalesPerson.Get(Cust."Salesperson Code");
            TeamSales.Reset();
            TeamSales.SetRange("Salesperson Code", SalesPerson.Code);
            if TeamSales.FindFirst() then
                Teams.Get(TeamSales."Team Code");
        end;
        Clear(Subject);
        Company.Get;
        Clear(Subject);
        CustLedgerEntry.Reset();
        CustLedgerEntry.SetRange("Customer No.", "No.");
        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
        if CustLedgerEntry.FindLast() then
            if (WorkDate() - (CustLedgerEntry."Posting Date")) = 90 then begin
                CLE2.Reset();
                CLE2.SetRange("Customer No.", "No.");
                //CLE2.SetRange("Posting Date", WorkDate() - 60);
                CLE2.SetRange("Document Type", CLE2."Document Type"::Invoice);
                CLE2.SetFilter("Remaining Amount", '<>%1', 0);
                if CLE2.FindFirst() then begin
                    Subject := 'Your Business and Bill Due' + '(' + (Cust."No.") + '_' + Cust.Name + ')';  //PRU_RPG
                                                                                                           //     SMTPMail.Create('Renew Insurance Policy', SMTPMailSetup."User ID", T50016."E-Mail ID", Subject, '', TRUE);  // PRU SH 250822
                    SMTPMail.Create(Cust."E-Mail", Subject, '', true);
                    SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'deepak.dhapke@sampoornafeeds.in');
                    SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'sale.coordinator2@sampoornafeeds.in');
                    SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'legal@sampoornafeeds.in');
                    SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'head.legal@sampoornafeeds.in');
                    SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, 'sanjay.tiwari@sampoornafeeds.in');

                    SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, SalesPerson."E-Mail");
                    SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, Teams."E-Mail");

                    SMTPMail.AppendToBody('Dear Sir/Madam,' + '<br><br>');
                    SMTPMail.AppendToBody('We are thankful for your patronage with us, we appreciate your business with us.');//PRU-VG
                    SMTPMail.AppendToBody('<br><br>');
                    SMTPMail.AppendToBody('We value your business relationship and look forward to long term business.');
                    SMTPMail.AppendToBody('<br><br>');
                    SMTPMail.AppendToBody('We have sent you repeated reminders for payment of overdue amount which is pending since last 90 days but Inspite of our repeated requests you are failed to clear your account, please note that till now details of outstanding amount in your account is as under :- ');
                    SMTPMail.AppendToBody('<br><br>');
                    SMTPMail.AppendToBody('<table  border="1">');
                    SMTPMail.AppendToBody('<tr>');
                    SMTPMail.AppendToBody('<th>' + 'Our Invoice No.' + '</th>');
                    SMTPMail.AppendToBody('<th>' + 'Date' + '</th>');
                    SMTPMail.AppendToBody('<th>' + 'Amount' + '</th>');
                    SMTPMail.AppendToBody('<th>' + 'Destination' + '</th>');
                    OutstandingBalance := 0;
                    CLE.Reset();
                    CLE.SetRange("Customer No.", "No.");
                    CLE.SetFilter("Remaining Amount", '<>%1', 0);
                    CLE.SetRange("Document Type", CLE."Document Type"::Invoice);
                    //CLE.SetRange("Posting Date", WorkDate() - 60);
                    if CLE.FindSet() then
                        repeat
                            CLE.CalcFields("Remaining Amount");
                            OutstandingBalance += CLE."Remaining Amount";

                            SMTPMail.AppendToBody('</tr>');
                            SMTPMail.AppendToBody('<tr>');
                            SMTPMail.AppendToBody('<td align = center>' + Format(CLE."Document No.") + '</td>');
                            SMTPMail.AppendToBody('<td align = center>' + Format(CLE."Posting Date") + '</td>');
                            SMTPMail.AppendToBody('<td align = center>' + Format(CLE."Remaining Amount") + '</td>');
                            SMTPMail.AppendToBody('<td align = center>' + Format('') + '</td>');
                            SMTPMail.AppendToBody('</tr>');
                        Until CLE.Next() = 0;
                    SMTPMail.AppendToBody('</table>');
                    SMTPMail.AppendToBody('<br><br>');
                    SMTPMail.AppendToBody('This is final reminder to you for payment of outstanding amount, in case we will not receive any response from your side till ');
                    SMTPMail.AppendToBody(Format(CalcDate('+15D', WorkDate())));
                    SMTPMail.AppendToBody(', we will be forced to take legal action against you and your firm/company.');
                    SMTPMail.AppendToBody('<br><br>');
                    SMTPMail.AppendToBody('Request you to please clear this amount on priority.');
                    SMTPMail.AppendToBody('<br><br>');
                    SMTPMail.AppendToBody('With warm regards,' + '<br>');//PRU-VG
                    if Cust."Responsibility Center" = 'FEED' Then Begin
                        SMTPMail.AppendToBody('Dr. Deepak Dhapke' + '<br>');
                        SMTPMail.AppendToBody('Vice President Sales' + '<br>');
                    End else begin
                        if Cust."Responsibility Center" = 'CATTLE' Then Begin
                            SMTPMail.AppendToBody('Sunil Kapoor' + '<br>');
                            SMTPMail.AppendToBody('DGM Sales' + '<br>');
                        end;
                    end;
                    SMTPMail.AppendToBody(Company.Name + '<br>');
                    SMTPMail.AppendToBody(Company.Address + ' ' + Company."Address 2" + ' ' + Company.City + '<br>');
                    SMTPMail.AppendToBody(Company."State Code" + ' ' + Company."Post Code" + '<br>');
                    SMTPMail.AppendToBody('Date' + ' ' + Format(WorkDate()));
                    //SMTPMail.AppendToBody(Format(WorkDate()) + '<br>');
                    Clear(SMSBody);
                    SMSBody := 'Dear Sir/Madam, We find that your account with us shows a debit balance of Rs. ' + Format(OutstandingBalance) + ' since ' + Format(WorkDate() - 90) + '. Kindly pay the dues immediately in the interest of mutual relationship. From: Sampoorna Feeds Pvt Ltd.';
                    //WhatsApp.SendSMS(Cust."Phone No.", SMSBody, '', Cust."No.", '1307175074447606494');
                    SMSDetail.APISMSMultipleNo(Cust."Phone No.", Cust."Mobile Phone No.", Cust."WhatsApp Mobile No.", Cust."Alternate Phone No. 1", Cust."Alternate Phone No. 2", Cust."Alternate Phone No. 3", '', SMSBody, '', Cust."No.", '1307175074447606494');// Airtel
                    NumberList := Cust."Phone No.".Split(',');
                    foreach Number in NumberList do begin
                        WhatsApp.AirtelWhatssAppAPI(WhatsApp.CustomerOutstandingReminder(Number, Format(OutstandingBalance), Format(WorkDate() - 90), '01khb7cc1tbs2fsprazansrznr'));
                    End;
                    Email.Send(SMTPMail, Enum::"Email Scenario"::Default);
                    SLEEP(100);
                end;
            end;
    end;

    procedure CustomerReminderafter120Oldoutstanding("No.": COde[20])
    var
        Cust: Record Customer;
        SalesPerson: Record "Salesperson/Purchaser";
        TeamSales: Record "Team Salesperson";
        Teams: Record Team;
        OutstandingBalance: Decimal;
        NumberList: List of [Text];
        Number: Text;
    begin
        Company.Get;
        Cust.Get("No.");
        if Cust."Salesperson Code" <> '' then begin
            SalesPerson.Get(Cust."Salesperson Code");
            TeamSales.Reset();
            TeamSales.SetRange("Salesperson Code", SalesPerson.Code);
            if TeamSales.FindFirst() then
                Teams.Get(TeamSales."Team Code");
        end;
        Clear(Subject);
        Company.Get;
        Clear(Subject);
        CustLedgerEntry.Reset();
        CustLedgerEntry.SetRange("Customer No.", "No.");
        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
        if CustLedgerEntry.FindLast() then
            if (WorkDate() - (CustLedgerEntry."Posting Date")) >= 120 then begin
                OutstandingBalance := 0;
                CLE2.Reset();
                CLE2.CalcFields("Remaining Amount");
                CLE2.SetRange("Customer No.", "No.");
                //CLE2.SetRange("Posting Date", WorkDate() - 60);
                CLE2.SetRange("Document Type", CLE2."Document Type"::Invoice);
                CLE2.CalcFields("Remaining Amount");
                CLE2.SetFilter("Remaining Amount", '<>%1', 0);
                if CLE2.Findfirst() then begin
                    CLE.Reset();
                    CLE.SetRange("Customer No.", "No.");
                    CLE.CalcFields("Remaining Amount");
                    CLE.SetFilter("Remaining Amount", '<>%1', 0);
                    CLE.SetRange("Document Type", CLE."Document Type"::Invoice);
                    //CLE.SetRange("Posting Date", WorkDate() - 60);
                    if CLE.FindSet() then
                        repeat
                            CLE.CalcFields("Remaining Amount");
                            OutstandingBalance += CLE."Remaining Amount";
                        Until CLE.Next = 0;
                    Clear(SMSBody);
                    SMSBody := 'Dear Sir/Madam, We find that your account with us shows a debit balance of Rs. ' + Format(OutstandingBalance) + ' since ' + Format(WorkDate() - 90) + '. Kindly pay the dues immediately in the interest of mutual relationship. From: Sampoorna Feeds Pvt Ltd.';
                    //WhatsApp.SendSMS(Cust."Phone No.", SMSBody, '', Cust."No.", '1307175074447606494');
                    SMSDetail.APISMSMultipleNo(Cust."Phone No.", Cust."Mobile Phone No.", Cust."WhatsApp Mobile No.", Cust."Alternate Phone No. 1", Cust."Alternate Phone No. 2", Cust."Alternate Phone No. 3", '', SMSBody, '', Cust."No.", '1307175074447606494');// Airtel

                    NumberList := Cust."Phone No.".Split(',');
                    foreach Number in NumberList do begin
                        WhatsApp.AirtelWhatssAppAPI(WhatsApp.CustomerOutstandingReminder(Number, Format(OutstandingBalance), Format(WorkDate() - 90), '01khb7cc1tbs2fsprazansrznr'));
                    END;
                end;
            end;
    end;


    procedure CustomerFreze()
    var
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
        Customer: record Customer;
        CLE: Record "Cust. Ledger Entry";
        CLE2: Record "Cust. Ledger Entry";
        Email: Codeunit Email;
        SMTPMail: Codeunit "Email Message";
        Subject: Text;
        Company: Record "Company Information";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        WhatsApp: Codeunit "WhatsApp Function";
        SMSBody: Text;
        SMSDetail: Codeunit "SMS Details";

}

