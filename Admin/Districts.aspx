<%@ Page Language="C#" MasterPageFile="~/mainmaster.master" AutoEventWireup="true"
    CodeFile="Districts.aspx.cs" Inherits="Districts" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="centerbox">
        <div class="headerlabel">
            <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/halfglobe.jpg" />
            <asp:Label ID="LblAddDistrict" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <table style="width: 100%">
                <tr>
                    <td style="width: 81px" valign="top">
                        <asp:Label ID="lblDistrictName" runat="server" Text="District Name" Width="104px"></asp:Label>
                    </td>
                    <td style="width: 282px" valign="top">
                        <asp:TextBox ID="txtDistrictName" runat="server" Width="200px"></asp:TextBox>&nbsp;
                        <asp:HiddenField ID="HFProvinceID" runat="server" />
                        <asp:HiddenField ID="HFDistrictID" runat="server" />
                    </td>
                    <td style="width: 282px" valign="top">
                        <asp:Button ID="BtnAddDistrict" runat="server" Text="Add District" OnClick="BtnAddDistrict_Click" /></td>
                </tr>
            </table>
        </div>
        <div class="headerlabel">
            <asp:Image ID="Image1" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/halfglobe.jpg" />
            <asp:Label ID="LblDisticts" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <asp:Table ID="TblProvinces" runat="server" Width="240px">
            </asp:Table>
        </div>
    </div>
</asp:Content>
