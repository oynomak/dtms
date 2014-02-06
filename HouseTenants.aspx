<%@ Page Language="C#" MasterPageFile="~/mainmaster.master" AutoEventWireup="true" CodeFile="HouseTenants.aspx.cs" Inherits="HouseTenants" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="lblFullName" runat="server" Style="z-index: 112; left: 209px; position: absolute;
        top: 238px" Text="Full name"></asp:Label>
    <asp:Label ID="lblLandParcelID" runat="server" Style="z-index: 101; left: 212px; position: absolute;
        top: 199px" Text="Land parcel ID"></asp:Label>
    <asp:Label ID="lblHouseID" runat="server" Style="z-index: 102; left: 211px; position: absolute;
        top: 161px" Text="House ID"></asp:Label>
    <asp:Label ID="lblTelephone" runat="server" Style="z-index: 103; left: 539px; position: absolute;
        top: 164px" Text="Telephone"></asp:Label>
    <asp:Label ID="lblAddress" runat="server" Style="z-index: 104; left: 550px; position: absolute;
        top: 204px" Text="Address"></asp:Label>
    <asp:Label ID="lblAmount" runat="server" Style="z-index: 105; left: 554px; position: absolute;
        top: 241px" Text="Amount"></asp:Label>
    <asp:TextBox ID="txtTelephone" runat="server" Style="z-index: 106; left: 629px; position: absolute;
        top: 165px"></asp:TextBox>
    <asp:TextBox ID="txtAddress" runat="server" Style="z-index: 107; left: 627px; position: absolute;
        top: 201px"></asp:TextBox>
    <asp:TextBox ID="txtAmount" runat="server" Style="z-index: 108; left: 628px; position: absolute;
        top: 241px"></asp:TextBox>
    <asp:TextBox ID="txtFullName" runat="server" Style="z-index: 109; left: 297px; position: absolute;
        top: 235px"></asp:TextBox>
    <asp:TextBox ID="txtHouseID" runat="server" Style="z-index: 110; left: 290px; position: absolute;
        top: 164px"></asp:TextBox>
    <asp:DropDownList ID="cboLandParcelID" runat="server" Style="z-index: 111; left: 370px;
        position: absolute; top: 198px">
    </asp:DropDownList>
</asp:Content>

