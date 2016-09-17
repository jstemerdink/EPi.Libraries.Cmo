<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ConversionPathEditor.ascx.cs" Inherits="EPiServer.Cmo.UI.CMO.Units.ConversionPathEditor" %>
<%@ Import Namespace="EPiServer.Core" %> 
<%@ Import Namespace="EPiServer.Cmo.Core.Business" %>
<%@ Import Namespace="EPiServer.Cmo.UI.Pages" %>  
<%@ Register Src="../ProcessingProgress.ascx" TagPrefix="cmo" TagName="Progress" %>

<div id="<%= ClientID %>" class="widgetWindow">    
    <table class="epi-default">
        <thead>
            <tr>
                <th>
                    <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ButtonUpdate" />
                        </Triggers>
                        <ContentTemplate>
                            <%= HttpUtility.HtmlEncode(Name)%>  
                        </ContentTemplate>         
                    </asp:UpdatePanel>
                </th>
            </tr>    
        </thead>      
        <tbody> 
            <tr>    
                <td>
                    <div class="widgetWindow">
                        <div class="widgetHeader">
                            <div class="CP-settings-rename">
                                <asp:UpdatePanel ID="RenameUpdatePanel" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="ButtonUpdate" />
                                    </Triggers>
                                    <ContentTemplate>
                                        <asp:ValidationSummary runat="server" ID="Summary" CssClass="EP-validationSummary"
                                            ForeColor="Black"  ValidationGroup="<%#ValidationGroupName %>" />
                                        <asp:Label ID="NameEditorLabel" runat="server" CssClass="CP-settings-groupLabel" Text="<%$ Resources: EPiServer, cmo.campaignmonitor.settings.conversionpath.conversionpathname %>" />
                                        <asp:TextBox runat="server" ID="TextBoxName"  MaxLength="255" SkinID="Custom" CssClass="episize240 CP-settings-renameInput" Text="<%# EditedConvertionName %>" ValidationGroup="<%#ValidationGroupName %>" />                                
                                        <asp:RequiredFieldValidator runat="server" ID="ValidatorNameRequired" ControlToValidate="TextBoxName" EnableClientScript="true"
                                            ForeColor="#FF3322" Display="Dynamic" ValidationGroup="<%#ValidationGroupName %>" Font-Size="0.8em" 
                                            CssClass="inputValidation conversion" Text="*" ErrorMessage="<%$ Resources: EPiServer, cmo.campaignmonitor.settings.conversionpath.conversionpathnamerequirederror %>" />
                                        <asp:CustomValidator runat="server" ID="ValidatorNameUnique" ForeColor="#FF3322" OnServerValidate="ValidatorNameUnique_ServerValidate"
                                            EnableClientScript="false" Display="Dynamic" ValidationGroup="<%# ValidationGroupName %>" Font-Size="0.8em" CssClass="inputValidation conversion"
                                            Text="*" ErrorMessage="<%$ Resources: EPiServer, cmo.campaignmonitor.settings.conversionpath.conversionpathnameuniqueerror %>" />
                                        <EPiServerUI:ToolButton ID="ButtonRename" Enabled="<%# !IsFinished %>"  GeneratesPostBack="False" runat="server" SkinId="Edit" Text="<%$ Resources: EPiServer, cmo.campaignmonitor.settings.conversionpath.conversionpathrenametitle %>" />
                                        <EPiServerUI:ToolButton ID="ButtonUpdate" DisablePageLeaveCheck="true" runat="server"  OnClick="ButtonUpdate_Click" ValidationGroup="<%# ValidationGroupName %>" SkinId="Check" Text="<%$ Resources: EPiServer, cmo.campaignmonitor.settings.conversionpath.conversionpathapplybutton %>" />
                                        <EPiServerUI:ToolButton ID="ButtonCancel" GeneratesPostBack="false"  CausesValidation="false" runat="server" SkinId="Cancel" Text="<%$ Resources: EPiServer, cmo.campaignmonitor.settings.conversionpath.cancelrenamebuttontitle %>"/>                                                                               
                                        <asp:HiddenField ID="IsEditorVisibleHidden" runat="server" Value="false" />                                       
                                        <asp:HiddenField ID="ConvertionNameOriginalHidden" runat="server" Value="<%# ConversionPath.Name %>" />                                       
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <span>
                                    <EPiServerUI:ToolButton ID="LinkButtonRemove" runat="server" SkinID="Delete" 
                                                            Enabled="<%# !IsFinished %>" 
                                                            CausesValidation="false" 
                                                            ConfirmMessage="<%# ConversionPathRemoveMessage %>"
                                                            DisablePageLeaveCheck="true"
                                                            Text="<%$ Resources: EPiServer, cmo.campaignmonitor.settings.conversionpath.removeconversionpath %>"
                                                            OnClick="LinkButtonRemove_Click"/>                                
                                </span>
                                <div class="epi-inlineBlock epi-alignMiddle">
                                    <asp:UpdateProgress runat="server" ID="RenameUpdateProgress" AssociatedUpdatePanelID="RenameUpdatePanel" DisplayAfter="100">
                                        <ProgressTemplate>
                                            <div class="epi-marginHorizontal">
                                                <cmo:Progress runat="server" />
                                            </div>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                </div>
                            </div>  
                        </div>         
                        <div class="widgetBody">
                            <div class="DivThumbnails">
                                <div class="pageViewCellThumb">
                                    <img alt="[[name]]" class="pageViewThumb" title="<%=GetThumbnailHandlerUrlTemplate() %>" src="" />
                                    <div class="pageName">
                                        <a class="pageNameLink" title="[[name]]" href="<%= Path %>[[reference]]" target="_blank">[[name]]</a>                                       
                                    </div>
                                </div>
                                <div title="Cmo.IsPageSelectorItemDeleted" class="pageViewCellThumb">                
                                    <img alt="[[name]]" class="pageViewThumb" title="<%=GetThumbnailHandlerUrlTemplate() %>" src="" />                                    
                                    <div class="pageName">
                                        <span class="pageNameLink deleted" title="[[name]]">[[name]]</span>                                        
                                    </div>
                                </div>
                            </div>
                            
                        </div>
                    </div>
                </td>
            </tr>
        </tbody>
     </table>  
 
</div>
<script type="text/javascript">
    //<![CDATA[

    var Cmo;
    if (!Cmo) { 
        Cmo = {};
    }

    $(function () {          
         var ConvertionPathPageView = function () {
            var self = this;        
            var divMain = $('#<%= ClientID %>');      
            var divThumbnails = $('.DivThumbnails', divMain);
            var pageKey = '<%= CmoConstants.PageReferenceRequestParameter %>';                
            this.items = <%= GetItemsString() %>;
            this.views = [divThumbnails];
            
            this.onReady = function() {
                self.cps.showList();
                self.arrangeThumbnails();
            }
            this.arrangeThumbnails = function() {
                var containerWidth = divMain.closest('.epi-contentContainer').width();
                var widgetWidth = containerWidth - 48;
                $('.widgetHeader', divMain).width(widgetWidth);
                $('.widgetBody', divMain).width(widgetWidth);
                if (self.items.length != 0) {
                    var itemWidth = $('> div:first-child', divThumbnails).width();
                    var itemMinWidth = itemWidth + 4;
                    var n = parseInt(widgetWidth / itemMinWidth);
                    var pad = (widgetWidth - n * (itemWidth)) / (n - 1);
                    divThumbnails.width(n * (itemWidth + pad) + 10);
                    $('> div', divThumbnails).css('padding-right', pad);
                }
            }
            $(window).resize(this.arrangeThumbnails);
             
            this.functional = function (name, index, value) {
                switch (name) {
                    case 'removed' :
                        return Cmo.IsPageSelectorItemDeleted(index, value) ? 'deleted' : '';
                }
            }

            $('img', divThumbnails).each(function () {
                this.src = this.title;
                this.title = this.alt;
            });

            this.cps = new Cmo.CampaignPageSelector(self.items, self.views, { functional : self.functional });
        };
                           
        var convertionPathList = new ConvertionPathPageView()
        $(document).ready(convertionPathList.onReady);  
          
        var initializeNameEditor = function(){
            $('#<%=this.ClientID %>').conversionPathNameEditor({      
                isVisibleHiddenId: '<%= IsEditorVisibleHidden.ClientID %>',
                buttonOkId: '<%= ButtonUpdate.ClientID %>',
                buttonRenameId: '<%= ButtonRename.ClientID %>',           
                buttonCancelId: '<%= ButtonCancel.ClientID %>',           
                textBoxNameId: '<%= TextBoxName.ClientID %>',
                validationSummaryId: '<%= Summary.ClientID %>',
                requiredFieldValidatorId: '<%= ValidatorNameRequired.ClientID %>',
                nameUniqueValidatorId: '<%= ValidatorNameUnique.ClientID %>',
                labelId: '<%= NameEditorLabel.ClientID %>',
                convertionNameOriginalHiddenId: '<%= ConvertionNameOriginalHidden.ClientID %>'
            });
        };

        var onPageLoaded = function (sender, args)
        {            
            if (!Sys.WebForms.PageRequestManager.getInstance().get_isInAsyncPostBack())
            {
                return;
            }
           var updatedPanels = args.get_panelsUpdated();
            for (var i = 0; i < updatedPanels.length; i++) {            
                if (updatedPanels[i].id == "<%= RenameUpdatePanel.ClientID %>")
                {
                    if ($("#<%= ClientID %>").conversionPathNameEditor && $.isFunction($("#<%= ClientID %>").conversionPathNameEditor))
                    {
                        $("#<%= ClientID %>").conversionPathNameEditor("destroy");
                    }                 
                    initializeNameEditor();                   
                    break;
                }
            }                     
        }
        initializeNameEditor();
        Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded( onPageLoaded );
    });

    //]]>    
</script>
