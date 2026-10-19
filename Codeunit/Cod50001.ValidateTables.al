codeunit 50001 "Validate Tables"
{

    Permissions = tabledata "G/L Entry" = rm,
    tabledata "User Setup" = rm;

    var
        Approvalworkflow: Codeunit "Approval Management Custom";
        CompanyInfo: Record "Company Information";
        Text002: Label 'Please approve the %1 and code as %2, currently it is in %3 Status';

    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnBeforeValidateEvent', 'No.', false, false)]
    local procedure OnBeforevalidateItemNoinpurchaselineLine(var Rec: Record "Purchase Line")
    var
        Item: Record Item;
        GLAccount: Record "G/L Account";
        RecordRestriction: Codeunit "Record Restriction Mgt.";

    begin
        CompanyInfo.Get();
        if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then
            If rec."No." <> '' then
                if rec.Type = Rec.Type::Item Then begin
                    Item.Get(Rec."No.");
                    if Approvalworkflow.CheckingItemApprovalsWorkflowEnabled(Item) Then begin
                        RecordRestriction.CheckRecordHasUsageRestrictions(Item);
                        If Item.Status <> Item.Status::Approved then
                            Error(Text002, 'Item', Item."No.", Item.Status);
                    end;
                end else begin
                    if rec.Type = Rec.Type::"G/L Account" Then begin
                        GLAccount.Get(Rec."No.");
                        if Approvalworkflow.CheckingGLAccountApprovalsWorkflowEnabled(GLAccount) Then Begin
                            RecordRestriction.CheckRecordHasUsageRestrictions(GLAccount);
                            If GLAccount.Status <> GLAccount.Status::Approved then
                                Error(Text002, 'G/L Account', GLAccount."No.", GLAccount.Status);
                        End;
                    end;
                end;
    end;
    [EventSubscriber(ObjectType::Table, DataBase::"Gen. Journal Line", 'OnBeforeValidateEvent', 'Account No.', false, false)]
    local procedure OnBeforevalidateAccount(var Rec: Record "Gen. Journal Line")
    var
        Cust: Record Customer;
        Vendor: Record Vendor;
        GLAccount: Record "G/L Account";
        RecordRestriction: Codeunit "Record Restriction Mgt.";
    begin
        CompanyInfo.Get();
        if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then
            if rec."Account No." <> '' Then
                if Approvalworkflow.CheckCustomerApprovalsWorkflowEnabled(Cust) Then Begin
                    Cust.Get(Rec."Account No.");
                    RecordRestriction.CheckRecordHasUsageRestrictions(Cust);
                    if Cust.Status <> Cust.Status::Approved then
                        Error(Text002, 'Customer', Cust."No.", Cust.Status);
                end Else
                    If Rec."Account Type" = Rec."Account Type"::Vendor then begin
                        if Approvalworkflow.CheckVendorApprovalsWorkflowEnabled(Vendor) Then Begin
                            Vendor.Get(Rec."Account No.");
                            RecordRestriction.CheckRecordHasUsageRestrictions(Vendor);
                            if Vendor.Status <> Vendor.Status::Approved Then
                                Error(Text002, 'Vendor', Vendor."No.", Vendor.Status);
                        end;
                    end else
                        If Rec."Account Type" = Rec."Account Type"::"G/L Account" then begin
                            if Approvalworkflow.CheckingGLAccountApprovalsWorkflowEnabled(GLAccount) Then Begin
                                GLAccount.Get(Rec."Account No.");
                                RecordRestriction.CheckRecordHasUsageRestrictions(GLAccount);
                                If GLAccount.Status <> GLAccount.Status::Approved Then
                                    Error(Text002, 'G/L Account', GLAccount."No.", GLAccount.Status);
                            end;
                        end;
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Gen. Journal Line", 'OnBeforeValidateEvent', 'Bal. Account No.', false, false)]
    local procedure OnBeforevalidateBalAccountNo(var Rec: Record "Gen. Journal Line")
    var
        Cust: Record Customer;
        Vendor: Record Vendor;
        GLAccount: Record "G/L Account";
        RecordRestriction: Codeunit "Record Restriction Mgt.";
    begin
        CompanyInfo.Get();
        if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then
            if rec."Bal. Account No." <> '' Then
                If Rec."Bal. Account Type" = Rec."Bal. Account Type"::Customer then begin
                    Cust.Get(Rec."Bal. Account No.");
                    if Approvalworkflow.CheckCustomerApprovalsWorkflowEnabled(Cust) Then Begin
                        RecordRestriction.CheckRecordHasUsageRestrictions(Cust);
                        if Cust.Status <> Cust.Status::Approved then
                            Error(Text002, 'Customer', Cust."No.", Cust.Status);
                    End;
                end Else
                    If Rec."Bal. Account Type" = Rec."Bal. Account Type"::Vendor then begin
                        Vendor.Get(Rec."Bal. Account No.");
                        if Approvalworkflow.CheckVendorApprovalsWorkflowEnabled(Vendor) Then Begin
                            RecordRestriction.CheckRecordHasUsageRestrictions(Vendor);
                            if Vendor.Status <> Vendor.Status::Approved Then
                                Error(Text002, 'Vendor', Vendor."No.", Vendor.Status);
                        End
                    end else
                        If Rec."Bal. Account Type" = Rec."Bal. Account Type"::"G/L Account" then begin
                            if Approvalworkflow.CheckingGLAccountApprovalsWorkflowEnabled(GLAccount) Then Begin
                                GLAccount.Get(Rec."Bal. Account No.");
                                RecordRestriction.CheckRecordHasUsageRestrictions(GLAccount);
                                if GLAccount.Status <> GLAccount.Status::Approved Then
                                    Error(Text002, 'G/L Account', GLAccount."No.", GLAccount.Status);
                            End;
                        end;
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Item Journal Line", 'OnBeforeValidateEvent', 'Item No.', false, false)]
    local procedure OnBeforevalidateItemNo(var Rec: Record "Item Journal Line")
    var
        Item: Record Item;
        RecordRestriction: Codeunit "Record Restriction Mgt.";
    begin
        CompanyInfo.Get();
        if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then
            If Rec."Journal Template Name" <> '' Then
                If rec."Item No." <> '' then begin
                    Item.Get(Rec."Item No.");
                    if Approvalworkflow.CheckingItemApprovalsWorkflowEnabled(Item) Then Begin
                        RecordRestriction.CheckRecordHasUsageRestrictions(Item);
                        If Item.Status <> Item.Status::Approved then
                            Error(Text002, 'Item', Item."No.", Item.Status);
                    End;
                end;
    end;


    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnBeforeValidateEvent', 'No.', false, false)]
    local procedure OnBeforevalidateItemNoinSalesLine(var Rec: Record "Sales Line")
    var
        Item: Record Item;
        GLAccount: Record "G/L Account";
        RecordRestriction: Codeunit "Record Restriction Mgt.";
    begin
        CompanyInfo.Get();
        if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then
            If rec."No." <> '' then
                if rec.Type = Rec.Type::Item Then begin
                    Item.Get(Rec."No.");
                    if Approvalworkflow.CheckingItemApprovalsWorkflowEnabled(Item) Then begin
                        RecordRestriction.CheckRecordHasUsageRestrictions(Item);
                        If Item.Status <> Item.Status::Approved then
                            Error(Text002, 'Item', Item."No.", Item.Status);
                    end;
                end else begin
                    if rec.Type = Rec.Type::"G/L Account" Then begin
                        GLAccount.Get(Rec."No.");
                        if Approvalworkflow.CheckingGLAccountApprovalsWorkflowEnabled(GLAccount) Then Begin
                            RecordRestriction.CheckRecordHasUsageRestrictions(GLAccount);
                            If GLAccount.Status <> GLAccount.Status::Approved then
                                Error(Text002, 'G/L Account', GLAccount."No.", GLAccount.Status);
                        end;
                    end;
                end;
    end;

    

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Header", 'OnBeforeValidateEvent', 'Buy-from Vendor No.', false, false)]
    local procedure OnBeforevalidateBuyfromvendorno(var Rec: Record "Purchase Header")
    var
        Vend: Record Vendor;
        RecordRestriction: Codeunit "Record Restriction Mgt.";
    begin
        CompanyInfo.Get();
        if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then
            If rec."Buy-from Vendor No." <> '' then begin
                Vend.Get(Rec."Buy-from Vendor No.");
                if Approvalworkflow.CheckVendorApprovalsWorkflowEnabled(Vend) Then begin
                    RecordRestriction.CheckRecordHasUsageRestrictions(Vend);
                    If Vend.Status <> Vend.Status::Approved then
                        Error(Text002, 'Vendor', Vend."No.", Vend.Status);
                end;
            end
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Header", 'OnBeforeValidateEvent', 'Pay-to Vendor No.', false, false)]
    local procedure OnBeforevalidatePaytoVendorNo(var Rec: Record "Purchase Header")
    var
        Vend: Record Vendor;
        RecordRestriction: Codeunit "Record Restriction Mgt.";
    begin
        CompanyInfo.Get();
        if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then
            If rec."Pay-to Vendor No." <> '' then begin
                Vend.Get(Rec."Pay-to Vendor No.");
                if Approvalworkflow.CheckVendorApprovalsWorkflowEnabled(Vend) Then begin
                    RecordRestriction.CheckRecordHasUsageRestrictions(Vend);
                    If Vend.Status <> Vend.Status::Approved then
                        Error(Text002, 'Vendor', Vend."No.", Vend.Status);
                end;
            end
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Header", 'OnBeforeValidateEvent', 'Sell-to Customer No.', false, false)]
    local procedure OnBeforevalidateSelltoCustomerNo(var Rec: Record "Sales Header")
    var
        Cust: Record Customer;
        RecordRestriction: Codeunit "Record Restriction Mgt.";
    begin
        CompanyInfo.Get();
        if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then
            If rec."Sell-to Customer No." <> '' then begin
                Cust.Get(Rec."Sell-to Customer No.");
                if Approvalworkflow.CheckCustomerApprovalsWorkflowEnabled(Cust) Then begin
                    RecordRestriction.CheckRecordHasUsageRestrictions(Cust);
                    If Cust.Status <> Cust.Status::Approved then
                        Error(Text002, 'Customer', Cust."No.", Cust.Status);
                end;
            end
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Header", 'OnBeforeValidateEvent', 'Bill-to Customer No.', false, false)]
    local procedure OnBeforevalidateBilltoCustomerNo(var Rec: Record "Sales Header")
    var
        Cust: Record Customer;
        RecordRestriction: Codeunit "Record Restriction Mgt.";
    begin
        CompanyInfo.Get();
        if CompanyInfo.SFPLCompany in [CompanyInfo.SFPLCompany::Sampoorna] then
            If rec."Bill-to Customer No." <> '' then begin
                Cust.Get(Rec."Bill-to Customer No.");
                if Approvalworkflow.CheckCustomerApprovalsWorkflowEnabled(Cust) Then begin
                    RecordRestriction.CheckRecordHasUsageRestrictions(Cust);
                    If Cust.Status <> Cust.Status::Approved then
                        Error(Text002, 'Customer', Cust."No.", Cust.Status);
                end;
            end
    end;


    [EventSubscriber(ObjectType::Table, Database::"Job Queue Entry", OnScheduleTaskOnAfterCalcShouldChangeUserID, '', True, True)]
    local procedure OnScheduleTaskOnAfterCalcShouldChangeUserID(var JobQueueEntry: Record "Job Queue Entry"; var ShouldChangeUserID: Boolean)
    var
        JobQueue: Record "Job Queue Entry";

    begin

        Jobqueue.Reset();
        Jobqueue.SetRange(ID, JobQueueEntry.ID);
        Jobqueue.SetFilter("Object ID to Run", '%1|%2|%3', 50048, 50047, 50160);
        if Jobqueue.FindSet() then
            ShouldChangeUserID := false;

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"System Initialization", 'OnAfterInitialization', '', true, true)]
    local procedure "LogInManagement_OnAfterLogInStart"()
    var
        ActiveSession: Record "Active Session";
        ActiveSession1: Record "Active Session";
        tgUserSetup: Record "User Setup";
        trole: page 50036;
        Login: Codeunit LogInManagement;
        SI: Codeunit "System Initialization";
        Jobqueue: Record "Job Queue Entry";


    begin


        // session.
        IF ((USERID <> 'JOBQUEUE') AND (USERID <> 'STF21474') AND (USERID <> 'AUDIT') AND (USERID <> 'SERVICES') AND (USERID <> 'AUDIT1') and (USERID <> 'SAM304') and (USERID <> 'SAM4325')) THEN BEGIN
            ActiveSession.RESET;
            ActiveSession.SETRANGE("User ID", USERID);
            ActiveSession.SETRANGE("Database Name", 'BC23');
            ActiveSession.SetFilter("Client Type", '<>%1', ActiveSession."Client Type"::Background);
            IF ActiveSession.FindFirst() THEN begin

                // IF ActiveSession.COUNT > 1 THEN Begin
                //     Message('Please delete the First Session from Active Session Page');
                //     Page.RunModal(Page::"Active Sessions", ActiveSession);
                // end;
                if ActiveSession."User ID" <> 'STFWH' then
                    IF ActiveSession.COUNT > 1 THEN Begin
                        ActiveSession1.Reset();
                        ActiveSession1.SetAscending("Session ID", True);
                        ActiveSession1.SetRange("User ID", USERID);
                        ActiveSession1.SETRANGE("Database Name", 'BC23');
                        ActiveSession1.SetFilter("Client Type", '<>%1', ActiveSession."Client Type"::Background);
                        if ActiveSession1.FindFirst() then
                            ActiveSession1.Delete;
                    end;
            END;

        END;

        //Suman 1606
        Jobqueue.Reset();
        Jobqueue.SetRange(Jobqueue.Status, Jobqueue.Status::Error);
        Jobqueue.SetFilter("Object ID to Run", '%1|%2|%3', 50048, 50047, 50160);
        if Jobqueue.FindSet() then
            repeat
                Jobqueue.Restart();
            Until Jobqueue.Next() = 0;

        Jobqueue.Reset();
        Jobqueue.SetRange(Jobqueue.Status, Jobqueue.Status::Error);
        Jobqueue.SetRange("Object ID to Run", 1509);
        if Jobqueue.FindSet() then
            repeat
                Jobqueue.Delete();
            Until Jobqueue.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Codeunit, codeunit::"System Initialization", 'OnAfterLogin', '', true, true)]
    local procedure UpdateDimCode()
    var
        SI: Codeunit "System Initialization";
        tgUserSetup: Record "User Setup";
        trole: page 50036;
        ActiveSession: Record "Active Session";

    begin
        //Suman 1606
        IF ((USERID <> 'JOBQUEUE') AND (USERID <> 'STF21474') AND (USERID <> 'SERVICES') AND (USERID <> 'RITU') AND (USERID <> 'SAM304') AND (USERID <> 'AUDIT') AND (USERID <> 'AUDIT1') and (USERID <> 'SAM4325')) THEN BEGIN
            tgUserSetup.GET(USERID);
            // Message(tgUserSetup."User ID");
            IF tgUserSetup."User ID" <> '' THEN begin
                // if not tgUserSetup."Super User" then
                trole.RunModal();
            end else
                ERROR('Need Administrator Permission to define LOB of User');

        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnBeforeValidateEvent, 'Order date', True, True)]
    Local procedure OnbeforeValidateEventOrderDate(Rec: Record "Purchase Header")
    var

    Begin
        If Rec."Document Type" = Rec."Document Type"::Order then
            If Rec.Status <> Rec.Status::Open then
                Error('Document Must be Open to change the Order Date');

    End;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnBeforeValidateEvent, 'Buy-from Vendor No.', True, True)]
    local procedure OnBeforeValidateEventGSTVendorType(Rec: Record "Purchase Header")
    var
        RecVendor: Record Vendor;

    begin
        RecVendor.Get(Rec."Buy-from Vendor No.");
        If ((RecVendor."GST Vendor Type" <> RecVendor."GST Vendor Type"::Import) and (RecVendor."GST Vendor Type" <> RecVendor."GST Vendor Type"::" ")) then
            RecVendor.TestField(RecVendor."State Code");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeCopyShipToCustomerAddressFieldsFromShipToAddr', '', true, true)]
    local procedure "Sales Header_OnBeforeCopyShipToCustomerAddressFieldsFromShipToAddr"
    (
        var SalesHeader: Record "Sales Header";
        var ShipToAddress: Record "Ship-to Address";
        var IsHandled: Boolean

    )
    var
        ShouldCopyLocationCode: Boolean;


    begin
        IsHandled := true;
        SalesHeader."Ship-to Name" := ShipToAddress.Name;
        SalesHeader."Ship-to Name 2" := ShipToAddress."Name 2";
        SalesHeader."Ship-to Address" := ShipToAddress.Address;
        SalesHeader."Ship-to Address 2" := ShipToAddress."Address 2";
        SalesHeader."Ship-to City" := ShipToAddress.City;
        SalesHeader."Ship-to Post Code" := ShipToAddress."Post Code";
        SalesHeader."Ship-to County" := ShipToAddress.County;
        SalesHeader.Validate("Ship-to Country/Region Code", ShipToAddress."Country/Region Code");
        SalesHeader."Ship-to Contact" := ShipToAddress.Contact;
        ShouldCopyLocationCode := ShipToAddress."Location Code" <> '';
        //OnSetShipToCustomerAddressFieldsFromShipToAddrOnAfterCalcShouldCopyLocationCode(Rec, xRec, ShipToAddr, ShouldCopyLocationCode);
        if ShouldCopyLocationCode then
            SalesHeader.Validate("Location Code", ShipToAddress."Location Code");
        SalesHeader.Validate("Shipping Agent Code", ShipToAddress."Shipping Agent Code");
        SalesHeader.Validate("Shipping Agent Service Code", ShipToAddress."Shipping Agent Service Code");
        if ShipToAddress."Tax Area Code" <> '' then
            SalesHeader.Validate("Tax Area Code", ShipToAddress."Tax Area Code");
        SalesHeader.Validate("Tax Liable", ShipToAddress."Tax Liable");

    end;



    [EventSubscriber(ObjectType::Table, 36, 'OnAfterInsertEvent', '', false, false)]
    local procedure SalesHeaderOnAfterInsert(var Rec: Record 36; RunTrigger: Boolean)
    var
        UserSetupRec: Record 91;
    begin
        //<<PRU_RC
        IF Rec."No." <> '' THEN BEGIN
            //  Message('%1..%2', UserSetupRec."User Permission", UserSetupRec."Shortcut Dimension 3 Code");
            UserSetupRec.GET(USERID);
            if UserSetupRec."User ID" <> 'JOBQUEUE' Then
                UserSetupRec.TESTFIELD("Global Dimension 1 Code");
            //    Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
            IF NOT UserSetupRec."User Permission" THEN BEGIN
                UserSetupRec.TESTFIELD("Global Dimension 2 Code");
                IF NOT UserSetupRec."HO Users" THEN
                    UserSetupRec.TESTFIELD("Shortcut Dimension 3 Code");
                //  Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                IF NOT UserSetupRec."HO Users" THEN BEGIN
                    Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
                    //   Rec.VALIDATE("Location Code", UserSetupRec."Shortcut Dimension 3 Code");
                    // Message(UserSetupRec."Shortcut Dimension 3 Code");
                END;
            END;

        END;
        //>>PRU_RC
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterInsertEvent', '', false, false)]
    local procedure PurchHeaderOnAfterInsert(var Rec: Record 38; RunTrigger: Boolean)
    var
        UserSetupRec: Record 91;
        Companyinfo: Record "Company Information";
    begin
        Companyinfo.Get;
        //<<PRU_RC
        If UserId <> 'JOBQUEUE' Then
            IF Rec."No." <> '' THEN BEGIN
                //  date-04-04-2023
                UserSetupRec.GET(USERID);
                UserSetupRec.TESTFIELD("Global Dimension 1 Code");
                //      Rec.VALIDATE("Responsibility Center", UserSetupRec."Responsibility Center");
                Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                IF NOT UserSetupRec."User Permission" THEN BEGIN
                    UserSetupRec.TESTFIELD("Global Dimension 2 Code");
                    if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] Then begin
                        IF NOT UserSetupRec."HO Users" THEN
                            UserSetupRec.TESTFIELD("Shortcut Dimension 3 Code");
                    end;
                    Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                    Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                    if Companyinfo.SFPLCompany in [Companyinfo.SFPLCompany::Sampoorna] Then begin
                        IF NOT UserSetupRec."HO Users" THEN BEGIN
                            Rec.Validate("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
                        end;
                        //       Rec.VALIDATE("Location Code", UserSetupRec."Shortcut Dimension 3 Code");
                    END;

                END;

            END;
    end;

    [EventSubscriber(ObjectType::Table, 5405, 'OnAfterInsertEvent', '', false, false)]
    local procedure ProductionOrderOnAfterInsert(var Rec: Record 5405; RunTrigger: Boolean)
    var
        UserSetupRec: Record 91;
    begin
        //<<PRU_RC
        IF Rec."No." <> '' THEN BEGIN
            if UserId <> 'JOBQUEUE' then begin
                IF Rec.Status <> Rec.Status::Finished THEN BEGIN
                    UserSetupRec.GET(USERID);
                    UserSetupRec.TESTFIELD("Global Dimension 1 Code");
                    Rec.VALIDATE("Responsibility Center", UserSetupRec."Responsibility Center");
                    Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                    IF NOT UserSetupRec."User Permission" THEN BEGIN
                        IF NOT UserSetupRec."HO Users" THEN
                            UserSetupRec.TESTFIELD("Shortcut Dimension 3 Code");
                        Rec.VALIDATE("Location Code", UserSetupRec."Shortcut Dimension 3 Code");
                        Rec.VALIDATE("Responsibility Center", UserSetupRec."Responsibility Center");
                        Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                        Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                        IF NOT UserSetupRec."HO Users" THEN BEGIN
                            Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
                        END;
                        //Message('%1..%2..%3', UserSetupRec."Global Dimension 1 Code", UserSetupRec."Global Dimension 2 Code", UserSetupRec."Shortcut Dimension 3 Code");
                    END;
                END;
            end;
        END;
        //>>PRU_RC
    end;

    [EventSubscriber(ObjectType::Table, 5740, 'OnAfterInsertEvent', '', false, false)]

    local procedure TransferOrderOnAfterInssert(var Rec: Record 5740; RunTrigger: Boolean)
    var
        UserSetupRec: Record 91;
        Tran: Codeunit 5704;
    begin
        //<<PRU_RC
        IF Rec."No." <> '' THEN BEGIN
            if UserId <> 'JOBQUEUE' then begin
                UserSetupRec.GET(USERID);
                UserSetupRec.TESTFIELD("Global Dimension 1 Code");
                Rec.SetHideValidationDialog(true);
                Rec.VALIDATE("Responsibility Center", UserSetupRec."Responsibility Center");
                Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                IF NOT UserSetupRec."User Permission" THEN BEGIN
                    UserSetupRec.TESTFIELD("Global Dimension 2 Code");
                    IF NOT UserSetupRec."HO Users" THEN
                        UserSetupRec.TESTFIELD("Shortcut Dimension 3 Code");
                    IF NOT UserSetupRec."HO Users" THEN BEGIN
                        Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
                        // Rec.Status := Rec.Status::Open;

                        //  Rec.VALIDATE("Transfer-from Code", UserSetupRec."Shortcut Dimension 3 Code");
                        //  Rec.Status := Rec.Status::Released;
                    END;

                    Rec.VALIDATE("Responsibility Center", UserSetupRec."Responsibility Center");
                    Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                    Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                END;

            end;
        END;
        //>>PRU_RC
    end;

    [EventSubscriber(ObjectType::Table, 99000754, 'OnAfterInsertEvent', '', false, false)]
    local procedure WorkCenterOnAfterInsert(var Rec: Record 99000754; RunTrigger: Boolean)
    var
        UserSetupRec: Record 91;
    begin
        IF Rec."No." <> '' THEN BEGIN
            UserSetupRec.GET(USERID);
            UserSetupRec.TESTFIELD("Global Dimension 1 Code");
            UserSetupRec.TESTFIELD("Global Dimension 2 Code");
            IF NOT UserSetupRec."HO Users" THEN
                UserSetupRec.TESTFIELD("Shortcut Dimension 3 Code");
            //S.M   Rec.VALIDATE("Responsibility Center", UserSetupRec."Responsibility Center");
            Rec.VALIDATE("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
            Rec.VALIDATE("Global Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
            IF NOT UserSetupRec."HO Users" THEN;
            //S.M Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
        END;
    end;

    [EventSubscriber(ObjectType::Table, 83, 'OnBeforeInsertEvent', '', false, false)]
    local procedure ItemJournalLineOnAFterInsert(var Rec: Record 83; RunTrigger: Boolean)
    var
        projo: Page 40;
        UserSetupRec: Record 91;
        LocRec: Record Location;
        ProdOrder: Record "Production Order";

    begin
        IF Rec."Line No." <> 0 THEN BEGIN
            UserSetupRec.GET(USERID);
            //UserSetupRec.TESTFIELD("Global Dimension 1 Code");
            if Rec."Journal Template Name" <> '' Then begin
                If Rec."Order Type" = Rec."Order Type"::Production then begin
                    if Rec."Source Code" <> 'REVALJNL' then begin
                        ProdOrder.Get(ProdOrder.Status::Released, Rec."Document No.");
                        Rec."Bardana Generation Entry" := ProdOrder."Bardana RPO";
                    end;
                end;
                Rec.VALIDATE("Responsibility Center", rec."Responsibility Center");
                Rec.VALIDATE("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
            end;
            IF NOT UserSetupRec."User Permission" THEN BEGIN
                UserSetupRec.TESTFIELD("Global Dimension 2 Code");
                IF NOT UserSetupRec."HO Users" THEN
                    UserSetupRec.TESTFIELD("Shortcut Dimension 3 Code");
                if Rec."Journal Template Name" <> '' Then begin
                    Rec.VALIDATE("Responsibility Center", UserSetupRec."Responsibility Center");
                    Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                    Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                end;
                IF NOT UserSetupRec."HO Users" THEN
                    if Rec."Journal Template Name" <> '' Then
                        if not Rec."Bardana Generation Entry" then
                            Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
                if locrec.gET(rEC."Location Code") then
                    If Not LocRec."Use As In-Transit" Then Begin
                        IF NOT UserSetupRec."HO Users" THEN
                            if (Rec."Journal Batch Name" <> '') Then
                                if Rec."Item No." <> '' then
                                    if not Rec."Bardana Generation Entry" then
                                        Rec.VALIDATE("Location Code", UserSetupRec."Shortcut Dimension 3 Code");
                    End;
            END;
        END;
    end;


    [EventSubscriber(ObjectType::Table, 50011, 'OnAfterInsertEvent', '', false, false)]

    local procedure IndentHeaderOnAfterInsert(var Rec: Record 50011; RunTrigger: Boolean)
    var
        UserSetupRec: Record 91;
    begin
        IF Rec."Indent No." <> '' THEN BEGIN
            UserSetupRec.GET(USERID);
            UserSetupRec.TESTFIELD("Global Dimension 1 Code");
            UserSetupRec.TESTFIELD("Global Dimension 2 Code");
            IF NOT UserSetupRec."HO Users" THEN
                UserSetupRec.TESTFIELD("Shortcut Dimension 3 Code");
            Rec.VALIDATE("Responsibility Center", UserSetupRec."Responsibility Center");
            Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
            Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
            IF NOT UserSetupRec."HO Users" THEN
                Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
        END;
    end;



    [EventSubscriber(ObjectType::Table, 50015, 'OnAfterInsertEvent', '', false, false)]
    local procedure GCStatementOnAFterInsert(var Rec: Record 50015; RunTrigger: Boolean)
    var
        UserSetupRec: Record 91;
    begin
        IF Rec."No." <> '' THEN BEGIN
            UserSetupRec.GET(USERID);
            UserSetupRec.TESTFIELD("Global Dimension 1 Code");
            Rec.VALIDATE("Responsibility Center", UserSetupRec."Responsibility Center");
            Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
            IF NOT UserSetupRec."User Permission" THEN BEGIN
                UserSetupRec.TESTFIELD("Global Dimension 2 Code");
                IF NOT UserSetupRec."HO Users" THEN
                    UserSetupRec.TESTFIELD("Shortcut Dimension 3 Code");
                Rec.VALIDATE("Responsibility Center", UserSetupRec."Responsibility Center");
                Rec.VALIDATE("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                Rec.VALIDATE("Shortcut Dimension 2 Code", UserSetupRec."Global Dimension 2 Code");
                IF NOT UserSetupRec."HO Users" THEN BEGIN
                    Rec.VALIDATE("Shortcut Dimension 3 Code", UserSetupRec."Shortcut Dimension 3 Code");
                    Rec.VALIDATE("Farm Code", UserSetupRec."Shortcut Dimension 3 Code");
                END;
            END;
        END;
    end;

    [EventSubscriber(ObjectType::Table, 17, 'OnAfterInsertEvent', '', false, false)]
    local procedure GLupdatePIH(var Rec: Record 17; RunTrigger: Boolean)
    var
        PurchInvHeader: Record 122;
        T_17: Record 17;


    begin
        //PRU_NEELESH
        PurchInvHeader.RESET;
        PurchInvHeader.SETRANGE("No.", Rec."Document No.");
        IF PurchInvHeader.FINDFIRST THEN BEGIN
            Rec."Line Narration1" := PurchInvHeader."Line Narration1";
            Rec.MODIFY;
        END;
        //PRU_NEELESH
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterDeleteEvent', '', false, false)]
    local procedure DeleteAttachedDocumentsOnAfterDeleteCustomer(var Rec: Record "Gen. Journal Line"; RunTrigger: Boolean)
    var
        DocumentAttachment: Record "Document Attachment";
    begin

        DocumentAttachment.Reset();
        DocumentAttachment.SetRange("Table ID", 81);
        DocumentAttachment.SetRange("No.", Rec."Document No.");
        if DocumentAttachment.FindFirst() then
            DocumentAttachment.DeleteAll();

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt", OnAfterSetDocumentAttachmentFiltersForRecRefInternal, '', True, true)]
    local procedure OnAfterSetDocumentAttachmentFiltersForRecRefInternal(var DocumentAttachment: Record "Document Attachment"; RecordRef: RecordRef; GetRelatedAttachments: Boolean)
    var
        GenJnLine: Record "Gen. Journal Line";
        GLEntry: Record "G/L Entry";
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin

        case RecordRef.Number of

            DATABASE::"Gen. Journal Line":
                begin
                    //RecordRef.Open(DATABASE::"Gen. Journal Line");
                    FieldRef := RecordRef.Field(7);
                    RecNo := FieldRef.Value();
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
            DATABASE::"G/L Entry":
                begin
                    //RecordRef.Open(DATABASE::"G/L Entry");
                    FieldRef := RecordRef.Field(6);
                    RecNo := FieldRef.Value();
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        end;

    end;


    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", OnBeforeDrillDown, '', True, true)]
    local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        GenJnLine: Record "Gen. Journal Line";
        GLEntry: Record "G/L Entry";
    begin

        case DocumentAttachment."Table ID" of

            0:
                exit;
            DATABASE::"Gen. Journal Line":
                begin
                    RecRef.Open(DATABASE::"Gen. Journal Line");
                    GenJnLine.Reset();
                    GenJnLine.SetRange("Document No.", DocumentAttachment."No.");
                    if GenJnLine.FindFirst() then
                        RecRef.GetTable(GenJnLine);
                end;
            DATABASE::"G/L Entry":
                begin
                    RecRef.Open(DATABASE::"G/L Entry");
                    GLEntry.Reset();
                    GLEntry.SetRange("Document No.", DocumentAttachment."No.");
                    if GLEntry.FindFirst() then
                        RecRef.GetTable(GLEntry);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", OnAfterGLFinishPosting, '', false, false)]
    local procedure OnAfterGLFinishPosting(GLEntry: Record "G/L Entry"; var GenJnlLine: Record "Gen. Journal Line"; var IsTransactionConsistent: Boolean; FirstTransactionNo: Integer; var GLRegister: Record "G/L Register"; var TempGLEntryBuf: Record "G/L Entry" temporary; var NextEntryNo: Integer; var NextTransactionNo: Integer)
    var
        Fromrecref: RecordRef;
        Torecordref: RecordRef;
        DocumentAttachment: Codeunit "Document Attachment Mgmt";
        RecDocumentAttachment: Record "Document Attachment";

    begin
        Fromrecref.GetTable(GenJnlLine);
        Torecordref.GetTable(GLEntry);
        RecDocumentAttachment.Reset();
        RecDocumentAttachment.SetRange("No.", GLEntry."Document No.");
        RecDocumentAttachment.SetRange("Table ID", 17);
        if not RecDocumentAttachment.FindFirst() then
            DocumentAttachment.CopyAttachmentsForPostedDocs(Fromrecref, Torecordref);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", OnAfterInitFieldsFromRecRef, '', False, false)]
    local procedure OnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    begin
        If RecRef.Number = 81 then begin
            DocumentAttachment.Validate(DocumentAttachment."No.", Format(RecRef.Field(7)));
            DocumentAttachment.Validate(DocumentAttachment."Document Type", Enum::"Attachment Document Type"::Invoice);
        end;
        If RecRef.Number = 17 then begin
            DocumentAttachment.Validate(DocumentAttachment."No.", Format(RecRef.Field(6)));
            DocumentAttachment.Validate(DocumentAttachment."Document Type", Enum::"Attachment Document Type"::Invoice);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt", OnBeforeCopyAttachmentsForPostedDocsLines, '', false, false)]
    local procedure OnBeforeCopyAttachmentsForPostedDocsLines(var FromRecRef: RecordRef; var ToRecRef: RecordRef; var IsHandled: Boolean)
    var
        FromDocumentAttachment: Record "Document Attachment";
        ToDocumentAttachment: Record "Document Attachment";
        FromFieldRef: FieldRef;
        ToFieldRef: FieldRef;
        FromDocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Purchase";
        FromNo: Code[20];
        ToNo: Code[20];
        documentattachment: Codeunit "Document Attachment Mgmt";


    begin

        if FromRecRef.Number = 81 then begin
            IsHandled := true;

            FromDocumentAttachment.SetRange("Table ID", FromRecRef.Number);

            // FromFieldRef := FromRecRef.Field(6);
            // FromDocumentType := FromFieldRef.Value();
            // FromDocumentAttachment.SetRange("Document Type", FromDocumentType);

            FromDocumentAttachment.SetRange("Document Type", Enum::"Attachment Document Type"::Invoice);

            FromFieldRef := FromRecRef.Field(7);
            FromNo := FromFieldRef.Value();
            FromDocumentAttachment.SetRange("No.", FromNo);

            // Find any attached docs for headers (sales / purch)
            if FromDocumentAttachment.FindSet() then
                repeat
                    Clear(ToDocumentAttachment);
                    ToDocumentAttachment.Init();
                    ToDocumentAttachment.TransferFields(FromDocumentAttachment);
                    ToDocumentAttachment.Validate("Table ID", ToRecRef.Number);

                    ToFieldRef := ToRecRef.Field(6);
                    ToNo := ToFieldRef.Value();
                    ToDocumentAttachment.Validate("No.", ToNo);
                    //Clear(ToDocumentAttachment."Document Type");
                    //OnCopyAttachmentsForPostedDocsOnBeforeToDocumentAttachmentInsert(FromDocumentAttachment, ToDocumentAttachment);
                    ToDocumentAttachment.Insert(true);
                //OnCopyAttachmentsForPostedDocsOnAfterToDocumentAttachmentInsert(FromDocumentAttachment, ToDocumentAttachment);
                until FromDocumentAttachment.Next() = 0;
        end;
    end;


    [EventSubscriber(ObjectType::Table, 17, 'OnAfterInsertEvent', '', false, false)]
    local procedure GLupdatePCM(var Rec: Record 17; RunTrigger: Boolean)
    var
        PurchCrMemoHdr: Record 124;
    begin
        //PRU_NEELESH
        PurchCrMemoHdr.RESET;
        PurchCrMemoHdr.SETRANGE("No.", Rec."Document No.");
        IF PurchCrMemoHdr.FINDFIRST THEN BEGIN
            Rec."Line Narration1" := PurchCrMemoHdr."Line Narration1";
            Rec.MODIFY;
        END;
        //PRU_NEELESH
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", 'OnAfterValidateEvent', 'PO Expiration Date', false, false)]

    procedure EmailTriggeronModifyPOExpirationdateOnAfterValidateEvent(var xRec: Record "Purchase Header"; var Rec: Record "Purchase Header")
    var
        SMTPMail: Codeunit "Email Message";
        Email: Codeunit Email;
        User: Record User;
        UserSetup: Record "User Setup";
        PurchLine: Record "Purchase Line";
    begin
        UserSetup.Get(UserId);
        if xRec."Document Type" = xRec."Document Type"::Order then
            if xRec.Status = xRec.Status::Released then
                if xRec."PO Expiration Date" <> 0D then begin
                    SMTPMail.Create('vishwajeetbehl@sampoornafeeds.in', 'Alert!! PO Expiration Date Changed for Vendor ' + Rec."Buy-from Vendor Name", '', true);
                    //SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, '');
                    SMTPMail.AddRecipient(Enum::"Email Recipient Type"::Cc, UserSetup."E-Mail");


                    SMTPMail.AppendToBody('Dear Sir,' + '<br><br>');
                    User.Reset();
                    User.SetRange("User Name", UserId);
                    if User.FindFirst() Then
                        SMTPMail.AppendToBody('The Purchase order has ben modified with the PO Expiration date, these modification has been Done by User ' + User."Full Name" + '<br><br>');//PRU-VG
                    SMTPMail.AppendToBody('Please find the below detail for your ref.' + '<br><br>');
                    //SMTPMail.AppendToBody('<br><br>');

                    SMTPMail.AppendToBody('<table  border="1">');
                    SMTPMail.AppendToBody('<tr>');
                    SMTPMail.AppendToBody('<th>' + 'PO No.' + '</th>');
                    SMTPMail.AppendToBody('<th>' + 'Vendor Name' + '</th>');
                    SMTPMail.AppendToBody('<th>' + 'Location Name' + '</th>');
                    SMTPMail.AppendToBody('<th>' + 'Old PO Expiration Date' + '</th>');
                    SMTPMail.AppendToBody('<th>' + 'New PO Expiration Date' + '</th>');

                    SMTPMail.AppendToBody('</tr>');
                    SMTPMail.AppendToBody('<tr>');
                    SMTPMail.AppendToBody('<td align = center>' + Format(Rec."No.") + '</td>');
                    SMTPMail.AppendToBody('<td align = center>' + Format(Rec."Buy-from Vendor Name") + '</td>');

                    SMTPMail.AppendToBody('<td align = center>' + Format(Rec."Ship-to Name") + '</td>');
                    SMTPMail.AppendToBody('<td align = center>' + Format(xRec."PO Expiration Date") + '</td>');
                    SMTPMail.AppendToBody('<td align = center>' + Format(Rec."PO Expiration Date") + '</td>');

                    SMTPMail.AppendToBody('</tr>');
                    SMTPMail.AppendToBody('</table>');
                    // Suman/03-03-2024
                    //PO Line//

                    SMTPMail.AppendToBody('<table  border="1">');
                    SMTPMail.AppendToBody('<tr>');
                    SMTPMail.AppendToBody('<th>' + 'Item Name' + '</th>');
                    SMTPMail.AppendToBody('<th>' + 'PO Balance Qty' + '</th>');
                    SMTPMail.AppendToBody('<th>' + 'Rate' + '</th>');
                    PurchLine.Reset();
                    PurchLine.SetRange("Document No.", Rec."No.");
                    PurchLine.SetFilter(PurchLine.Type, '<>%1', PurchLine.Type::" ");
                    if PurchLine.FindFirst() then
                        repeat
                            SMTPMail.AppendToBody('</tr>');
                            SMTPMail.AppendToBody('<tr>');
                            SMTPMail.AppendToBody('<td align = center>' + Format(PurchLine.Description) + '</td>');
                            SMTPMail.AppendToBody('<td align = center>' + Format(PurchLine."Qty. to Receive") + '</td>');
                            SMTPMail.AppendToBody('<td align = center>' + Format(PurchLine."Direct Unit Cost") + '</td>');
                        Until PurchLine.Next() = 0;

                    SMTPMail.AppendToBody('</tr>');
                    SMTPMail.AppendToBody('</table>');

                    SMTPMail.AppendToBody('<br><br>');
                    SMTPMail.AppendToBody('This is a system generated mail., kindly do not reply on this email IDs, if you have any queries please contact dealing desk' + '<br><br>');

                    SMTPMail.AppendToBody('Thanks & Regards,' + '<br>');

                    SMTPMail.AppendToBody(User."Full Name");

                    Email.Send(SMTPMail, Enum::"Email Scenario"::Default);
                    SLEEP(100);
                end;
    end;

    procedure UpdateApproverIDInTables(ApprovalEntry: Record 454)
    var
        PurchaseHeader_Loc: Record 38;
        ApprovalRecordId: Text;
        IsVendorID_Loc: Text;
        VendorID_Loc: Text;
        Vendor_Rec: Record 23;
        TableName: Text;
        Str1: Text;
        Str2: Text;
        Str3: Text;
        CommaPosition: Integer;
        GenJournalLine: Record 81;
        LineNo: Integer;
        CustomerRec: Record 18;
        ItemRec: Record 27;
    begin
        //PRU_NEELESH
        IF (ApprovalEntry."Table ID" = 23) THEN BEGIN
            CLEAR(ApprovalRecordId);
            CLEAR(IsVendorID_Loc);
            CLEAR(ApprovalRecordId);
            ApprovalRecordId := ApprovalEntry.RecordDetails;
            IsVendorID_Loc := COPYSTR(ApprovalRecordId, 1, 7);
            IF (IsVendorID_Loc = 'Vendor:') THEN BEGIN
                VendorID_Loc := COPYSTR(ApprovalRecordId, 9, STRLEN(ApprovalRecordId));
                IF Vendor_Rec.GET(VendorID_Loc) THEN BEGIN
                    Vendor_Rec.Status := Vendor_Rec.Status::Approved;
                    Vendor_Rec.MODIFY;

                END;
            END;
        END;

        IF (ApprovalEntry."Table ID" = 18) THEN BEGIN
            CLEAR(ApprovalRecordId);
            CLEAR(IsVendorID_Loc);
            CLEAR(ApprovalRecordId);
            ApprovalRecordId := ApprovalEntry.RecordDetails;
            IsVendorID_Loc := COPYSTR(ApprovalRecordId, 1, 9);
            IF (IsVendorID_Loc = 'Customer:') THEN BEGIN
                VendorID_Loc := COPYSTR(ApprovalRecordId, 11, STRLEN(ApprovalRecordId));
                IF CustomerRec.GET(VendorID_Loc) THEN BEGIN
                    //CustomerRec."Remaining Credit Limit" := CustomerRec."Updated Credit Limit";
                    //CustomerRec."Updated Credit Limit" :=0;
                    CustomerRec.Status := CustomerRec.Status::Approved;
                    CustomerRec.MODIFY;
                END;
            END;
        END;


        IF (ApprovalEntry."Table ID" = 27) THEN BEGIN
            CLEAR(ApprovalRecordId);
            CLEAR(IsVendorID_Loc);
            CLEAR(ApprovalRecordId);
            ApprovalRecordId := ApprovalEntry.RecordDetails;
            IsVendorID_Loc := COPYSTR(ApprovalRecordId, 1, 5);
            IF (IsVendorID_Loc = 'Item:') THEN BEGIN
                VendorID_Loc := COPYSTR(ApprovalRecordId, 7, STRLEN(ApprovalRecordId));
                IF ItemRec.GET(VendorID_Loc) THEN BEGIN
                    ItemRec.Status := ItemRec.Status::Approved;
                    ItemRec.MODIFY;
                END;
            END;
        END;
        //PRU_NEELESH
    end;


    procedure UpdateRejectrIDInTables(ApprovalEntry: Record 454)
    var
        PurchaseHeader_Loc: Record 38;
        ApprovalRecordId: Text;
        IsVendorID_Loc: Text;
        VendorID_Loc: Text;
        Vendor_Rec: Record 23;
        TableName: Text;
        Str1: Text;
        Str2: Text;
        Str3: Text;
        CommaPosition: Integer;
        GenJournalLine: Record 81;
        CustomerRec: Record 18;
        ItemRec: Record 27;
    begin
        //PRU_NEELESH
        CLEAR(ApprovalRecordId);
        CLEAR(IsVendorID_Loc);
        CLEAR(VendorID_Loc);
        ApprovalRecordId := ApprovalEntry.RecordDetails;
        IsVendorID_Loc := COPYSTR(ApprovalRecordId, 1, 7);
        IF (IsVendorID_Loc = 'Vendor:') THEN BEGIN
            VendorID_Loc := COPYSTR(ApprovalRecordId, 9, STRLEN(ApprovalRecordId));
            IF Vendor_Rec.GET(VendorID_Loc) THEN BEGIN
                Vendor_Rec.Status := Vendor_Rec.Status::Open;
                Vendor_Rec.MODIFY;
            END;
        END;

        CLEAR(ApprovalRecordId);
        CLEAR(IsVendorID_Loc);
        CLEAR(VendorID_Loc);
        ApprovalRecordId := ApprovalEntry.RecordDetails;
        IsVendorID_Loc := COPYSTR(ApprovalRecordId, 1, 9);
        IF (IsVendorID_Loc = 'Customer:') THEN BEGIN
            VendorID_Loc := COPYSTR(ApprovalRecordId, 11, STRLEN(ApprovalRecordId));
            IF CustomerRec.GET(VendorID_Loc) THEN BEGIN
                CustomerRec.Status := CustomerRec.Status::Open;
                CustomerRec.MODIFY;
            END;
        END;
        CLEAR(ApprovalRecordId);
        CLEAR(IsVendorID_Loc);
        CLEAR(VendorID_Loc);
        ApprovalRecordId := ApprovalEntry.RecordDetails;
        IsVendorID_Loc := COPYSTR(ApprovalRecordId, 1, 5);
        IF (IsVendorID_Loc = 'Customer:') THEN BEGIN
            VendorID_Loc := COPYSTR(ApprovalRecordId, 7, STRLEN(ApprovalRecordId));
            IF ItemRec.GET(VendorID_Loc) THEN BEGIN
                ItemRec.Status := ItemRec.Status::Open;
                ItemRec.MODIFY;
            END;
        END;

        //PRU_NEELESH
    end;

    procedure UpdateUserSetup(ResCenter: Code[20]; BranchCode: Code[20]; LocCode: Code[20])
    Var
        UserSetup: Record "User Setup";
        UserResSetup: Record "User Wise Resp. Center";
        FoundResCenter: Boolean;
        Text001: Label 'You do not have permissions for responsibility center %1 \ Contact your system administrator if you need to have your permissions changed.';
        Text002: Label 'Responsibility Center should not be blank.';
        Text004: Label 'Please select Responsibility Center';
        Text005: Label 'Please select Branch Code';
        Text006: Label 'Please select Location Code';
        Text008: Label 'You can only select responsibility center %1, because same user %2 is already working on same responsibility center %3 using another session.\\For more assisstence, please coordinate with your erp administrator.';
        Text010: Label 'Please press OK button to Log In the database.';

    begin

        UserSetup.GET(USERID);
        IF NOT UserResSetup.GET(USERID, ResCenter) THEN
            ERROR('User must have a proper Responsibility Center Permission');
        UserSetup.VALIDATE("Global Dimension 1 Code", ResCenter);
        UserSetup.VALIDATE("Purchase Resp. Ctr. Filter", ResCenter);
        UserSetup.VALIDATE("Sales Resp. Ctr. Filter", ResCenter);
        UserSetup.VALIDATE("Responsibility Center", ResCenter);
        UserSetup.VALIDATE("Service Resp. Ctr. Filter", ResCenter); //RK-PRU
        UserSetup.VALIDATE("Global Dimension 2 Code", BranchCode);
        //UserSetup.Validate("Super User", True);
        IF NOT UserSetup."HO Users" THEN
            UserSetup.VALIDATE("Shortcut Dimension 3 Code", LocCode)
        ELSE
            UserSetup.VALIDATE("Shortcut Dimension 3 Code", '');
        //UserSetup."Plant Code" := ResCenter;

        UserSetup.MODIFY;
        FoundResCenter := TRUE;
        UserSetup.GET(USERID); ///Pru_gk
        IF UserSetup."User Permission" = TRUE THEN BEGIN ///Pru_gk
            IF ResCenter = '' THEN
                ERROR(Text004);
        END ELSE BEGIN
            IF ResCenter = '' THEN
                ERROR(Text004);
            IF BranchCode = '' THEN
                ERROR(Text005);
            UserSetup.GET(USERID);
            IF NOT UserSetup."HO Users" THEN BEGIN
                IF LocCode = '' THEN
                    ERROR(Text006);

            END;
        END;
        IF NOT FoundResCenter THEN
            ERROR(Text010);

        // if not LoginDimension.Get(ServiceInstanceId(), SessionId()) then begin
        //     LoginDimension.Init();
        //     LoginDimension."Server Instance ID" := ServiceInstanceId();
        //     LoginDimension."Session ID" := SessionId();
        //     LoginDimension."Global Dimension 1 Code" := ResCenter;
        //     LoginDimension."Global Dimension 2 Code" := BranchCode;
        //     LoginDimension."Shortcut Dimension 3 Code" := LocCode;
        //     LoginDimension.Insert();

        // end;
    end;
}

