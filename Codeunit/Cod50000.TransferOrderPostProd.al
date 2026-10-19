codeunit 50000 "TransferOrder-Post Prod."
{
    TableNo = 5740;

    trigger OnRun()
    begin
        TransHeader.COPY(Rec);
        Code;
        Rec := TransHeader;
    end;

    var
        Text000: Label '&Ship,&Receive';
        TransHeader: Record 5740;
        tgUsersetup: Record 91;
        tgFromLoc: Record 14;
        tgToLoc: Record 14;
        Text001: Label '&Ship';
        Text002: Label ',&Receive';


    local procedure "Code"()
    var
        TransLine: Record 5741;
        TransferPostShipment: Codeunit 5704;
        TransferPostReceipt: Codeunit 5705;
        DefaultNumber: Integer;
        Selection: Option " ",Shipment,Receipt;
    begin
        WITH TransHeader DO BEGIN
            TransLine.SETRANGE("Document No.", "No.");
            IF TransLine.FIND('-') THEN
                REPEAT
                    IF (TransLine."Quantity Shipped" < TransLine.Quantity) AND
                       (DefaultNumber = 0)
                    THEN
                        DefaultNumber := 1;
                    IF (TransLine."Quantity Received" < TransLine.Quantity) AND
                       (DefaultNumber = 0)
                    THEN
                        DefaultNumber := 2;
                UNTIL (TransLine.NEXT = 0) OR (DefaultNumber > 0);

            IF
              DefaultNumber = 0 THEN
                DefaultNumber := 1;


            // TransferPostReceipt.CreateProdOrder; // PRU SH 250822
            Selection := STRMENU(Text000, DefaultNumber);
            CASE Selection OF
                0:
                    EXIT;
                1:
                    TransferPostShipment.RUN(TransHeader);
                2:
                    TransferPostReceipt.RUN(TransHeader);
            END;
        END;
    end;
}

