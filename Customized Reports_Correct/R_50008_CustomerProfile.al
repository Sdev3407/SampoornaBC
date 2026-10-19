report 50008 CustomerProfile
{

    Caption = 'Customer Profile';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayout\CustomerProfile.rdl';


    dataset
    {
        dataitem(Customer; "Customer")
        {
            column(No_; "No.")
            {

            }
            column(Name; Name)
            {

            }
            column(Credit_Limit__LCY_; "Credit Limit (LCY)")
            {

            }
            column(Salesperson_Code; "Salesperson Code")
            {

            }
            column(Salesperson_Code_2; "Salesperson Code 2")
            {

            }
            column(Team_Code; "Team Code")
            {

            }
            column(Team_Type; "Team Type")
            {

            }
            column(Responsibility_Center; "Responsibility Center")
            {

            }
            column(Blocked; Blocked)
            {

            }
            column(Outstanding_SMS; "Outstanding SMS")
            {

            }
            column(Privacy_Blocked; "Privacy Blocked")
            {

            }
            column(Last_Modified_Date_Time; "Last Modified Date Time")
            {

            }
            column(Farmer_Location; "Farmer Location")
            {

            }
            column(Customer_Type; "Customer Type")
            {

            }
            column(Customer_Status; "Customer Status")
            {

            }
            column(Status; Status)
            {

            }
            column(Freight_Term; "Freight Term")
            {

            }
            column(Broker_Code; "Broker Code")
            {

            }
            column(TCS_Sec_206; "TCS Sec 206")
            {

            }
            column(CDS_Credit_Limit; "CDS Credit Limit")
            {

            }
            column(State_Code; "State Code")
            {

            }

            column(Address; Address)
            {

            }
            column(Address_2; "Address 2")
            {

            }
            column(Country_Region_Code; "Country/Region Code")
            {

            }
            column(City; City)
            {

            }
            column(Post_Code; "Post Code")
            {

            }
            column(Phone_No_; "Phone No.")
            {

            }
            column(E_Mail; "E-Mail")
            {

            }
            column(Bill_to_Customer_No_; "Bill-to Customer No.")
            {

            }
            column(Invoice_Disc__Code; "Invoice Disc. Code")
            {

            }
            column(Copy_Sell_to_Addr__to_Qte_From; "Copy Sell-to Addr. to Qte From")
            {

            }
            column(Gen__Bus__Posting_Group; "Gen. Bus. Posting Group")
            {

            }
            column(Customer_Posting_Group; "Customer Posting Group")
            {

            }
            column(Customer_Price_Group; "Customer Price Group")
            {

            }
            column(Customer_Disc__Group; "Customer Disc. Group")
            {

            }
            column(Allow_Line_Disc_; "Allow Line Disc.")
            {

            }
            column(Payment_Method_Code; "Payment Method Code")
            {

            }
            column(Payment_Terms_Code; "Payment Terms Code")
            {

            }
            column(Preferred_Bank_Account_Code; "Preferred Bank Account Code")
            {

            }
            column(Location_Code; "Location Code")
            {

            }
            column(Combine_Shipments; "Combine Shipments")
            {

            }
            column(Reserve; Reserve)
            {

            }
            column(Shipping_Advice; "Shipping Advice")
            {

            }
            column(Ship_to_Code; "Ship-to Code")
            {

            }
            column(P_A_N__No_; "P.A.N. No.")
            {

            }
            column(P_A_N__Status; "P.A.N. Status")
            {

            }
            column(Aadhar_No_; "Aadhar No.")
            {

            }
            column(TAN_No_; "TAN No.")
            {

            }
            column(GST_Customer_Type; "GST Customer Type")
            {

            }
            column(GST_Registration_Type; "GST Registration Type")
            {

            }
            column(GST_Registration_No_; "GST Registration No.")
            {

            }
            column(E_Commerce_Operator; "E-Commerce Operator")
            {

            }
            column(ARN_No_; "ARN No.")
            {

            }
            column(PAN_Link_Status; "PAN Link Status")
            {

            }
            column(GST_Name; "GST Name")
            {

            }

            column(GST_Address; "GST Address")
            {

            }
            column(GST_Address_2; "GST Address 2")
            {

            }
            column(GST_Post_Code; "GST Post Code")
            {

            }
            column(GST_State_Code; "GST State Code")
            {

            }
            column(GST_Status; "GST Status")
            {

            }

        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CLE: Record 21;
        VLE: Record 25;
        DCLE: Record 379;
        DVLE: Record 380;
        GSTLE: Record "GST Ledger Entry";//16418;
        DGSTLE: Record "Detailed GST Ledger Entry";//16419;
        TransNo: Integer;
        BLE: Record 271;
}

