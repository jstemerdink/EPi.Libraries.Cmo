<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BrowsersPieChart.ascx.cs"
    Inherits="EPiServer.Cmo.UI.Units.BrowsersPieChart" %>
<%@ Register Assembly="ComponentArt.Web.Visualization.Charting" Namespace="ComponentArt.Web.Visualization.Charting"
    TagPrefix="ca" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Import Namespace="EPiServer.Framework.Localization" %>
<asp:Panel runat="server" ID="PanelNoDataMessage" CssClass="epi-floatLeft" Visible="false">
    <%= LocalizationService.GetString("/cmo/campaignMonitor/report/DataIsNotAvailable")%>
</asp:Panel>
<asp:Panel runat="server" ID="PanelChart" CssClass="epi-floatLeft CM-report-pieChart">
        <ca:Chart ID="Chart" runat="server" BackColor="White" CompositionKind="Concentric"
            GeometricEngineKind="HighQualityRendering" Width="480px" Height="200px" WebChartImageType="Png"
            MainStyle="PieRound" RenderingPrecision="0.1" SafetyMarginsPercentage="10" SelectedPaletteName="CMOPrint"
            TextAlignment="Near" Font-Bold="False" Font-Names="Tahoma" Font-Size="Small"
            BackGradientKind="None" Font-Overline="False" CustomImageFileName="" SaveImageOnDisk="false"
            SelectedLightingSetupName="LightingSetup1">
            <Palettes>
                <ca:Palette AxisLineColor="0, 0, 0, 0" BackgroundColor="255, 255, 255, 255" BackgroundEndingColor="255, 255, 255, 255"
                    CoodinateLabelFontColor="255, 0, 0, 0" CoordinateLineColor="0, 0, 0, 0" CoordinatePlaneColor="0, 0, 0, 0"
                    CoordinatePlaneSecondaryColor="0, 0, 0, 0" DataLabelFontColor="255, 0, 0, 0"
                    FrameColor="0, 0, 0, 0" FrameFontColor="0, 0, 0" FrameSecondaryColor="0, 0, 0, 0"
                    LegendBackgroundColor="0, 0, 0, 0" LegendBorderColor="0, 0, 0, 0" LegendFontColor="255, 0, 0, 0"
                    Name="CMODefault" PrimaryColors="ff223844,ff44748c,ff315418,ff549129,ff70170f,ffa3615b,ff704307,ffe59808,ff616263,ff898b8c"
                    SecondaryColors="ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff"
                    TitleFontColor="0, 0, 0" TwoDObjectBorderColor="255, 102, 102, 102" />
                <ca:Palette AxisLineColor="0, 0, 0, 0" BackgroundColor="255, 255, 255, 255" BackgroundEndingColor="255, 255, 255, 255"
                    CoodinateLabelFontColor="255, 0, 0, 0" CoordinateLineColor="0, 0, 0, 0" CoordinatePlaneColor="0, 0, 0, 0"
                    CoordinatePlaneSecondaryColor="0, 0, 0, 0" DataLabelFontColor="255, 0, 0, 0"
                    FrameColor="0, 0, 0, 0" FrameFontColor="0, 0, 0" FrameSecondaryColor="0, 0, 0, 0"
                    LegendBackgroundColor="0, 0, 0, 0" LegendBorderColor="0, 0, 0, 0" LegendFontColor="255, 0, 0, 0"
                    Name="CMOPrint" PrimaryColors="ff223844,ff44748c,ff315418,ff549129,ff70170f,ffa3615b,ff704307,ffe59808,ff616263,ff898b8c"
                    SecondaryColors="ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff"
                    TitleFontColor="0, 0, 0" TwoDObjectBorderColor="255, 102, 102, 102" />
            </Palettes>
            <Clientside ClientsideApiEnabled="False" />
            <SeriesStyles>
                <ca:SeriesStyle Name="PieRound" ChartKind="Pie" RelativeHeight="0.01" />
            </SeriesStyles>
            <LightingSetups>
                <ca:LightingSetup Name="LightingSetup1">
                    <Lights>
                        <ca:Light Intensity="100" IsAmbient="True" />
                    </Lights>
                </ca:LightingSetup>
            </LightingSetups>
            <DataPointLabelStyles>
                <ca:DataPointLabelStyle DataPointLabelKind="PieDoughnutShape" Font="Tahoma, 10pt"
                    ForeColor="Transparent" HOffset="13" LiftZ="0.5" LocalRefPoint="(0.5,0.5,1)"
                    Name="Outside" PieLabelPosition="Outside" />
            </DataPointLabelStyles>
            <View ViewDirection="(0,180,0)" Kind="ParallelProjection" NativeSize="480, 200">
                <Margins Bottom="10" Left="0" Right="0" Top="10" />
            </View>
            <CoordinateSystem>
                <XAxis DefaultCoordinateSetComputation="ByNumberOfPoints,50,1,Day,True,True">
                </XAxis>
                <YAxis DefaultCoordinateSetComputation="ByNumberOfPoints,5,20,Day,True,True">
                </YAxis>
                <ZAxis DefaultCoordinateSetComputation="ByNumberOfPoints,50,1,Day,True,True">
                </ZAxis>
                <PlaneXY Visible="False">
                </PlaneXY>
                <PlaneYZ Visible="False">
                </PlaneYZ>
                <PlaneZX Visible="False">
                </PlaneZX>
            </CoordinateSystem>
            <Series>
                <ca:Series Name="Browsers">
                    <Labels>
                        <ca:SeriesLabels LabelExpression="x" LabelStyleName="Outside" />
                    </Labels>
                </ca:Series>
            </Series>
        </ca:Chart>
</asp:Panel>
<asp:Panel runat="server" ID="PanelOthers" CssClass="epi-floatLeft">
    <asp:Repeater runat="server" ID="RepeaterOthers">
        <HeaderTemplate>
            <div><strong><%= OthersTitle %>:</strong></div>
        </HeaderTemplate>
        <ItemTemplate>
            <div><%# Eval("Percentage", "{0:P1}") %> : <%# Eval("Name") %> <%# Eval("Version") %></div>
        </ItemTemplate>
    </asp:Repeater>
</asp:Panel>
 <script type="text/javascript">
     // <![CDATA[
     var Cmo;
     if (!Cmo) {
         Cmo = {};
     }

     Cmo.initPieChart = function () {
         var url = '<%= NavigateUrl %>';
         var pieChart = $(".CM-report-pieChart");

         if (url) {
             pieChart.css('cursor', 'pointer');
             pieChart.addClass("gaugeCampaign")
             pieChart.click(function () {
                 window.location = url;
             });
         }
     }

     $(document).ready(Cmo.initPieChart);
    // ]]>        
</script>
