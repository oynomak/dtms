<%@ Page Language="C#" MasterPageFile="~/mainmaster.master" AutoEventWireup="true"
    CodeFile="TaxPayment.aspx.cs" Inherits="TaxPayment" Title="Untitled Page" %>

<%@ Register Assembly="DevExpress.Web.ASPxDataControls.v6.2, Version=6.2.4.0, Culture=neutral, PublicKeyToken=79868b8147b5eae4"
    Namespace="DevExpress.Web.ASPxDataControls" TagPrefix="dxwdc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="centerbox">
        <div class="headerlabel">
            <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/tax.jpg" />
            <asp:Label ID="Lblheader" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <div>
                <asp:Label ID="LblRequired" runat="server" Text="* indicates a mandatory (required) field"
                    Font-Bold="true"></asp:Label>
                <br />
                <asp:Label ID="LblError" runat="server" Font-Bold="true" ForeColor="red"></asp:Label>
            </div>
            <br />
            <table align="center">
                <tr>
                    <td valign="top">
                        <asp:Label ID="lblTaxPayerID" runat="server" Text="Taxpayer" ></asp:Label>
                        <asp:Label ID="lblStar" runat="server" Text="*" ForeColor="red" Font-Bold="true"
                            Font-Size="Larger"></asp:Label>
                        </td>
                    <td>
                        <asp:DropDownList ID="cboTaxPayerID" runat="server" Width="232px">
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="LblTaxType" runat="server" Text="Tax Type" ></asp:Label>
                        <asp:Label ID="Label1" runat="server" Text="*" ForeColor="red" Font-Bold="true"
                            Font-Size="Larger"></asp:Label>
                        </td>
                    <td>
                        <asp:DropDownList ID="DDLTaxType" runat="server" Width="232px">
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="lblAmount" runat="server" Text="Amount" ></asp:Label>
                        <asp:Label ID="Label2" runat="server" Text="*" ForeColor="red" Font-Bold="true"
                            Font-Size="Larger"></asp:Label>
                        </td>
                    <td>
                        <asp:TextBox ID="txtAmount" runat="server" Width="224px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="lblPaymentDate" runat="server" Text="Payment date" ></asp:Label>
                        <asp:Label ID="Label3" runat="server" Text="*" ForeColor="red" Font-Bold="true"
                            Font-Size="Larger"></asp:Label>
                        </td>
                    <td>
                        <dxwdc:ASPxDateEdit ID="DEPaymentDate" runat="server" Width="232px">
                        </dxwdc:ASPxDateEdit>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="lblDescription" runat="server" Text="Description" ></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtDescription" runat="server" Height="66px" Width="368px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td valign="top">
                    </td>
                    <td>
                        <asp:HiddenField ID="HFTaxPaymentID" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                    </td>
                    <td>
                        <asp:Button ID="BtnSave" runat="server" OnClick="Button1_Click" Text="Save" Width="88px" CssClass ="buttons" />
                        <asp:Button ID="BtnCancel" runat="server" Text="Cancel" Width="88px" OnClick="BtnCancel_Click" CssClass ="buttons" /></td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
