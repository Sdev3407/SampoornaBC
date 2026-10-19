tableextension 50006 GLAccountExt extends "G/L Account"
{
    fields
    {
        field(50000; "SMS Alert Mobile No."; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
            ExtendedDatatype = PhoneNo;
        }
        field(50001; "Prevent Negative Balance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "FEED Freight Charge"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Group By"; Option)
        {
            DataClassification = ToBeClassified;
            //            OptionCaption = ' ,Revenue From Operations,OTHER INCOME,PURCHASES,SALARY-STAFF,WAGESS- LABOUR,EMPLOYER CONTRIBUTION TO PF & OTHER FUND,REPAIR AND MAINTAINANCE,INSURANCE,FINANCE CHARGES,DEPRICIATION,FREIGHT EXPENSES-INWARD,FREIGHT EXPENSES-Outward,MANUFACTURING COST,OTHER INDIRECT COST,OTHER SELLING & DISTRIBUTION EXPENSE,CURRENT TAX';
            OptionMembers = " ","Revenue From Operations","OTHER INCOME",PURCHASES,"SALARY-STAFF","WAGESS- LABOUR","EMPLOYER CONTRIBUTION TO PF & OTHER FUND","REPAIR AND MAINTAINANCE",INSURANCE,"FINANCE CHARGES",DEPRICIATION,"FREIGHT EXPENSES-INWARD","FREIGHT EXPENSES-Outward","MANUFACTURING COST","OTHER INDIRECT COST","OTHER SELLING & DISTRIBUTION EXPENSE","CURRENT TAX";
        }
        field(50004; "Group by Shorting"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Required"; Option)
        {
            //DataClassification = ToBeClassified;
            OptionMembers = "Yes","No";
        }
        field(50006; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_NEELESH';
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved';
            OptionMembers = Open,"Pending Approval",Approved;
        }
    }
}