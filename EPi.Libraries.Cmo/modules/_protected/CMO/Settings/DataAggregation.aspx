<%@ Page Title="" Language="C#" MasterPageFile="../MasterPages/Cmo.Master" AutoEventWireup="true"
    CodeBehind="DataAggregation.aspx.cs" Inherits="EPiServer.Cmo.UI.CMO.Settings.DataAggregation" %>
<%@ Register TagPrefix="EPiServerUI" Assembly="EPiServer.UI" Namespace="EPiServer.UI.WebControls" %>
<asp:Content ID="Content4" ContentPlaceHolderID="CmoContentPlaceHolder" runat="server">
    <div class="epi-contentContainer epi-padding-small">
        <div class="epi-formArea">
            <div class="epi-size25">
                <div> 
                    <asp:Label runat="server" AssociatedControlID="RunAggregationOnStart" Text="<%$ Resources: EPiServer, cmo.admin.runAggregationOnStart %>" />
                    <asp:CheckBox ID="RunAggregationOnStart" runat="server"></asp:CheckBox>
                </div>
                <div>
                    <asp:Label runat="server" AssociatedControlID="AggregationInterval" Text="<%$ Resources: EPiServer, cmo.admin.aggregationInterval %>" />
                    <asp:TextBox ID="AggregationInterval" runat="server" CssClass="EP-requiredField"></asp:TextBox>&nbsp;
                    <asp:RequiredFieldValidator ControlToValidate="AggregationInterval" runat="server" ID="AggregationIntervalRequiredValidator">*</asp:RequiredFieldValidator>
                    <asp:RangeValidator ControlToValidate="AggregationInterval" Type="Integer" MinimumValue="1" MaximumValue="10080" runat="server"
                        ID="AggregationIntervalRangeValidator">*</asp:RangeValidator>
                </div>
                <div>
                    <asp:Label runat="server" AssociatedControlID="UserNumberToProcessAtOnce" Text="<%$ Resources: EPiServer, cmo.admin.userNumberToProcessAtOnce %>" title="<%$ Resources: EPiServer, cmo.admin.userNumberToProcessAtOncetooltip %>" />
                    <asp:TextBox ID="UserNumberToProcessAtOnce" runat="server" CssClass="EP-requiredField"></asp:TextBox>&nbsp;
                    <asp:RequiredFieldValidator ControlToValidate="UserNumberToProcessAtOnce" runat="server" ID="UserNumberToProcessAtOnceRequiredValidator">*</asp:RequiredFieldValidator>
                    <asp:RangeValidator ControlToValidate="UserNumberToProcessAtOnce" Type="Integer" MinimumValue="1" MaximumValue="100000" runat="server"
                        ID="UserNumberToProcessAtOnceRangeValidator">*</asp:RangeValidator>
                </div>
                <div>
                    <asp:Label runat="server" AssociatedControlID="VisitIdleTime" Text="<%$ Resources: EPiServer, cmo.admin.visitIdleTime %>" />
                    <asp:TextBox ID="VisitIdleTime" runat="server" CssClass="EP-requiredField"></asp:TextBox>&nbsp;
                    <asp:RequiredFieldValidator ControlToValidate="VisitIdleTime" runat="server" ID="VisitIdleTimeRequiredValidator">*</asp:RequiredFieldValidator>
                    <asp:RangeValidator ControlToValidate="VisitIdleTime" Type="Integer" MinimumValue="1" MaximumValue="10080" runat="server"
                        ID="VisitIdleTimeRangeValidator">*</asp:RangeValidator>
                </div>
                <div>
                    <asp:Label runat="server" AssociatedControlID="PageVisitIdleTime" Text="<%$ Resources: EPiServer, cmo.admin.pageVisitIdleTime %>"  title="<%$ Resources: EPiServer, cmo.admin.pageVisitIdleTimetooltip %>"/>
                    <asp:TextBox ID="PageVisitIdleTime" runat="server" CssClass="EP-requiredField"></asp:TextBox>&nbsp;
                    <asp:RequiredFieldValidator ControlToValidate="PageVisitIdleTime" runat="server" ID="PageVisitIdleTimeRequiredValidator">*</asp:RequiredFieldValidator>
                    <asp:RangeValidator ControlToValidate="PageVisitIdleTime" Type="Integer" MinimumValue="1" MaximumValue="10080" runat="server"
                        ID="PageVisitIdleTimeRangeValidator">*</asp:RangeValidator>
                    <asp:CustomValidator ControlToValidate="PageVisitIdleTime" runat="server" ID="PageVisitIdleTimeCustomValidator" OnServerValidate="ValidatePageVisitIdleTimeComparingToVisitIdleTime"
                        EnableClientScript="false" ErrorMessage="<%$ Resources: EPiServer, cmo.admin.pageVisitIdleTimeValidationMessage %>" Text="*" />
                </div>
                <div>
                    <asp:Label runat="server" AssociatedControlID="WaitTimeOnStop" Text="<%$ Resources: EPiServer, cmo.admin.waitTimeOnStop %>"  title="<%$ Resources: EPiServer, cmo.admin.waitTimeOnStoptooltip %>"/>
                    <asp:TextBox ID="WaitTimeOnStop" runat="server" CssClass="EP-requiredField"></asp:TextBox>&nbsp;
                    <asp:RequiredFieldValidator ControlToValidate="WaitTimeOnStop" runat="server" ID="WaitTimeOnStopRequiredValidator">*</asp:RequiredFieldValidator>
                    <asp:RangeValidator ControlToValidate="WaitTimeOnStop" Type="Integer" MinimumValue="0" MaximumValue="30" runat="server" ID="WaitTimeOnStopRangeValidator">*</asp:RangeValidator>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
