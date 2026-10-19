namespace Sampoorna_BC.Sampoorna_BC;
using Microsoft.Purchases.Vendor;
using Microsoft.Sales.Setup;
using System.Text;
using Microsoft.Sales.Customer;
using Microsoft.Inventory.Location;
using Microsoft.Sales.History;
using Microsoft.Finance.TaxBase;

//SIM -----Code Added---->>>>>>----------
codeunit 50060 UpdatePANNo
{
    procedure UpdateVendor(VendCode: Code[100]; PANNo: Code[10])
    var
        AccessTokenKey: Text;
        Vendor: Record Vendor;
        Expiresin: Integer;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        ExpiryDT: DateTime;
        MessResponse: Text;
    begin
        if Vendor.get(VendCode) then begin
            if (Vendor."PAN Link Status" <> Vendor."PAN Link Status"::Operative) then begin
                GetAccessToken(AccessTokenKey, Expiresin);
                SetToken('MasterIndia', AccessTokenKey, DataScope::Module);
                SendPANSearchRequest(PANNo, MessResponse);
                if MessResponse = 'YES' then begin
                    Vendor.Validate("PAN Link Status", Vendor."PAN Link Status"::Operative);
                    //Vendor."P.A.N. Status" := Vendor."P.A.N. Status"::" ";
                End else begin
                    Message(MessResponse);
                    Vendor.Validate("PAN Link Status", Vendor."PAN Link Status"::Inoperative);
                End;
                Vendor.Modify();
            end;
            Commit();
            // Vendor.Modify();
        END;            //Vendor."PAN Link Status" := Vendor."PAN Link Status"::Inoperative;

    end;

    procedure UpdateCustomer(CustCode: Code[100]; CustPANNo: Code[10])
    var
        AccessTokenKey: Text;
        Customer: Record Customer;
        Expiresin: Integer;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        ExpiryDT: DateTime;
        MessResponse: Text;
    begin
        if Customer.get(CustCode) then begin
            if (Customer."PAN Link Status" <> Customer."PAN Link Status"::Operative) then begin
                GetAccessToken(AccessTokenKey, Expiresin);
                SetToken('MasterIndia', AccessTokenKey, DataScope::Module);
                SendPANSearchRequest(CustPANNo, MessResponse);
                if MessResponse = 'YES' then begin
                    Customer."PAN Link Status" := Customer."PAN Link Status"::Operative;

                end else begin
                    Message(MessResponse);
                    Customer."PAN Link Status" := Customer."PAN Link Status"::Inoperative;
                END;
                Customer.Modify();
            end;
        end;
    end;

    [NonDebuggable]
    procedure SetToken(KeyTxt: Text; Token: Text; Scope: DataScope)
    var
        FailedToSaveErr: Label 'Failed to save Token!';
    begin
        if not IsolatedStorage.Set(KeyTxt, Token, Scope) then
            Error(FailedToSaveErr);
    end;

    [NonDebuggable]
    procedure GetInfo(KeyTxt: Text; Scope: DataScope) Token: Text
    var
        NotFoundErr: Label 'Token %1 not found!', Comment = '%1= token';
    begin
        if IsolatedStorage.Contains(KeyTxt, Scope) then
            IsolatedStorage.Get(KeyTxt, Scope, Token);
        // else
        // Error(NotFoundErr, KeyTxt);
    end;

    procedure GetAccessToken(var AccessTok: Text; var ExpiresIn: Integer): Text
    var

        APIIntegrationSetup: Record "Sales & Receivables Setup";
        APIResponse: Text;
        Body: Text;
        JSONManagement: Codeunit "JSON Management";
        gResponseMsg: Text;
        gRequestMsg: Text;
        gContent: HttpContent;
        gContentHeaders: HttpHeaders;
        gHttpClient: HttpClient;
        JsonText: Text;
        gHttpResponseMsg: HttpResponseMessage;
        gHttpRequestMsg: HttpRequestMessage;
        URL: Text;
        Body2: Text;
        Json: Text;
        WebURL: Label 'https://commonapi.mastersindia.co/oauth/access_token';
    begin
        CLEARALL;
        CLEAR(APIResponse);

        Body := '{' +
          '"username":"' + 'sumandev@sampoornafeeds.in' + '",' +
          '"password":"' + 'Goodluck@12India' + '",' +
          '"client_id":"' + 'QKCUuNMLRZnUgNQJJg' + '",' +
          '"client_secret":"' + 'UGelnP6hP1bbroywvbpNyneL' + '",' +
           '"grant_type":"' + 'password' + '"' +
       '}';

        Clear(AccessTok);
        Clear(ExpiresIn);
        Clear(gResponseMsg);
        gContent.WriteFrom(Body);
        gContent.GetHeaders(gContentHeaders);
        gContentHeaders.Clear();
        gContentHeaders.Add('Content-Type', 'application/json');
        if gHttpClient.Post(WebURL, gContent, gHttpResponseMsg) then begin
            gHttpResponseMsg.Content.ReadAs(Json);
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                //MESSAGE(Json);
                IF (GetResponsesValue(Json, '"access_token', ',', 1) <> '') THEN BEGIN
                    AccessTok := GetResponsesValue(Json, '"access_token', ',', 1);
                    Evaluate(ExpiresIn, GetResponsesValue(Json, '"expires_in', ',', 1));
                END;
            END;
        END;
    END;

    procedure GetResponsesValue(resp3: Text; Lstr: Text; Strng: Text; Cnt: Integer): Text
    var
        mstr: Text;
        IntPos: Integer;
        i: Integer;
        Resp1: Text;
    begin
        IF STRPOS(resp3, Lstr) = 0 THEN
            EXIT('');
        FOR i := 1 TO Cnt DO BEGIN
            IntPos := STRPOS(resp3, Lstr) + STRLEN(Lstr);
            Resp1 := DELSTR(resp3, 1, IntPos);
            resp3 := Resp1;
        END;
        IF Lstr <> 'error' THEN BEGIN
            IF STRPOS(Resp1, Strng) <> 0 THEN
                Resp1 := COPYSTR(Resp1, 1, STRPOS(Resp1, Strng) - 1)
            ELSE
                Resp1 := COPYSTR(Resp1, 1, STRLEN(Resp1) - 1);
            Resp1 := SELECTSTR(1, Resp1);
        END;
        //IF NOT (Lstr = 'StatusDate') THEN
        //   Resp1 := DELCHR(Resp1, '=', ' ');
        Resp1 := DELCHR(Resp1, '=', '"');
        Resp1 := DELCHR(Resp1, '<', ':');
        Resp1 := DELCHR(Resp1, '=', '\');
        EXIT(Resp1);
    END;

    procedure SendPANSearchRequest(PAN: Code[30]; var MessageResponse: Text)
    var

        APIIntegrationSetup: Record "Sales & Receivables Setup";
        APIResponse: Text;
        Body: Text;
        JSONManagement: Codeunit "JSON Management";
        gResponseMsg: Text;
        gRequestMsg: Text;
        gContent: HttpContent;
        gContentHeaders: HttpHeaders;
        gHttpClient: HttpClient;
        JsonText: Text;
        gHttpResponseMsg: HttpResponseMessage;
        gHttpRequestMsg: HttpRequestMessage;
        Json: Text;
        WebURL: Label 'https://commonapi.mastersindia.co/commonapis/panlinkstatus?pan=';
        ErrorResponse: Text;

    begin
        //  CLEARALL;
        CLEAR(APIResponse);
        Clear(gResponseMsg);

        gContent.GetHeaders(gContentHeaders);
        gContentHeaders.Clear();
        gHttpClient.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + GetInfo('MasterIndia', DataScope::Module));
        gHttpClient.DefaultRequestHeaders.Add('client_id', 'tMtzGMPSMcXqsxJVTA');

        if gHttpClient.Get(WebURL + PAN, gHttpResponseMsg) then begin
            gHttpResponseMsg.Content.ReadAs(Json);
            if gHttpResponseMsg.IsSuccessStatusCode then begin
                ErrorResponse := GetResponsesValue(Json, '"error', ',', 1);
                MessageResponse := GetResponsesValue(Json, '"message', ',', 1);
            END;
        END;
    END;
    //SIM -----Code Added---->>>>>>----------
}
