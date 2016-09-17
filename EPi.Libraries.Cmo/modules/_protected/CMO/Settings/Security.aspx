<%@ Page Title="" Language="C#" MasterPageFile="../MasterPages/Cmo.Master" AutoEventWireup="true"
    CodeBehind="Security.aspx.cs" Inherits="EPiServer.Cmo.UI.CMO.Settings.Security" %>
<%@ Register TagPrefix="EPiServerUI" Assembly="EPiServer.UI" Namespace="EPiServer.UI.WebControls" %>
<asp:Content ID="Content4" ContentPlaceHolderID="CmoContentPlaceHolder" runat="server">
    <div class="epi-contentContainer epi-padding-small">
        <div class="epi-formArea">
            <div class="epi-size25">
                <div>
                    <asp:Label runat="server" AssociatedControlID="EditorRoles" Text="<%$ Resources: EPiServer, cmo.admin.editorRoles %>" />
                    <asp:TextBox ID="EditorRoles" runat="server" CssClass="EP-requiredField"></asp:TextBox>&nbsp;
                    <asp:RequiredFieldValidator ControlToValidate="EditorRoles" runat="server" ID="EditorRolesRequiredValidator">*</asp:RequiredFieldValidator>
                </div>
                <div>
                    <asp:Label runat="server" AssociatedControlID="ViewerRoles" Text="<%$ Resources: EPiServer, cmo.admin.viewerRoles %>" />
                    <asp:TextBox ID="ViewerRoles" runat="server" CssClass="EP-requiredField"></asp:TextBox>&nbsp;
                    <asp:RequiredFieldValidator ControlToValidate="ViewerRoles" runat="server" ID="ViewerRolesRequiredValidator">*</asp:RequiredFieldValidator>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
