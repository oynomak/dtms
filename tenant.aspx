<%@ Page Language="C#" MasterPageFile="~/mainmaster.master" AutoEventWireup="true"
    CodeFile="tenant.aspx.cs" Inherits="tenant" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="centerbox">
        <div class="headerlabel">
            <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/bank.jpg" />
            <asp:Label ID="LblTenantInformation" runat="server" Font-Bold="True"></asp:Label>
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
                    <td valign="top" style="width: 109px">
                        <asp:Label ID="LblTenantName" runat="server" Text="Tenant's Full Name"></asp:Label>
                        <asp:Label ID="lblStar" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                            Text="*"></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="txtTenantName" runat="server" Width="280px"></asp:TextBox>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td valign="top" style="width: 109px">
                        <asp:Label ID="LblTelephone" runat="server" Text="Telephone"></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="txtTelephone" runat="server" Width="130px"></asp:TextBox>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td valign="top" style="width: 109px">
                        <asp:Label ID="LblAddress" runat="server" Text="Address"></asp:Label>
                        <asp:Label ID="Label1" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                            Text="*"></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="txtAddress" runat="server" Width="130px"></asp:TextBox>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td valign="top" style="width: 109px">
                        <asp:Label ID="LblAmount" runat="server" Text="Amount"></asp:Label>
                        <asp:Label ID="Label2" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                            Text="*"></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="txtAmount" runat="server" Width="70px"></asp:TextBox>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td valign="top" style="width: 109px">
                        <asp:Label ID="lblPlotNumber" runat="server" Text="Plot No."></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="txtPlotNumber" runat="server" Width="70px"></asp:TextBox>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td style="width: 109px" valign="top">
                    </td>
                    <td valign="top">
                        <asp:Button ID="BtnSave" runat="server" OnClick="BtnSave_Click" Text="Save" Width="64px"
                            CssClass="buttons" />
                        <asp:Button ID="BtnCancel" runat="server" OnClick="BtnCancel_Click" Text="Cancel"
                            CssClass="buttons" /></td>
                </tr>
                <tr>
                    <td style="width: 109px">
                        &nbsp;</td>
                    <td>
                        <asp:HiddenField ID="HFTenantID" runat="server" />
                        <asp:HiddenField ID="HFTaxPayerID" runat="server" />
                        <asp:HiddenField ID="HFBack" runat="server" />
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
