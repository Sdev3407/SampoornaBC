report 50070 "Transfer Report"
{
    ProcessingOnly = true;
    Caption = 'Transfer Report';
    UsageCategory = Administration;
    ApplicationArea = all;
    dataset
    {
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            DataItemTableView = SORTING("Posting Date")
                                ORDER(Ascending);
            RequestFilterFields = "Posting Date", "No.";
            dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");

                trigger OnAfterGetRecord()
                begin
                    Location.RESET;
                    IF Location.GET("Transfer Shipment Line"."Location State code") THEN;

                    Clear(ILE_Amount);
                    ILE.RESET;
                    ILE.SETRANGE("Document No.", "Document No.");
                    ILE.SETRANGE("Document Line No.", "Transfer Shipment Line"."Line No.");
                    ILE.SETRANGE("Item No.", "Item No.");
                    ILE.SETRANGE(ILE."Location Code", "Transfer Shipment Line"."Transfer-from Code");
                    IF ILE.FINDSET THEN
                        REPEAT
                            ILE.CALCFIELDS("Cost Amount (Actual)");
                            ILE_Amount += ILE."Cost Amount (Actual)";

                        UNTIL ILE.NEXT = 0;

                    //MESSAGE('%1|%2',ILE."Document No.",ILE_Amount);
                    CreateBody;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(ReceiptNo);
                //CLEAR(BranchCode);
                //CLEAR(LobCode);
                TransferReceiptHeader.RESET;
                TransferReceiptHeader.SETRANGE("Transfer Order No.", "Transfer Shipment Header"."Transfer Order No.");
                IF TransferReceiptHeader.FINDFIRST THEN
                    ReceiptNo := TransferReceiptHeader."No.";
                //BranchCode := TransferReceiptHeader."Shortcut Dimension 2 Code";
                //LobCode := TransferReceiptHeader."Shortcut Dimension 1 Code";
                /*IF ReceiptNo = '' THEN
                  BranchCode := ''*/

                Location1.RESET;
                Location1.SETRANGE(Code, "Transfer Shipment Header"."Transfer-to Code");
                IF Location1.FINDFIRST THEN
                    BranchCode := Location1."Global Dimension 2 Code";
                LobCode := Location1."Global Dimension 1 Code";

                //MESSAGE('%1|%2',BranchCode,LobCode);

            end;

            trigger OnPreDataItem()
            begin
                CreateHeader;
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

    trigger OnPostReport()
    begin
        ExcelBuffer.CreateNewBook('Transfer Report');
        ExcelBuffer.WriteSheet('Transfer Report', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename(StrSubstNo('Transfer Report', CurrentDateTime, UserId));
        ExcelBuffer.OpenExcel();
        // ExcelBuffer.CreateBookAndOpenExcel('', 'Transfer Report', ' ', COMPANYNAME, USERID);
    end;

    var
        ILECOst: Decimal;
        Itemledger: Record "Item Ledger Entry";
        MATRIX_CaptionSet: array[100] of Code[20];
        ExcelBuffer: Record 370 temporary;
        Stdate: Date;
        EnDate: Date;
        Srno: Integer;
        DuplicateBranch: Code[20];
        Location: Record 14;
        CompanyInformation: Record 79;
        I: Integer;
        ReportName: array[10] of Text;
        OrderDate: Date;
        TransferReceiptHeader: Record 5746;
        ReceiptNo: Code[20];
        BranchCode: Code[20];
        LobCode: Code[20];
        Location1: Record 14;
        ILE_Amount: Decimal;
        ILE: Record 32;

    local procedure CreateHeader()
    begin
        SetMatrixCaption;
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Posting Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Shipment No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Receipt No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Transfer Order No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Transfer From Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Transfer From Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Transfer To Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Transfer To Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('LR No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('LR Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('From Branch', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('To Branch', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Item Type', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Item Catagory', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Item No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Quantity', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Description', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('From Lob', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('To Lob', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Amount as per Line', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Amount as per ILE', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
    end;

    local procedure CreateBody()
    begin
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn("Transfer Shipment Header"."Posting Date", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn("Transfer Shipment Header"."No.", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(ReceiptNo, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Transfer Shipment Header"."Transfer Order No.", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Transfer Shipment Header"."Transfer-from Code", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Transfer Shipment Header"."Transfer-from Name", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Transfer Shipment Header"."Transfer-to Code", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Transfer Shipment Header"."Transfer-to Name", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Transfer Shipment Header"."LR/RR No.", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Transfer Shipment Header"."LR/RR Date", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn("Transfer Shipment Header"."Shortcut Dimension 2 Code", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(BranchCode, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Transfer Shipment Line"."Item Type", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Transfer Shipment Line"."Item Category Code", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Transfer Shipment Line"."Item No.", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Transfer Shipment Line".Quantity, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn("Transfer Shipment Line".Description, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Transfer Shipment Header"."Shortcut Dimension 1 Code", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LobCode, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn("Transfer Shipment Line".Amount, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(ILE_Amount, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        //FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number);
    end;

    local procedure SetMatrixCaption()
    begin
        ReportName[1] := 'Report Name  :';
        ReportName[2] := 'Transfer Report';
        FOR I := 1 TO 5 DO BEGIN
            IF I = 2 THEN BEGIN
                ReportName[1] := 'Report Fillters :';
                ReportName[2] := "Transfer Shipment Header".GETFILTERS;
            END ELSE
                IF I = 3 THEN BEGIN
                    ReportName[1] := 'WorkDate  :';
                    ReportName[2] := FORMAT(TODAY);
                END ELSE
                    IF I = 4 THEN BEGIN
                        ReportName[1] := 'USER  :';
                        ReportName[2] := USERID;
                    END;

            IF I <> 5 THEN BEGIN
                ExcelBuffer.NewRow;
                ExcelBuffer.AddColumn(ReportName[1], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(ReportName[2], FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);


            END ELSE BEGIN
                ExcelBuffer.NewRow;
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);


                ReportName[1] := '';
                ReportName[2] := '';
            END;
        END;
    end;


    procedure GetDateFillter(Sdate: Date; Edate: Date)
    begin
    end;
}

