<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReportSection.ascx.cs" Inherits="EPiServer.Cmo.UI.Units.ReportSection" %>    
             
        <div id="<%= ClientID %>" class="<%=CssClass%>">        
           <div class="widgetHeader">
               <h3>                   
                   <a href="#" id="anchor<%= ClientID %>" class="widgetHeaderLink">                       
                    <span id="<%=HeaderIconID%>" class="widgetHeaderIcon"></span>
                    <span class="widgetHeaderText"><%=System.Web.HttpUtility.HtmlEncode(SectionTitle) %></span>
                   </a>
               </h3>
           </div>                    
           <span id="<%=ClientID%>_ContentPanel" class="<%=ContentCssClass%> ">
            <asp:PlaceHolder  runat="server" ID="ControlsPlaceHolder" />
           </span>                   
        </div>                
    
    
    <script language="javascript" type="text/javascript">
        // <![CDATA[    
       
        if(!Cmo.ReportSectionsOperateFunctions)
        {
            Cmo.ReportSectionsOperateFunctions = [];
        }
        Cmo.ReportSectionsOperateFunctions.push(operate<%=SwitchJavaScriptFunctionName%>);
        
        function <%= SwitchJavaScriptFunctionName %>() 
        {   
            var divMain = $("#<%= ClientID %>");
            var divContent = divMain.find("#<%=ClientID%>_ContentPanel");
            var spanHider = divMain.find("#<%=HeaderIconID%>");
            divContent.toggle(0);
            window.location.href = '#' + divContent.parent().prev().attr('id');
            spanHider.toggleClass("collapsed");
            
            $.cookie("<%=CookieName%>_Collapsed", spanHider.hasClass("collapsed"));            
        }

        function operate<%=SwitchJavaScriptFunctionName%>(action)
        {
            var divMain = $("#<%= ClientID %>");
            var divContent = divMain.find("#<%=ClientID%>_ContentPanel");
            var spanHider = divMain.find("#<%=HeaderIconID%>");
            if(action == 'close')
            {
                divContent.hide(0);
                spanHider.addClass("collapsed");
            }
            else
            {
                divContent.show(0);
                spanHider.removeClass("collapsed");
            }
            $.cookie("<%=CookieName%>_Collapsed", spanHider.hasClass("collapsed"));            
        }
        
        function onReady<%=SwitchJavaScriptFunctionName%>()
        {   
            $("#anchor<%=ClientID %>").unbind('click');
            $("#anchor<%=ClientID %>").click(function() {
                if ('<%= AccordionEnabled.ToString().ToLowerInvariant() %>'=='true')
                {
                    $.each(Cmo.ReportSectionsOperateFunctions,function(){
                        this('close');
                    });
                }
                <%= SwitchJavaScriptFunctionName %>(); 
                return false;
            });

            if ($.cookie("<%=CookieName%>_Collapsed") == 'true' && '<%= IgnoreSavedState.ToString().ToLowerInvariant() %>'=='false')
            {
                operate<%=SwitchJavaScriptFunctionName%>('close')
            }
            
            if ('<%= ShowCollapsed.ToString().ToLowerInvariant() %>'=='true' && Cmo.ReportSectionsDefaultSectionId!='<%= ClientID %>')
            {
                operate<%=SwitchJavaScriptFunctionName%>('close');
            }
        }        
        
        if (typeof(Sys) != "undefined"){
            Sys.Application.add_load(onReady<%=SwitchJavaScriptFunctionName%>);
            Sys.Application.notifyScriptLoaded();
        }
        else {
            $(document).ready(onReady<%=SwitchJavaScriptFunctionName%>);
        }
        // ]]>			 
    </script>