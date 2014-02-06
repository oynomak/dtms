<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Businesses.aspx.cs" Inherits="Businesses" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="lblBusinessName" runat="server" Style="z-index: 100; left: 231px; position: absolute;
        top: 223px" Text="Business name"></asp:Label>
    <asp:Label ID="lblLandParcelID" runat="server" Style="z-index: 101; left: 227px; position: absolute;
        top: 184px" Text="Land parcel ID"></asp:Label>
    <asp:Label ID="lblBusinessID" runat="server" Style="z-index: 102; left: 253px; position: absolute;
        top: 147px" Text="Business ID"></asp:Label>
    <asp:Label ID="lblAddress" runat="server" Style="z-index: 103; left: 633px; position: absolute;
        top: 217px" Text="Address"></asp:Label>
    <asp:Label ID="lblAmount" runat="server" Style="z-index: 104; left: 639px; position: absolute;
        top: 183px" Text="Amount"></asp:Label>
    <asp:Label ID="lblStartDate" runat="server" Style="z-index: 105; left: 610px; position: absolute;
        top: 147px" Text="Start date" Width="80px"></asp:Label>
    <asp:Label ID="lblProfession" runat="server" Style="z-index: 106; left: 253px; position: absolute;
        top: 272px" Text="Profession"></asp:Label>
    &nbsp;
    <asp:Button ID="btnOpenCalendar" runat="server" Style="z-index: 107; left: 877px;
        position: absolute; top: 138px" Text="Open calendar" OnClick="btnOpenCalendar_Click" />
    <asp:TextBox ID="txtBusinessID" runat="server" Style="z-index: 108; left: 360px; position: absolute;
        top: 147px"></asp:TextBox>
    <asp:TextBox ID="txtProfession" runat="server" Style="z-index: 109; left: 359px; position: absolute;
        top: 262px"></asp:TextBox>
    <asp:TextBox ID="txtStartDate" runat="server" Style="z-index: 110; left: 709px; position: absolute;
        top: 143px"></asp:TextBox>
    <asp:TextBox ID="txtAmount" runat="server" Style="z-index: 111; left: 712px; position: absolute;
        top: 180px"></asp:TextBox>
    <asp:TextBox ID="txtAddress" runat="server" Style="z-index: 112; left: 709px; position: absolute;
        top: 213px" Height="59px"></asp:TextBox>
    <asp:TextBox ID="txtBusinessName" runat="server" Style="z-index: 113; left: 357px; position: absolute;
        top: 220px"></asp:TextBox>
    <asp:DropDownList ID="cboLandParcelID" runat="server" Style="z-index: 114; left: 431px;
        position: absolute; top: 179px">
    </asp:DropDownList>
    <asp:Calendar ID="Calendar1" runat="server" Style="z-index: 116; left: 883px; position: absolute;
        top: 167px" OnSelectionChanged="Calendar1_SelectionChanged" Visible="False" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" Width="200px">
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

