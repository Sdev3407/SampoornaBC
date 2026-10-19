// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------

/// <summary>
/// A Page that allows the user to enter a password.
/// </summary>
page 50152 "GST OTP Dialog Page"
{
    Caption = 'OTP Varification';
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = StandardDialog;


    layout
    {
        area(content)
        {
            field("GST No"; GSTNo1)
            {
                Editable = False;
            }
            field("User Name"; UserName1)
            {
                Editable = false;
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
    var
        Response: Text[100];

    begin

        if CloseAction = ACTION::OK then begin

            Response := CUIMS.OTPVarify(GSTNo1, UserName1, PasswordValue);

            if Response = 'OTPhasverifiedsuccessfully' Then
                Message('OTP has verified successfully')
            Else
                Error(Response);

        end;
    end;

    procedure StoreOTP(GSTNo: Code[20]; UserName: text[25])
    begin

        GSTNo1 := GSTNo;
        Username1 := UserName;
    end;




    var
        CUIMS: Codeunit IMS;
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
        GSTNo1: Text;
        UserName1: Text;


    /// <summary>
    /// Gets the password value typed on the page.
    /// </summary>
    /// <returns>The password value typed on the page.</returns>

}

