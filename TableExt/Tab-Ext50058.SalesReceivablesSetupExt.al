tableextension 50058 SalesReceivablesSetupExt extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "SMS Send Type"; Option)
        {
            Caption = 'SMS Send Type';
            DataClassification = ToBeClassified;
            Description = 'MSZ:20012021';
            OptionCaption = 'HTTP Request,Email';
            OptionMembers = "HTTP Request",Email;
        }
        field(50001; "SMS HTTP URL"; Text[100])
        {
            Caption = 'SMS HTTP URL';
            DataClassification = ToBeClassified;
            Description = 'MSZ:20012021';
        }
        field(50002; "SMS Email Server"; Text[100])
        {
            Caption = 'SMS Email Server';
            DataClassification = ToBeClassified;
            Description = 'MSZ:20012021';
        }
        field(50003; "SMS User"; Text[30])
        {
            Caption = 'SMS User';
            DataClassification = ToBeClassified;
            Description = 'MSZ:20012021';
        }
        field(50004; "SMS Password"; Text[30])
        {
            Caption = 'SMS Password';
            DataClassification = ToBeClassified;
            Description = 'MSZ:20012021';
        }
        field(50005; "SMS Sender Phone"; Text[30])
        {
            Caption = 'SMS Sender Phone';
            DataClassification = ToBeClassified;
            Description = 'MSZ:20012021';
        }
        field(50006; "SMS local Country code"; Code[4])
        {
            Caption = 'SMS local Country code';
            DataClassification = ToBeClassified;
            Description = 'MSZ:20012021';
        }
        field(50007; "Sender ID"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'MSZ:20012021';
        }
        field(50008; "Customer ID"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'MSZ:20012021';
        }
        field(50009; "Entity ID"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'MSZ:20012021';
        }
        field(50010; "From Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "To Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50100; "Send Sms"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'MSZ:20012021';
        }
        field(60000; "E-Invoicing Token Validity"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(60001; "E-Invoicing User Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(60002; "E-Invoicing User Password"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(60003; "Client ID"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(60004; "Client Secret"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(60005; "E-Invoicing Token"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(60006; "Process No Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(60007; "Tocken Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(60008; "GST Tocken"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(60009; "Print Report"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60010; "UPI ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }
}