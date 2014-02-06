<%@ Page Language="C#" MasterPageFile="~/mainmaster.master" AutoEventWireup="true"
    CodeFile="taxpayertenants.aspx.cs" Inherits="taxpayertenants" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="centerbox">
        <div class="headerlabel">
            <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/bank.jpg" />
            <asp:Label ID="LblAddTenant" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div>
            <asp:Label ID="LblRequired" runat="server" Font-Bold="true" Text="* indicates a mandatory (required) field"></asp:Label>
            <br />
            <asp:Label ID="LblError" runat="server" Font-Bold="true" ForeColor="red"></asp:Label>
        </div>
        <br />
        <div class="simplebordered">
            <table style="width: 100%">
                <tr>
                    <td valign="top">
                        <asp:Label ID="LblTenantName" runat="server" Text="Tenant's Full Name"></asp:Label>
                        <asp:Label ID="lblStar" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                            Text="*"></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:Label ID="LblTelephone" runat="server" Text="Telephone"></asp:Label>                        
                    </td>
                    <td valign="top">
                        <asp:Label ID="LblAddress" runat="server" Text="Address"></asp:Label>
                        <asp:Label ID="Label2" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                            Text="*"></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:Label ID="LblAmount" runat="server" Text="Monthly Rent"></asp:Label>
                        <asp:Label ID="Label3" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                            Text="*"></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:Label ID="lblPlotNumber" runat="server" Text="Plot No."></asp:Label>
                        <asp:Label ID="Label4" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                            Text="*"></asp:Label>
                    </td>
                    <td valign="top">
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:TextBox ID="txtTenantName" runat="server" Width="150px"></asp:TextBox>&nbsp;
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="txtTelephone" runat="server" Width="130px"></asp:TextBox>&nbsp;
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="txtAddress" runat="server" Width="130px"></asp:TextBox>&nbsp;
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="txtAmount" runat="server" Width="70px"></asp:TextBox>&nbsp;
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="txtPlotNumber" runat="server" Width="70px"></asp:TextBox>&nbsp;
                    </td>
                    <td valign="top">
                        <asp:Button ID="BtnAddTenant" runat="server" Text=" Add " OnClick="BtnAddTenant_Click" CssClass ="buttons"/></td>
                </tr>
                <tr>
                    <td>
                        <asp:HiddenField ID="HFTaxPayerID" runat="server" />
                    </td>
                    <td>
                        <asp:HiddenField ID="HFTenantID" runat="server" />
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
        </div>
        <div class="headerlabel">
            <asp:Image ID="Image1" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/bank.jpg" />
            <asp:Label ID="LblTenants" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <asp:Table ID="TblTenants" runat="server" Width="240px">
            </asp:Table>
        </div>
        <div class="simplebordered">
            <table>
                <tr>
                    <td>
                        <asp:Button ID="BtnBack" runat="server" Text=" Back " OnClick="BtnBack_Click"  CssClass ="buttons"/>
                        <asp:Button ID="BtnNext" runat="server" Text=" Next " OnClick="BtnNext_Click"  CssClass ="buttons"/>
                        <asp:Button ID="BtnFinish" runat="server" OnClick="BtnFinish_Click" Text=" Finish"  CssClass ="buttons" /></td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
