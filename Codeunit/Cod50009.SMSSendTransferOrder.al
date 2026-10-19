codeunit 50009 "SMS Send Transfer Order"
{

    trigger OnRun()
    begin
        //SMSSendTransferOrder('F-GSN/1920/6073');
    end;

    var
        SMSfunctions: Codeunit 50018;
        Companyinfo: Record "Company Information";
        SalesRece: Record "Sales & Receivables Setup";


    procedure SMSSendTransferOrder(DoCNo: Code[20])
    var
        TransfrShptHder: Record 5744;
        SMSBody: Text[1024];
        Item: Record 27;
        TransferShipmentLine: Record 5745;
        Location: Record 14;
        LocPhoneNo: Text;
        Region: Record Region;
        DimensionValue: Record "Dimension Value";
        CompanyInfo: Record "Company Information";
        FromLOC: Record Location;
        WhatsApp: Codeunit "WhatsApp Function";
        SFPLSMSBody: Text;
        STARSMSBody: Text;
        SMSDetail: Codeunit "SMS Details";
    begin
        CompanyInfo.Get;
        SalesRece.Get;
        IF TransfrShptHder.GET(DoCNo) THEN BEGIN
            CLEAR(LocPhoneNo);
            FromLOC.Get(TransfrShptHder."Transfer-from Code");
            IF Location.GET(TransfrShptHder."Transfer-to Code") THEN BEGIN
                If Location."Region Code" <> '' Then begin
                    DimensionValue.Get('BRANCH', Location."Shortcut Dimension 2 Code");
                    if (Location."Phone No." <> '') and (DimensionValue."Mobile No" <> '') then
                        LocPhoneNo := Location."Phone No." + ',' + DimensionValue."Mobile No"
                    else
                        if (Location."Phone No." <> '') and (DimensionValue."Mobile No" <> '') then
                            LocPhoneNo := Location."Phone No." + ',' + DimensionValue."Mobile No"
                end else
                    LocPhoneNo := Location."Phone No.";
            END;

            TransferShipmentLine.SETRANGE("Document No.", TransfrShptHder."No.");
            IF TransferShipmentLine.FINDSET THEN
                REPEAT
                    //IF Item.GET(TransferShipmentLine."Item No.") THEN;
                    IF TransferShipmentLine.Quantity <> 0 THEN BEGIN
                        if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::"Star Foods"] Then begin
                            Item.Get(TransferShipmentLine."Item No.");
                            // STARSMSBody := 'https://pgapi.vispl.in/fe/api/v1/multiSend?username=samprnpg.trans&password=' + SalesRece."SMS Password" + '&unicode=false&from=' + SalesRece."Sender ID" + '&to=' + LocPhoneNo + '&text=' +
                            // 'Star Foods has Dispatched' + FORMAT(TransferShipmentLine.Description) + '' + FORMAT(TransferShipmentLine.Quantity) + '' + FORMAT(TransferShipmentLine."Unit of Measure") + 'on Your Location ' + FORMAT(Location.Name) + ' From ' + FromLOC.Name + ' vide vehicle no. ' +
                            // TransfrShptHder."Vehicle No." + ' and D.C No. ' + TransfrShptHder."No." + ' Date ' + Format(TransfrShptHder."Posting Date") + ' From:- Star Foods' + '&dltContentId=1307174600656869960&dltPrincipalEntityId=' + SalesRece."Entity ID";
                            STARSMSBody := 'Star Foods has Dispatched ' + FORMAT(Item.Description) + '' + FORMAT(TransferShipmentLine.Quantity) + ' ' + FORMAT(TransferShipmentLine."Unit of Measure") + 'on Your Location ' + FORMAT(Location.Name) + ' From ' + FromLOC.Name + ' vide vehicle no. ' +
                            TransfrShptHder."Vehicle No." + ' and D.C No. ' + TransfrShptHder."No." + ' Date ' + Format(TransfrShptHder."Posting Date") + ' From:- Star Foods';
                        end;

                        if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] Then begin
                            Item.Get(TransferShipmentLine."Item No.");
                            SFPLSMSBody := 'SFPL has Dispatched ' + FORMAT(Item.Description) + ' ' + FORMAT(TransferShipmentLine.Quantity) + ' ' + FORMAT(TransferShipmentLine."Unit of Measure Code") + ' on Your Location ' + FORMAT(Location.Name) + ' From ' + FromLOC.Name + ' vide vehicle no. ' +
                            TransfrShptHder."Vehicle No." + ' and D.C No. ' + TransfrShptHder."No." + ' Date ' + Format(TransfrShptHder."Posting Date") + ' From:- Sampoorna Feeds Pvt. Ltd.';
                            //  SFPLSMSBody := 'https://pgapi.vispl.in/fe/api/v1/multiSend?username=samprnpg.trans&password=' + SalesRece."SMS Password" + '&unicode=false&from=' + SalesRece."Sender ID" + '&to=' + LocPhoneNo + '&text=' +
                            // 'SFPL has Dispatched ' + FORMAT(TransferShipmentLine.Description) + ' ' + FORMAT(TransferShipmentLine.Quantity) + ' ' + FORMAT(TransferShipmentLine."Unit of Measure Code") + ' on Your Location ' + FORMAT(Location.Name) + ' From ' + FromLOC.Name + ' vide vehicle no. ' +
                            // TransfrShptHder."Vehicle No." + ' and D.C No. ' + TransfrShptHder."No." + ' Date ' + Format(TransfrShptHder."Posting Date") + ' From:- Sampoorna Feeds Pvt. Ltd.' + '&dltContentId=1307174600928046073&dltPrincipalEntityId=' + SalesRece."Entity ID";
                        end;

                        // CLEAR(SMSfunctions);
                        // SMSfunctions.SendSMSByURL(SMSBody);
                        if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::"Star Foods"] Then begin
                            // if Location."Phone No." <> '' then
                            //     WhatsApp.SendSMS(Location."Phone No.", STARSMSBody, '', Location.Code, '1307174600656869960');
                            // if DimensionValue."Mobile No" <> '' then
                            //     WhatsApp.SendSMS(DimensionValue."Mobile No", STARSMSBody, '', Location.Code, '1307174600656869960');
                            SMSDetail.APISMSMultipleNo(Location."Phone No.", DimensionValue."Mobile No", '', '', '', '', '', STARSMSBody, '', Location.Code, '1307174600656869960');// Airtel
                        end;

                        if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] Then begin
                            // if Location."Phone No." <> '' then
                            //     WhatsApp.SendSMS(Location."Phone No.", SFPLSMSBody, '', Location.Code, '1307174600928046073');
                            // if DimensionValue."Mobile No" <> '' then
                            //     WhatsApp.SendSMS(DimensionValue."Mobile No", SFPLSMSBody, '', Location.Code, '1307174600928046073');

                            SMSDetail.APISMSMultipleNo(Location."Phone No.", DimensionValue."Mobile No", '', '', '', '', '', SFPLSMSBody, '', Location.Code, '1307174600928046073');// Airtel
                            //PRU SH 25082022
                        end;                                                                                                        // HYPERLINK(SMSBody);
                                                                                                                                    //MESSAGE(SMSBody);
                                                                                                                                    // END;
                    END;

                UNTIL TransferShipmentLine.NEXT = 0;
        END;
    end;


    procedure SMSSendGCStatment(DocNo: Code[20])
    var
        GCStatement: Record 50015;
        SMSBody: Text[1024];
        FarmLocationPhoneNo: Text;
        Location: Record 14;
        Vendor: Record 23;
        Region: record Region;
        MobileNo: Text;
        WhatsApp: Codeunit "WhatsApp Function";
        SMSDetail: Codeunit "SMS Details";

    begin
        Companyinfo.Get;
        SalesRece.Get;
        GCStatement.SETRANGE("No.", DocNo);
        IF GCStatement.FINDSET THEN BEGIN
            IF GCStatement."Farm Code" <> '' THEN BEGIN
                Location.GET(GCStatement."Farm Code");
                Vendor.GET(Location."Farmer Code");
                Region.Get(GCStatement.Region);
                if (Vendor."Phone No." <> '') and (Region."MobileNo." <> '') Then
                    MobileNo := Vendor."Phone No." + ',' + Region."MobileNo."
                else
                    if Vendor."Phone No." <> '' then
                        MobileNo := Vendor."Phone No."
                    else
                        if Region."MobileNo." <> '' then
                            MobileNo := Region."MobileNo.";

                if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] Then begin
                    SMSBody := 'SFPL: GC Amount Rs. ' +
               FORMAT(GCStatement."Net Payable After TDS") + ' ' + 'paid to your A/C No. ' + GCStatement."Farmer No." + '; Feed: ' + FORMAT(GCStatement."Feed Consumption(kgs)") + ' ' + 'Kg;' + 'Mortality:' + ' ' +
               FORMAT(GCStatement.Mortality) + ' birds; ' + 'FCR:' + FORMAT(GCStatement.FCR) + ';' + ' Avg. Wt.: ' + FORMAT(GCStatement."Average Body weight2") + ';' + ' Sales: ' + FORMAT(GCStatement."Birds Sold (kg)") +
               'Kg;' + ' ' + 'From: Sampoorna Feeds Pvt.Ltd.';

                end;
                if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::"Star Foods"] Then begin
                    SMSBody := 'STAR FOODS: GC Amount Rs. ' + FORMAT(GCStatement."Net Payable After TDS") + ' ' + 'paid to your A/C No. ' + GCStatement."Farmer No." + '; Feed: ' + FORMAT(GCStatement."Feed Consumption(kgs)") + ' ' + 'Kg;' + 'Mortality:' + ' ' +
                   FORMAT(GCStatement.Mortality) + ' birds; ' + 'FCR: ' + FORMAT(GCStatement.FCR) + ';' + ' Avg. Wt.: ' + FORMAT(GCStatement."Average Body weight2") + ';' + ' Sales: ' + FORMAT(GCStatement."Birds Sold (kg)") +
                   'Kg;' + ' ' + 'From: STAR FOODS';

                end;

                if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::"Star Foods"] Then begin
                    // if Vendor."Phone No." <> '' then
                    //     WhatsApp.SendSMS(Vendor."Phone No.", SMSBody, '', Vendor."No.", '1307173397674665876');
                    // if Region."MobileNo." <> '' then
                    //     WhatsApp.SendSMS(Region."MobileNo.", SMSBody, '', Vendor."No.", '1307173397674665876');
                    SMSDetail.APISMSMultipleNo(Vendor."Phone No.", Region."MobileNo.", '', '', '', '', '', SMSBody, '', Vendor."No.", '1307173397674665876');// Airtel
                end;
                if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] Then begin
                    // if Vendor."Phone No." <> '' then
                    //     WhatsApp.SendSMS(Vendor."Phone No.", SMSBody, '', Vendor."No.", '1307162142434137263');
                    // if Region."MobileNo." <> '' then
                    //     WhatsApp.SendSMS(Region."MobileNo.", SMSBody, '', Vendor."No.", '1307162142434137263');
                    SMSDetail.APISMSMultipleNo(Vendor."Phone No.", Region."MobileNo.", '', '', '', '', '', SMSBody, '', Vendor."No.", '1307162142434137263');// Airtel
                end;
                //HYPERLINK(SMSBody);



            END;

        END;
    end;
}

