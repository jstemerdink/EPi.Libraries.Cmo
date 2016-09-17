<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LpoGaugeChart.ascx.cs" Inherits="EPiServer.Cmo.UI.Units.LpoGaugeChart" %>

 <div style="height:164px;width:200px;" id="<%=this.ClientID %>">
        <object id="<%=this.ObjectID %>"
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