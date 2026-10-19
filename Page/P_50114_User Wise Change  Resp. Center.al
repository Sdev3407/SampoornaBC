page 50114 "User Wise Change  Resp. Center"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "User Wise Resp. Center";
    layout
    {
        area(content)
        {
            field("USER ID"; USERID)
            {
                ApplicationArea = All;
            }
            field("Responsibility Center"; ResCenter)
            {
                ApplicationArea = All;
                Enabled = ActivateControl;

                trigger OnLookup(var Text: Text): Boolean
                begin

                    CLEAR(PageResCenter);
                    CLEAR(ResCenter);

                    UserResSetup.RESET;
                    UserResSetup.SETRANGE("User ID", USERID);
                    UserResSetup.SETFILTER("Responsibility Center", '<>%1', '');
                    UserResSetup.SETFILTER("Global Dimension 1 Code", '<>%1', '');
                    UserResSetup.FIND('-');
                    UserResSetup.FILTERGROUP(2);
                    PageResCenter.SETTABLEVIEW(UserResSetup);
                    PageResCenter.LOOKUPMODE := TRUE;
                    IF PageResCenter.RUNMODAL = ACTION::LookupOK THEN
                        ResCenter := PageResCenter.GetResCenter;
                end;

                trigger OnValidate()
                var
                    UserWiseRespCenter: Record "User Wise Resp. Center";
                begin
                    IF NOT UserWiseRespCenter.GET(USERID, ResCenter) THEN
                        ERROR('User ID %1 does not comes in the %2 Responsibility Center. Contact your system administrator', USERID, ResCenter);
                end;
            }
            field(BranchCode; BranchCode)
            {
                ApplicationArea = All;
                Caption = 'Branch Code';
                Visible = ShowField1;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CLEAR(PageBranchCenter);
                    CLEAR(BranchCode);

                    UserBranchSetup.RESET;
                    UserBranchSetup.SETRANGE("User ID", USERID);
                    UserBranchSetup.SETFILTER("Responsibility Center", '%1', ResCenter);
                    UserBranchSetup.SETFILTER("Global Dimension 1 Code", '%1', ResCenter);
                    UserBranchSetup.SETFILTER("Global Dimension 2 Code", '<>%1', '');
                    UserBranchSetup.FIND('-');
                    UserBranchSetup.FILTERGROUP(2);
                    PageBranchCenter.SETTABLEVIEW(UserBranchSetup);
                    PageBranchCenter.LOOKUPMODE := TRUE;
                    IF PageBranchCenter.RUNMODAL = ACTION::LookupOK THEN
                        BranchCode := PageBranchCenter.GetResCenter;
                end;

                trigger OnValidate()
                var
                    UserBranchRespCenter: Record "User Branch Resp. Center";
                begin
                    IF NOT UserBranchRespCenter.GET(USERID, ResCenter, BranchCode) THEN
                        ERROR('User ID %1 does not comes in the %2 Branch Code. Contact your system administrator', USERID, BranchCode);
                end;
            }
            field(LocCode; LocCode)
            {
                ApplicationArea = All;
                Caption = 'Location Code';
                Visible = ShowField;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CLEAR(PageLocCenter);
                    CLEAR(LocCode);

                    UserLocSetup.RESET;
                    UserLocSetup.SETRANGE("User ID", USERID);
                    UserLocSetup.SETFILTER("Responsibility Center", '%1', ResCenter);
                    UserLocSetup.SETFILTER("Global Dimension 1 Code", '%1', ResCenter);
                    UserLocSetup.SETFILTER("Global Dimension 2 Code", '%1', BranchCode);
                    UserLocSetup.SETFILTER("Shortcut Dimension 3 Code", '<>%1', '');
                    UserLocSetup.FIND('-');
                    UserLocSetup.FILTERGROUP(2);
                    PageLocCenter.SETTABLEVIEW(UserLocSetup);
                    PageLocCenter.LOOKUPMODE := TRUE;
                    IF PageLocCenter.RUNMODAL = ACTION::LookupOK THEN
                        LocCode := PageLocCenter.GetResCenter;
                end;

                trigger OnValidate()
                var
                    UserLocationRespCenter: Record "User Location Resp. Center";
                begin
                    IF NOT UserLocationRespCenter.GET(USERID, ResCenter, BranchCode, LocCode) THEN
                        ERROR('User ID %1 does not comes in the %2 Location Code. Contact your system administrator', USERID, LocCode);
                end;
            }
        }
    }

    actions
    {
    }

    trigger OnClosePage()
    begin
        UserSetup.GET(USERID); ////// Pru_gk ASUP_0.1
        IF UserSetup."User Permission" = FALSE THEN BEGIN ////// Pru_gk ASUP_0.1
            IF ResCenter = '' THEN
                ERROR(Text004);
            IF BranchCode = '' THEN
                ERROR(Text005);
            UserSetup.GET(USERID);
            IF NOT UserSetup."HO Users" THEN BEGIN
                IF LocCode = '' THEN
                    ERROR(Text006);
            END;
        END ELSE BEGIN
            IF ResCenter = '' THEN
                ERROR(Text004);
        END;


        IF NOT FoundResCenter THEN
            ERROR(Text010);
    end;

    trigger OnOpenPage()
    begin
        FoundResCenter := FALSE;
        compinfo.CALCFIELDS(Picture);
        IF UserSetup.GET(USERID) THEN
            ActivateControl := TRUE
        ELSE
            ActivateControl := FALSE;
        //CurrPage."Responsibility Center".ACTIVATE;
        UserSetup.GET(USERID);
        ////Pru_gk
        IF (NOT UserSetup."HO Users") AND (UserSetup."User Permission" = FALSE) THEN
            ShowField := TRUE;

        IF (UserSetup."HO Users") AND (UserSetup."User Permission" = TRUE) THEN
            ShowField := FALSE;

        IF (NOT UserSetup."HO Users") AND (UserSetup."User Permission" = TRUE) THEN
            ShowField := FALSE;

        IF (UserSetup."HO Users") AND (UserSetup."User Permission" = FALSE) THEN
            ShowField := FALSE;
        //Pru_gk

        IF (NOT UserSetup."HO Users") THEN
            ShowField1 := TRUE;
        IF UserSetup."User Permission" = FALSE THEN
            ShowField1 := TRUE;
        IF UserSetup."HO Users" = TRUE THEN
            ShowField1 := TRUE;
        IF UserSetup."User Permission" = TRUE THEN
            ShowField1 := FALSE;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        //IF CloseAction IN [ACTION::OK,ACTION::LookupOK] THEN
        IF CloseAction IN [ACTION::OK] THEN BEGIN
            IF ResCenter = '' THEN
                ERROR(Text002)
            ELSE BEGIN
                UserSetup.GET(USERID);
                L_Session.RESET;
                L_Session.SETRANGE("User ID", USERID);
                // L_Session.SETRANGE("Database Name",'Napino-Payroll');
                IF L_Session.FINDFIRST THEN BEGIN
                    IF L_Session.COUNT > 1 THEN BEGIN
                        IF UserSetup."Responsibility Center" <> ResCenter THEN
                            ERROR(Text008, UserSetup."Responsibility Center", UserSetup."User ID", UserSetup."Responsibility Center");
                    END;
                END;

                UserSetup.GET(USERID);
                IF NOT UserResSetup.GET(USERID, ResCenter) THEN
                    ERROR('User must have a proper Responsibility Center Permission');
                UserSetup.VALIDATE("Global Dimension 1 Code", ResCenter);
                UserSetup.VALIDATE("Purchase Resp. Ctr. Filter", ResCenter);
                UserSetup.VALIDATE("Sales Resp. Ctr. Filter", ResCenter);
                UserSetup.VALIDATE("Responsibility Center", ResCenter);
                UserSetup.VALIDATE("Service Resp. Ctr. Filter", ResCenter); //RK-PRU
                UserSetup.VALIDATE("Global Dimension 2 Code", BranchCode);
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


                CurrPage.CLOSE;
            END;
        END;
    end;

    var
        Text001: Label 'You do not have permissions for responsibility center %1 \ Contact your system administrator if you need to have your permissions changed.';
        Text002: Label 'Responsibility Center should not be blank.';
        Text004: Label 'Please select Responsibility Center';
        Text008: Label 'You can only select responsibility center %1, because same user %2 is already working on same responsibility center %3 using another session.\\For more assisstence, please coordinate with your erp administrator.';
        Text010: Label 'Please press OK button to Log In the database.';
        UserResSetup: Record "User Wise Resp. Center";
        ResCenter: Code[20];
        SalesResCenter: Code[20];
        PurchResCenter: Code[20];
        UserSetup: Record 91;
        flag: Boolean;
        compinfo: Record 79;
        ResCenterName: Text[30];
        SalesResCenterName: Text[30];
        PurchResCenterName: Text[30];
        ResRec: Record 5714;
        PageResCenter: Page "User Lob Resp. Center";
        L_Session: Record 2000000009;
        FoundResCenter: Boolean;
        ActivateControl: Boolean;
        BranchCode: Code[20];
        PageBranchCenter: Page "User Branch Resp. Center";
        UserBranchSetup: Record "User Branch Resp. Center";
        LocCode: Code[20];
        PageLocCenter: Page "User Location Resp. Center";
        UserLocSetup: Record "User Location Resp. Center";
        Text005: Label 'Please select Branch Code';
        Text006: Label 'Please select Location Code';
        ShowField: Boolean;
        ShowField1: Boolean;
}

