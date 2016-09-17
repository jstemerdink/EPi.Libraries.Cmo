<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CMCampaignCountryChart.ascx.cs"
    Inherits="EPiServer.Cmo.UI.Units.CMCampaignCountryChart" %>
<%@ Register Assembly="ComponentArt.Web.Visualization.Charting" Namespace="ComponentArt.Web.Visualization.Charting"
    TagPrefix="ca" %>
<ca:Chart ID="ChartCountries" runat="server" BackColor="Transparent" ForeColor="ControlText"
    GeometricEngineKind="HighQualityRendering" Height="180px" RenderingPrecision="0.1" WebChartImageType="Jpeg" JpegQuality="90"
    SafetyMarginsPercentage="5" SelectedPaletteName="CMO" TextAlignment="Near" Width="440px"
    CompositionKind="Stacked" SaveImageOnDisk="false">
    <Palettes>
        <ca:Palette AxisLineColor="97, 98, 99" BackgroundColor="49, 50, 51" BackgroundEndingColor="49, 50, 51"
            CoodinateLabelFontColor="218, 221, 224" CoordinateLineColor="0, 0, 0" CoordinatePlaneColor="49, 50, 51"
            CoordinatePlaneSecondaryColor="49, 50, 51" DataLabelFontColor="0, 0, 0" FrameColor="49, 50, 51"
            FrameFontColor="218, 221, 224" FrameSecondaryColor="49, 50, 51" LegendBackgroundColor="49, 50, 51"
            LegendBorderColor="64, 64, 64" LegendFontColor="218, 221, 224" Name="CMO" PrimaryColors="ff65add1,ff008000,ff0064c8,ffff8200,ffa0522d,ffdaa520,ffffa500,fffaebd7,ff8a2be2,ffd2691e"
            SecondaryColors="ffffff00,ffffff00,ffffff00,ffffff00,ffffff00,ffffff00,ffffff00,ffffff00,ffffff00,ffffff00"
            TitleFontColor="0, 0, 0" TwoDObjectBorderColor="200, 0, 0, 0" />
    </Palettes>
    <Clientside ClientsideApiEnabled="False" />
    <View ViewDirection="(0,0,1)" Kind="ParallelProjection" NativeSize="400, 200">
        <Margins Bottom="25" Left="6" Right="1" Top="5" />
    </View>
    <Legend BackColor="Transparent" BorderColor="Transparent" Font="Arial, 9.75pt, style=Bold"
        FontColor="Transparent" Name="&lt;Default&gt;" NumberOfItems="2147483647" Ordered="False"
        Visible="True" BorderShadeWidth="0" LegendLayout="Row" LegendPosition="BottomCenter"
        LocationOffsetHorizontal="1" LocationOffsetVertical="0" DrawBackgroundRectangle="False"
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
        <ca:LabelStyle LiftZ="0.1" Name="Default"></ca:LabelStyle>
    </LabelStyles>
</ca:Chart>
