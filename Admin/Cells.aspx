<%@ Page Language="C#" MasterPageFile="~/mainmaster.master" AutoEventWireup="true" CodeFile="Cells.aspx.cs" Inherits="Cells" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="centerbox">
        <div class="headerlabel">
            <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/halfglobe.jpg" />
            <asp:Label ID="LblAddCell" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <table style="width: 100%">
                <tr>
                    <td style="width: 81px" valign="top">
                        <asp:Label ID="lblCellName" runat="server" Text="Cell Name" Width="104px"></asp:Label>
                    </td>
                    <td style="width: 282px" valign="top">
                        <asp:TextBox ID="txtCellName" runat="server" Width="200px"></asp:TextBox>&nbsp;
                        <asp:HiddenField ID="HFSectorID" runat="server" />
                        <asp:HiddenField ID="HFCellID" runat="server" />
                    </td>
                    <td style="width: 282px" valign="top">
                        <asp:Button ID="BtnAddCell" runat="server" Text="Add Cell" OnClick="BtnAddCell_Click" /></td>
                </tr>
            </table>
        </div>
        <div class="headerlabel">
            <asp:Image ID="Image1" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/halfglobe.jpg" />
            <asp:Label ID="LblCells" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <asp:Table ID="TblCells" runat="server" Width="240px">
            </asp:Table>
        </div>
    </div>
</asp:Content>

