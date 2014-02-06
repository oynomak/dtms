<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="LandParcels.aspx.cs" Inherits="LandParcels" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="lblTaxPayerID" runat="server" Style="z-index: 100; left: 257px; position: absolute;
        top: 219px" Text="Tax payer ID"></asp:Label>
    <asp:Label ID="lblLandParcelID" runat="server" Style="z-index: 101; left: 244px; position: absolute;
        top: 175px" Text="Land parcel ID"></asp:Label>
    <asp:Label ID="lblYear" runat="server" Style="z-index: 102; left: 309px; position: absolute;
        top: 308px" Text="Year"></asp:Label>
    <asp:Label ID="lblStandingLevel" runat="server" Style="z-index: 103; left: 262px; position: absolute;
        top: 361px" Text="Stanging level"></asp:Label>
    <asp:Label ID="lblLandTitle" runat="server" Style="z-index: 104; left: 282px; position: absolute;
        top: 407px" Text="Land title "></asp:Label>
    <asp:Label ID="lblTitleNumber" runat="server" Style="z-index: 105; left: 608px; position: absolute;
        top: 181px" Text="Title number" Width="90px"></asp:Label>
    &nbsp;
    <asp:Label ID="lblContractDate" runat="server" Style="z-index: 106; left: 612px; position: absolute;
        top: 361px" Text="Contract date" Width="92px"></asp:Label>
    <asp:Label ID="lblContactNumber" runat="server" Style="z-index: 107; left: 584px; position: absolute;
        top: 316px" Text="Contract number" Width="113px"></asp:Label>
    <asp:TextBox ID="txtContractDate" runat="server" Style="z-index: 108; left: 722px;
        position: absolute; top: 356px"></asp:TextBox>
    <asp:Button ID="btnOpenCalendar" runat="server" Style="z-index: 124; left: 873px;
        position: absolute; top: 355px" Text="Open calendar" OnClick="btnOpenCalendar_Click" />
    <asp:Label ID="lblNumberOfHouse" runat="server" Style="z-index: 110; left: 567px; position: absolute;
        top: 271px" Text="Number of house" Width="129px"></asp:Label>
    <asp:Label ID="lblUsage" runat="server" Style="z-index: 111; left: 653px; position: absolute;
        top: 231px" Text="Usage"></asp:Label>
    <asp:TextBox ID="txtUsage" runat="server" Style="z-index: 112; left: 728px; position: absolute;
        top: 225px"></asp:TextBox>
    <asp:DropDownList ID="cboTaxPayerID" runat="server" Style="z-index: 113; left: 426px;
        position: absolute; top: 219px">
    </asp:DropDownList>
    <asp:TextBox ID="txtNumberOfHouse" runat="server" Style="z-index: 114; left: 725px; position: absolute;
        top: 267px"></asp:TextBox>
    <asp:TextBox ID="txtContactNumber" runat="server" Style="z-index: 115; left: 722px; position: absolute;
        top: 316px"></asp:TextBox>
    &nbsp;&nbsp;
    <asp:TextBox ID="txtLandTitle" runat="server" Style="z-index: 116; left: 355px; position: absolute;
        top: 404px"></asp:TextBox>
    <asp:TextBox ID="txtTitleNumber" runat="server" Style="z-index: 117; left: 723px; position: absolute;
        top: 175px"></asp:TextBox>
    <asp:TextBox ID="txtStandingLevel" runat="server" Style="z-index: 118; left: 358px; position: absolute;
        top: 350px"></asp:TextBox>
    <asp:TextBox ID="txtLandParcelID" runat="server" Style="z-index: 119; left: 353px; position: absolute;
        top: 174px"></asp:TextBox>
    <asp:TextBox ID="txtYear" runat="server" Style="z-index: 120; left: 357px; position: absolute;
        top: 304px"></asp:TextBox>
    <asp:Label ID="lblPlotNumber" runat="server" Style="z-index: 121; left: 262px; position: absolute;
        top: 256px" Text="Plot number"></asp:Label>
    <asp:TextBox ID="txtPlotNumber" runat="server" Style="z-index: 122; left: 353px; position: absolute;
        top: 258px"></asp:TextBox>
    <asp:Calendar ID="Calendar1" runat="server" Style="z-index: 123; left: 815px; position: absolute;
        top: 382px" OnSelectionChanged="Calendar1_SelectionChanged" Visible="False" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" Width="200px">
        <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
        <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
        <SelectorStyle BackColor="#CCCCCC" />
        <WeekendDayStyle BackColor="#FFFFCC" />
        <OtherMonthDayStyle ForeColor="#808080" />
        <NextPrevStyle VerticalAlign="Bottom" />
        <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
        <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
    </asp:Calendar>
</asp:Content>

