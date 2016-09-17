<%@ Page Language="C#" MasterPageFile="MasterPages/Cmo.Master" AutoEventWireup="true" CodeBehind="CMList.aspx.cs" Inherits="EPiServer.Cmo.UI.Pages.CMList" %>
<%@ Register TagPrefix="cmo" Namespace="EPiServer.Cmo.UI.Units" %>
<%@ Register TagPrefix="EPiServerUI" Namespace="EPiServer.UI.WebControls" %>
<%@ Register Src="Units/CampaignsList.ascx" TagPrefix="cmo" TagName="CampaignsList" %>

<asp:Content ID="Content2" ContentPlaceHolderID="CmoContentPlaceHolder" runat="server">
<div class="epi-contentContainer">
     <div class="epi-padding-small"> 
        <cmo:campaignslist runat="server" id="CampaignsList" OnCmoItemDelete="CampaignsListCampaignDelete"
            OnCmoItemEdit="CampaignsListCampaignEdit" />
    </div>
</div>

</asp:Content>
