<%@ Page Language="VB" MasterPageFile="~/mainmaster.master" AutoEventWireup="false"
    CodeFile="reports.aspx.vb" Inherits="reports" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="centerbox">
        <div class="headerlabel">
            <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/reports.jpg" />
            <asp:Label ID="lblHeader" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <ul>
                <li>
                    <asp:HyperLink runat="server" ID="Todays" Text="Today's Tax payments"></asp:HyperLink>
                </li>
                <li>
                    <asp:HyperLink runat="server" ID="ThisMonth" Text="This month's Tax Payments"></asp:HyperLink>
                </li>
                <li>
                    <asp:HyperLink runat="server" ID="ThisYear" Text="This Year's Tax payments"></asp:HyperLink>
                </li>
                <li>
                    <asp:HyperLink runat="server" ID="Period" Text="Tax payments for a specified period"></asp:HyperLink>
                </li>
                <li>
                    <asp:HyperLink runat="server" ID="SectorPayments" Text="Tax Payments By Sectors and Cell"></asp:HyperLink></li>
                <li>
                    <asp:HyperLink runat="server" ID="TaxTypeSummary" Text="Summary of Payments by Tax type"></asp:HyperLink>
                </li>
                <li>
                    <asp:HyperLink runat="server" ID="SectorSummary" Text="Summary of Payments by Sector"></asp:HyperLink>
                </li>
                <li>
                    <asp:HyperLink runat="server" ID="SectorTaxTypeSummary" Text="Summary of Payments by Sector and Tax Type"></asp:HyperLink></li>
                <li>
                    <asp:HyperLink runat="server" ID="TaxPayerRegistry" Text="Taxpayer Registry by Sector"></asp:HyperLink>
                <li>
                    <asp:HyperLink runat="server" ID="TaxpayerProfession" Text="Taxpayers List by Profession"></asp:HyperLink></li>
                <li>
                    <asp:HyperLink runat="server" ID="Defaulters" Text="Defaulters By Sector And Cell"></asp:HyperLink></li>
                
            </ul>
        </div>
    </div>
</asp:Content>
