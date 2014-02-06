<%@ Page Language="C#" MasterPageFile="~/mainmaster.master" AutoEventWireup="true"
    CodeFile="Provinces.aspx.cs" Inherits="Provinces" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="centerbox">
        <div class="headerlabel">
            <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/region.jpg" />
            <asp:Label ID="LblAddProvince" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <table style="width: 100%">
                <tr>
                    <td style="width: 81px" valign="top">
                        <asp:Label ID="lblProvinceName" runat="server" Text="Province Name" Width="104px"></asp:Label>
                    </td>
                    <td style="width: 282px" valign="top">
                        <asp:TextBox ID="txtProvinceName" runat="server" Width="200px" AutoPostBack="True"></asp:TextBox>
                        <asp:HiddenField ID="HFProvinceID" runat="server" />
                    </td>
                    <td>
                        <asp:Button ID="BtnAddProvince" runat="server" Text="Add Province" OnClick="Button1_Click" /></td>
                </tr>
            </table>
        </div>
        <div class="headerlabel">
            <asp:Image ID="Image1" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/globe.jpg" />
            <asp:Label ID="LblProvinces" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <asp:Table ID="TblProvinces" runat="server" Width="240px">
            </asp:Table>
        </div>
    </div>
</asp:Content>
