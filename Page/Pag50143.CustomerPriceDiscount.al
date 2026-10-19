page 50143 "CustomerPrice&Discount"
{
    ApplicationArea = All;
    Caption = 'Customer Price and Discount';
    PageType = List;
    SourceTable = Customer;
    UsageCategory = Lists;
    //Editable = true;
    DeleteAllowed = false;
    CardPageID = "Customer Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = all;
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        Cust: Record Customer;
                        TempEmailItem: Record "Email Item" temporary;
                        EmailScenario: Enum "Email Scenario";
                        EmailCu: Codeunit Email;
                        EmailMsg: Codeunit "Email Message";
                        TeamSalesperson: Record "Team Salesperson";
                        Team: Record Team;
                        EmailRecpt: Text;
                        RecRef: RecordRef;
                        SalesPrice: Record "Sales Price";
                        Outstr: OutStream;
                        Instr: InStream;
                        TempBlob: Codeunit "Temp Blob";
                        SubJextText: Text;
                    //Report50148: report 50148;
                    begin
                        Clear(EmailCu);
                        Clear(EmailMsg);
                        if Rec."Salesperson Code" <> '' then begin
                            TeamSalesperson.Reset();
                            TeamSalesperson.SetRange(TeamSalesperson."Salesperson Code", Rec."Salesperson Code");
                            if TeamSalesperson.FindFirst() then begin
                                Team.Reset();
                                Team.SetRange(Code, TeamSalesperson."Team Code");
                                Team.SetFilter(Team."E-Mail", '<>%1', '');
                                if Team.FindFirst() then
                                    EmailRecpt := Team."E-Mail";
                            end;
                        end;
                        EmailRecpt := EmailRecpt + ';' + 'sale.coordinator1@sampoornafeeds.in;sale@sampoornafeeds.com;pankaj.bhangalia@sampoornafeeds.in;shilpa.bhatia@sampoornafeeds.in';
                        EmailMsg.Create(EmailRecpt, Rec."No." + ' Changes in Customer Price Group', '');
                        SalesPrice.Reset();
                        SalesPrice.SetRange(SalesPrice."Sales Code", Rec."Customer Price Group");
                        if SalesPrice.FindFirst() then begin
                            RecRef.GetTable(SalesPrice);
                            TempBlob.CreateOutStream(Outstr);
                            Report.SaveAs(Report::"Sales Price_SFPL", '', ReportFormat::Pdf, Outstr, RecRef);
                            TempBlob.CreateInStream(Instr);
                            EmailMsg.AddAttachment('New ' + Rec."No." + ' ' + Rec."Customer Price Group" + '.pdf', 'PDF', Instr);
                        end;
                        SalesPrice.Reset();
                        SalesPrice.SetRange(SalesPrice."Sales Code", XRec."Customer Price Group");
                        if SalesPrice.FindFirst() then begin
                            RecRef.GetTable(SalesPrice);
                            TempBlob.CreateOutStream(Outstr);
                            Report.SaveAs(Report::"Sales Price_SFPL", '', ReportFormat::Pdf, Outstr, RecRef);
                            TempBlob.CreateInStream(Instr);
                            EmailMsg.AddAttachment('Old ' + Rec."No." + ' ' + XRec."Customer Price Group" + '.pdf', 'PDF', Instr);
                        end;
                        EmailMsg.AppendToBody('Dear All' + ',' + '<BR><BR>');
                        EmailMsg.AppendToBody('Customer Price group has been changed from ' + xRec."Customer Price Group" + ' To ' + Rec."Customer Price Group" + ' For Customer Code : ' + Rec."No." + '.<BR><BR>');
                        EmailMsg.AppendToBody('This modification performed by USER and Date  :' + UserId + ' ' + Format(Today) + '<BR><BR>');
                        EmailMsg.AppendToBody('Regards' + ',' + '<BR>' + 'Sampoorna Feeds Pvt. Ltd.' + '<BR><BR>');
                        EmailMsg.AppendToBody('This is system generated mail. Please do not reply.<BR><BR>');
                        EmailMsg.SetBodyHTMLFormatted(true);
                        EmailCu.OpenInEditor(EmailMsg, EmailScenario::Default);
                    end;
                }
                field("Customer Disc. Group"; rec."Customer Disc. Group")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {

            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::Customer),
                              "No." = field("No.");
                // Visible = NOT IsOfficeAddin;
            }

            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }
    trigger OnDeleteRecord(): Boolean
    var
    begin
        Error('You can not delete the record.');
    end;

}