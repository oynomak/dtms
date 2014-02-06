<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BankAccounts.aspx.cs" Inherits="BankAccounts" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="lblTaxPayerID" runat="server" Style="z-index: 100; left: 420px; position: absolute;
        top: 252px" Text="Tax payer ID"></asp:Label>
    <asp:Label ID="lblAccountNumber" runat="server" Style="z-index: 101; left: 415px; position: absolute;
        top: 211px" Text="Account Number"></asp:Label>
    <asp:Label ID="lblBankBranchID" runat="server" Style="z-index: 102; left: 418px; position: absolute;
        top: 178px" Text="Bank Branch ID"></asp:Label>
    <asp:Label ID="lblBankAccount" runat="server" Style="z-index: 103; left: 421px; position: absolute;
        top: 147px" Text="Bank Account ID"></asp:Label>
    <asp:TextBox ID="txtBankAccountID" runat="server" Style="z-index: 104; left: 536px;
        position: absolute; top: 148px"></asp:TextBox>
    <asp:TextBox ID="txtAccountNumber" runat="server" Style="z-index: 105; left: 530px; position: absolute;
        top: 214px"></asp:TextBox>
    <asp:DropDownList ID="cboBankBranchID" runat="server" Style="z-index: 106; left: 609px;
        position: absolute; top: 182px">
    </asp:DropDownList>
    <asp:DropDownList ID="cboTaxPayerID" runat="server" Style="z-index: 108; left: 602px;
        position: absolute; top: 249px">
    </asp:DropDownList>
</asp:Content>

