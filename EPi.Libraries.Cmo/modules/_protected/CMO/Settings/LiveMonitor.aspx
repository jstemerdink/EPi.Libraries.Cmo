<%@ Page Title="" Language="C#" MasterPageFile="../MasterPages/Cmo.Master" AutoEventWireup="true"
    CodeBehind="LiveMonitor.aspx.cs" Inherits="EPiServer.Cmo.Trace.Pages.Settings.LiveMonitor" %>
<%@ Register TagPrefix="EPiServerUI" Assembly="EPiServer.UI" Namespace="EPiServer.UI.WebControls" %>
<asp:Content ID="Content4" ContentPlaceHolderID="CmoContentPlaceHolder" runat="server">
    <div class="epi-contentContainer epi-padding-small">
        <div class="epi-formArea">
            <div class="epi-size25">
                <div>
                    <asp:Label runat="server" AssociatedControlID="EPiTraceScriptInjectionOptionList" Text="<%$ Resources: EPiServer, cmo.admin.EPiTraceScriptInjectionOption.Description %>" />
                    <asp:DropDownList runat="server" ID="EPiTraceScriptInjectionOptionList" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
