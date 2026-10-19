codeunit 50006 "Sales Credit Limit"
{

    trigger OnRun()
    begin
    end;


    procedure CreditLimitUpdateOnCustomerShip(var ParaSH: Record 36)
    var
        Cust: Record 18;
        T18_Loc: Record 18;
    begin
        IF NOT (ParaSH."GST Customer Type" = ParaSH."GST Customer Type"::Export) THEN BEGIN
            CASE ParaSH."Document Type" OF
                ParaSH."Document Type"::Order:
                    BEGIN
                        ////IF ParaSH.Status = ParaSH.Status::Released THEN BEGIN
                        ParaSH.CALCFIELDS(Amount);
                        Cust.GET(ParaSH."Sell-to Customer No.");
                        /*IF Cust.Distributor THEN BEGIN
                          Cust."Remaining Credit Limit" := Cust."Remaining Credit Limit" - ParaSH."Amt. to Customer";
                          Cust.MODIFY;
                        END ELSE
                        IF Cust."Distributor Code" <> '' THEN BEGIN
                          T18_Loc.GET(Cust."Distributor Code");
                          T18_Loc."Remaining Credit Limit" := T18_Loc."Remaining Credit Limit" - ParaSH."Amt. to Customer";
                          T18_Loc.MODIFY;
                        END ELSE BEGIN*/

                        Cust."Remaining Credit Limit" := Cust."Remaining Credit Limit" - ParaSH.Amount;
                        Cust.MODIFY;
                        ///END;
                        /*END ELSE IF ParaSH.Status = ParaSH.Status::Open THEN BEGIN
                          ParaSH.CALCFIELDS("Amount to Customer");
                          Cust.GET(ParaSH."Sell-to Customer No.");
                          IF Cust.Distributor THEN BEGIN
                            Cust."Remaining Credit Limit" := Cust."Remaining Credit Limit" + ParaSH."Amount to Customer";
                            Cust.MODIFY;
                          END ELSE
                          IF Cust."Distributor Code" <> '' THEN BEGIN
                            T18_Loc.GET(Cust."Distributor Code");
                            T18_Loc."Remaining Credit Limit" := T18_Loc."Remaining Credit Limit" + ParaSH."Amount to Customer";
                            T18_Loc.MODIFY;
                          END ELSE BEGIN
                            Cust."Remaining Credit Limit" := Cust."Remaining Credit Limit" + ParaSH."Amount to Customer";
                            Cust.MODIFY;
                          END;
                        END;*/
                    END;
                ParaSH."Document Type"::"Credit Memo":
                    BEGIN
                        /////IF ParaSH.Status = ParaSH.Status::Released THEN BEGIN
                        ParaSH.CALCFIELDS(Amount);
                        Cust.GET(ParaSH."Sell-to Customer No.");
                        /*IF Cust.Distributor THEN BEGIN
                          Cust."Remaining Credit Limit" := Cust."Remaining Credit Limit" + ParaSH."Amt. to Customer";
                          Cust.MODIFY;
                        END ELSE
                        IF Cust."Distributor Code" <> '' THEN BEGIN
                          T18_Loc.GET(Cust."Distributor Code");
                          T18_Loc."Remaining Credit Limit" := T18_Loc."Remaining Credit Limit" + ParaSH."Amt. to Customer";
                          T18_Loc.MODIFY;
                        END ELSE BEGIN*/
                        Cust."Remaining Credit Limit" := Cust."Remaining Credit Limit" + ParaSH.Amount;
                        Cust.MODIFY;
                        ///END;
                        /*END ELSE IF ParaSH.Status = ParaSH.Status::Open THEN BEGIN
                          ParaSH.CALCFIELDS("Amount to Customer");
                          Cust.GET(ParaSH."Sell-to Customer No.");
                          IF Cust.Distributor THEN BEGIN
                            Cust."Remaining Credit Limit" := Cust."Remaining Credit Limit" - ParaSH."Amount to Customer";
                            Cust.MODIFY;
                          END ELSE
                          IF Cust."Distributor Code" <> '' THEN BEGIN
                            T18_Loc.GET(Cust."Distributor Code");
                            T18_Loc."Remaining Credit Limit" := T18_Loc."Remaining Credit Limit" - ParaSH."Amount to Customer";
                            T18_Loc.MODIFY;
                          END ELSE BEGIN
                            Cust."Remaining Credit Limit" := Cust."Remaining Credit Limit" - ParaSH."Amount to Customer";
                            Cust.MODIFY;
                          END;
                        END;*/
                    END;
            END;
        END;

    end;


    procedure CheckCreditLimitShip(var ParaSH: Record 36)
    var
        Cust: Record 18;
        T18_Loc: Record 18;
    begin
        IF NOT (ParaSH."GST Customer Type" = ParaSH."GST Customer Type"::Export) THEN BEGIN
            CASE ParaSH."Document Type" OF
                ParaSH."Document Type"::Order:
                    BEGIN
                        ParaSH.CALCFIELDS(Amount);
                        Cust.GET(ParaSH."Sell-to Customer No.");
                        IF Cust."Credit Limit (LCY)" <> 0 THEN BEGIN
                            /*IF Cust.Distributor THEN BEGIN
                              IF Cust."Remaining Credit Limit" < ParaSH."Amt. to Customer" THEN
                                ERROR('Credit Limit for the Customer is exceeding by %1',(ParaSH."Amt. to Customer"-Cust."Remaining Credit Limit"));
                            END ELSE
                            IF Cust."Distributor Code" <> '' THEN BEGIN
                              T18_Loc.GET(Cust."Distributor Code");
                              IF T18_Loc."Remaining Credit Limit" < ParaSH."Amt. to Customer" THEN
                                ERROR('Credit Limit for the Customer is exceeding by %1',(ParaSH."Amt. to Customer"-T18_Loc."Remaining Credit Limit"));
                            END ELSE BEGIN*/
                            // IF Cust."Remaining Credit Limit" < ParaSH.Amount THEN
                            //     ERROR('Credit Limit for the Customer is exceeding by %1', (ParaSH.Amount - Cust."Remaining Credit Limit"));
                        END;

                    END;
                ParaSH."Document Type"::Invoice:
                    BEGIN
                        ParaSH.CALCFIELDS(Amount);
                        Cust.GET(ParaSH."Sell-to Customer No.");
                        IF Cust."Credit Limit (LCY)" <> 0 THEN BEGIN
                            /*IF Cust.Distributor THEN BEGIN
                              IF Cust."Remaining Credit Limit" < ParaSH."Amt. to Customer" THEN
                                ERROR('Credit Limit for the Customer is exceeding by %1',(ParaSH."Amt. to Customer"-Cust."Remaining Credit Limit"));
                            END ELSE
                            IF Cust."Distributor Code" <> '' THEN BEGIN
                              T18_Loc.GET(Cust."Distributor Code");
                              IF T18_Loc."Remaining Credit Limit" < ParaSH."Amt. to Customer" THEN
                                ERROR('Credit Limit for the Customer is exceeding by %1',(ParaSH."Amt. to Customer"-T18_Loc."Remaining Credit Limit"));
                            END ELSE BEGIN*/
                            IF Cust."Remaining Credit Limit" < ParaSH.Amount THEN
                                ERROR('Credit Limit for the Customer is exceeding by %1', (ParaSH.Amount - Cust."Remaining Credit Limit"));
                        END;
                    END;
                ParaSH."Document Type"::"Credit Memo":
                    BEGIN
                        ParaSH.CALCFIELDS(Amount);
                        Cust.GET(ParaSH."Sell-to Customer No.");
                        IF Cust."Credit Limit (LCY)" <> 0 THEN BEGIN
                            /*IF Cust.Distributor THEN BEGIN
                              IF Cust."Remaining Credit Limit" < ParaSH."Amt. to Customer" THEN
                                ERROR('Credit Limit for the Customer is exceeding by %1',(ParaSH."Amt. to Customer"-Cust."Remaining Credit Limit"));
                            END ELSE
                            IF Cust."Distributor Code" <> '' THEN BEGIN
                              T18_Loc.GET(Cust."Distributor Code");
                              IF T18_Loc."Remaining Credit Limit" < ParaSH."Amt. to Customer" THEN
                                ERROR('Credit Limit for the Customer is exceeding by %1',(ParaSH."Amt. to Customer"-T18_Loc."Remaining Credit Limit"));
                            END ELSE BEGIN*/
                            IF Cust."Remaining Credit Limit" < ParaSH."Amt. to Customer" THEN
                                ERROR('Credit Limit for the Customer is exceeding by %1', (ParaSH.Amount - Cust."Remaining Credit Limit"));
                        END;
                    END;
            END;
        END;

    end;


    procedure CreditLimitCheckOnOpenInvoices(ParaCust: Code[20]; DocDate: Date)
    var
        T21_Loc: Record 21;
        Cust: Record 18;
        GracePeriod: Text;
    begin
        Cust.GET(ParaCust);
        ///////IF Cust."Grace Period Date" = 0D THEN BEGIN
        /*///PRU-VG 050319
          T21_Loc.RESET;
          T21_Loc.SETRANGE("Customer No.",ParaCust);
          T21_Loc.SETRANGE(Open,TRUE);
          T21_Loc.SETRANGE("Document Type",T21_Loc."Document Type"::Invoice);
          //////IF Cust."Grace Period Date" <> 0D THEN
            ////T21_Loc.SETFILTER("Due Date",'<%1',CALCDATE('-'+FORMAT(Cust."Grace Period Date"),DocDate))
          ////ELSE
            ////T21_Loc.SETFILTER("Posting Date",'<%1',Cust."Grace Period Date");
          ////ELSE
          /////IF FORMAT(Cust."Credit Days") <> '' THEN/////301118
            ////T21_Loc.SETFILTER("Due Date",'<%1',CALCDATE('-' + FORMAT(Cust."Credit Days"),DocDate))/////301118
          /////ELSE/////301118
            T21_Loc.SETFILTER("Due Date",'<%1',DocDate);
          T21_Loc.SETAUTOCALCFIELDS("Remaining Amount");
          IF T21_Loc.FINDFIRST THEN REPEAT
            IF T21_Loc."Remaining Amount" > 0 THEN
              ERROR('Customer Payment Is Pending');
          UNTIL T21_Loc.NEXT=0;*////PRU-VG 050319
        /*END ELSE BEGIN
          IF DocDate > Cust."Grace Period Date" THEN BEGIN
            /////IF FORMAT(Cust."Credit Days")<>'' THEN
            ERROR('Customer Grace Period Date is Less than specified Sales Order Posting Date');
          END;*/
        /////END;

    end;


    procedure CheckCustPayment(var CustLedgerEntry: Record 379)
    var
        T_21: Record 21;
        T_18: Record 18;
        ParaCustomer: Record 18;
    begin
        IF CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Payment THEN BEGIN
            ParaCustomer.GET(CustLedgerEntry."Customer No.");
            IF ParaCustomer."Credit Limit (LCY)" <> 0 THEN BEGIN
                /*IF ParaCustomer.Distributor THEN BEGIN
                  ParaCustomer."Remaining Credit Limit" += ABS(CustLedgerEntry.Amount);
                  ParaCustomer.MODIFY;
                END ELSE
                IF ParaCustomer."Distributor Code" <> '' THEN BEGIN
                  T_18.GET(ParaCustomer."Distributor Code");
                  T_18."Remaining Credit Limit" += ABS(CustLedgerEntry.Amount);
                  T_18.MODIFY;
                END ELSE BEGIN*/
                ParaCustomer."Remaining Credit Limit" += ABS(CustLedgerEntry.Amount);
                ParaCustomer.MODIFY;
            END;
        END;

    end;


    procedure CheckCustPaymentReversal(var CustLedgerEntry: Record 379)
    var
        T_21: Record 21;
        T_18: Record 18;
        ParaCustomer: Record 18;
    begin
        IF CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Payment THEN BEGIN
            ParaCustomer.GET(CustLedgerEntry."Customer No.");
            IF ParaCustomer."Credit Limit (LCY)" <> 0 THEN BEGIN
                /*IF ParaCustomer.Distributor THEN BEGIN
                  ParaCustomer."Remaining Credit Limit" += ABS(CustLedgerEntry.Amount);
                  ParaCustomer.MODIFY;
                END ELSE
                IF ParaCustomer."Distributor Code" <> '' THEN BEGIN
                  T_18.GET(ParaCustomer."Distributor Code");
                  T_18."Remaining Credit Limit" += ABS(CustLedgerEntry.Amount);
                  T_18.MODIFY;
                END ELSE BEGIN*/
                ParaCustomer."Remaining Credit Limit" -= ABS(CustLedgerEntry.Amount);
                ParaCustomer.MODIFY;
            END;
        END ELSE
            IF CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Refund THEN BEGIN
                ParaCustomer.GET(CustLedgerEntry."Customer No.");
                IF ParaCustomer."Credit Limit (LCY)" <> 0 THEN BEGIN
                    /*IF ParaCustomer.Distributor THEN BEGIN
                      ParaCustomer."Remaining Credit Limit" += ABS(CustLedgerEntry.Amount);
                      ParaCustomer.MODIFY;
                    END ELSE
                    IF ParaCustomer."Distributor Code" <> '' THEN BEGIN
                      T_18.GET(ParaCustomer."Distributor Code");
                      T_18."Remaining Credit Limit" += ABS(CustLedgerEntry.Amount);
                      T_18.MODIFY;
                    END ELSE BEGIN*/
                    ParaCustomer."Remaining Credit Limit" += ABS(CustLedgerEntry.Amount);
                    ParaCustomer.MODIFY;
                END;
            END;

    end;


    procedure CheckCustPaymentRefund(var CustLedgerEntry: Record 379)
    var
        T_21: Record 21;
        T_18: Record 18;
        ParaCustomer: Record 18;
    begin
        IF CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Refund THEN BEGIN
            ParaCustomer.GET(CustLedgerEntry."Customer No.");
            IF ParaCustomer."Credit Limit (LCY)" <> 0 THEN BEGIN
                /*IF ParaCustomer.Distributor THEN BEGIN
                  ParaCustomer."Remaining Credit Limit" += ABS(CustLedgerEntry.Amount);
                  ParaCustomer.MODIFY;
                END ELSE
                IF ParaCustomer."Distributor Code" <> '' THEN BEGIN
                  T_18.GET(ParaCustomer."Distributor Code");
                  T_18."Remaining Credit Limit" += ABS(CustLedgerEntry.Amount);
                  T_18.MODIFY;
                END ELSE BEGIN*/
                ParaCustomer."Remaining Credit Limit" -= ABS(CustLedgerEntry.Amount);
                ParaCustomer.MODIFY;
            END;
        END;

    end;


    procedure CheckCustPaymentForBlankLine(var CustLedgerEntry: Record 379)
    var
        T_21: Record 21;
        T_18: Record 18;
        ParaCustomer: Record 18;
    begin
        IF CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::" " THEN BEGIN
            IF CustLedgerEntry."Credit Amount" <> 0 THEN BEGIN
                ParaCustomer.GET(CustLedgerEntry."Customer No.");
                IF ParaCustomer."Credit Limit (LCY)" <> 0 THEN BEGIN
                    /*IF ParaCustomer.Distributor THEN BEGIN
                      ParaCustomer."Remaining Credit Limit" += ABS(CustLedgerEntry.Amount);
                      ParaCustomer.MODIFY;
                    END ELSE
                    IF ParaCustomer."Distributor Code" <> '' THEN BEGIN
                      T_18.GET(ParaCustomer."Distributor Code");
                      T_18."Remaining Credit Limit" += ABS(CustLedgerEntry.Amount);
                      T_18.MODIFY;
                    END ELSE BEGIN*/
                    ParaCustomer."Remaining Credit Limit" += ABS(CustLedgerEntry.Amount);
                    ParaCustomer.MODIFY;
                END;
            END;
        END;

    end;


    procedure CheckCustPaymentRefundforBlankLine(var CustLedgerEntry: Record 379)
    var
        T_21: Record 21;
        T_18: Record 18;
        ParaCustomer: Record 18;
    begin
        IF CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::" " THEN BEGIN
            IF CustLedgerEntry."Debit Amount" <> 0 THEN BEGIN
                ParaCustomer.GET(CustLedgerEntry."Customer No.");
                IF ParaCustomer."Credit Limit (LCY)" <> 0 THEN BEGIN
                    /*IF ParaCustomer.Distributor THEN BEGIN
                      ParaCustomer."Remaining Credit Limit" += ABS(CustLedgerEntry.Amount);
                      ParaCustomer.MODIFY;
                    END ELSE
                    IF ParaCustomer."Distributor Code" <> '' THEN BEGIN
                      T_18.GET(ParaCustomer."Distributor Code");
                      T_18."Remaining Credit Limit" += ABS(CustLedgerEntry.Amount);
                      T_18.MODIFY;
                    END ELSE BEGIN*/
                    ParaCustomer."Remaining Credit Limit" -= ABS(CustLedgerEntry.Amount);
                    ParaCustomer.MODIFY;
                END;
            END;
        END;

    end;


    procedure CheckReverseCustPaymentForBlankLine(var CustLedgerEntry: Record 379)
    var
        T_21: Record 21;
        T_18: Record 18;
        ParaCustomer: Record 18;
    begin
        IF CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::" " THEN BEGIN
            IF CustLedgerEntry."Credit Amount" <> 0 THEN BEGIN
                ParaCustomer.GET(CustLedgerEntry."Customer No.");
                IF ParaCustomer."Credit Limit (LCY)" <> 0 THEN BEGIN
                    /*IF ParaCustomer.Distributor THEN BEGIN
                      ParaCustomer."Remaining Credit Limit" += ABS(CustLedgerEntry.Amount);
                      ParaCustomer.MODIFY;
                    END ELSE
                    IF ParaCustomer."Distributor Code" <> '' THEN BEGIN
                      T_18.GET(ParaCustomer."Distributor Code");
                      T_18."Remaining Credit Limit" += ABS(CustLedgerEntry.Amount);
                      T_18.MODIFY;
                    END ELSE BEGIN*/
                    ParaCustomer."Remaining Credit Limit" -= ABS(CustLedgerEntry.Amount);
                    ParaCustomer.MODIFY;
                END;
            END;
        END;

    end;


    procedure CheckReverseCustPaymentRefundforBlankLine(var CustLedgerEntry: Record 379)
    var
        T_21: Record 21;
        T_18: Record 18;
        ParaCustomer: Record 18;
    begin
        IF CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::" " THEN BEGIN
            IF CustLedgerEntry."Debit Amount" <> 0 THEN BEGIN
                ParaCustomer.GET(CustLedgerEntry."Customer No.");
                IF ParaCustomer."Credit Limit (LCY)" <> 0 THEN BEGIN
                    /*IF ParaCustomer.Distributor THEN BEGIN
                      ParaCustomer."Remaining Credit Limit" += ABS(CustLedgerEntry.Amount);
                      ParaCustomer.MODIFY;
                    END ELSE
                    IF ParaCustomer."Distributor Code" <> '' THEN BEGIN
                      T_18.GET(ParaCustomer."Distributor Code");
                      T_18."Remaining Credit Limit" += ABS(CustLedgerEntry.Amount);
                      T_18.MODIFY;
                    END ELSE BEGIN*/
                    ParaCustomer."Remaining Credit Limit" += ABS(CustLedgerEntry.Amount);
                    ParaCustomer.MODIFY;
                END;
            END;
        END;

    end;


    procedure CreditLimitUpdateOnUndoShipment(var ParaSSL: Record 111)
    var
        Cust: Record 18;
    begin
        Cust.GET(ParaSSL."Sell-to Customer No.");
        IF Cust."Credit Limit (LCY)" <> 0 THEN BEGIN
            Cust."Remaining Credit Limit" := Cust."Remaining Credit Limit" + ParaSSL."Amt. to Customer";
            Cust.MODIFY;
        END;
    end;
}


