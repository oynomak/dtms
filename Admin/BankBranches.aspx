<%@ Page Language="C#" MasterPageFile="~/mainmaster.master" AutoEventWireup="true" CodeFile="BankBranches.aspx.cs" Inherits="BankBranches" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div class="centerbox">
        <div class="headerlabel">
            <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/bank.jpg" />
            <asp:Label ID="LblAddBankBranch" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <table style="width: 100%">
                <tr>
                    <td style="width: 81px" valign="top">
                        <asp:Label ID="lblBankBranchName" runat="server" Text="Branch Name" Width="104px"></asp:Label>
                    </td>
                    <td style="width: 282px" valign="top">
                        <asp:TextBox ID="txtBankBranchName" runat="server" Width="200px" ></asp:TextBox>
                        <asp:HiddenField ID="HFBankBranchID" runat="server" />
                        <asp:HiddenField ID="HFBankID" runat="server" />
                    </td>
                    <td>
                        <asp:Button ID="BtnAddBankBranch" runat="server" Text="Add Branch" OnClick="BtnAddBankBranch_Click" /></td>
                </tr>
            </table>
        </div>
        <div class="headerlabel">
            <asp:Image ID="Image1" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/bank.jpg" />
            <asp:Label ID="LblBankBranches" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <asp:Table ID="TblBankBranches" runat="server" Width="240px">
            </asp:Table>
        </div>
    </div>
</asp:Content>

