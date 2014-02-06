<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Properties.aspx.cs" Inherits="Properties" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="lblOwnerName" runat="server" Style="z-index: 100; left: 285px; position: absolute;
        top: 210px" Text="Owners name"></asp:Label>
    <asp:Label ID="lblLandParcelID" runat="server" Style="z-index: 101; left: 284px; position: absolute;
        top: 181px" Text="Land Parcel ID"></asp:Label>
    <asp:Label ID="lblPropertieID" runat="server" Style="z-index: 102; left: 304px; position: absolute;
        top: 144px" Text="Propertie ID"></asp:Label>
    <asp:Label ID="lblDistrictValuation" runat="server" Style="z-index: 103; left: 557px; position: absolute;
        top: 224px" Text="District valuation" Width="130px"></asp:Label>
    &nbsp;
    <asp:Label ID="lblOwnerValuation" runat="server" Style="z-index: 104; left: 581px; position: absolute;
        top: 187px" Text="Owner valuation" Width="113px"></asp:Label>
    <asp:Label ID="lblDateOfAquisition" runat="server" Style="z-index: 105; left: 580px; position: absolute;
        top: 147px" Text="Date of aquisition" Width="119px"></asp:Label>
    <asp:Label ID="lblUser" runat="server" Style="z-index: 106; left: 316px; position: absolute;
        top: 257px" Text="Usage"></asp:Label>
    <asp:TextBox ID="txtOwnerName" runat="server" Style="z-index: 107; left: 383px; position: absolute;
        top: 214px"></asp:TextBox>
    <asp:TextBox ID="txtOwnerValuation" runat="server" Style="z-index: 108; left: 704px; position: absolute;
        top: 191px"></asp:TextBox>
    <asp:TextBox ID="txtUser" runat="server" Style="z-index: 109; left: 377px; position: absolute;
        top: 253px"></asp:TextBox>
    <asp:TextBox ID="txtDateOfAquisition" runat="server" Style="z-index: 110; left: 706px; position: absolute;
        top: 146px"></asp:TextBox>
    &nbsp;
    <asp:TextBox ID="txtPropertieID" runat="server" Style="z-index: 111; left: 392px; position: absolute;
        top: 143px"></asp:TextBox>
    <asp:DropDownList ID="cboLandParcelID" runat="server" Style="z-index: 112; left: 463px;
        position: absolute; top: 183px">
    </asp:DropDownList>
    <asp:TextBox ID="txtDistrictValuation" runat="server" Style="z-index: 113; left: 701px; position: absolute;
        top: 230px"></asp:TextBox>
    <asp:Button ID="btnOpenCalendar" runat="server" Style="z-index: 114; left: 867px;
        position: absolute; top: 143px" Text="Open calendar" OnClick="btnOpenCalendar_Click" />
    <asp:Calendar ID="Calendar1" runat="server" Style="z-index: 116; left: 887px; position: absolute;
        top: 173px" OnSelectionChanged="Calendar1_SelectionChanged" Visible="False" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" Width="200px">
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

