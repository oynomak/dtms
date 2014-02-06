<%@ Page Language="C#" MasterPageFile="~/mainmaster.master" AutoEventWireup="true" CodeFile="UserPermission.aspx.cs" Inherits="UserPermission" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="lblPermissionID" runat="server" Style="z-index: 100; left: 376px; position: absolute;
        top: 246px" Text="Permission ID"></asp:Label>
    <asp:Label ID="lblUserId" runat="server" Style="z-index: 101; left: 374px; position: absolute;
        top: 206px" Text="User ID"></asp:Label>
    <asp:Label ID="lblUserPermissionID" runat="server" Style="z-index: 102; left: 372px; position: absolute;
        top: 172px" Text="User permission ID"></asp:Label>
    <asp:TextBox ID="txtUserPermissionID" runat="server" Style="z-index: 103; left: 529px; position: absolute;
        top: 170px"></asp:TextBox>
    <asp:TextBox ID="txtUserId" runat="server" Style="z-index: 104; left: 529px; position: absolute;
        top: 210px"></asp:TextBox>
    &nbsp;
    <asp:DropDownList ID="cboPermissionID" runat="server" Style="z-index: 107; left: 528px;
        position: absolute; top: 246px" Width="158px">
    </asp:DropDownList>
</asp:Content>

