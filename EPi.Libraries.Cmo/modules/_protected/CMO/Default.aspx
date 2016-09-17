<%@ Page Title="" Language="C#" MasterPageFile="MasterPages/Cmo.Master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="EPiServer.Cmo.UI.Pages.Default" %>

<%@ Register TagPrefix="cmo" Namespace="EPiServer.Cmo.UI.Units" %>
<%@ Register TagPrefix="EPiServerUI" Namespace="EPiServer.UI.WebControls" %>
<%@ Register Src="Units/CampaignsList.ascx" TagPrefix="cmo" TagName="CampaignsList" %>
<%@ Register Src="Units/LpoTestList.ascx" TagPrefix="cmo" TagName="LpoTestList" %>
<%@ Import Namespace="EPiServer.Cmo.Cms" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Import Namespace="EPiServer.Cmo.Core.Entities" %>
<%@ Import Namespace="EPiServer.Cmo.Core.Business" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="CmoHeadContentPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="CmoContentPlaceHolder" runat="server">
    <div class="epi-contentContainer">
        <div class="epi-padding-small">
            <asp:panel runat="server" cssclass="listHeader">
                <cmo:Label ID="LpoLabelTitle" runat="server" Text="<%$ Resources: EPiServer, cmo.lpo.list.recentlychanged %>" Tag="H2" />
            </asp:panel>
            <cmo:lpotestlist runat="server" id="LpoTestList" oncmoitemdelete="LpoTestListLpoTestDelete"
                oncmoitemedit="LpoTestListLpoTestEdit" />
            <asp:panel runat="server" cssclass="listHeader">
                <cmo:Label ID="CMLabelTitle" runat="server" Text="<%$ Resources: EPiServer, cmo.list.recentlychanged %>" Tag="H2" />
            </asp:panel>
            <cmo:campaignslist runat="server" id="CampaignsList" oncmoitemdelete="CampaignsListCampaignDelete"
                oncmoitemedit="CampaignsListCampaignEdit" />
        </div>
    </div>
</asp:Content>
