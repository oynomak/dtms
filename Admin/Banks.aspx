<%@ Page Language="C#" MasterPageFile="~/mainmaster.master" AutoEventWireup="true" CodeFile="Banks.aspx.cs" Inherits="Banks" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="centerbox">
        <div class="headerlabel">
            <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/bank.jpg" />
            <asp:Label ID="LblAddBank" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <table style="width: 100%">
                <tr>
                    <td style="width: 81px" valign="top">
                        <asp:Label ID="lblBankName" runat="server" Text="Bank Name" Width="104px"></asp:Label>
                    </td>
                    <td style="width: 282px" valign="top">
                        <asp:TextBox ID="txtBankName" runat="server" Width="200px" ></asp:TextBox>
                        <asp:HiddenField ID="HFBankID" runat="server" />
                    </td>
                    <td>
                        <asp:Button ID="BtnAddBank" runat="server" Text="Add Bank" OnClick="Button1_Click" /></td>
                </tr>
            </table>
        </div>
        <div class="headerlabel">
            <asp:Image ID="Image1" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/bank.jpg" />
            <asp:Label ID="LblBanks" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <asp:Table ID="TblBanks" runat="server" Width="240px">
            </asp:Table>
        </div>
    </div>
</asp:Content>

