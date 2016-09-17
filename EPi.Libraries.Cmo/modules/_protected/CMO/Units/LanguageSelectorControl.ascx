<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LanguageSelectorControl.ascx.cs" Inherits="EPiServer.Cmo.UI.Units.LanguageSelectorControl" %>
<script type="text/javascript" >
    // <![CDATA[
    
    $(function() {
        var langDropDown = $('#<%=LanguageSelectDropDown.ClientID %>')
        var dateSelectorDisabled = langDropDown.attr('disabled');
        langDropDown.ddselector({ onChange: <%=OnLanguageChangedClient %>, disabled: dateSelectorDisabled });
    });
    // ]]>		        
</script>

<asp:DropDownList ID="LanguageSelectDropDown" runat="server">
</asp:DropDownList>
