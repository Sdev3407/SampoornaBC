// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------

/// <summary>
/// A Page that allows the user to enter a password.
/// </summary>
page 50149 "OTP Dialog Page"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = StandardDialog;
    //SourceTable = "User Wise Resp. Center";
    //Permissions = TableData Session = rimd;

    layout
    {
        area(content)
        {
            field("Document No"; DocumentNo)
            {
                Editable = False;
            }

            field(OTP; PasswordValue)
            {
                ApplicationArea = All;
                Caption = 'OTP';
                ExtendedDatatype = Masked;
                ToolTip = 'Specifies the OTP for this above document. The OTP must consist of 6  Numarical';

                trigger OnValidate()
                begin

                end;
            }

        }
    }

    actions
    {
    }







    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin

        if CloseAction = ACTION::OK then begin

            IF PasswordValue <> format(GlobalOTP) then
                Error(PasswordMismatchErr)
            ELSE begin
                GenerateLoginLedger(DocumentNo);
                Message('Thank you for OTP to Confirm the Delivery');
            end;
        end;
    end;

    procedure StoreOTP(LocalOTP: Integer; docNO: Code[20])
    begin
        GlobalOTP := LocalOTP;
        DocumentNo := docNO;
    end;

    local procedure GenerateLoginLedger(docNo: Code[20])
    var
        EntryNo: Integer;
        RandomOTP: Integer;
        RecUser: Record User;
        Usersetup: Record "User Setup";
        SalesShipmentHeader: Record "Sales Shipment Header";

    begin

        SalesShipmentHeader.Reset();
        SalesShipmentHeader.SetRange("No.", docNo);
        if SalesShipmentHeader.FindFirst() then begin
            SalesShipmentHeader."OTP Varified at" := CurrentDateTime;
            SalesShipmentHeader."OTP Varified" := true;
            SalesShipmentHeader."OTP Varified by" := UserId;
            SalesShipmentHeader.Modify();
        end;

    end;


    var

        PasswordMismatchErr: Label 'The OTP that you entered do not match.';
        [InDataSet]
        PasswordValue: Code[6];
        [InDataSet]
        ConfirmPasswordValue: Text;
        [InDataSet]
        OldPasswordValue: Text;
        ShowOldPassword: Boolean;
        ValidPassword: Boolean;
        RequiresPasswordValidation: Boolean;
        RequiresPasswordConfirmation: Boolean;
        GlobalOTP: Integer;
        DocumentNo: Text;

    /// <summary>
    /// Gets the password value typed on the page.
    /// </summary>
    /// <returns>The password value typed on the page.</returns>

}

