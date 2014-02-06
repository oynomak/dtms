<%@ Page Language="C#" MasterPageFile="~/mainmaster.master" AutoEventWireup="true" CodeFile="permissions.aspx.cs" Inherits="permissions" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:TextBox ID="txtPermissionID" runat="server" Style="z-index: 100; left: 425px; position: absolute;
        top: 167px"></asp:TextBox>
    <asp:Label ID="lblPermissionID" runat="server" Style="z-index: 101; left: 303px; position: absolute;
        top: 169px" Text="Permission ID" Width="116px"></asp:Label>
    <asp:Label ID="lblPermissionName" runat="server" Style="z-index: 104; left: 306px; position: absolute;
        top: 199px" Text="Permission Name" Width="107px"></asp:Label>
    <asp:TextBox ID="txtPermissionName" runat="server" Style="z-index: 103; left: 422px; position: absolute;
        top: 198px"></asp:TextBox>
</asp:Content>

