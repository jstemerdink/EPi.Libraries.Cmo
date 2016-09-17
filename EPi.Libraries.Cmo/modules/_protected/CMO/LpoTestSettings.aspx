<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LpoTestSettings.aspx.cs"
    Inherits="EPiServer.Cmo.UI.Pages.LpoTestSettings" MasterPageFile="MasterPages/Cmo.Master" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Import Namespace="EPiServer.Cmo.Core.Business" %>
<%@ Import Namespace="EPiServer.Cmo.Cms" %>
<%@ Import Namespace="EPiServer.Cmo.UI.Globalization" %>


<%@ Register Src="Units/LpoPageSelector.ascx" TagName="LpoPageSelector" TagPrefix="cmo" %>

<asp:Content ContentPlaceHolderID="CmoHeadContentPlaceHolder" runat="server">
    <script type="text/javascript">
        // <![CDATA[

        var Cmo;
        if (!Cmo) Cmo = {};

        Cmo.dateFrom = '#<%= DateFromTextBox.ClientID %>';
        Cmo.dateTo = '#<%= DateToTextBox.ClientID %>';

        // Dates validation functions
        Cmo.ValidateStartDate = function(source, args) {
            args.Value = $(Cmo.dateFrom).val();
            Cmo.ValidateDate(source, args);
        }

        Cmo.ValidateEndDate = function(source, args) {
            args.Value = $(Cmo.dateTo).val();
            Cmo.ValidateDate(source, args);
        }

        // On document load finished
        $(document).ready(function () {
            $(Cmo.dateFrom).attr('autocomplete', 'off');
            $(Cmo.dateTo).attr('autocomplete', 'off');
            Cmo.SetupDatePicker($(Cmo.dateFrom), '<%= CultureHelper.DatepickerLocale %>', '<%= CultureHelper.DatepickerFormat %>', '-1d');
            Cmo.SetupDatePicker($(Cmo.dateTo), '<%= CultureHelper.DatepickerLocale %>', '<%= CultureHelper.DatepickerFormat %>', '-1d');
        });

        // ]]>			                
    </script>

</asp:Content>
<asp:Content ContentPlaceHolderID="CmoContentPlaceHolder" runat="server">
    <div id="dialog">
        <p id="dialogText">
        </p>
    </div>

    <div class="epi-contentContainer epi-padding-small">
        <div class="epi-formArea epi-alignMiddleContent LPOSettings">
            <div class="epi-size15">
                <div>
                    <strong><%= TranslateForHtml("/cmo/lpo/settings/testdetailsheader")%></strong>
                </div>
                <div>
                    <asp:Label runat="server" AssociatedControlID="TestNameTextBox" Text="<%$ Resources: EPiServer, cmo.lpo.settings.testnametext %>" />
                    <asp:TextBox ID="TestNameTextBox" runat="server" MaxLength="255" title="<%$ Resources: EPiServer, cmo.lpo.settings.testnametitle %>" />
                    <asp:RequiredFieldValidator ID="TestNameRequiredFieldValidator" runat="server" Text="*" ErrorMessage="<%$ Resources: EPiServer, cmo.lpo.settings.testnamevalidationmessage %>"
                        Display="Dynamic" ForeColor="#FF3322" CssClass="inputValidation" ControlToValidate="TestNameTextBox"
                        Font-Size="0.8em"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="TestNameCustomValidator" runat="server" Text="*" ErrorMessage="<%$ Resources: EPiServer, cmo.lpo.settings.testnameexistvalidationmessage %>"
                        Display="Dynamic" ForeColor="#FF3322" CssClass="inputValidation" ControlToValidate="TestNameTextBox"
                        Font-Size="0.8em" OnServerValidate="TestNameCustomValidator_ServerValidate"></asp:CustomValidator>
                </div>
                <div>
                    <asp:Label runat="server" AssociatedControlID="TestOwnerTextBox" Text="<%$ Resources: EPiServer, cmo.lpo.settings.testownertext %>" />
                    <asp:TextBox ID="TestOwnerTextBox" runat="server" MaxLength="255" title="<%$ Resources: EPiServer, cmo.lpo.settings.testownertitle %>" />
                </div>
                <div>
                    <asp:Label runat="server" AssociatedControlID="DateFromTextBox" Text="<%$ Resources: EPiServer, cmo.lpo.settings.startdatetext %>" />
                    <asp:TextBox ID="DateFromTextBox" runat="server" title="<%$ Resources: EPiServer, cmo.lpo.settings.startdatetitle %>" />
                    <asp:CustomValidator ID="DateFromCustomValidator" runat="server" Text="*" ErrorMessage="<%$ Resources: EPiServer, cmo.lpo.settings.datestartvalidationmessage %>"
                        Display="Dynamic" ForeColor="#FF3322" Font-Size="0.8em" CssClass="inputValidation"
                        OnServerValidate="StartDateCustomValidator_ServerValidate" EnableClientScript="true"
                        ClientValidationFunction="Cmo.ValidateStartDate"></asp:CustomValidator>
                </div>
                <div>
                    <asp:Label runat="server" AssociatedControlID="DateToTextBox" Text="<%$ Resources: EPiServer, cmo.lpo.settings.enddatetext %>" />
                    <asp:TextBox ID="DateToTextBox" runat="server" title="<%$ Resources: EPiServer, cmo.lpo.settings.enddatetitle %>" />
                    <asp:CustomValidator ID="DateToCustomValidator" runat="server" Text="*" ErrorMessage="<%$ Resources: EPiServer, cmo.lpo.settings.dateendvalidationmessage %>"
                        Display="Dynamic" ForeColor="#FF3322" Font-Size="0.8em" CssClass="inputValidation"
                        OnServerValidate="EndDateCustomValidator_ServerValidate" EnableClientScript="true"
                        ClientValidationFunction="Cmo.ValidateEndDate"></asp:CustomValidator>
                </div>
            </div>

            <div class="epi-size15 epi-paddingVertical-small">
                <div>
                    <strong><%= TranslateForHtml("/cmo/lpo/settings/selectpageheader")%></strong>
                </div>
                <cmo:LpoPageSelector runat="server" id="PageSelector" ></cmo:LpoPageSelector>
            </div>

            <div class="epi-size15 epi-paddingVertical-small">
                <div>
                    <strong><%= TranslateForHtml("/cmo/lpo/settings/visitorpercentageheader")%></strong>
                </div>
                <div>
                    <asp:Label runat="server" AssociatedControlID="VisitorPercentageTextBox" Text="<%$ Resources: EPiServer, cmo.lpo.settings.visitorpercentagetext %>" />
                    <asp:TextBox ID="VisitorPercentageTextBox" SkinId="Size50" runat="server" title="<%$ Resources: EPiServer, cmo.lpo.settings.visitortitle %>" />
                    <span class="epi-font-small">
                        <strong><%= TranslateForHtml("/cmo/lpo/settings/settingspageexample")%></strong>
                        <%= TranslateForHtml("/cmo/lpo/settings/visitorpercentageexample")%>
                    </span>
                    <asp:RequiredFieldValidator ID="VisitorPercentageRequiredFieldValidator" runat="server" Text="*" 
                        ErrorMessage="<%$ Resources: EPiServer, cmo.lpo.settings.visitorpercentagerequiredvalidationmessage %>"
                        Display="Dynamic" ForeColor="#FF3322" CssClass="inputValidation" ControlToValidate="VisitorPercentageTextBox"
                        Font-Size="0.8em"></asp:RequiredFieldValidator>
                    <asp:RangeValidator runat="server" ID="VisitorPercentageRangeValidator" Type="Integer" MinimumValue="1" MaximumValue="100"
                        Text="*" ErrorMessage="<%$ Resources: EPiServer, cmo.lpo.settings.visitorpercentagewrongvaluevalidationmessage %>"
                        ForeColor="#FF3322" CssClass="inputValidation" ControlToValidate="VisitorPercentageTextBox" Font-Size="0.8em" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
