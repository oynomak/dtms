<%@ Page Language="C#" MasterPageFile="~/mainmaster.master" AutoEventWireup="true"
    CodeFile="sector.aspx.cs" Inherits="sector" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="centerbox">
        <div class="headerlabel">
            <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/region.jpg" />
            <asp:Label ID="LblHeader" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <ul>
                <li>
                    <asp:HyperLink ID="Registry" runat="server" Text="Taxpayer Registry"></asp:HyperLink></li>
            </ul>
            <ul>
                <li id="taxpayments" runat="server">Tax Payments:</li>
            </ul>
            <ul class="sublist">
                <li>
                    <asp:HyperLink ID="TaxToday" runat="server" Text="Today"></asp:HyperLink></li>
                <li>
                    <asp:HyperLink ID="TaxThisWeek" runat="server" Text="This Week"></asp:HyperLink></li>
                <li>
                    <asp:HyperLink ID="TaxThisMonth" runat="server" Text="This Month"></asp:HyperLink></li>
                <li>
                    <asp:HyperLink ID="TaxThisYear" runat="server" Text="This Year"></asp:HyperLink></li>
                <li>
                    <asp:HyperLink ID="TaxPeriod" runat="server" Text="Specify Period.... "></asp:HyperLink></li>
            </ul>
            <ul>
                <li id="feepayments" runat="server">Fee Payments:</li>
            </ul>
            <ul class="sublist">
                <li>
                    <asp:HyperLink ID="FeesToday" runat="server" Text="Today"></asp:HyperLink></li>
                <li>
                    <asp:HyperLink ID="FeesThisWeek" runat="server" Text="This Week"></asp:HyperLink></li>
                <li>
                    <asp:HyperLink ID="FeesThisMonth" runat="server" Text="This Month"></asp:HyperLink></li>
                <li>
                    <asp:HyperLink ID="FeesThisYear" runat="server" Text="This Year"></asp:HyperLink></li>
                <li>
                    <asp:HyperLink ID="FeesPeriod" runat="server" Text="Specify Period.... "></asp:HyperLink></li>
            </ul>
        </div>
    </div>
</asp:Content>
