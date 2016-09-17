<%@ Page Title="" Language="C#" MasterPageFile="../MasterPages/Cmo.Master" AutoEventWireup="true"
    CodeBehind="ExternalApplications.aspx.cs" Inherits="EPiServer.Cmo.UI.CMO.Settings.ExternalApplications" %>
<%@ Register TagPrefix="cmo" Namespace="EPiServer.Cmo.UI.Units" %>
<%@ Register TagPrefix="cmo" TagName="Progress" Src="../Units/ProcessingProgress.ascx" %>
<asp:Content ID="Content4" ContentPlaceHolderID="CmoContentPlaceHolder" runat="server">
    <asp:UpdatePanel runat="server" updatemode="Always" id="KeysUpdatePanel">
        <ContentTemplate>
            <div class="epi-contentContainer epi-padding-small">
                <div class="epi-formArea">
                    <div class="epi-buttonDefault epi-overflowHidden">
                        <div class="epi-floatLeft">
                            <EPiServerUI:ToolButton ID="AddButton" SkinID="Add" OnClick="AddButtonClick"  Text="<%$ Resources: EPiServer, button.add %>"
                                ToolTip="<%$ Resources: EPiServer, button.add %>" runat="server" />
                        </div>
                        <div class="epi-floatLeft epi-paddingVertical-xsmall epi-marginHorizontal">
                            <asp:UpdateProgress runat="server" ID="KeysUpdateProgress" AssociatedUpdatePanelID="KeysUpdatePanel" DisplayAfter="100">
                                <ProgressTemplate>
                                    <cmo:Progress runat="server" />
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </div>
                    </div>
                    <div class="epi-clear">
                        <asp:CustomValidator id="UsedExternalApplicatoinsValidator" runat="server" OnServerValidate="UsedExternalApplicatoinsValidation" Text="*" Display="Dynamic" />
                        <asp:GridView runat="server" id="KeysGridView" AutoGenerateColumns="false" DataSourceID="KeysDataSource" DataKeyNames="ID"
                            OnRowCancelingEdit="CancelEditClick" OnRowEditing="RowEditing" OnRowDeleting="RowDeleting" OnRowDeleted="RowDeleted" OnRowUpdated="RowUpdated" >
                            <Columns>
                                <asp:TemplateField HeaderText="<%$ Resources: EPiServer, cmo.admin.externalapplicationname %>" ItemStyle-Wrap="false">                
                                    <ItemTemplate>   
                                        <%# HttpUtility.HtmlEncode(Eval("Text").ToString()) %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="KeyName" MaxLength="100" Text='<%# Bind("Text") %>' CssClass="EP-requiredField" runat="server" />
                                        <asp:RequiredFieldValidator ID="ValidatorKeyName" ControlToValidate="KeyName" Text="*" ErrorMessage="<%$ Resources: EPiServer, cmo.admin.externalapplicationnamerequired %>" EnableClientScript="true" Display="Dynamic" runat="server" />
                                        <asp:CustomValidator ID="ValidatorKeyNameUnique" ControlToValidate="KeyName" OnServerValidate="ValidateKeyName" Text="*" ErrorMessage="<%$ Resources: EPiServer, cmo.admin.externalapplicationduplicatenameerrormessage %>" EnableClientScript="false" runat="server"/>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="<%$ Resources: EPiServer, cmo.admin.externalapplicationkey %>" ItemStyle-Wrap="false">                
                                    <ItemTemplate>
                                        <%# HttpUtility.HtmlEncode(Eval("Key").ToString()) %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="KeyValue" MaxLength="100" Text='<%# Bind("Key") %>' CssClass="EP-requiredField"  Enabled='<%# !IsKeyUsed((string) Eval("Key")) %>' runat="server" />
                                        <asp:RequiredFieldValidator ID="ValidatorKeyValue" ControlToValidate="KeyValue" Text="*" ErrorMessage="<%$ Resources: EPiServer, cmo.admin.externalapplicationkeyrequired %>" EnableClientScript="true" Display="Dynamic" runat="server" />
                                        <asp:CustomValidator ID="ValidatorKeyValueUnique" ControlToValidate="KeyValue" OnServerValidate="ValidateKeyValue" Text="*" ErrorMessage="<%$ Resources: EPiServer, cmo.admin.externalapplicationduplicatekeyerrormessage %>" EnableClientScript="false" runat="server"/>
                                        <asp:CustomValidator id="ValidatorKeyUsed" ControlToValidate="KeyValue" OnServerValidate="ValidateKeyUsed" Text="*" ErrorMessage="" EnableClientScript="false" runat="server" />
                                        <asp:RegularExpressionValidator runat="server" ID="KeyValueRegexValidator" Display="Dynamic" ValidationExpression="^[a-zA-Z0-9]+$"  ControlToValidate="KeyValue" 
                                            ErrorMessage="<%$ Resources: EPiServer, cmo.admin.externalapplicationkeyformaterror %>" Text="*" EnableClientScript="true" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="<%$ Resources: EPiServer, cmo.admin.externalapplicationused %>" ItemStyle-Wrap="false">            
                                    <ItemTemplate>
                                        <%# GetKeyUsedHtml((string)Eval("Key")) %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="<%$ Resources: EPiServer, button.edit %>" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <EPiServerUI:ToolButton CommandName="Edit" SkinID="Edit" CausesValidation="false" DisablePageLeaveCheck="true" Enabled='<%# IsEditEnabled((string) Eval("Key")) %>' ToolTip="<%$ Resources: EPiServer, button.edit %>"  runat="server" /> 
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <EPiServerUI:ToolButton CommandName="Update" SkinID="Save" CausesValidation="true" DisablePageLeaveCheck="true" ToolTip="<%$ Resources: EPiServer, button.save %>" runat="server" /><EPiServerUI:ToolButton CommandName="Cancel" SkinID="Cancel" CausesValidation="false" DisablePageLeaveCheck="true" ToolTip="<%$ Resources: EPiServer, button.cancel %>"  runat="server" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="<%$ Resources: EPiServer, button.delete %>" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <EPiServerUI:ToolButton ID="deleteTool" CommandName="Delete" SkinID="Delete" EnableClientConfirm="false" Enabled='<%# IsDeleteEnabled((string) Eval("Key")) %>' OnClientClick='<%# GetDeleteConfirmationScript((string)Eval("Text")) %>' CausesValidation="false" DisablePageLeaveCheck="true" ToolTip="<%$ Resources: EPiServer, button.delete %>" runat="server" /> 
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <cmo:GenericKpiKeysDataSource runat="server" ID="KeysDataSource">
                        </cmo:GenericKpiKeysDataSource>
                        <asp:HiddenField id="PageDataChanged" runat="server" />
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <script type="text/javascript">
        // <![CDATA[
        var Cmo;
        if (!Cmo) {
            Cmo = {};
        };

        Cmo.GenericKpiSettingsSetPageChanged = function () {
            var changed = $('#<%=PageDataChanged.ClientID %>').val();
            if (changed == 'true') {
                EPi.PageLeaveCheck.SetPageChanged(true);
            }
        };

        Cmo.SetDefaultButton = function () {
            setTimeout(function () {
                var textBoxes = $('table input[type=text]');
                var firstTextBox = textBoxes.eq(0);
                firstTextBox.focus().val(firstTextBox.val());

                textBoxes.keypress(function (e) {
                    if ((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13)) {
                        $('table input[type=submit].epi-cmsButton-Save').focus();
                        $('table input[type=submit].epi-cmsButton-Save').click();  
                        return false;
                    }
                    else if ((e.which && e.which == 27) || (e.keyCode && e.keyCode == 27)) {
                        $('table input[type=submit].epi-cmsButton-Cancel').focus();
                        $('table input[type=submit].epi-cmsButton-Cancel').click();
                        return false;
                    } 
                    else {
                        return true;
                    }
                });
            }, 100);
        };

        Cmo.OnLoad = function () {
            Cmo.GenericKpiSettingsSetPageChanged();
            Cmo.SetDefaultButton();

            if (Sys.WebForms.PageRequestManager.getInstance().get_isInAsyncPostBack()) {
                Cmo.ClearMessage();
            }
        };
        // ]]>
    </script>
</asp:Content>
