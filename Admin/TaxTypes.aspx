<%@ Page Language="VB" MasterPageFile="~/mainmaster.master" AutoEventWireup="false"
    CodeFile="TaxTypes.aspx.vb" Inherits="Admin_TaxTypes" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="centerbox">
        <div class="headerlabel">
            <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/type.jpg" />
            <asp:Label ID="LblAddTaxType" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <table style="width: 100%">
                <tr>
                    <td style="width: 81px" valign="top">
                        <asp:Label ID="lblTaxTypeName" runat="server" Text="Tax Type" Width="104px"></asp:Label>
                    </td>
                    <td style="width: 282px" valign="top">
                        <asp:TextBox ID="txtTaxTypeName" runat="server" Width="200px"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Button ID="BtnAddTaxType" runat="server" Text="Add Tax Type" />
                        <asp:HiddenField ID="HFTaxTypeID" runat="server" />
                    </td>
                </tr>
            </table>
        </div>
        <div class="headerlabel">
            <asp:Image ID="Image1" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/type.jpg" />
            <asp:Label ID="LblTaxTypes" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <asp:Table ID="TblTaxTypes" runat="server" Width="240px">
            </asp:Table>
        </div>
    </div>
</asp:Content>
