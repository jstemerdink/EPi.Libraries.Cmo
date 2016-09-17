<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LpoTestList.aspx.cs" Inherits="EPiServer.Cmo.UI.Pages.LpoTestList"
    MasterPageFile="MasterPages/Cmo.Master" %>
<%@ Register Src="Units/LpoTestList.ascx" TagPrefix="cmo" TagName="LpoTestList" %>
<%@ Import Namespace="EPiServer.Core"%>
<%@ Import Namespace="EPiServer.Cmo.Core.Entities"%>
<%@ Import Namespace="EPiServer.Cmo.Core.Business" %>

<asp:Content runat="server" ContentPlaceHolderID="CmoContentPlaceHolder">
    <div class="epi-contentContainer">
        <div class="epi-padding-small">
            <cmo:LpoTestList runat="server" id="LpoTestListControl" OnCmoItemDelete="LpoTestListLpoTestDelete"
                OnCmoItemEdit="LpoTestListLpoTestEdit" />
        </div>
    </div>
</asp:Content>
