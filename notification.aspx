<%@ Page Language="VB" MasterPageFile="~/mainmaster.master" AutoEventWireup="false"
    CodeFile="notification.aspx.vb" Inherits="notification" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="centerbox">
        <div class="headerlabel">
            <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/taxpayer.jpg" />
            <asp:Label ID="lblHeader" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <br />
        <div class="simplebordered">
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lblNotification" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                     &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="BtnBack" runat="server" Text="Continue" Width="80px" CssClass ="buttons" />
                        <asp:HiddenField ID="HFUrlBack" runat="server" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
