<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CMCampaignLineChart.ascx.cs" Inherits="EPiServer.Cmo.UI.Units.CMCampaignLineChart" %>
<%@ Register Assembly="ComponentArt.Web.Visualization.Charting" Namespace="ComponentArt.Web.Visualization.Charting" TagPrefix="ca" %>
<%@ Import Namespace="EPiServer.Cmo.UI.Pages" %>
<%@ Register Src="ProcessingProgress.ascx" TagPrefix="cmo" TagName="Progress" %>
<asp:UpdateProgress runat="server" AssociatedUpdatePanelID="LineChartUpdatePanel" >
    <ProgressTemplate>
        <div class="epi-floatLeft epi-margin-small">
            <cmo:Progress runat="server" />
        </div>
    </ProgressTemplate>
</asp:UpdateProgress>
<asp:UpdatePanel runat="server" UpdateMode="Conditional" ID="LineChartUpdatePanel">
    <ContentTemplate>
        <div class="epi-floatRight epi-marginVertical-small epitoolbuttoncontainernoborder periodSelectorList">
            <asp:Label runat="server" CssClass="epi-floatLeft reportCampaignLabel" Text="<%$ Resources: EPiServer, cmo.campaignMonitor.report.visitsandpageviews.linechart.periodselectortitle %>" />
            <asp:Label ID="PeriodScaleLiteral" runat="server" CssClass="epi-floatLeft reportCampaignLabel periodSelectorListValuePrint" Visible="false" />
            <EPiServerUI:ToolButtonContainer ID="PeriodScaleSelector" runat="server">
                <asp:Label runat="server" ID="LinkButtonByMonthContainer">
                    <EPiServerUI:ToolButton runat="server" CssClassInnerButton="epi-cmsButton-CalendarMonth" ID="LinkButtonByMonth" CommandArgument="Month" OnCommand="LinkButton_Command"
                        ToolTip="<%$ Resources: EPiServer, cmo.campaignMonitor.report.visitsandpageviews.linechart.periodselectormonth %>" />
                    <asp:Label ID="LabelByMonth" runat="server" CssClass="disabledPeriod" ToolTip="<%$ Resources: EPiServer, cmo.campaignMonitor.report.visitsandpageviews.linechart.periodselectordisabled %>" />
                </asp:Label>
                <asp:Label runat="server" ID="LinkButtonByWeekContainer">
                    <EPiServerUI:ToolButton runat="server" CssClassInnerButton="epi-cmsButton-CalendarWeek" ID="LinkButtonByWeek" CommandArgument="Week" OnCommand="LinkButton_Command"
                        ToolTip="<%$ Resources: EPiServer, cmo.campaignMonitor.report.visitsandpageviews.linechart.periodselectorweek %>" />
                    <asp:Label ID="LabelByWeek" runat="server" CssClass="disabledPeriod" ToolTip="<%$ Resources: EPiServer, cmo.campaignMonitor.report.visitsandpageviews.linechart.periodselectordisabled %>" />
                </asp:Label>
                <asp:Label runat="server" ID="LinkButtonByDayContainer">
                    <EPiServerUI:ToolButton runat="server" CssClassInnerButton="epi-cmsButton-CalendarDay" ID="LinkButtonByDay" CommandArgument="Day" OnCommand="LinkButton_Command"
                        ToolTip="<%$ Resources: EPiServer, cmo.campaignMonitor.report.visitsandpageviews.linechart.periodselectorday %>" />
                    <asp:Label ID="LabelByDay" runat="server" CssClass="disabledPeriod" ToolTip="<%$ Resources: EPiServer, cmo.campaignMonitor.report.visitsandpageviews.linechart.periodselectordisabled %>" />
                </asp:Label>
                <asp:Label runat="server" ID="LinkButtonByHourContainer">
                    <EPiServerUI:ToolButton runat="server" CssClassInnerButton="epi-cmsButton-CalendarHour" ID="LinkButtonByHour" CommandArgument="Hour" OnCommand="LinkButton_Command"
                        ToolTip="<%$ Resources: EPiServer, cmo.campaignMonitor.report.visitsandpageviews.linechart.periodselectorhour %>" />
                    <asp:Label ID="LabelByHour" runat="server" CssClass="disabledPeriod" ToolTip="<%$ Resources: EPiServer, cmo.campaignMonitor.report.visitsandpageviews.linechart.periodselectordisabled %>" />
                </asp:Label>
            </EPiServerUI:ToolButtonContainer>
        </div>
          
        <div class="widgetContentRow epi-clear CM-report-lineChart">
                <ca:Chart ID="Chart" runat="server" BackGradientKind="None" BackColor="Transparent" CompositionKind="Merged" CssClass="lineChartContainer" ForeColor="ControlText"
                    GeometricEngineKind="HighQualityRendering" Height="245px" MainStyle="CircleMarker" RenderingPrecision="0.1" SafetyMarginsPercentage="3"
                    WebChartImageType="Png" SelectedPaletteName="CMODefault" TextAlignment="Near" Width="749px" RenderAreaMap="True"
                    MissingPointsStyleName="LineSmooth" Font-Names="Tahoma" Font-Size="Smaller" CustomImageFileName="" SaveImageOnDisk="False">
                    <Clientside ClientsideApiEnabled="False" />
                    <Palettes>
                        <ca:Palette Name="CMODefault" AxisLineColor="197, 197, 197" BackgroundColor="255, 255, 255" BackgroundEndingColor="255, 255, 255" CoodinateLabelFontColor="0, 0, 0"
                            CoordinateLineColor="197, 197, 197" CoordinatePlaneColor="235, 235, 235" CoordinatePlaneSecondaryColor="235, 235, 235" DataLabelFontColor="0, 0, 0"
                            FrameColor="50, 50, 50" FrameFontColor="0, 0, 0" FrameSecondaryColor="50, 50, 50" LegendBackgroundColor="0, 0, 0, 0"
                            LegendBorderColor="0, 0, 0, 0" LegendFontColor="0, 0, 0" PrimaryColors="ff6dbae0,ff6dbae0,ffF19808,ffF19808,ff294654,ffdaa520,ffffa500,fffaebd7,ff8a2be2,ffd2691e"
                            SecondaryColors="ffffff00,ffffff00,ffffff00,ffffff00,ffffff00,ffffff00,ffffff00,ffffff00,ffffff00,ffffff00" TitleFontColor="0, 0, 0"
                            TwoDObjectBorderColor="0, 0, 0, 0" />
                        <ca:Palette Name="CMOPrint" AxisLineColor="255, 127, 127, 127" BackgroundColor="255, 255, 255, 255" BackgroundEndingColor="255, 255, 255, 255"
                            CoodinateLabelFontColor="255, 0, 0, 0" CoordinateLineColor="255, 200, 200, 200" CoordinatePlaneColor="0, 0, 0, 0" CoordinatePlaneSecondaryColor="0, 0, 0, 0"
                            DataLabelFontColor="255, 0, 0, 0" FrameColor="0, 0, 0, 0" FrameFontColor="0, 0, 0, 0" FrameSecondaryColor="0, 0, 0, 0"
                            LegendBackgroundColor="0, 0, 0, 0" LegendBorderColor="0, 0, 0, 0" LegendFontColor="0, 0, 0" PrimaryColors="ff6dbae0,ff6dbae0,ff549129,ff549129,ff294654,ffdaa520,ffffa500,fffaebd7,ff8a2be2,ffd2691e"
                            SecondaryColors="ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff" TitleFontColor="0, 0, 0, 0"
                            TwoDObjectBorderColor="0, 0, 0, 0" />
                    </Palettes>
                    <View Kind="TwoDimensional" NativeSize="749, 245">
                        <Margins Bottom="36" Left="6" Right="3" Top="13" />
                    </View>
                    <Legend Font="Tahoma, 9pt" Name="&lt;Default&gt;" NumberOfItems="2147483647" Ordered="False" Visible="True"
                        BorderShadeWidth="0" LegendLayout="Row" LegendPosition="TopCenter" LocationOffsetVertical="0" DrawBackgroundRectangle="False"
                        ItemBorderShadeWidth="0" />
                    <CoordinateSystem>
                        <XAxis DefaultCoordinateSetComputation="ByNumberOfPoints,20,1,Day,True,True">
                        </XAxis>
                        <YAxis DefaultCoordinateSetComputation="ByNumberOfPoints,1,100,Day,True,True">
                        </YAxis>
                        <ZAxis DefaultCoordinateSetComputation="ByNumberOfPoints,20,1,Day,True,True">
                        </ZAxis>
                        <PlaneYZ Visible="False">
                        </PlaneYZ>
                        <PlaneZX Visible="False">
                        </PlaneZX>
                    </CoordinateSystem>
                    <LabelStyles>
                        <ca:LabelStyle Font="Tahoma, 8pt" ForeColor="0, 0, 0, 0" LiftZ="0.5" Name="DefaultAxisLabels" />
                        <ca:LabelStyle LiftZ="0.1" Name="Default"></ca:LabelStyle>
                    </LabelStyles>
                </ca:Chart>
            </div>
    </ContentTemplate>
</asp:UpdatePanel>

<script type="text/javascript">
    // <![CDATA[
    var Cmo;
    if (!Cmo) {
        Cmo = {};
    }

    Cmo.InitChart<%=ClientID %> = function() {
        var url = '<%= NavigateUrl %>';
        var lineChart = $(".CM-report-lineChart");
        
        if (url) {
            lineChart.css('cursor', 'pointer');
            lineChart.addClass("gaugeCampaign")
            lineChart.click(function() {
                window.location = url;
            });
        }
     
        // removing unneeded image map areas
        $("map[name=<%=this.ClientID %>_ChartMap] area[shape='POLYGON'],map[name=<%=this.ClientID %>_ChartMap] area[shape='POLY']").filter(function(){return !$(this).attr('title')}).remove();
        $("map[name=<%=this.ClientID %>_ChartMap] area[shape='CIRCLE']").filter(function(){return !$(this).attr('title')}).remove();

        // changing of the area circle radius from 3 to 5 pixels
        $("map[name=<%=this.ClientID %>_ChartMap] area[shape='CIRCLE']").attr("coords", function(index)
        {
            return $(this).attr("coords").replace(/,3$/, ",5");
        });

        $("img#<%=this.ClientID %>\\_Chart")[0].removeAttribute('style');
        $("img#<%=this.ClientID %>\\_Chart").addClass('lineChart'); 
        $("img#<%=this.ClientID %>\\_Chart").parent()[0].removeAttribute('style');
    };  

    Sys.Application.add_load(Cmo.InitChart<%=ClientID %>);
    // ]]>
</script>
