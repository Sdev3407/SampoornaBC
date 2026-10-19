pageextension 50121 SalespeoplePurchasersExt extends "Salespersons/Purchasers"
{
    layout
    {
        addafter("Name")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = All;

            }
            field(Blocked; Rec.Blocked)
            {
                ApplicationArea = All;
            }

            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = All;
            }
            field(Location; Rec.Location)
            {
                ApplicationArea = all;
                Visible = false;

            }

        }
    }

    actions
    {
        addafter(Dimensions)
        {
            action("Update Detail to Website")
            {
                Promoted = True;
                trigger OnAction()
                var
                Begin
                    UpdateSalespersontoWebsite(Rec.Code);
                End;
            }
            action("Sales Target")
            {
                Promoted = True;
                RunObject = Page "Sales Person Target";
                RunPageLink = "Sales Person Code" = field(Code);
            }
            Action("Reset Password")
            {
                ApplicationArea = all;

                trigger OnAction()
                var
                    PasswordHandler: Codeunit "Password Handler";

                begin
                    Rec.Password := PasswordHandler.GeneratePassword(8);

                    Rec."Password Reset in Next Login" := True;
                    Rec.Modify();
                end;

            }
        }
    }



    var
        myInt: Integer;

    procedure UpdateSalespersontoWebsite(Code: Code[20])
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
        URL1: Text[200];
        jObject: JsonObject;
        JToke: JsonToken;
        JArray: JsonArray;
        JobjectText: Text;
        SalesPerson: Record "Salesperson/Purchaser";
    begin
        Clear(jObject);
        SalesPerson.Get(Code);
        jObject.Add('code', SalesPerson.Code);
        jObject.Add('name', SalesPerson.Name);
        jObject.Add('block', SalesPerson.Blocked);
        jObject.Add('e_Mail', SalesPerson."E-Mail");
        jObject.Add('phone_No', SalesPerson."Phone No.");
        jObject.Add('spLocation', SalesPerson.Location);
        jObject.WriteTo(JobjectText);


        URL := 'http://103.10.191.226:8020/api/SalesExecutive/Add-Edit-SalesExecutive';
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
                //Message(gRequestMsg);
            end;
        end;
    end;

}