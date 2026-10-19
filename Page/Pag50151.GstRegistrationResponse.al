namespace Sampoorna_BC.Sampoorna_BC;
using Microsoft.Finance.GST.Base;

page 50151 GstRegistrationResponse
{
    ApplicationArea = All;
    Caption = 'IMS Data List';
    PageType = List;
    SourceTable = ResponseGstRegistration;
    UsageCategory = Lists;
    DeleteAllowed = True;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("GST Registation No."; Rec."GST Registation No.")
                {
                    //ToolTip = 'Specifies the value of the hash field.', Comment = '%';
                    Editable = false;
                }
                field(Section; Rec.Section)
                {
                    //ToolTip = 'Specifies the value of the hash field.', Comment = '%';
                    Editable = false;
                }

                field(hash; Rec.hash)
                {
                    ToolTip = 'Specifies the value of the hash field.', Comment = '%';
                    Editable = false;
                }
                field(val; Rec.val)
                {
                    ToolTip = 'Specifies the value of the val field.', Comment = '%';
                    Editable = false;
                }
                field(samt; Rec.samt)
                {
                    ToolTip = 'Specifies the value of the samt field.', Comment = '%';
                    Editable = false;
                }
                field(txval; Rec.txval)
                {
                    ToolTip = 'Specifies the value of the txval field.', Comment = '%';
                    Editable = false;
                }
                field(rtnprd; Rec.rtnprd)
                {
                    ToolTip = 'Specifies the value of the rtnprd field.', Comment = '%';
                    Editable = false;
                }
                field(camt; Rec.camt)
                {
                    ToolTip = 'Specifies the value of the camt field.', Comment = '%';
                    Editable = false;
                }
                field(inum; Rec.inum)
                {
                    ToolTip = 'Specifies the value of the inum field.', Comment = '%';
                    Editable = false;
                }
                field(cess; Rec.cess)
                {
                    ToolTip = 'Specifies the value of the cess field.', Comment = '%';
                    Editable = false;
                }
                field(srcfilstatus; Rec.srcfilstatus)
                {
                    ToolTip = 'Specifies the value of the srcfilstatus field.', Comment = '%';
                    Editable = false;
                }
                field(iamt; Rec.iamt)
                {
                    ToolTip = 'Specifies the value of the iamt field.', Comment = '%';
                    Editable = false;
                }
                field(stin; Rec.stin)
                {
                    ToolTip = 'Specifies the value of the stin field.', Comment = '%';
                    Editable = false;
                }
                field(srcform; Rec.srcform)
                {
                    ToolTip = 'Specifies the value of the srcform field.', Comment = '%';
                    Editable = false;
                }
                field(inv_typ; Rec.inv_typ)
                {
                    ToolTip = 'Specifies the value of the inv_typ field.', Comment = '%';
                    Editable = false;
                }
                field(pos; Rec.pos)
                {
                    ToolTip = 'Specifies the value of the pos field.', Comment = '%';
                    Editable = false;
                }
                field(idt; Rec.idt)
                {
                    ToolTip = 'Specifies the value of the idt field.', Comment = '%';
                    Editable = false;
                }
                field("action"; Rec."action")
                {
                    ToolTip = 'Specifies the value of the action field.', Comment = '%';
                    Editable = false;
                }
                field(ispendactblocked; Rec.ispendactblocked)
                {
                    ToolTip = 'Specifies the value of the ispendactblocked field.', Comment = '%';
                    Editable = false;
                }
                field(oinum; Rec.oinum)
                {
                    //ToolTip = 'Specifies the value of the ispendactblocked field.', Comment = '%';
                    Editable = false;
                }
                field(oidt; Rec.oidt)
                {
                    //ToolTip = 'Specifies the value of the ispendactblocked field.', Comment = '%';
                    Editable = false;
                }
                field("ERP Status"; Rec."ERP Status")
                {
                    ToolTip = 'Specifies the value of the ERP Status field.', Comment = '%';
                }
                field("Reposne Message"; Rec."Reposne Message")
                {
                    ToolTip = 'Specifies the value of the API Response value', Comment = '%';
                    Editable = False;
                }
                field(Sync; Rec.Sync)
                {
                    //ToolTip = 'Specifies the value of the API Response value', Comment = '%';
                    Editable = False;
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Get No Action IMS Data ")
                {
                    ApplicationArea = All;
                    Caption = 'Get No Action IMS Data';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        IMSCode: Codeunit IMS;
                        GSTRegistration: Record "GST Registration Nos.";
                    Begin

                        GSTRegistration.Reset();
                        if GSTRegistration.FindFirst() then
                            repeat
                                IMSCode.GetAccessToken(GSTRegistration.Code, 'NAT');
                            until GSTRegistration.Next() = 0;

                    End;

                    
                }
                action("Get Pending IMS Data ")
                {
                    ApplicationArea = All;
                    Caption = 'Get Pending IMS Data';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        IMSCode: Codeunit IMS;
                        GSTRegistration: Record "GST Registration Nos.";
                    Begin

                        GSTRegistration.Reset();
                        if GSTRegistration.FindFirst() then
                            repeat
                                IMSCode.GetAccessToken(GSTRegistration.Code, 'P');
                            until GSTRegistration.Next() = 0;

                    End;
                }

                action("Varify Data")
                {
                    ApplicationArea = All;
                    Caption = 'Varify Data';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        IMSCode: Codeunit IMS;
                        GSTRegistration: Record "GST Registration Nos.";
                    Begin

                        IMSCode.UpdateStatus();

                    End;
                }
                action("Push Data to Portal")
                {
                    ApplicationArea = All;
                    Caption = 'Push Data to Portal';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        IMSCode: Codeunit IMS;
                        GSTRegistration: Record "GST Registration Nos.";
                    Begin

                        GSTRegistration.Reset();
                        if GSTRegistration.FindFirst() then
                            repeat
                                IMSCode.SyncGstRegistrationNo(GSTRegistration.Code);

                            until GSTRegistration.Next() = 0;

                    End;
                }
            }
        }
    }
}
