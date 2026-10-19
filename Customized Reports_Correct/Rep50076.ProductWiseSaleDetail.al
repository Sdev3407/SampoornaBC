report 50076 "Product_Wise Sale Detail"
{
    ProcessingOnly = true;
    Caption = 'Product_Wise Sale Detail';
    UsageCategory = Administration;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Invoice Line"; "Sales Invoice Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.")
                                ORDER(Ascending)
                                WHERE(Type = FILTER(<> ' '),
                                      Quantity = FILTER(<> 0),
                                      "No." = FILTER(<> 135100));

            trigger OnAfterGetRecord()
            begin
                ExcelBuffer.NewRow;

                TeamType := '';
                TeamName := '';
                SalesPerson := '';
                //SalesInvoiceH.Get("Sales Invoice Line"."Document No.");
                Customer.RESET;
                IF Customer.GET("Sales Invoice Line"."Sell-to Customer No.") THEN;
                TeamSalesperson.RESET;
                TeamSalesperson.SETRANGE(TeamSalesperson."Salesperson Code", Customer."Salesperson Code");
                IF TeamSalesperson.FINDFIRST THEN BEGIN
                    TeamSalesperson.CALCFIELDS("Salesperson Name");
                    SalesPerson := TeamSalesperson."Salesperson Name";
                    Team.RESET;
                    Team.SETRANGE(Code, TeamSalesperson."Team Code");
                    IF Team.FINDFIRST THEN BEGIN
                        //TeamSalesperson.CALCFIELDS("Salesperson Name");
                        TeamType := FORMAT(Team."Team Type");
                        TeamName := Team.Name;
                    END;
                END;



                ExcelBuffer.AddColumn(TeamType, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TeamName, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                // ExcelBuffer.AddColumn("Sales Invoice Line"."Product Group Code", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);  //PRU SH 01082022
                ExcelBuffer.AddColumn(SalesPerson, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Invoice', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn("Sales Invoice Line"."Posting Date", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(Customer."No.", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(Customer.Name, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn("Sales Invoice Line"."No.", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn("Sales Invoice Line".Description, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn("Sales Invoice Line"."Unit of Measure", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn("Sales Invoice Line"."Location Code", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                IF "Sales Invoice Line".Type = "Sales Invoice Line".Type::"Charge (Item)" THEN BEGIN
                    ExcelBuffer.AddColumn(0, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(0, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                END ELSE BEGIN
                    ExcelBuffer.AddColumn("Sales Invoice Line".Quantity, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(("Sales Invoice Line"."Quantity (Base)" / 1000), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                END;
                ExcelBuffer.AddColumn("Sales Invoice Line"."Amount", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
            end;

            trigger OnPreDataItem()
            begin
                "Sales Invoice Line".SETRANGE("Posting Date", StartingDate, EndingDate);
            end;
        }
        dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.")
                                ORDER(Ascending)
                                WHERE(Type = FILTER(<> ' '),
                                      Quantity = FILTER(<> 0),
                                      "No." = FILTER(<> 135100));

            trigger OnAfterGetRecord()
            begin
                ExcelBuffer.NewRow;
                TeamType := '';
                TeamName := '';
                SalesPerson := '';
                SalesCreditH.Get("Sales Cr.Memo Line"."Document No.");
                Customer.RESET;
                IF Customer.GET("Sales Cr.Memo Line"."Sell-to Customer No.") THEN;
                TeamSalesperson.RESET;
                TeamSalesperson.SETRANGE(TeamSalesperson."Salesperson Code", Customer."Salesperson Code");
                IF TeamSalesperson.FINDFIRST THEN BEGIN
                    TeamSalesperson.CALCFIELDS("Salesperson Name");
                    SalesPerson := TeamSalesperson."Salesperson Name";
                    Team.RESET;
                    Team.SETRANGE(Code, TeamSalesperson."Team Code");
                    IF Team.FINDFIRST THEN BEGIN
                        //TeamSalesperson.CALCFIELDS("Salesperson Name");
                        TeamType := FORMAT(Team."Team Type");
                        TeamName := Team.Name;
                    END;
                END;
                ExcelBuffer.AddColumn(TeamType, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TeamName, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                //  ExcelBuffer.AddColumn("Sales Cr.Memo Line"."Product Group Code", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);  //PRU SH 01082022
                ExcelBuffer.AddColumn(SalesPerson, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Credit Memo', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn("Sales Cr.Memo Line"."Posting Date", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
                ExcelBuffer.AddColumn(Customer."No.", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(Customer.Name, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn("Sales Cr.Memo Line"."No.", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn("Sales Cr.Memo Line".Description, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn("Sales Cr.Memo Line"."Unit of Measure", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn("Sales Cr.Memo Line"."Location Code", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                IF "Sales Cr.Memo Line".Type = "Sales Cr.Memo Line".Type::"Charge (Item)" THEN BEGIN
                    ExcelBuffer.AddColumn(0, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(0, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                END ELSE BEGIN
                    ExcelBuffer.AddColumn(-("Sales Cr.Memo Line".Quantity), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(-(("Sales Cr.Memo Line"."Quantity (Base)" / 1000)), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                END;
                ExcelBuffer.AddColumn(-("Sales Cr.Memo Line"."Amount"), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
            end;

            trigger OnPreDataItem()
            begin
                "Sales Cr.Memo Line".SETRANGE("Posting Date", StartingDate, EndingDate);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field("Start Date"; StartingDate)
                {
                    ApplicationArea = All;
                }
                field("End Date"; EndingDate)
                {
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        ExcelBuffer.CreateNewBook('Product Wise Data');
        ExcelBuffer.WriteSheet('Product Wise Data', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(StrSubstNo('Product Wise Data', CurrentDateTime, UserId));
        ExcelBuffer.OpenExcel();
        //ExcelBuffer.CreateNewBookAndOpenExcel('', 'Product Wise Data', ' ', COMPANYNAME, USERID);
    end;

    trigger OnPreReport()
    begin
        CreateExcelHeader;
    end;

    var
        ExcelBuffer: Record 370 temporary;
        Date: Record 2000000007;
        StartingDate: Date;
        EndingDate: Date;
        NoOfmonth: Integer;
        Customer: Record 18;
        TeamSalesperson: Record 5084;
        Item: Record 27;
        Team: Record 5083;
        TeamType: Text;
        TeamName: Text;
        SalesPerson: Text;
        SalesInvoiceH: Record "Sales Invoice Header";
        SalesCreditH: Record "Sales Cr.Memo Header";

    local procedure CreateExcelHeader()
    var
        DateCalendar: Record 2000000007;
    begin
        ExcelBuffer.AddColumn('Team Type', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Team Code', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        //        ExcelBuffer.AddColumn('Product Group Code', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Invoice Sales Person Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Document Type', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Posting Date', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Customer Code', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Customer Name', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Item No.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Discription.', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Unit of Measure Code', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Location Code', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Qty In BAG', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Qty In MT', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Amount', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
    end;
}

