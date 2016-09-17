<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CmReportGauge.ascx.cs" Inherits="EPiServer.Cmo.UI.Units.Kpi.CmReportGauge" %>
    
<asp:Panel ID="GuagePanel" runat="server" CssClass="reportGauge" >
<div style="width: 200px !important; height: 140px">
        <object id="<%=GetObjectId() %>"
         data="data:application/x-silverlight-2," type="application/x-silverlight-2" width="100%" height="100%">
		  <param name="source" value="ClientBin/EPiServer.Cmo.Gauge.xap?ver=7.0"/>
		  <param name="onError" value="onSilverlightError" />
          <param name="onload" value="onLoad<%=this.ObjectID %>" />
		  <param name="background" value="Transparent" />
          <param name="windowless" value="true" />
		  <param name="minRuntimeVersion" value="3.0.40624.0" />
		  <param name="autoUpgrade" value="true" />
		  <param name="initParams" value="<%=GetGuageParams()%>"/>
		  <a href="http://go.microsoft.com/fwlink/?LinkID=149156&v=3.0.40624.0" style="text-decoration:none">
 			  <img src="http://go.microsoft.com/fwlink/?LinkId=108181" alt="Get Microsoft Silverlight" style="border-style:none"/>
		  </a>
	    </object>
</div>
</asp:Panel>