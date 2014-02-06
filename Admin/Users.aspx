<%@ Page Language="VB" MasterPageFile="~/mainmaster.master" AutoEventWireup="false" CodeFile="Users.aspx.vb" Inherits="Users" title="Untitled Page" %>

<%@ Register Assembly="DevExpress.Web.ASPxDataControls.v6.2, Version=6.2.4.0, Culture=neutral, PublicKeyToken=79868b8147b5eae4"
    Namespace="DevExpress.Web.ASPxDataControls" TagPrefix="dxwdc" %>

<%@ Register Assembly="DevExpress.Web.ASPxGrid.v6.2, Version=6.2.4.0, Culture=neutral, PublicKeyToken=79868b8147b5eae4"
    Namespace="DevExpress.Web.ASPxGrid" TagPrefix="dxwg" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="centerbox">
        <div class="headerlabel">
            <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/users.jpg" />
            <asp:Label ID="lblHeader" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="printerlabel">
        <asp:HyperLink runat="server" NavigateUrl="~/Admin/User.aspx" ID="HLAddUser" Text="Add User"></asp:HyperLink>
        </div>
        <div class="simplebordered">
           <asp:Table ID="TblUsers" runat="server" Width="100%">
            </asp:Table>
            &nbsp;
        </div>
    </div>
</asp:Content>

