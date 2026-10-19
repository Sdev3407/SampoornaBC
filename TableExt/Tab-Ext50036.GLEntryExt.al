tableextension 50036 GLEntryExt extends "G/L Entry"
{
    fields
    {
        field(50000; Comment1; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50001; "Bal.Account Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Shortcut Dimension 3Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(50003; "Shortcut Dimension 4Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }

        field(50016; "Line Narration1"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_AS0.005';
        }
        field(50017; "Flock Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'FPD_0.1 Pru_gk';
        }
        field(50018; "FEED Freight Charge"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Entry Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Group By"; Option)
        {
            CalcFormula = Lookup("G/L Account"."Group By" WHERE("No." = FIELD("G/L Account No.")));
            FieldClass = FlowField;
            OptionMembers = " ","Revenue From Operations","OTHER INCOME",PURCHASES,"SALARY-STAFF","WAGESS- LABOUR","EMPLOYER CONTRIBUTION TO PF & OTHER FUND","REPAIR AND MAINTAINANCE",INSURANCE,"FINANCE CHARGES",DEPRICIATION,"FREIGHT EXPENSES-INWARD","FREIGHT EXPENSES-Outward","MANUFACTURING COST","OTHER INDIRECT COST","OTHER SELLING & DISTRIBUTION EXPENSE","CURRENT TAX";
        }
        field(50021; "Group by Shorting"; Integer)
        {
            CalcFormula = Lookup("G/L Account"."Group by Shorting" WHERE("No." = FIELD("G/L Account No.")));
            FieldClass = FlowField;
        }
        field(50022; "SFPL User ID"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

    }
}