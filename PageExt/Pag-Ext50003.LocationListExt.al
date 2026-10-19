
pageextension 50003 LocationListExt extends "Location List"
{
    layout
    {
        addafter(Name)
        {
            field(Address; Rec.Address)
            {
                ApplicationArea = all;
            }
            field("Address 2"; Rec."Address 2")
            {
                ApplicationArea = all;
            }
            field("Post Code"; Rec."Post Code")
            {
                ApplicationArea = all;
            }
            field("State Code"; Rec."State Code")
            {
                ApplicationArea = all;
            }
            field("GST Registration No."; Rec."GST Registration No.")
            {
                ApplicationArea = all;
            }
            field("Phone No."; Rec."Phone No.")
            {
                ApplicationArea = all;
            }
            field(City; Rec.City)
            {
                ApplicationArea = all;
            }

            field("Farm Type"; Rec."Farm Type")
            {
                ApplicationArea = All;

            }


            field(Farmer; Rec.Farmer)
            {
                ApplicationArea = All;

            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;

            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;

            }
            field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;

            }
            field("Flock Prefix"; Rec."Flock Prefix")
            {
                ApplicationArea = All;

            }
            field("Farmer Name"; Rec."Farmer Name")
            {
                ApplicationArea = All;

            }
            field("Account No."; Rec."Account No.")
            {
                ApplicationArea = All;

            }
            field("Bank Name"; Rec."Bank Name")
            {
                ApplicationArea = All;

            }
            field("IFSC Code"; Rec."IFSC Code")
            {
                ApplicationArea = All;

            }

            field("Aadhar No."; Rec."Aadhar No.")
            {
                ApplicationArea = All;

            }
            field("Farmer Group"; Rec."Farmer Group")
            {
                ApplicationArea = All;

            }
            field("Payment Type"; Rec."Payment Type")
            {
                ApplicationArea = All;

            }
            field("Total Sq.Ft Area"; Rec."Total Sq.Ft Area")
            {
                ApplicationArea = All;

            }
            field("Tds%"; Rec."Tds%")
            {
                ApplicationArea = All;

            }
            field("P.A.N"; Rec."P.A.N")
            {
                ApplicationArea = All;

            }
            field("Security Check 1"; Rec."Security Check 1")
            {
                ApplicationArea = All;

            }
            field("Security Check 2"; Rec."Security Check 2")
            {
                ApplicationArea = All;

            }
            field("Security Amount"; Rec."Security Amount")
            {
                ApplicationArea = All;

            }
            field("Bank Branch"; Rec."Bank Branch")
            {
                ApplicationArea = All;

            }
            field(Mandal; Rec.Mandal)
            {
                ApplicationArea = All;

            }
            field("Date of Agreement"; Rec."Date of Agreement")
            {
                ApplicationArea = All;

            }
            field(Own; Rec.Own)
            {
                ApplicationArea = All;

            }
            field(Lease; Rec.Lease)
            {
                ApplicationArea = All;

            }
            field("Own Rental"; Rec."Own Rental")
            {
                ApplicationArea = All;

            }
            field("Agreement End Date"; Rec."Agreement End Date")
            {
                ApplicationArea = All;

            }
            field("Incoming Document Entry No."; Rec."Incoming Document Entry No.")
            {
                ApplicationArea = All;

            }
            field("Document Type"; Rec."Document Type")
            {
                ApplicationArea = All;

            }
            field(Block; Rec.Block)
            {
                ApplicationArea = All;

            }
            field("Per Bird Sq. Ft"; Rec."Per Bird Sq. Ft")
            {
                ApplicationArea = All;

            }
            field(Capicity; Rec.Capicity)
            {
                ApplicationArea = All;

            }
            field(Grade; Rec.Grade)
            {
                ApplicationArea = All;

            }
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = All;

            }
            field("Rejection Location"; Rec."Rejection Location")
            {
                ApplicationArea = All;

            }
            field("Farmer Code"; Rec."Farmer Code")
            {
                ApplicationArea = All;

            }
            field("Liquidation Date"; Rec."Liquidation Date")
            {
                ApplicationArea = All;

            }
            field("Shed Type"; Rec."Shed Type")
            {
                ApplicationArea = All;

            }
            field("Dimension Set ID"; Rec."Dimension Set ID")
            {
                ApplicationArea = All;

            }
            field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;

            }
            field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
            {
                ApplicationArea = All;

            }
            field("Location Type"; Rec."Location Type")
            {
                ApplicationArea = All;

            }
            field("Location Mail ID"; Rec."Location Mail ID")
            {
                ApplicationArea = All;

            }
            field("Electricity Connection Number"; Rec."Electricity Connection Number")
            {
                ApplicationArea = All;

            }
            field("Farm address"; Rec."Farm address")
            {
                ApplicationArea = All;

            }
            field("Farm address 2"; Rec."Farm address 2")
            {
                ApplicationArea = All;

            }
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;

            }
            field("Region Code"; rec."Region Code")
            {
                ApplicationArea = all;
            }
        }
        addafter(Control1905767507)
        {
            part("Attached Documents"; "AXT Location Document Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(14),
                              "No." = FIELD("Code"), "Document Type" = filter(Order);
            }
        }
    }

    actions
    {
        addafter("Transfer Order")
        {
            action("Change Log")
            {
                ApplicationArea = All;
                Image = ChangeLog;
                RunObject = Page "Change Log Entries";
                RunPageLink = "Table No." = FILTER(14), "Primary Key Field 1 Caption" = field(Code);

            }
            action("Detail Sent to Website")
            {
                ApplicationArea = All;
                trigger OnAction()
                var

                Begin
                    UpdateLocationDetailtoWebsite(Rec.Code);
                End;


            }




            action("Attachements")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Attachements';
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = page "AXT Location Document Attached";
                RunPageLink = "Table ID" = filter(14), "No." = field(Code), "Document Type" = const(Order);
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Location Master", '%1', UserSetup."Access Location Master"::View);
        ERROR('You can not delete the record');
        //PRU_DD 1.10
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Location Master", '%1', UserSetup."Access Location Master"::" ");
        IF UserSetup.FINDFIRST THEN
            Error('You can not Create the record');
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Location Master", '%1', UserSetup."Access Location Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Location Master", '%1', UserSetup."Access Location Master"::View);
        IF UserSetup.FINDFIRST THEN
            ERROR('You can not modify the record');
        //PRU_DD 1.10
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Location Master", '%1', UserSetup."Access Location Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10
    end;

    trigger OnOpenPage()
    begin

        //TRI A.S 19.09.13 START
        // Rec.FILTERGROUP(2);
        // userset.GET(USERID);
        // userset.TESTFIELD("Responsibility Center");
        // IF NOT userset."HO Users" THEN
        //    // Rec.SETFILTER("Responsibility Center", '%1|%2', userset."Responsibility Center", '');
        // Rec.FILTERGROUP(0);
        // //TRI A.S 19.09.13 STOP


        //PRU_DD 1.10
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Location Master", '%1', UserSetup."Access Location Master"::" ");
        IF UserSetup.FINDFIRST THEN
            ERROR('You do not have permission to open Location List');

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        UserSetup.SETFILTER(UserSetup."Access Location Master", '%1', UserSetup."Access Location Master"::View);
        IF UserSetup.FINDFIRST THEN
            CurrPage.EDITABLE(FALSE);
        //PRU_DD 1.10

    end;

    procedure UpdateLocationDetailtoWebsite(Code: Code[20])
    var
        jObject: JsonObject;
        JobjectText: Text;
        gResponseMsg: Text;
        URL: Text;
        gContent: HttpContent;
        gContentHeaders: HttpHeaders;
        gHttpClient: HttpClient;
        gHttpRequestMsg: HttpRequestMessage;
        gHttpResponseMsg: HttpResponseMessage;

    begin
        Clear(jObject);
        jObject.Add('locationno', Rec.Code);
        jObject.Add('locationname', Rec.Name);
        jObject.Add('address', Rec.Address);
        jObject.Add('address_2', Rec."Address 2");
        jObject.Add('post_Code', Rec."Post Code");
        jObject.Add('state_Code', Rec."State Code");

        jObject.Add('gsT_Registration_No', Rec."GST Registration No.");
        jObject.Add('phone_No', Rec."Phone No.");
        jObject.Add('city', Rec.City);
        jObject.Add('block', Rec.Block);
        jObject.WriteTo(JobjectText);


        URL := 'http://103.10.191.226:8020/api/Location/Add-Edit-Location';
        ClearLastError();
        Clear(gResponseMsg);
        gContent.GetHeaders(gContentHeaders);
        gContent.WriteFrom(JobjectText);
        gContentHeaders.Remove('Content-Type');
        gContentHeaders.Add('Content-Type', 'application/json');
        gHttpClient.DefaultRequestHeaders.add('Authorization', 'Basic QWRtaW46QWRtaW5AMTIz');
        gHttpRequestMsg.SetRequestUri(URL);
        gHttpRequestMsg.Content := gContent;
        gHttpRequestMsg.Method('POST');
        if gHttpClient.Send(gHttpRequestMsg, gHttpResponseMsg) then begin
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                gHttpResponseMsg.Content.ReadAs(gResponseMsg);
                // Message(gRequestMsg);
            end;
        end;
    end;


    var
        userset: Record 91;
        UserSetup: Record 91;

}
