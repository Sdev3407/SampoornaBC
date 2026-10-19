codeunit 50018 "SMS functions"
{
    // // SMS Send Using SMS DLL Client

    trigger OnRun()
    var
        SMSContent: Text;
        SalesInvoiceHeader: Record 112;
    begin
        ReportDate := CALCDATE('-1D', WORKDATE);
        // SendSalesSMS()
        SendSMSToSalesPerson;
        SendSMSToTeam;
        SendSMSToManegment;

    end;

    var
        TotalCattleSaleAsOnDateTeam: Decimal;
        CattleTeamTarget: Decimal;
        WhatsappFunction: Codeunit "WhatsApp Function";
        SalespersonPurchaser: Record 13;
        ItemLedgerEntry: Record 32;
        SMSSetup: Record 311;
        TeamSalesperson: Record 5084;
        SaleTillDate: Decimal;
        ExpectedSales: Decimal;
        PreviousSale: Decimal;
        EndDate: Date;
        StartDate: Date;
        PreStartDate: Date;
        PreEndDate: Date;
        TotalSaleAsOnDate: Decimal;
        TotalCattleSaleAsOnDate: Decimal;
        CattleSalesTarget: Decimal;
        ExpectedSalesInMonth: Decimal;
        PreviousMonthSale: Decimal;
        TotalSaleAsOnDateTeam: Decimal;
        ExpectedSalesInMonthTeam: Decimal;
        PreviousMonthSaleTeam: Decimal;
        ReportDate: Date;
        CattleAsonValue: Decimal;
        PulAsonValue: Decimal;
        CattlePrevVAlue: Decimal;
        PolPreValue: Decimal;
        CattleExpValue: Decimal;
        PolExpValue: Decimal;
        NoOfCattle: Integer;
        NoOfPol: Integer;
        IsTeamCattleExist: Boolean;
        IsTeamPoultryExist: Boolean;
        TeamCattleNo: Text;
        TeampoultryNo: Text;
        Salesperson: Record 13;
        SMTPMailSetup: Codeunit "Email Message";
        SMTPMail: Codeunit "Email Message";
        "PhoneNo.": Text;
        SalesPersonPhone: Text;
        TeamPhone: Text;
        TeamCode: Text;
        Team: Record 5083;
        WebURL: Text;
        WebMessage: Text;
    // AesOperation: DotNet AesOperation;

    //PRU SH 25082022
    procedure SENDSMS()
    begin
        ReportDate := CALCDATE('-1D', WORKDATE);
        SendSMSToSalesPerson;
        SendSMSToTeam;
        SendSMSToManegment;
    end;

    procedure SendSMS(SMSnumber: Text[1024]; SmsMessage: Text[1024]; Description: Text[1024]; ContentID: Text): Boolean
    var
        Setup: Record 50010;
        Mail: Codeunit 397;
        URL: Text[1024];
        Success: Boolean;
        SmsURL1: Text;
        WebClient: DotNet WebClient;
        len: Integer;
        gResponseMsg: Text;
        gRequestMsg: Text;
        gContent: HttpContent;
        gContentHeaders: HttpHeaders;
        gHttpClient: HttpClient;
        gHttpResponseMsg: HttpResponseMessage;
        Json: Text;
        SalesandRec: Record "Sales & Receivables Setup";
    begin
        SalesandRec.Get;
        IF (SMSnumber <> '') AND (SmsMessage <> '') THEN BEGIN
            SMSSetup.GET;
            CASE SMSSetup."SMS Send Type" OF
                SMSSetup."SMS Send Type"::"HTTP Request":
                    BEGIN
                        URL := SMSSetup."SMS HTTP URL" +
                        '?username=' + SMSSetup."SMS User" +
                        '&password=' + SMSSetup."SMS Password" +
                        '&unicode=false' +
                        '&from=' + SMSSetup."Sender ID" +
                        '&to=' + SMSnumber +
                        '&dltContentId=' + ContentID +
                        '&dltPrincipalEntityId=' + SMSSetup."Entity ID" +
                        '&text=' + SmsMessage;

                        //  Message(URL);
                        //    WebClient := WebClient.WebClient;
                        Clear(gResponseMsg);
                        //    gContent.WriteFrom(Body);
                        gContent.GetHeaders(gContentHeaders);
                        gContentHeaders.Clear();
                        gContentHeaders.Add('Content-Type', 'application/json');
                        //  http://einvsandbox.webtel.in/v1.03/GenIRN
                        if gHttpClient.Post(URL, gContent, gHttpResponseMsg) then begin
                            //                if gHttpClient.Post('http://einvlive.webtel.in/v1.03/GenIRN', gContent, gHttpResponseMsg) then begin
                            gHttpResponseMsg.Content.ReadAs(Json);
                            if gHttpResponseMsg.IsSuccessStatusCode then begin
                                //     Message('check1');
                            END;
                        END;

                        Success := TRUE;
                        EXIT(Success);
                    END;
                SMSSetup."SMS Send Type"::Email:
                    IF Mail.NewMessage(SMSnumber + '@' + SMSSetup."SMS Email Server", '', '', Description, SmsMessage, '', FALSE) THEN
                        EXIT(TRUE);
            END;
        END;
        EXIT(FALSE);
    end;

    local procedure CalulateSaleValue(SalesPersonCode: Code[20])
    var
        ItemLedgerEntry: Record 32;
        SalesShipmentHeader: Record 110;
        salesReturnReceipt: Record "Return Receipt Header";
    begin
        ReportDate := CALCDATE('-1D', WORKDATE);
        ExpectedSalesInMonth := 0;
        TotalSaleAsOnDate := 0;
        PreviousMonthSale := 0;
        EndDate := CALCDATE('CM', ReportDate);
        StartDate := CALCDATE('-CM', ReportDate);
        PreEndDate := CALCDATE('CM', CALCDATE('-1M', ReportDate));
        PreStartDate := CALCDATE('-CM', CALCDATE('-1M', ReportDate));
        //   MESSAGE('%1,%2,%3,%4', StartDate, EndDate, PreStartDate, PreEndDate);
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", StartDate, ReportDate);
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Sale);
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item Type", ItemLedgerEntry."Item Type"::Feed);
        IF ItemLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                SalesShipmentHeader.RESET;
                SalesShipmentHeader.SETRANGE(SalesShipmentHeader."No.", ItemLedgerEntry."Document No.");
                SalesShipmentHeader.SETRANGE(SalesShipmentHeader."Salesperson Code", SalesPersonCode);
                IF SalesShipmentHeader.FINDFIRST THEN
                    TotalSaleAsOnDate += ItemLedgerEntry.Quantity;
                salesReturnReceipt.Reset();
                salesReturnReceipt.SETRANGE(salesReturnReceipt."No.", ItemLedgerEntry."Document No.");
                salesReturnReceipt.SETRANGE(salesReturnReceipt."Salesperson Code", SalesPersonCode);
                IF salesReturnReceipt.FINDFIRST THEN
                    TotalSaleAsOnDate += (ItemLedgerEntry.Quantity);

            UNTIL ItemLedgerEntry.NEXT = 0;
        END;
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", PreStartDate, PreEndDate);
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Sale);
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item Type", ItemLedgerEntry."Item Type"::Feed);
        IF ItemLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                SalesShipmentHeader.RESET;
                SalesShipmentHeader.SETRANGE(SalesShipmentHeader."No.", ItemLedgerEntry."Document No.");
                SalesShipmentHeader.SETRANGE(SalesShipmentHeader."Salesperson Code", SalesPersonCode);
                IF SalesShipmentHeader.FINDFIRST THEN
                    PreviousMonthSale += ItemLedgerEntry.Quantity;
                salesReturnReceipt.Reset();
                salesReturnReceipt.SETRANGE(salesReturnReceipt."No.", ItemLedgerEntry."Document No.");
                salesReturnReceipt.SETRANGE(salesReturnReceipt."Salesperson Code", SalesPersonCode);
                IF salesReturnReceipt.FINDFIRST THEN
                    PreviousMonthSale += (ItemLedgerEntry.Quantity);
            UNTIL ItemLedgerEntry.NEXT = 0;
        END;
        IF TotalSaleAsOnDate <> 0 THEN
            ExpectedSalesInMonth := (TotalSaleAsOnDate / DATE2DMY(ReportDate, 1)) * DATE2DMY(EndDate, 1);
        TotalSaleAsOnDate := ROUND(ABS(TotalSaleAsOnDate / 1000), 0.01, '<');
        PreviousMonthSale := ROUND(ABS(PreviousMonthSale / 1000), 0.01, '<');
        ExpectedSalesInMonth := ROUND(ABS(ExpectedSalesInMonth / 1000), 0.01, '<');
        //MESSAGE('%1,%2,%3', TotalSaleAsOnDate, ExpectedSalesInMonth, PreviousMonthSale);
    end;

    local procedure CalulateSaleValueforCattle(SalesPersonCode: Code[20])
    var
        ItemLedgerEntry: Record 32;
        SalesShipmentHeader: Record 110;
        salesReturnReceipt: Record "Return Receipt Header";
        SalesTarget: Record "Sales Person Target";
    begin
        Clear(TotalCattleSaleAsOnDate);
        Clear(CattleSalesTarget);
        ReportDate := CALCDATE('-1D', WORKDATE);
        ExpectedSalesInMonth := 0;
        TotalSaleAsOnDate := 0;
        PreviousMonthSale := 0;
        EndDate := CALCDATE('CM', ReportDate);
        StartDate := CALCDATE('-CM', ReportDate);
        PreEndDate := CALCDATE('CM', CALCDATE('-1M', ReportDate));
        PreStartDate := CALCDATE('-CM', CALCDATE('-1M', ReportDate));
        //   MESSAGE('%1,%2,%3,%4', StartDate, EndDate, PreStartDate, PreEndDate);
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", StartDate, ReportDate);
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Sale);
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item Type", ItemLedgerEntry."Item Type"::Feed);
        ItemLedgerEntry.SetRange(ItemLedgerEntry."Salesperson/Purchaser", SalesPersonCode);
        IF ItemLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                TotalCattleSaleAsOnDate += (ItemLedgerEntry.Quantity / 1000);
            UNTIL ItemLedgerEntry.NEXT = 0;
        END;
        SalesTarget.Reset();
        SalesTarget.SetRange("Sales Person Code", SalesPersonCode);
        SalesTarget.SetRange("Start Date", StartDate);
        SalesTarget.SetRange("End Date", EndDate);
        if SalesTarget.FindFirst() then
            CattleSalesTarget := SalesTarget."Qty In MT";
    end;

    procedure SendSMSToSalesPerson()
    var
        SMSContent: Text;
        SalesPer: Decimal;
        SMSDetail: Codeunit "SMS Details";
        NumberList: List of [Text];
        Number: Text;
    begin
        // SEND SMS TO SALES PERSONN
        SalespersonPurchaser.RESET;
        SalespersonPurchaser.SETRANGE(SalespersonPurchaser.Blocked, FALSE);
        SalespersonPurchaser.SETRANGE(SalespersonPurchaser."Responsibility Center", 'FEED');
        //SalespersonPurchaser.SETRANGE(SalespersonPurchaser.Code, 'SAM4466');
        IF SalespersonPurchaser.FINDSET THEN BEGIN
            REPEAT
                SMSSetup.GET;
                CalulateSaleValue(SalespersonPurchaser.Code);
                if SalespersonPurchaser."Phone No." <> '' then begin
                    SMSContent := 'Hi,' + ' ' + SalespersonPurchaser.Name + ' ' + ' Total  Achieved As on  ' + ' ' + FORMAT(ReportDate) + ' ' + FORMAT(TotalSaleAsOnDate) + ' ' + 'MT  Proj This Month-' + ' ' + FORMAT(ExpectedSalesInMonth) + ' ' + 'MT,  Achieved Last Month,' + ' ' +
                    FORMAT(PreviousMonthSale) + ' ' + 'MT,  Sampoorna Feeds.';
                    //SendSMS(SalespersonPurchaser."Phone No.", SMSContent, 'MSZ', '1307162142455677764');
                    NumberList := SalespersonPurchaser."Phone No.".Split(',');
                    foreach Number in NumberList do begin
                        SMSDetail.APISMSSingalNo(Number, SMSContent, '', SalespersonPurchaser.Code, '1307162142455677764');// Airtel
                    end;
                END;
            //SendSMS('9313349945',SMSContent,'MSZ');
            UNTIL SalespersonPurchaser.NEXT = 0;
        END;

        SalespersonPurchaser.RESET;
        SalespersonPurchaser.SETRANGE(SalespersonPurchaser.Blocked, FALSE);
        SalespersonPurchaser.SETRANGE(SalespersonPurchaser."Responsibility Center", 'CATTLE');
        //SalespersonPurchaser.SetRange(SalespersonPurchaser.Code, 'SAM2178');
        IF SalespersonPurchaser.FINDSET THEN BEGIN
            REPEAT
                Clear(SalesPer);
                CalulateSaleValueforCattle(SalespersonPurchaser.Code);
                if SalespersonPurchaser."Phone No." <> '' then begin
                    SalesPer := 0;
                    If (TotalCattleSaleAsOnDate <> 0) and (CattleSalesTarget <> 0) Then
                        SalesPer := Round((ABS(TotalCattleSaleAsOnDate) / CattleSalesTarget) * 100);
                    NumberList := SalespersonPurchaser."Phone No.".Split(',');
                    foreach Number in NumberList do begin
                        WhatsappFunction.AirtelWhatssAppAPI(WhatsappFunction.WhatsupSmsforCattleSales(Number, SalespersonPurchaser.Name, WorkDate(), CattleSalesTarget, ABS(TotalCattleSaleAsOnDate), SalesPer, '01kj9m9gzs29vwbztkxvq4y3a1'));
                    END;
                end;
            //SendSMS('9313349945',SMSContent,'MSZ');
            UNTIL SalespersonPurchaser.NEXT = 0;
        END;

    end;

    procedure SendSMSToTeam()
    var
        SMSContent: Text;
        TeamSalesperson: Record 5084;
        Team: Record 5083;
        SalesPer: Decimal;
        SMSDetail: Codeunit "SMS Details";
        NumberList: List of [Text];
        Number: Text;
    begin
        // SEND SMS TO TEAM
        Team.RESET;
        // Team.SetRange(Code, 'AMAN');
        IF Team.FINDSET THEN BEGIN
            REPEAT
                TeamSalesperson.RESET;
                TeamSalesperson.SETRANGE(TeamSalesperson."Team Code", Team.Code);
                //       TeamSalesperson.SETRANGE(TeamSalesperson."Team Code", 'BIHAR');
                IF TeamSalesperson.FINDFIRST THEN BEGIN
                    SMSSetup.GET;
                    CalulateTeamSaleValue(Team.Code);
                    if Team."Team Phone No." <> '' then begin
                        SMSContent := 'Hi,' + ' ' + Team.Name + ' ' + ' Total  Achieved As on  ' + ' ' + FORMAT(ReportDate) + ' ' + FORMAT(TotalSaleAsOnDateTeam) + ' ' + 'MT  Proj This Month-' + ' ' + FORMAT(ExpectedSalesInMonthTeam) + ' ' + 'MT,  Achieved Last Month,' + ' ' +
                        FORMAT(PreviousMonthSaleTeam) + ' ' + 'MT,  Sampoorna Feeds.';
                        //SendSMS(Team."Team Phone No.", SMSContent, 'MSZ', '1307162142455677764');
                        NumberList := Team."Team Phone No.".Split(',');
                        foreach Number in NumberList do begin
                            SMSDetail.APISMSSingalNo(Number, SMSContent, '', Team.Code, '1307162142455677764');// Airtel
                        END;
                    end;
                END;
            UNTIL Team.NEXT = 0;
        END;

        Team.RESET;
        Team.SetRange("Team Type", Team."Team Type"::Cattle);
        //Team.SetRange(Code, 'SUMIT');
        IF Team.FINDSET THEN BEGIN
            REPEAT
                TeamSalesperson.RESET;
                TeamSalesperson.SETRANGE(TeamSalesperson."Team Code", Team.Code);
                //       TeamSalesperson.SETRANGE(TeamSalesperson."Team Code", 'BIHAR');
                IF TeamSalesperson.FINDFIRST THEN BEGIN
                    SMSSetup.GET;
                    Clear(SalesPer);
                    CalulateCattleTeamSaleValue(Team.Code);
                    if Team."Team Phone No." <> '' then begin
                        SalesPer := 0;
                        if (TotalCattleSaleAsOnDateTeam <> 0) and (CattleTeamTarget <> 0) Then
                            SalesPer := Round((ABS(TotalCattleSaleAsOnDateTeam) / CattleTeamTarget) * 100);
                        NumberList := Team."Team Phone No.".Split(',');
                        foreach Number in NumberList do begin
                            WhatsappFunction.AirtelWhatssAppAPI(WhatsappFunction.WhatsupSmsforCattleSales(Number, Team.Name, WorkDate(), CattleTeamTarget, ABS(TotalCattleSaleAsOnDateTeam), SalesPer, '01kj9m9gzs29vwbztkxvq4y3a1'));
                        END;
                    END;
                END;
            UNTIL Team.NEXT = 0;
        END;


    end;

    local procedure CalulateTeamSaleValue(TeamCode: Code[50])
    var
        ItemLedgerEntry: Record 32;
        SalesShipmentHeader: Record 110;
        TeamSalesperson: Record 5084;
        ReturnReceiptHeader: Record "Return Receipt Header";
        SMSDetail: Codeunit "SMS Details";
    begin
        ReportDate := CALCDATE('-1D', WORKDATE);
        ExpectedSalesInMonthTeam := 0;
        TotalSaleAsOnDateTeam := 0;
        PreviousMonthSaleTeam := 0;
        EndDate := CALCDATE('CM', ReportDate);
        StartDate := CALCDATE('-CM', ReportDate);
        PreEndDate := CALCDATE('CM', CALCDATE('-1M', ReportDate));
        PreStartDate := CALCDATE('-CM', CALCDATE('-1M', ReportDate));
        //MESSAGE('%1,%2,%3,%4', StartDate, EndDate, PreStartDate, PreEndDate);
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", StartDate, ReportDate);
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Sale);
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item Type", ItemLedgerEntry."Item Type"::Feed);
        IF ItemLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                SalesShipmentHeader.RESET;
                SalesShipmentHeader.SETRANGE(SalesShipmentHeader."No.", ItemLedgerEntry."Document No.");
                IF SalesShipmentHeader.FINDFIRST THEN BEGIN
                    TeamSalesperson.RESET;
                    TeamSalesperson.SETRANGE(TeamSalesperson."Team Code", TeamCode);
                    IF TeamSalesperson.FINDSET THEN BEGIN
                        REPEAT
                            IF SalesShipmentHeader."Salesperson Code" = TeamSalesperson."Salesperson Code" THEN
                                TotalSaleAsOnDateTeam += ItemLedgerEntry.Quantity;
                        UNTIL TeamSalesperson.NEXT = 0;
                    END;
                END;
                ReturnReceiptHeader.RESET;
                ReturnReceiptHeader.SETRANGE(ReturnReceiptHeader."No.", ItemLedgerEntry."Document No.");
                IF ReturnReceiptHeader.FINDFIRST THEN BEGIN
                    TeamSalesperson.RESET;
                    TeamSalesperson.SETRANGE(TeamSalesperson."Team Code", TeamCode);
                    IF TeamSalesperson.FINDSET THEN BEGIN
                        REPEAT
                            IF ReturnReceiptHeader."Salesperson Code" = TeamSalesperson."Salesperson Code" THEN
                                TotalSaleAsOnDateTeam += ItemLedgerEntry.Quantity;
                        UNTIL TeamSalesperson.NEXT = 0;
                    END;
                END;
            UNTIL ItemLedgerEntry.NEXT = 0;
        END;
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", PreStartDate, PreEndDate);
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Sale);
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item Type", ItemLedgerEntry."Item Type"::Feed);
        IF ItemLedgerEntry.FINDSET THEN BEGIN
            REPEAT
                SalesShipmentHeader.RESET;
                SalesShipmentHeader.SETRANGE(SalesShipmentHeader."No.", ItemLedgerEntry."Document No.");
                IF SalesShipmentHeader.FINDFIRST THEN BEGIN
                    TeamSalesperson.RESET;
                    TeamSalesperson.SETRANGE(TeamSalesperson."Team Code", TeamCode);
                    IF TeamSalesperson.FINDSET THEN BEGIN
                        REPEAT
                            IF SalesShipmentHeader."Salesperson Code" = TeamSalesperson."Salesperson Code" THEN
                                PreviousMonthSaleTeam += ItemLedgerEntry.Quantity;
                        UNTIL TeamSalesperson.NEXT = 0;
                    END;
                END;
                ReturnReceiptHeader.RESET;
                ReturnReceiptHeader.SETRANGE(ReturnReceiptHeader."No.", ItemLedgerEntry."Document No.");
                IF ReturnReceiptHeader.FINDFIRST THEN BEGIN
                    TeamSalesperson.RESET;
                    TeamSalesperson.SETRANGE(TeamSalesperson."Team Code", TeamCode);
                    IF TeamSalesperson.FINDSET THEN BEGIN
                        REPEAT
                            IF ReturnReceiptHeader."Salesperson Code" = TeamSalesperson."Salesperson Code" THEN
                                PreviousMonthSaleTeam += ItemLedgerEntry.Quantity;
                        UNTIL TeamSalesperson.NEXT = 0;
                    END;
                END;
            UNTIL ItemLedgerEntry.NEXT = 0;
        END;
        IF TotalSaleAsOnDateTeam <> 0 THEN
            ExpectedSalesInMonthTeam := (TotalSaleAsOnDateTeam / DATE2DMY(ReportDate, 1)) * DATE2DMY(EndDate, 1);
        TotalSaleAsOnDateTeam := ROUND(ABS(TotalSaleAsOnDateTeam / 1000), 0.01, '<');
        PreviousMonthSaleTeam := ROUND(ABS(PreviousMonthSaleTeam / 1000), 0.01, '<');
        ExpectedSalesInMonthTeam := ROUND(ABS(ExpectedSalesInMonthTeam / 1000), 0.01, '<');
        //MESSAGE('%1,%2,%3', TotalSaleAsOnDate, ExpectedSalesInMonth, PreviousMonthSale);
    end;

    local procedure CalulateCattleTeamSaleValue(TeamCode: Code[50])
    var
        ItemLedgerEntry: Record 32;
        SalesShipmentHeader: Record 110;
        TeamSalesperson: Record 5084;
        SalesTarget: Record "Sales Person Target";
    begin
        ReportDate := CALCDATE('-1D', WORKDATE);
        ExpectedSalesInMonthTeam := 0;
        TotalSaleAsOnDateTeam := 0;
        PreviousMonthSaleTeam := 0;
        EndDate := CALCDATE('CM', ReportDate);
        StartDate := CALCDATE('-CM', ReportDate);
        PreEndDate := CALCDATE('CM', CALCDATE('-1M', ReportDate));
        PreStartDate := CALCDATE('-CM', CALCDATE('-1M', ReportDate));
        //MESSAGE('%1,%2,%3,%4', StartDate, EndDate, PreStartDate, PreEndDate);
        Clear(TotalCattleSaleAsOnDateTeam);
        Clear(CattleTeamTarget);
        TeamSalesperson.RESET;
        TeamSalesperson.SETRANGE(TeamSalesperson."Team Code", TeamCode);
        IF TeamSalesperson.FINDSET THEN BEGIN
            REPEAT
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", StartDate, ReportDate);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item Type", ItemLedgerEntry."Item Type"::Feed);
                ItemLedgerEntry.SetRange(ItemLedgerEntry."Salesperson/Purchaser", TeamSalesperson."Salesperson Code");
                IF ItemLedgerEntry.FINDSET THEN BEGIN
                    REPEAT
                        TotalCattleSaleAsOnDateTeam += (ItemLedgerEntry.Quantity / 1000);
                    UNTIL ItemLedgerEntry.NEXT = 0;
                end;
                SalesTarget.Reset();
                SalesTarget.SetRange("Sales Person Code", TeamSalesperson."Salesperson Code");
                SalesTarget.SetRange("Start Date", StartDate);
                SalesTarget.SetRange("End Date", EndDate);
                If SalesTarget.FindFirst() then
                    repeat
                        CattleTeamTarget += SalesTarget."Qty In MT";
                    UNTIL SalesTarget.Next() = 0;

            UNTIL TeamSalesperson.NEXT = 0;
        end;

    end;

    procedure SendSMSToManegment()
    var
        SMSContent: Text;
        TeamSalesperson: Record 5084;
        Team: Record 5083;
        TeamType: Option " ",Cattle,Poultry;
        SMSDetail: Codeunit "SMS Details";
        NumberList: List of [Text];
        Number: Text;

    begin
        ReportDate := CALCDATE('-1D', WORKDATE);
        //  SEND SMS TO MANEGMENT
        Team.RESET;
        //   Team.SetRange(Code, 'AMAN');
        IF Team.FINDSET THEN BEGIN
            REPEAT
                IF (Team."Team Type" = Team."Team Type"::Cattle) AND (Team."Managment Phone No." <> '') THEN BEGIN
                    IsTeamCattleExist := TRUE;
                    TeamCattleNo := Team."Managment Phone No.";
                END ELSE
                    IF (Team."Team Type" = Team."Team Type"::Poultry) AND (Team."Managment Phone No." <> '') THEN BEGIN
                        IsTeamPoultryExist := TRUE;
                        TeampoultryNo := Team."Managment Phone No.";
                    END;
                //MESSAGE('%1',IsTeamCattleExist);
                CalculateManegmentValue(Team.Code, Team."Team Type");
            UNTIL Team.NEXT = 0;
        END;

        CattleExpValue := (CattleAsonValue / DATE2DMY(ReportDate, 1)) * DATE2DMY(EndDate, 1);
        CattleAsonValue := ROUND(ABS(CattleAsonValue / 1000), 0.001, '<');
        CattlePrevVAlue := ROUND(ABS(CattlePrevVAlue / 1000), 0.001, '<');
        CattleExpValue := ROUND(ABS(CattleExpValue / 1000), 0.001, '<');

        PolExpValue := (PulAsonValue / DATE2DMY(ReportDate, 1)) * DATE2DMY(EndDate, 1);
        PulAsonValue := ROUND(ABS(PulAsonValue / 1000), 0.001, '<');
        PolPreValue := ROUND(ABS(PolPreValue / 1000), 0.001, '<');
        PolExpValue := ROUND(ABS(PolExpValue / 1000), 0.001, '<');
        //MESSAGE('%1,%2,%3,%4',CattleAsonValue,PulAsonValue,CattleExpValue,PolExpValue);
        IF (IsTeamCattleExist = TRUE) AND (TeamCattleNo <> '') THEN BEGIN
            SMSContent := '';
            SMSContent := 'Hi,' + ' ' + ' Total  Achieved As on  ' + ' ' + FORMAT(ReportDate) + ' ' + FORMAT(CattleAsonValue) + ' ' + 'MT  Proj This Month-' + ' ' + FORMAT(CattleExpValue) + ' ' + 'MT,  Achieved Last Month,' + ' ' +
            FORMAT(CattlePrevVAlue) + ' ' + 'MT,  Sampoorna Feeds.';
            if TeamCattleNo <> '' then begin
                NumberList := TeamCattleNo.Split(',');
                foreach Number in NumberList do begin
                    //SendSMS(Number, SMSContent, 'MSZ', '1307162142479602693');
                    SMSDetail.APISMSSingalNo(Number, SMSContent, '', '', '1307162142479602693')
                end;
            END;
            //MESSAGE(SMSContent);
        END;
        IF (IsTeamPoultryExist = TRUE) AND (TeampoultryNo <> '') THEN BEGIN
            SMSContent := '';
            SMSContent := 'Hi,' + ' ' + ' Total  Achieved As on  ' + ' ' + FORMAT(ReportDate) + ' ' + FORMAT(PulAsonValue) + ' ' + 'MT  Proj This Month-' + ' ' + FORMAT(PolExpValue) + ' ' + 'MT,  Achieved Last Month,' + ' ' +
            FORMAT(PolPreValue) + ' ' + 'MT,  Sampoorna Feeds.';
            if TeampoultryNo <> '' then begin
                NumberList := TeampoultryNo.Split(',');
                foreach Number in NumberList do begin
                    //SendSMS(Number, SMSContent, 'MSZ', '1307162142479602693');
                    SMSDetail.APISMSSingalNo(Number, SMSContent, '', '', '1307162142479602693');
                end;
            END;
            //MESSAGE(SMSContent);
        END;
    end;

    local procedure CalculateManegmentValue(TeamCode: Code[40]; TeamType: Option " ",Cattle,Poultry)
    var
        SMSContent: Text;
        TeamSalesperson: Record 5084;
        Team: Record 5083;
        SalesShipmentHeader: Record 110;
        ReturnReceiptHeader: Record "Return Receipt Header";
    begin
        EndDate := CALCDATE('CM', ReportDate);
        StartDate := CALCDATE('-CM', ReportDate);
        PreEndDate := CALCDATE('CM', CALCDATE('-1M', ReportDate));
        PreStartDate := CALCDATE('-CM', CALCDATE('-1M', ReportDate));
        CASE TeamType OF
            TeamType::Cattle:
                BEGIN
                    ItemLedgerEntry.RESET;
                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", StartDate, ReportDate);
                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item Type", ItemLedgerEntry."Item Type"::Feed);
                    IF ItemLedgerEntry.FINDSET THEN BEGIN
                        REPEAT
                            SalesShipmentHeader.RESET;
                            SalesShipmentHeader.SETRANGE(SalesShipmentHeader."No.", ItemLedgerEntry."Document No.");
                            IF SalesShipmentHeader.FINDFIRST THEN BEGIN
                                TeamSalesperson.RESET;
                                TeamSalesperson.SETRANGE(TeamSalesperson."Team Code", TeamCode);
                                IF TeamSalesperson.FINDSET THEN BEGIN
                                    REPEAT
                                        IF SalesShipmentHeader."Salesperson Code" = TeamSalesperson."Salesperson Code" THEN
                                            CattleAsonValue += ItemLedgerEntry.Quantity;
                                    UNTIL TeamSalesperson.NEXT = 0;
                                END;
                            END;
                            ReturnReceiptHeader.RESET;
                            ReturnReceiptHeader.SETRANGE(ReturnReceiptHeader."No.", ItemLedgerEntry."Document No.");
                            IF ReturnReceiptHeader.FINDFIRST THEN BEGIN
                                TeamSalesperson.RESET;
                                TeamSalesperson.SETRANGE(TeamSalesperson."Team Code", TeamCode);
                                IF TeamSalesperson.FINDSET THEN BEGIN
                                    REPEAT
                                        IF ReturnReceiptHeader."Salesperson Code" = TeamSalesperson."Salesperson Code" THEN
                                            CattleAsonValue += ItemLedgerEntry.Quantity;
                                    UNTIL TeamSalesperson.NEXT = 0;
                                END;
                            END;
                        UNTIL ItemLedgerEntry.NEXT = 0;
                    END;
                    ItemLedgerEntry.RESET;
                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", PreStartDate, PreEndDate);
                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item Type", ItemLedgerEntry."Item Type"::Feed);
                    IF ItemLedgerEntry.FINDSET THEN BEGIN
                        REPEAT
                            SalesShipmentHeader.RESET;
                            SalesShipmentHeader.SETRANGE(SalesShipmentHeader."No.", ItemLedgerEntry."Document No.");
                            IF SalesShipmentHeader.FINDFIRST THEN BEGIN
                                TeamSalesperson.RESET;
                                TeamSalesperson.SETRANGE(TeamSalesperson."Team Code", TeamCode);
                                IF TeamSalesperson.FINDSET THEN BEGIN
                                    REPEAT
                                        IF SalesShipmentHeader."Salesperson Code" = TeamSalesperson."Salesperson Code" THEN
                                            CattlePrevVAlue += ItemLedgerEntry.Quantity;
                                    UNTIL TeamSalesperson.NEXT = 0;
                                END;
                            END;
                            ReturnReceiptHeader.RESET;
                            ReturnReceiptHeader.SETRANGE(ReturnReceiptHeader."No.", ItemLedgerEntry."Document No.");
                            IF ReturnReceiptHeader.FINDFIRST THEN BEGIN
                                TeamSalesperson.RESET;
                                TeamSalesperson.SETRANGE(TeamSalesperson."Team Code", TeamCode);
                                IF TeamSalesperson.FINDSET THEN BEGIN
                                    REPEAT
                                        IF ReturnReceiptHeader."Salesperson Code" = TeamSalesperson."Salesperson Code" THEN
                                            CattlePrevVAlue += ItemLedgerEntry.Quantity;
                                    UNTIL TeamSalesperson.NEXT = 0;
                                END;
                            END;
                        UNTIL ItemLedgerEntry.NEXT = 0;
                    END;

                END;
            TeamType::Poultry:
                BEGIN
                    ItemLedgerEntry.RESET;
                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", StartDate, ReportDate);
                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item Type", ItemLedgerEntry."Item Type"::Feed);
                    IF ItemLedgerEntry.FINDSET THEN BEGIN
                        REPEAT
                            SalesShipmentHeader.RESET;
                            SalesShipmentHeader.SETRANGE(SalesShipmentHeader."No.", ItemLedgerEntry."Document No.");
                            IF SalesShipmentHeader.FINDFIRST THEN BEGIN
                                TeamSalesperson.RESET;
                                TeamSalesperson.SETRANGE(TeamSalesperson."Team Code", TeamCode);
                                IF TeamSalesperson.FINDSET THEN BEGIN
                                    REPEAT
                                        IF SalesShipmentHeader."Salesperson Code" = TeamSalesperson."Salesperson Code" THEN
                                            PulAsonValue += ItemLedgerEntry.Quantity;
                                    UNTIL TeamSalesperson.NEXT = 0;
                                END;
                            END;
                            ReturnReceiptHeader.RESET;
                            ReturnReceiptHeader.SETRANGE(ReturnReceiptHeader."No.", ItemLedgerEntry."Document No.");
                            IF ReturnReceiptHeader.FINDFIRST THEN BEGIN
                                TeamSalesperson.RESET;
                                TeamSalesperson.SETRANGE(TeamSalesperson."Team Code", TeamCode);
                                IF TeamSalesperson.FINDSET THEN BEGIN
                                    REPEAT
                                        IF ReturnReceiptHeader."Salesperson Code" = TeamSalesperson."Salesperson Code" THEN
                                            PulAsonValue += ItemLedgerEntry.Quantity;
                                    UNTIL TeamSalesperson.NEXT = 0;
                                END;
                            END;
                        UNTIL ItemLedgerEntry.NEXT = 0;
                    END;
                    ItemLedgerEntry.RESET;
                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Posting Date", PreStartDate, PreEndDate);
                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item Type", ItemLedgerEntry."Item Type"::Feed);
                    IF ItemLedgerEntry.FINDSET THEN BEGIN
                        REPEAT
                            SalesShipmentHeader.RESET;
                            SalesShipmentHeader.SETRANGE(SalesShipmentHeader."No.", ItemLedgerEntry."Document No.");
                            IF SalesShipmentHeader.FINDFIRST THEN BEGIN
                                TeamSalesperson.RESET;
                                TeamSalesperson.SETRANGE(TeamSalesperson."Team Code", TeamCode);
                                IF TeamSalesperson.FINDSET THEN BEGIN
                                    REPEAT
                                        IF SalesShipmentHeader."Salesperson Code" = TeamSalesperson."Salesperson Code" THEN
                                            PolPreValue += ItemLedgerEntry.Quantity;
                                    UNTIL TeamSalesperson.NEXT = 0;
                                END;
                            END;
                            ReturnReceiptHeader.RESET;
                            ReturnReceiptHeader.SETRANGE(ReturnReceiptHeader."No.", ItemLedgerEntry."Document No.");
                            IF ReturnReceiptHeader.FINDFIRST THEN BEGIN
                                TeamSalesperson.RESET;
                                TeamSalesperson.SETRANGE(TeamSalesperson."Team Code", TeamCode);
                                IF TeamSalesperson.FINDSET THEN BEGIN
                                    REPEAT
                                        IF ReturnReceiptHeader."Salesperson Code" = TeamSalesperson."Salesperson Code" THEN
                                            PolPreValue += ItemLedgerEntry.Quantity;
                                    UNTIL TeamSalesperson.NEXT = 0;
                                END;
                            END;
                        UNTIL ItemLedgerEntry.NEXT = 0;
                    END;
                END;
        END;
        // IF TotalSaleAsOnDateTeam <> 0 THEN
        // ExpectedSalesInMonthTeam := (TotalSaleAsOnDateTeam/DATE2DMY(ReportDate,1))*DATE2DMY(EndDate,1);
        // TotalSaleAsOnDateTeam :=  ROUND(ABS(TotalSaleAsOnDateTeam/1000),0.01,'<');
        // PreviousMonthSaleTeam :=  ROUND(ABS(PreviousMonthSaleTeam/1000),0.01,'<');
        // ExpectedSalesInMonthTeam :=  ROUND(ABS(ExpectedSalesInMonthTeam/1000),0.01,'<');
        // //MESSAGE('%1,%2,%3',TotalSaleAsOnDate,ExpectedSalesInMonth,PreviousMonthSale);
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterPostVend', '', false, false)]
    local procedure OnAfterPostVendPayment(var GenJournalLine: Record 81; Balancing: Boolean; var TempGLEntryBuf: Record 17 temporary; var NextEntryNo: Integer; var NextTransactionNo: Integer)
    var
        SmsGenJournalLine: Record 81;
        Vendor: Record 23;
        Text001: Label 'Vendor Phone No Not Found';
        SMSBody: Label 'Today we have initiated payment of INR %1 to your Bank A/c No XXXX%2 through %3 With %4 %5 Dated %6. From :- SAMPOORNA FEEDS PVT.LTD';
        SMSFomat: Text;
        SalesReceivablesSetup: Record 311;
        StrLength: Integer;
        Posision: Integer;
        LastFourDigit: Code[10];
        PayMode: Code[10];
        LineNarration: Text[30];
        Companyinfo: Record "Company Information";
        Page: Page 233;
        WhatsAppSMS: Codeunit "WhatsApp Function";
        SMSDetail: Codeunit "SMS Details";
    begin
        Companyinfo.get;
        If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] Then Begin
            PayMode := '';
            SmsGenJournalLine.RESET;
            SmsGenJournalLine.SETRANGE(SmsGenJournalLine."Document No.", GenJournalLine."Document No.");
            SmsGenJournalLine.SETRANGE(SmsGenJournalLine."Document Type", SmsGenJournalLine."Document Type"::Payment);
            SmsGenJournalLine.SETRANGE(SmsGenJournalLine."Source Code", 'BANKPAYTV');
            SmsGenJournalLine.SETRANGE(SmsGenJournalLine."Account Type", SmsGenJournalLine."Account Type"::Vendor);
            SmsGenJournalLine.SETRANGE(SmsGenJournalLine."Line No.", GenJournalLine."Line No.");
            IF SmsGenJournalLine.FINDFIRST THEN BEGIN
                Vendor.RESET;
                IF Vendor.GET(SmsGenJournalLine."Account No.") THEN BEGIN
                    IF Vendor."Phone No." <> '' THEN BEGIN
                        SMSFomat := SMSBody;
                        // IF GenJournalLine."Payment Mode" = GenJournalLine."Payment Mode"::Cheque THEN BEGIN
                        //     PayMode := 'Cheque No.';
                        //     LastFourDigit := '';
                        // END ELSE BEGIN
                        PayMode := 'UTR';
                        StrLength := STRLEN(SmsGenJournalLine."Recipient Bank Account No.");
                        LastFourDigit := COPYSTR(SmsGenJournalLine."Recipient Bank Account No.", (StrLength - 4 + 1), StrLength);
                        // END;
                        LineNarration := COPYSTR(SmsGenJournalLine."Line Narration1", 1, 30);
                        SMSFomat := STRSUBSTNO(SMSFomat, SmsGenJournalLine.Amount, LastFourDigit, SmsGenJournalLine."Payment Mode", PayMode, LineNarration, SmsGenJournalLine."Posting Date");
                        //SendSMS(Vendor."Phone No.", SMSFomat, '', '1307165932626618995');
                        //MESSAGE(SMSFomat);
                        //SendSMS(Vendor."Phone No.", SMSFomat, '', '1307173234834165493');
                        // WhatsAppSMS.SendSMS(Vendor."Phone No.", SMSFomat, '', Vendor."No.", '1307173234834165493');
                        SMSDetail.APISMSSingalNo(Vendor."Phone No.", SMSFomat, '', Vendor."No.", '1307173234834165493'); //Airtel
                        //SendSMS('9313349945',SMSFomat,'');
                        // MESSAGE(SMSFomat)
                    END ELSE
                        MESSAGE(Text001);
                END;
            END;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterPostVend', '', false, false)]
    local procedure OnAfterPostVendRefund(var GenJournalLine: Record 81; Balancing: Boolean; var TempGLEntryBuf: Record 17 temporary; var NextEntryNo: Integer; var NextTransactionNo: Integer)
    var
        SmsGenJournalLine: Record 81;
        Vendor: Record 23;
        Text001: Label 'Vendor Phone No Not Found';

        SMSBody: Label 'Payment of INR %1 to your Account ,  returned back on %2. From :- SAMPOORNA FEEDS PVT. LTD';
        SMSFomat: Text;
        SalesReceivablesSetup: Record 311;
        StrLength: Integer;
        Posision: Integer;
        LastFourDigit: Code[10];
        CompanyInfo: Record "Company Information";
        WhatsAppSMS: Codeunit "WhatsApp Function";
        SMSDetail: Codeunit "SMS Details";
    begin
        CompanyInfo.Get;
        // VENDOR PAYMENT REC
        //SalesReceivablesSetup.GET;
        //IF NOT SalesReceivablesSetup."Send Sms" THEN BEGIN
        If CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] Then Begin
            SmsGenJournalLine.RESET;
            SmsGenJournalLine.SETRANGE(SmsGenJournalLine."Document No.", GenJournalLine."Document No.");
            SmsGenJournalLine.SETRANGE(SmsGenJournalLine."Document Type", SmsGenJournalLine."Document Type"::Refund);
            SmsGenJournalLine.SETRANGE(SmsGenJournalLine."Source Code", 'BANKRCPTV');
            SmsGenJournalLine.SETRANGE(SmsGenJournalLine."Account Type", SmsGenJournalLine."Account Type"::Vendor);
            SmsGenJournalLine.SETRANGE(SmsGenJournalLine."Line No.", GenJournalLine."Line No.");
            IF SmsGenJournalLine.FINDFIRST THEN BEGIN
                Vendor.RESET;
                IF Vendor.GET(SmsGenJournalLine."Account No.") THEN BEGIN
                    IF Vendor."Phone No." <> '' THEN BEGIN
                        SMSFomat := SMSBody;
                        SMSFomat := STRSUBSTNO(SMSFomat, ABS(SmsGenJournalLine.Amount), SmsGenJournalLine."Posting Date");
                        //SendSMS(Vendor."Phone No.", SMSFomat, '', '1307165932626618995');
                        //WhatsAppSMS.SendSMS(Vendor."Phone No.", SMSFomat, '', Vendor."No.", '1307165932626618995');
                        SMSDetail.APISMSSingalNo(Vendor."Phone No.", SMSFomat, '', Vendor."No.", '1307165932626618995');// Airtel
                        //MESSAGE(SMSFomat)
                    END ELSE
                        MESSAGE(Text001);
                END;
            END;
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterPostCust', '', false, false)]
    local procedure OnAfterPostCust(var GenJournalLine: Record 81; Balancing: Boolean; var TempGLEntryBuf: Record 17 temporary; var NextEntryNo: Integer; var NextTransactionNo: Integer)
    var
        SmsGenJournalLine: Record 81;
        Salesperson: Record 13;
        SMSFomat: Text;
        SalesReceivablesSetup: Record 311;
        Text001: Label 'Sales Person Phone No Not Found';
        SalesPSMSBody: Label 'Dear %1, Payment from %2 of Rs %3 on %4 has been received and after credit to the account the balance is Rs. %5, From-Sampoorna Feeds Pvt Ltd.';
        //SMSBody: Label 'Dear %1, Payment from %2 of Rs %3 on %4 has been received and after credit to the account the balance is Rs. %5, From-SFPL.';
        CustSMSBody: Label 'Dear %1, Thanks for the payment, We have Received Payment Rs:- %2/-. From:- Sampoorna Feeds Pvt.Ltd.';
        Customer: Record 18;
        CustomerName: Text;
        CompanyInfo: Record "Company Information";
        WhatsAppSMS: Codeunit "WhatsApp Function";
        SMSDetail: Codeunit "SMS Details";
        NumberList: List of [Text];
        Number: Text;
    begin
        CompanyInfo.Get;
        //SalesReceivablesSetup.GET;
        //IF NOT SalesReceivablesSetup."Send Sms" THEN BEGIN
        if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] Then Begin
            SmsGenJournalLine.RESET;
            SmsGenJournalLine.SETRANGE(SmsGenJournalLine."Document No.", GenJournalLine."Document No.");
            SmsGenJournalLine.SETRANGE(SmsGenJournalLine."Document Type", SmsGenJournalLine."Document Type"::Payment);
            SmsGenJournalLine.SETRANGE(SmsGenJournalLine."Source Code", 'BANKRCPTV');
            SmsGenJournalLine.SETRANGE(SmsGenJournalLine."Account Type", SmsGenJournalLine."Account Type"::Customer);
            SmsGenJournalLine.SETRANGE(SmsGenJournalLine."Line No.", GenJournalLine."Line No.");
            IF SmsGenJournalLine.FINDFIRST THEN BEGIN

                IF Customer.GET(SmsGenJournalLine."Account No.") THEN BEGIN
                    Customer.CALCFIELDS(Balance);
                    CustomerName := COPYSTR(Customer.Name, 1, 30);
                    SMSFomat := SalesPSMSBody;
                    SMSFomat := STRSUBSTNO(SMSFomat, Salesperson.Name, CustomerName, ABS(SmsGenJournalLine.Amount), SmsGenJournalLine."Posting Date", Customer.Balance);
                    if Customer."Payment SMS" Then
                        SMSDetail.APISMSMultipleNo(Customer."Phone No.", Customer."Mobile Phone No.", '', '', '', '', '', STRSUBSTNO(CustSMSBody, CustomerName, ABS(SmsGenJournalLine.Amount)), '', Customer."No.", '1307174670699868794');// Airtel  
                    if Customer."Customer Status" = Customer."Customer Status"::"Suit Filed Cases" then begin
                        //SMSDetail.APISMSSingalNo('9875994463', SMSFomat, '', Customer."No.", '1307165932626618995');// Airtel
                        SMSDetail.APISMSSingalNo('7087016792', SMSFomat, '', Customer."No.", '1307165932626618995');// Airtel

                    end;
                end;
                Salesperson.RESET;
                IF Salesperson.GET(SmsGenJournalLine."Salespers./Purch. Code") THEN BEGIN
                    SalesPersonPhone := Salesperson."Phone No.";
                    IF (SmsGenJournalLine."Shortcut Dimension 1 Code" = 'CATTLE') or (SmsGenJournalLine."Shortcut Dimension 1 Code" = 'SWINE') THEN BEGIN
                        TeamSalesperson.RESET;
                        TeamSalesperson.SETRANGE(TeamSalesperson."Salesperson Code", SmsGenJournalLine."Salespers./Purch. Code");
                        IF TeamSalesperson.FINDFIRST THEN begin
                            TeamCode := TeamSalesperson."Team Code";
                            Team.RESET;
                            Team.SETRANGE(Team.Code, TeamCode);
                            IF Team.FINDFIRST THEN
                                TeamPhone := Team."Team Phone No.";
                        end;
                    END;
                    "PhoneNo." := SalesPersonPhone + TeamPhone;

                    //WhatsAppSMS.SendSMS(Customer."Phone No.", STRSUBSTNO(CustSMSBody, CustomerName, ABS(SmsGenJournalLine.Amount)), '', Customer."No.", '1307174670699868794');
                    if SalesPersonPhone <> '' Then
                        if Customer."Sales Person Payment SMS" Then begin
                            NumberList := SalesPersonPhone.Split(',');
                            foreach Number in NumberList do begin
                                SMSDetail.APISMSSingalNo(Number, SMSFomat, '', Customer."No.", '1307165932626618995');// Airtel
                            end;
                        end;                                                                                               //WhatsAppSMS.SendSMS(SalesPersonPhone, SMSFomat, '', Customer."No.", '1307165932626618995');
                    if TeamPhone <> '' Then begin
                        NumberList := SalesPersonPhone.Split(',');
                        foreach Number in NumberList do begin
                            SMSDetail.APISMSSingalNo(Number, SMSFomat, '', Customer."No.", '1307165932626618995');// Airtel
                        end;
                    end;                                                                                        //WhatsAppSMS.SendSMS(TeamPhone, SMSFomat, '', Customer."No.", '1307165932626618995');
                                                                                                                //MESSAGE(SMSFomat);
                                                                                                                // END ELSE
                                                                                                                //     MESSAGE(Text001);
                END;


            END;
        END;
    END;





    procedure SendSMSByURL(SmsURL: Text[1024]): Boolean
    var
        Setup: Record 50010;

        Mail: Codeunit 397;
        URL: Text[1024];
        Success: Boolean;

        WebClient: DotNet WebClient;
        SmsURL1: Text;
        len: Integer;
        gResponseMsg: Text;
        gRequestMsg: Text;
        gContent: HttpContent;
        gContentHeaders: HttpHeaders;
        gHttpClient: HttpClient;
        gHttpResponseMsg: HttpResponseMessage;
        Json: Text;
        SMSLog: Record "SMS Log";
    begin
        // HTTPRequest is an automation such as 'Microsoft XML, v6.0'.XMLHTTP

        IF (SmsURL <> '') THEN BEGIN
            SMSSetup.GET;
            CASE SMSSetup."SMS Send Type" OF
                SMSSetup."SMS Send Type"::"HTTP Request":
                    BEGIN
                        Clear(gResponseMsg);
                        gContent.GetHeaders(gContentHeaders);
                        gContentHeaders.Clear();
                        gContentHeaders.Add('Content-Type', 'application/json');
                        if gHttpClient.Post(SmsURL, gContent, gHttpResponseMsg) then begin
                            gHttpResponseMsg.Content.ReadAs(Json);
                            if gHttpResponseMsg.IsSuccessStatusCode then begin
                                //     Message('check1');
                            END;
                        END;

                        Success := TRUE;
                        EXIT(Success);
                    END;
            END;
        END;
        EXIT(FALSE);
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterInsertGlobalGLEntry', '', false, false)]
    local procedure OnAfterInsertGlobalGLEntry(var GLEntry: Record 17)
    var
        PrintGLEntry: Record 17;
        SalesReceivablesSetup: Record 311;
    begin
        /*
        *//*\alesReceivablesSetup.RESET;
        IF SalesReceivablesSetup.GET THEN;
        IF SalesReceivablesSetup."Print Report" THEN BEGIN
          PrintGLEntry.RESET;
          PrintGLEntry.SETRANGE(PrintGLEntry."Document No.",GLEntry."Document No.");
          PrintGLEntry.SETFILTER(PrintGLEntry."Source Code",'<>%1','INVTPCOST');
          IF PrintGLEntry.FINDFIRST THEN BEGIN
            REPORT.RUNMODAL(16567,TRUE,TRUE,PrintGLEntry);
            END;
        END;
        */

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnRunOnBeforeFinalizePosting', '', true, true)]
    local procedure "Sales-Post_OnRunOnBeforeFinalizePosting"
    (
        var SalesHeader: Record "Sales Header";
        var SalesShipmentHeader: Record "Sales Shipment Header";
        var SalesInvoiceHeader: Record "Sales Invoice Header";
        var SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        var ReturnReceiptHeader: Record "Return Receipt Header";
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        CommitIsSuppressed: Boolean;
        GenJnlLineExtDocNo: Code[35];
        var EverythingInvoiced: Boolean;
        GenJnlLineDocNo: Code[20];
        SrcCode: Code[10]
    )
    var
        cuSalesPost: Codeunit 80;
        // GSTManagement: Codeunit 16401;
        CU50018: Codeunit 50025;
    begin
        //    Message('%1', SalesInvoiceHeader."No.");
        if SalesInvoiceHeader."No." <> '***' then begin
            IF SalesInvoiceHeader."No." <> '' THEN BEGIN
                if SalesHeader."GST Customer Type" <> SalesHeader."GST Customer Type"::Unregistered then begin
                    if SalesHeader."Invoice Type" = SalesHeader."Invoice Type"::Taxable then begin
                        IF CheckGST(SalesInvoiceHeader."No.") THEN BEGIN
                            SalesInvoiceHeader.RESET;
                            SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."No.", SalesInvoiceHeader."No.");
                            IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                                CLEAR(cuSalesPost);
                                CU50018.GenerateSalesEInvoice(SalesInvoiceHeader);
                            END;
                        END;
                    END;
                end;
            END;
        END;
        if SalesCrMemoHeader."No." <> '***' then begin
            if SalesCrMemoHeader."No." <> '' then begin
                if SalesCrMemoHeader."GST Customer Type" <> SalesCrMemoHeader."GST Customer Type"::Unregistered then begin
                    if SalesCrMemoHeader."Invoice Type" = SalesCrMemoHeader."Invoice Type"::Taxable then begin
                        if CheckGST(SalesCrMemoHeader."No.") then begin
                            SalesCrMemoHeader.Reset;
                            SalesCrMemoHeader.SetRange(SalesCrMemoHeader."No.", SalesCrMemoHeader."No.");
                            if SalesCrMemoHeader.FindFirst then begin
                                Clear(cuSalesPost);
                                CU50018.GenerateSalesCrMemoEInvoice(SalesCrMemoHeader);
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    //PRU SH 25082022


    local procedure CheckGST(DocNo: Code[20]): Boolean
    var
        recSalesInvoiceLines: Record 113;
        decInvoiceValue: Decimal;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        IGST: Decimal;
        CGST: Decimal;
        SGST: Decimal;
    begin
        Clear(IGST);
        Clear(CGST);
        Clear(SGST);
        CLEAR(decInvoiceValue);
        recSalesInvoiceLines.RESET;
        recSalesInvoiceLines.SETRANGE("Document No.", DocNo);
        recSalesInvoiceLines.SETFILTER(Quantity, '<>%1', 0);
        if recSalesInvoiceLines.FINDFIRST then begin
            repeat

                //  decInvoiceValue += recSalesInvoiceLines."Total GST Amount";
                DetailedGSTLedgerEntry.RESET;
                DetailedGSTLedgerEntry.SETRANGE(DetailedGSTLedgerEntry."Document No.", recSalesInvoiceLines."Document No.");
                //  DetailedGSTLedgerEntry.SETRANGE(DetailedGSTLedgerEntry."Document Type", DetailedGSTLedgerEntry."Document Type"::Invoice);
                DetailedGSTLedgerEntry.SETRANGE(DetailedGSTLedgerEntry."Document Line No.", recSalesInvoiceLines."Line No.");
                IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
                    REPEAT
                        IF DetailedGSTLedgerEntry."GST Component Code" = 'IGST' THEN
                            IGST += ABS(DetailedGSTLedgerEntry."GST Amount");
                        IF DetailedGSTLedgerEntry."GST Component Code" = 'CGST' THEN
                            CGST += ABS(DetailedGSTLedgerEntry."GST Amount");
                        IF DetailedGSTLedgerEntry."GST Component Code" = 'SGST' THEN
                            SGST += ABS(DetailedGSTLedgerEntry."GST Amount");
                    UNTIL DetailedGSTLedgerEntry.NEXT = 0;
                END;
            UNTIL recSalesInvoiceLines.NEXT = 0;
        end;
        decInvoiceValue := CGST + SGST + IGST;
        //   Message('%1', decInvoiceValue);
        IF decInvoiceValue <> 0 THEN
            EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;


    procedure SaveReportAsPDF(FromDate: Date; ToDate: Date; VendorNo: Code[1024])
    var
        Vendor: Record 23;
        PDFVendor: Record 23;
    begin
        Vendor.RESET;
    end;

    local procedure ReplaceString(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;


    procedure SendSalesSMS()
    var
        CustomerPhone: Text;
        SMSBody: Text[1024];
        SMSBody1: Text[1024];
        CustomerInfo: Record 18;
        // SMSTxt: Label 'A/c  "%1" purchased live birds from SFPL against DC - %2 , %3  %4  "@" Rs. %5/%6 Amount Rs. %7 and Birds %8 %9. Thank you.&priority=ndnd&stype=normal';
        Checkbool: Boolean;
        Item: Record Item;
        //SMSAPI: Label 'https://pgapi.vispl.in/fe/api/v1/multiSend?username=samprnpg.trans&password=UCjvl&unicode=false&from=SFPLCO&to=';
        SMSAPI: Text;
        EndSMS: Label '&dltContentId=1307165932681769800';
        ProjSales: Decimal;
        YesterdaySales: Decimal;
        TotalProjSales: Decimal;
        TotalYestSales: Decimal;
        InteSalesProj: Decimal;
        InteSalesYesterday: Decimal;
        TotalInteSalesProj: Decimal;
        TotalInteSalesYesterday: Decimal;
        SalesandRec: Record "Sales & Receivables Setup";

    Begin

        SMSAPI := 'https://pgapi.vispl.in/fe/api/v1/multiSend?username=samprnpg.trans&password=' + SalesandRec."SMS Password" + '&unicode=false&from=' + SalesandRec."Sender ID" + '&to=';
        //CustomerPhone := '9999324784';
        Clear(ProjSales);
        Clear(YesterdaySales);
        Clear(SMSBody);
        Clear(TotalProjSales);
        Clear(TotalYestSales);
        Clear(InteSalesProj);
        Clear(InteSalesYesterday);
        Clear(TotalInteSalesProj);
        Clear(TotalInteSalesYesterday);
        SMSBody := SMSAPI + CustomerPhone + '&text=' + ' ';
        Item.Reset();
        Item.SetRange(Blocked, false);
        Item.SetRange("Item Type", Item."Item Type"::Feed);
        Item.SetRange(SMSItemType, Item.SMSItemType::BF);
        if Item.FindSet() then
            repeat
                CreateILEQuanSum(Item."No.", ProjSales, YesterdaySales, InteSalesProj, InteSalesYesterday);
                TotalProjSales += ProjSales;
                TotalYestSales += YesterdaySales;
                TotalInteSalesProj += InteSalesProj;
                TotalInteSalesYesterday += InteSalesYesterday;
                SMSBody := 'Commercial Sales ';
                SMSBody1 := 'Internal Sale ';
                SMSBody += 'BF' + ':' + Format(YesterdaySales) + ' : ' + Format(ProjSales);
                SMSBody1 += 'I-BF' + ':' + Format(InteSalesYesterday) + ' : ' + Format(InteSalesProj);
            Until Item.Next() = 0;

        Clear(ProjSales);
        Clear(YesterdaySales);

        Item.Reset();
        Item.SetRange(Blocked, false);
        Item.SetRange("Item Type", Item."Item Type"::Feed);
        Item.SetRange(SMSItemType, Item.SMSItemType::CF);
        if Item.FindSet() then
            repeat
                CreateILEQuanSum(Item."No.", ProjSales, YesterdaySales, InteSalesProj, InteSalesYesterday);
                TotalProjSales += ProjSales;
                TotalYestSales += YesterdaySales;
                TotalInteSalesProj += InteSalesProj;
                TotalInteSalesYesterday += InteSalesYesterday;
                SMSBody += 'CF' + ':' + Format(YesterdaySales) + ' : ' + Format(ProjSales);
                SMSBody1 += 'I-CF' + ':' + Format(InteSalesYesterday) + ' : ' + Format(InteSalesProj);
            Until Item.Next() = 0;

        Clear(ProjSales);
        Clear(YesterdaySales);
        Item.Reset();
        Item.SetRange(Blocked, false);
        Item.SetRange("Item Type", Item."Item Type"::Feed);
        Item.SetRange(SMSItemType, Item.SMSItemType::LF);
        if Item.FindSet() then
            repeat
                CreateILEQuanSum(Item."No.", ProjSales, YesterdaySales, InteSalesProj, InteSalesYesterday);
                TotalProjSales += ProjSales;
                TotalYestSales += YesterdaySales;
                TotalInteSalesProj += InteSalesProj;
                TotalInteSalesYesterday += InteSalesYesterday;
                SMSBody += 'LF' + ':' + Format(YesterdaySales) + ' : ' + Format(ProjSales);
                SMSBody1 += 'I-LF' + ':' + Format(InteSalesYesterday) + ' : ' + Format(InteSalesProj);
            Until Item.Next() = 0;

        Clear(ProjSales);
        Clear(YesterdaySales);
        Item.Reset();
        Item.SetRange(Blocked, false);
        Item.SetRange("Item Type", Item."Item Type"::Feed);
        Item.SetRange(SMSItemType, Item.SMSItemType::LLP);
        if Item.FindSet() then
            repeat
                CreateILEQuanSum(Item."No.", ProjSales, YesterdaySales, InteSalesProj, InteSalesYesterday);
                TotalProjSales += ProjSales;
                TotalYestSales += YesterdaySales;
                TotalInteSalesProj += InteSalesProj;
                TotalInteSalesYesterday += InteSalesYesterday;
                SMSBody += 'LLP' + ':' + Format(YesterdaySales) + ' : ' + Format(ProjSales);
                SMSBody1 += 'I-LLP' + ':' + Format(InteSalesYesterday) + ' : ' + Format(InteSalesProj);
            Until Item.Next() = 0;

        SMSBody += ' Total ' + ':' + Format(TotalYestSales) + ' : ' + Format(TotalProjSales);
        SMSBody1 += ' I-Total ' + ':' + Format(TotalInteSalesYesterday) + ' : ' + Format(TotalInteSalesProj);
        SMSBody := SMSBody + ' ' + SMSBody1;
        SMSBody += EndSMS;


        if CustomerPhone <> '' then
            SendSMSByURL(SMSBody)
        else
            Message(SMSBody);
    end;

    procedure CreateILEQuanSum(ItemFilter: Text; var SalesProj: Decimal; Var SalesYesterday: Decimal; Var InteSalesProj: Decimal; Var InteSalesYesterday: Decimal);
    var
        ILE: Record 32;
        Startdate: Date;
        EndDate: Date;
        Cust: Record Customer;
    begin

        Startdate := CalcDate('-CM', WorkDate());
        EndDate := WorkDate() - 1;

        ILE.Reset();
        ILE.SetLoadFields("Cust. Posting Group", "Item No.", "Entry Type", "Posting Date", Quantity);
        ILE.CalcFields("Cust. Posting Group");
        ILE.setfilter("Item No.", '%1', ItemFilter);
        ILE.SetRange("Entry Type", ILE."Entry Type"::Sale);
        ILE.SetRange("Posting Date", WorkDate() - 1);
        ILE.SetFilter("Cust. Posting Group", '<>%1', 'INTER BRANCH TRANSFE');
        if ILE.FindSet() then begin
            ILE.CalcSums(Quantity);
            SalesYesterday += ILE.Quantity / 1000 * -1;
        end;

        ILE.Reset();
        ILE.SetLoadFields("Cust. Posting Group", "Item No.", "Entry Type", "Posting Date", Quantity);
        ILE.CalcFields("Cust. Posting Group");
        ILE.setfilter("Item No.", '%1', ItemFilter);
        ILE.SetRange("Entry Type", ILE."Entry Type"::Sale);
        ILE.SetRange("Posting Date", Startdate, EndDate);
        ILE.SetFilter("Cust. Posting Group", '<>%1', 'INTER BRANCH TRANSFE');
        if ILE.FindSet() then begin
            ILE.CalcSums(Quantity);
            SalesProj += ((ILE.Quantity / 1000) * Date2DMY(EndDate, 1) * -1) / Date2DMY(WorkDate() - 1, 1);
        end;
        ILE.Reset();
        ILE.SetLoadFields("Cust. Posting Group", "Item No.", "Entry Type", "Posting Date", Quantity);
        ILE.CalcFields("Cust. Posting Group");
        ILE.setfilter("Item No.", '%1', ItemFilter);
        ILE.SetRange("Entry Type", ILE."Entry Type"::Sale);
        ILE.SetRange("Posting Date", WorkDate() - 1);
        ILE.SetFilter("Cust. Posting Group", '%1', 'INTER BRANCH TRANSFE');
        if ILE.FindSet() then begin
            ILE.CalcSums(Quantity);
            InteSalesYesterday += ILE.Quantity / 1000 * -1;
        end;

        ILE.Reset();
        ILE.SetLoadFields("Cust. Posting Group", "Item No.", "Entry Type", "Posting Date", Quantity);
        ILE.CalcFields("Cust. Posting Group");
        ILE.setfilter("Item No.", '%1', ItemFilter);
        ILE.SetRange("Entry Type", ILE."Entry Type"::Sale);
        ILE.SetRange("Posting Date", Startdate, EndDate);
        ILE.SetFilter("Cust. Posting Group", '%1', 'INTER BRANCH TRANSFE');
        if ILE.FindSet() then begin
            ILE.CalcSums(Quantity);
            InteSalesProj += ((ILE.Quantity / 1000) * Date2DMY(EndDate, 1) * -1) / Date2DMY(WorkDate() - 1, 1);
        end;
    end;


}

