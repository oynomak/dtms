<%@ Page Language="C#" MasterPageFile="~/mainmaster.master" AutoEventWireup="true" CodeFile="taxtype.aspx.cs" Inherits="taxtype" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <div class="centerbox">
        <div class="headerlabel">
            <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/region.jpg" />
            <asp:Label ID="LblHeader" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <ul>
                <li>View Payments</li>
            </ul>
            <ul class="sublist">
                <li><asp:HyperLink ID="TodayPayments" runat="server" Text="Today's Payments"></asp:HyperLink></li>
                <li><asp:HyperLink ID="HLThisWeekPayments" runat="server" Text="This Week"></asp:HyperLink></li>
                <li><asp:HyperLink ID="HLThisMonthPayments" runat="server" Text="This Month"></asp:HyperLink></li>
                <li><asp:HyperLink ID="HLThisYearPayments" runat="server" Text="This Year"></asp:HyperLink></li>
                <li><asp:HyperLink ID="HLSpecifyPeriod" runat="server" Text="Specify Period.... "></asp:HyperLink></li>
            </ul>
        </div>
    </div>
</asp:Content>

