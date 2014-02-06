<%@ Page Language="C#" MasterPageFile="~/mainmaster.master" AutoEventWireup="true" CodeFile="Sectors.aspx.cs" Inherits="Sectors" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <div class="centerbox">
        <div class="headerlabel">
            <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/halfglobe.jpg" />
            <asp:Label ID="LblAddSector" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <table style="width: 100%">
                <tr>
                    <td style="width: 81px" valign="top">
                        <asp:Label ID="lblSectorName" runat="server" Text="Sector Name" Width="104px"></asp:Label>
                    </td>
                    <td style="width: 282px" valign="top">
                        <asp:TextBox ID="txtSectorName" runat="server" Width="200px"></asp:TextBox>&nbsp;
                        <asp:HiddenField ID="HFDistrictID" runat="server" />
                        <asp:HiddenField ID="HFSectorID" runat="server" />
                    </td>
                    <td style="width: 282px" valign="top">
                        <asp:Button ID="BtnAddSector" runat="server" Text="Add Sector" OnClick="BtnAddSector_Click" /></td>
                </tr>
            </table>
        </div>
        <div class="headerlabel">
            <asp:Image ID="Image1" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/halfglobe.jpg" />
            <asp:Label ID="LblSectors" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <asp:Table ID="TblSector" runat="server" Width="240px">
            </asp:Table>
        </div>
    </div>
</asp:Content>

