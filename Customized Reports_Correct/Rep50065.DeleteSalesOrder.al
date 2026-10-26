report 50065 "Delete Sales Order"
{
    UsageCategory = Administration;
    Caption = '/Delete Sales Order Report';
    ApplicationArea = All;
    //DefaultLayout = RDLC;
    ProcessingOnly = true;
    //RDLCLayout = '.\DeleteSalesOrderNew.rdl';
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = WHERE(Status = CONST(Open));
            //"Shortcut Dimension 1 Code" = FILTER('<>CATTLE'));

            trigger OnAfterGetRecord()
            begin
                Firstdate := CalcDate('-CM', WorkDate());
                if WorkDate() = CalcDate('-CM', WorkDate()) then begin
                    DeleteSH.RESET;
                    DeleteSH.SETRANGE("Document Type", DeleteSH."Document Type"::Order);
                    //DeleteSH.SETFILTER(DeleteSH."No.",'%1','F-SO/2122/20783');
                    DeleteSH.SETRANGE(DeleteSH."No.", "Sales Header"."No.");
                    DeleteSH.SETRANGE(DeleteSH.Status, DeleteSH.Status::Open);
                    DeleteSH.SetRange("Shipped Not Invoiced", false);
                    DeleteSH.SETFILTER(DeleteSH."Shortcut Dimension 1 Code", '%1', 'CATTLE');
                    IF DeleteSH.FINDFIRST THEN begin
                        DeleteSL.RESET;
                        DeleteSL.SETRANGE(DeleteSL."Document No.", DeleteSH."No.");
                        IF DeleteSL.FINDSET THEN
                            //DeleteSH.ConfirmDeletion();
                            //DeleteSH.ConfirmDeletion()
                            DeleteSL.DELETEALL(True);
                        DeleteSH.DELETE(True);
                    end;
                end;



                DeleteSH.RESET;
                DeleteSH.SETRANGE("Document Type", DeleteSH."Document Type"::Order);
                //DeleteSH.SETFILTER(DeleteSH."No.",'%1','F-SO/2122/20783');
                DeleteSH.SETRANGE(DeleteSH."No.", "Sales Header"."No.");
                DeleteSH.SETRANGE(DeleteSH.Status, DeleteSH.Status::Open);
                DeleteSH.SetRange("Shipped Not Invoiced", false);
                // DeleteSH.SETFILTER(DeleteSH."Shortcut Dimension 2 Code",'<>%1','1011');
                IF DeleteSH.FINDFIRST THEN BEGIN
                    IF TODAY - DeleteSH."Order Date" > 4 THEN BEGIN
                        DeleteSL.RESET;
                        DeleteSL.SETRANGE(DeleteSL."Document No.", DeleteSH."No.");
                        IF DeleteSL.FINDSET THEN
                            DeleteSL.DELETEALL(True);
                        DeleteSH.DELETE(True);
                    END;
                END;

                IF "Customer Price Group" <> '' THEN BEGIN
                    DeleteSH.RESET;
                    DeleteSH.SETRANGE("Document Type", DeleteSH."Document Type"::Order);
                    DeleteSH.SETRANGE(DeleteSH."No.", "Sales Header"."No.");
                    DeleteSH.SETRANGE(DeleteSH.Status, DeleteSH.Status::Open);
                    DeleteSH.SetRange(DeleteSH."Shipped Not Invoiced", False);
                    //DeleteSH.SETFILTER(DeleteSH."Shortcut Dimension 2 Code",'<>%1','1011');
                    IF DeleteSH.FINDFIRST THEN BEGIN
                        IF IsSalesLineImpty(DeleteSH."No.") THEN
                            DeleteSH.DELETE(True)
                        ELSE BEGIN
                            IF CheckSalesPriceExp(DeleteSH."Customer Price Group", DeleteSH."Location Code", DeleteSH."Order Date", DeleteSH."No.") THEN BEGIN
                                DeleteSL.RESET;
                                DeleteSL.SETRANGE(DeleteSL."Document No.", DeleteSH."No.");
                                IF DeleteSL.FINDSET THEN
                                    DeleteSL.DELETEALL(True);
                                DeleteSH.DELETE(True);
                                //DeletedDocs += "Sales Header"."No." + '|';
                                //Window.UPDATE("Sales Header"."No.");
                            END;
                        END;
                    END;
                END ELSE BEGIN
                    DeleteSH.RESET;
                    DeleteSH.SETRANGE("Document Type", DeleteSH."Document Type"::Order);
                    //DeleteSH.SETFILTER(DeleteSH."No.",'%1','F-SO/2122/20783');
                    DeleteSH.SETRANGE(DeleteSH."No.", "Sales Header"."No.");
                    DeleteSH.SETRANGE(DeleteSH.Status, DeleteSH.Status::Open);
                    DeleteSH.SetRange(DeleteSH."Shipped Not Invoiced", False);
                    //DeleteSH.SETFILTER(DeleteSH."Shortcut Dimension 2 Code",'<>%1','1011');
                    IF DeleteSH.FINDFIRST THEN BEGIN
                        IF TODAY - DeleteSH."Order Date" > 4 THEN BEGIN
                            DeleteSL.RESET;
                            DeleteSL.SETRANGE(DeleteSL."Document No.", DeleteSH."No.");
                            IF DeleteSL.FINDSET THEN
                                DeleteSL.DELETEALL(True);
                            DeleteSH.DELETE(True);
                        END;

                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN('Deleting Order');
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

    trigger OnInitReport()
    begin
        //MESSAGE('%1',TODAY-11092021D);
    end;

    trigger OnPostReport()
    begin
        //MESSAGE(Text001, DeletedDocs);
    end;

    var

        Firstdate: Date;
        DeleteSH: Record 36;
        DeleteSL: Record 37;
        DeletedDocs: Code[1000];
        Text001: Label 'These Sale Order Document Deleted as per Rule %1.';
        Window: Dialog;

    local procedure CheckSalesPriceExp(CustomerPriceGroup: Code[30]; LocationCode: Code[30]; OrderDate: Date; DocNo: Code[20]): Boolean
    var
        SalesPrice: Record "Price List Line";
        CheckSalesLine: Record 37;
        Flag: Boolean;
        PriceDate: Date;
    begin
        Flag := FALSE;
        CheckSalesLine.RESET;
        CheckSalesLine.SETRANGE(CheckSalesLine."Document No.", DocNo);
        IF CheckSalesLine.FINDSET THEN BEGIN
            REPEAT

                SalesPrice.RESET;
                SalesPrice.SETRANGE(SalesPrice."Location Code", LocationCode);
                SalesPrice.SETRANGE(SalesPrice."Source Type", SalesPrice."Source Type"::"Customer Price Group");
                SalesPrice.SETRANGE(SalesPrice."Source No.", CustomerPriceGroup);
                SalesPrice.SETRANGE(SalesPrice."Product No1", CheckSalesLine."No.");
                SalesPrice.SETCURRENTKEY("Starting Date");
                SalesPrice.SETASCENDING("Starting Date", TRUE);
                IF SalesPrice.FINDLAST THEN BEGIN
                    //PRU SH 01082022
                    IF (SalesPrice."MRP Price" <> CheckSalesLine."MRP Price") OR (SalesPrice."Unit Price" <> CheckSalesLine."Unit Price") THEN BEGIN
                        Flag := TRUE;
                        PriceDate := SalesPrice."Starting Date";
                    END;
                    //PRU SH 01082022
                END;
            UNTIL CheckSalesLine.NEXT = 0;
        END;
        IF Flag THEN BEGIN
            IF TODAY - OrderDate > 4 THEN
                EXIT(TRUE)
            ELSE
                EXIT(FALSE);
        END;
    end;

    local procedure IsSalesLineImpty(DocNo: Code[20]): Boolean
    var
        SalesLine: Record 37;
    begin
        SalesLine.RESET;
        SalesLine.SETRANGE(SalesLine."Document No.", DocNo);
        IF NOT SalesLine.FINDFIRST THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;
}

