<%@ Page Language="C#" MasterPageFile="~/mainmaster.master" AutoEventWireup="true"
    CodeFile="taxpayerbankdetails.aspx.cs" Inherits="taxpayerbankdetails" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="centerbox">
        <div class="headerlabel">
            <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/bank.jpg" />
            <asp:Label ID="LblAddBankAccount" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div>
            <asp:Label ID="LblRequired" runat="server" Font-Bold="true" Text="* indicates a mandatory (required) field"></asp:Label>
            <br />
            <asp:Label ID="LblError" runat="server" Font-Bold="true" ForeColor="red"></asp:Label>
        </div>
        <br />
        <div class="simplebordered">
            <table style="width: 100%">
                <tr>
                    <td valign="top">
                        <asp:Label ID="lblBankBranch" runat="server" Text="Bank Branch" Width="104px"></asp:Label>
                        <asp:Label ID="lblStar" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                            Text="*"></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:Label ID="LblAccountNumber" runat="server" Text="Account Number" Width="104px"></asp:Label>
                        <asp:Label ID="Label1" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                            Text="*"></asp:Label>
                    </td>
                    <td valign="top">
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:DropDownList ID="DDLBankBranches" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="txtAccountNumber" runat="server" Width="200px"></asp:TextBox>&nbsp;
                    </td>
                    <td style="width: 282px" valign="top">
                        <asp:Button ID="BtnAddBankAccount" runat="server" Text="Add Account" OnClick="BtnAddBankAccount_Click" /></td>
                </tr>
                <tr>
                    <td>
                        <asp:HiddenField ID="HFTaxPayerID" runat="server" />
                        &nbsp;
                    </td>
                    <td>
                        <asp:HiddenField ID="HFBankAccountID" runat="server" />
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
        </div>
        <div class="headerlabel">
            <asp:Image ID="Image1" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/bank.jpg" />
            <asp:Label ID="LblBankAccounts" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <asp:Table ID="TblAccounts" runat="server" Width="240px">
            </asp:Table>
        </div>
        <div class="simplebordered">
            <table>
                <tr>
                    <td>
                        <asp:Button ID="BtnBack" runat="server" Text=" Back " OnClick="BtnBack_Click"  CssClass="buttons" />
                        <asp:Button ID="BtnNext" runat="server" Text=" Next " OnClick="BtnNext_Click" CssClass="buttons" />
                        <asp:Button ID="BtnFinish" runat="server" Text=" Finish" OnClick="BtnFinish_Click" CssClass="buttons" /></td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
