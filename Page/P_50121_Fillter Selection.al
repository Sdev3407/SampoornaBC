page 50121 "Fillter Selection"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            field(Location; LocationFillter)
            {
                ApplicationArea = All;
                TableRelation = Location.Code;
            }
            field("LOB Code"; GlobDim1)
            {
                ApplicationArea = All;
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                              Blocked = CONST(false));
            }
            field(BRANCH; GlobbDim2)
            {
                ApplicationArea = All;
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                              Blocked = CONST(false));
            }
            field("LOC Code"; ShortDim3)
            {
                ApplicationArea = All;
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            }
        }
    }

    actions
    {
    }

    trigger OnClosePage()
    begin
        //BlanketPurchaseOrder.GetFillterValue(LocationFillter);
    end;

    var
        LocationFillter: Code[20];
        GlobDim1: Code[20];
        GlobbDim2: Code[20];
        ShortDim3: Code[20];
        BlanketPurchaseOrder: Page 509;
        StartDate: Date;
        EndDate: Date;
        VendorNo: Code[1024];


    local procedure ReturnValue(var NLocation: Code[20]; var NewGlobalD1: Code[20]; var NewGlobalD2: Code[20]; var NewShort3: Code[20])
    begin
        NLocation := LocationFillter;
        NewGlobalD1 := GlobDim1;
        NewGlobalD2 := GlobbDim2;
        NewShort3 := ShortDim3;
    end;

    local procedure Setvisibility(IsVisible: Boolean)
    begin
    end;
}

