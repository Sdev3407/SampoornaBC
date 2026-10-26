tableextension 50029 UserSetupExt extends "User Setup"
{
    fields
    {
        field(50000; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG-RC';
            TableRelation = "Responsibility Center";
        }
        field(50001; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,3';
            Description = 'PRU-VG-RC';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                          "Dimension Value Type" = CONST(Standard),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(50002; "Allow Indent Line Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG 1.1';
        }
        field(50003; "Allow Indent Line Re-open"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG 1.1';
        }
        field(50004; "Store Locations"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Global Dimension 1 Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50006; "Global Dimension 2 Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50007; "Allow Calculate Bag Weight"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-FE-001';
        }
        field(50008; "Allow Prod. BOM Usage"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50009; "HO Users"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50010; "Short Close on Prod. Order"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-VG';
        }
        field(50011; "Salesperson User"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Access FA Reclass. Journals"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50013; "Access GRN"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50014; "Access Purchase Invoice"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50015; "Access Purchase Order"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Receive,Invoice,Receive & Invoice';
            OptionMembers = " ",Edit,View,Receive,Invoice,"Receive & Invoice";
        }
        field(50016; "Access Sales Order"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Ship,Invoice,Ship & Invoice';
            OptionMembers = " ",Edit,View,Ship,Invoice,"Ship & Invoice";
        }
        field(50017; "Access Sales Return Order"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Receive,Invoice,Receive & Invoice';
            OptionMembers = " ",Edit,View,Receive,Invoice,"Receive & Invoice";
        }
        field(50018; "Access Sales Invoice"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50019; "Access Item Master"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Approve,View';
            OptionMembers = " ",Create,Approve,View;
        }
        field(50020; "Access Customer Master"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Approve,View';
            OptionMembers = " ",Create,Approve,View;
        }
        field(50021; "Access Vendor Master"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Approve,View';
            OptionMembers = " ",Create,Approve,View;
        }
        field(50022; "Access Cash Receipt Journal"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50023; "Access Sales Credit Memo"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50024; "Access Purchase Credit Memo"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50025; "Access Purchase Return Order"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Ship,Invoice,Ship & Invoice';
            OptionMembers = " ",Edit,View,Ship,Invoice,"Ship & Invoice";
        }
        field(50026; "Imprest Permission"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,View,Edit';
            OptionMembers = " ",View,Edit;
        }
        field(50027; "Tax Details Permission"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
        }
        field(50028; "Chart of Account"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View';
            OptionMembers = " ",Edit,View;
        }
        field(50029; "Dimension Values"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View';
            OptionMembers = " ",Edit,View;
        }
        field(50030; "Service Tax Setup"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View';
            OptionMembers = " ",Edit,View;
        }
        field(50031; "TDS NOD/NOC Setup"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View';
            OptionMembers = " ",Edit,View;
        }
        field(50032; "Enabled Back Date Gate Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';

        }
        field(50033; "Access Location Master"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Create';
            OptionMembers = " ",Edit,View,Create;
        }
        field(50034; "Acccess GST Group Code"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View';
            OptionMembers = " ",Edit,View;
        }
        field(50035; "Acccess HSN/SAC Code"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View';
            OptionMembers = " ",Edit,View;
        }
        field(50036; "Acccess GST Configuration"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View';
            OptionMembers = " ",Edit,View;
        }
        field(50037; "Acccess GST Setup"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View';
            OptionMembers = " ",Edit,View;
        }
        field(50038; "Access Purchase Journal"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50039; "Access Sales Journal"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50040; "Access Cash Receipt Voucher"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50041; "Access Bank Receipt Voucher"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50042; "Access Payment Journal"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50043; "Access Cash Payment Voucher"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50044; "Access Bank Payment Voucher"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50045; "Access General Journals"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50046; "Access Journal Voucher"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50047; "Access Contra Voucher"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50048; "Access Ship to Address"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,View,Edit';
            OptionMembers = " ",Create,View,Edit;
        }
        field(50049; "Access Breed Master"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View';
            OptionMembers = " ",Edit,View;
        }
        field(50050; "Access Data Entry Sheet"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50051; "Access Hatchry Entry Sheet"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50052; "Access Parameter List"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View';
            OptionMembers = " ",Create,Edit,View;
        }
        field(50053; "Access Template Master"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View';
            OptionMembers = " ",Create,Edit,View;
        }
        field(50054; "Access Item Reclass"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50055; "Access Bank Rec."; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50057; "Access Purchase Quote"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View,Convert';
            OptionMembers = " ",Create,Edit,View,Convert;
        }
        field(50058; "Access Gate In & Gate Out"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View,Post';
            OptionMembers = " ",Create,Edit,View,Post;
        }
        field(50059; "Access Indent"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,Edit,View,Close,Reopen,Approve';
            OptionMembers = " ",Create,Edit,View,Close,Reopen,Approve;
        }
        field(50060; "Access Normal GC Statement"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,View,Edit,Calculate';
            OptionMembers = " ",Create,View,Edit,Calculate;
        }
        field(50061; "Access EC GC Statement"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,View,Edit,Calculate';
            OptionMembers = " ",Create,View,Edit,Calculate;
        }
        field(50062; "Access RGP"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,View,Edit,Post';
            OptionMembers = " ",Create,View,Edit,Post;
        }
        field(50063; "Access NRGP"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,View,Edit,Post';
            OptionMembers = " ",Create,View,Edit,Post;
        }
        field(50064; "Access Item Journal"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,View,Edit,Post';
            OptionMembers = " ",Create,View,Edit,Post;
        }
        field(50065; "Access Transfer Order"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,View,Edit,Ship,Recieve,Ship & Receive';
            OptionMembers = " ",Create,View,Edit,Ship,Recieve,"Ship & Receive";
        }
        field(50066; "Access Prod. BOM"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,View,Edit';
            OptionMembers = " ",Create,View,Edit;
        }
        field(50067; "Access R Prod. Order"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,View,Edit,Convert';
            OptionMembers = " ",Create,View,Edit,Convert;
        }
        field(50068; "Access Work Center"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,View,Edit';
            OptionMembers = " ",Create,View,Edit;
        }
        field(50069; "Access Machine Center"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,View,Edit';
            OptionMembers = " ",Create,View,Edit;
        }
        field(50070; "Access Routing"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,View,Edit';
            OptionMembers = " ",Create,View,Edit;
        }
        field(50071; "Access Bank Account"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Create,View,Edit';
            OptionMembers = " ",Create,View,Edit;
        }
        field(50072; "Access GL Setup"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View';
            OptionMembers = " ",Edit,View;
        }
        field(50073; "Access User Setup"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Create';
            OptionMembers = " ",Edit,View,Create;
        }
        field(50074; "Access User"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Create';
            OptionMembers = " ",Edit,View,Create;
        }
        field(50075; "Access FA G/L Journals"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50076; "Access FA Journals"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-DD 1.10';
            OptionCaption = ' ,Edit,View,Post';
            OptionMembers = " ",Edit,View,Post;
        }
        field(50077; "TO Post With Prod.Order"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-GK 1.10';
        }
        field(50078; "Liquidation Date"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-GK 1.10';
        }
        field(50079; "Edit Flock No. ILE"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50080; "Reverse Transaction"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'PRU-AB';
        }
        field(50081; Department; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Accounts,Sales,Production,Auditor,Purchase,Finance,IT,HR';
            OptionMembers = " ",Accounts,Sales,Production,Auditor,Purchase,Finance,IT,HR;
        }
        field(50082; "Access G\L Account"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'PRU_NEELESH';
        }
        field(50083; "User Permission"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50085; "Date Freeze"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

            end;
        }
        field(50086; "Day Aceess"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50087; "CBF Line No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Line Name (CBF)"."Line Code";
        }
        field(50088; "Lob Aceess"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50089; "Extension Aceess"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50090; "Regional Head"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50091; "Sales Person Code"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50092; "Sales Team Code"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50093; "Sales Team Leader"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50094; "User Type"; Option)
        {
            OptionMembers = "Head Office","Feed Plant","CBF";
        }
        field(50095; "BOM Print"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50096; "Bank Payment"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50097; "Login By OTP"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50098; "Material issue"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50099; "User Status"; Option)
        {
            OptionCaption = 'Enabled,Disabled';
            OptionMembers = Enabled,Disabled;
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = lookup(User.State where("User Name" = field("User ID")));
        }
    }


    procedure ValidateShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode); //TRI
    end;


}