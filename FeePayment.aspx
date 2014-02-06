<%@ Page Language="C#" MasterPageFile="~/mainMaster.master" AutoEventWireup="true"
    CodeFile="FeePayment.aspx.cs" Inherits="FeePayment" Title="Untitled Page" %>

<%@ Register Assembly="DevExpress.Web.ASPxDataControls.v6.2, Version=6.2.4.0, Culture=neutral, PublicKeyToken=79868b8147b5eae4"
    Namespace="DevExpress.Web.ASPxDataControls" TagPrefix="dxwdc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="centerbox">
        <div class="headerlabel">
            <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/tax.jpg" />
            <asp:Label ID="lblHeader" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <div>
                <asp:Label ID="LblRequired" runat="server" Text="* indicates a mandatory (required) field"
                    Font-Bold="true"></asp:Label>
                <br />
                <asp:Label ID="LblError" runat="server" Font-Bold="true" ForeColor="red"></asp:Label>
            </div>
            <table border="0" style="width: 100%">
                <tr>
                    <td valign="top">
                        <asp:Label ID="lblTaxPayerID" runat="server" Text="TaxPayer" ></asp:Label>
                        <asp:Label ID="lblStar" runat="server" Text="*" ForeColor="red" Font-Bold="true"
                            Font-Size="Larger"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="cboTaxPayerID" runat="server" Width="240px">
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td style="width: 100px; height: 18px" valign="top">
                        <asp:Label ID="lblPaymentDate" runat="server" Text="Payment date" ></asp:Label>
                        <asp:Label ID="Label1" runat="server" Text="*" ForeColor="red" Font-Bold="true" Font-Size="Larger"></asp:Label>
                    </td>
                    <td style="width: 100px; height: 18px">
                        <dxwdc:ASPxDateEdit ID="DEPaymentDate" runat="server" Width="240px">
                        </dxwdc:ASPxDateEdit>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="lblAmount" runat="server" Text="Amount" ></asp:Label>
                        <asp:Label ID="Label2" runat="server" Text="*" ForeColor="red" Font-Bold="true" Font-Size="Larger"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtAmount" runat="server" Width="232px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="lblDesignation" runat="server" Text="Designation" ></asp:Label>
                        <asp:Label ID="Label3" runat="server" Text="*" ForeColor="red" Font-Bold="true" Font-Size="Larger"></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="txtDesignation" runat="server" Height="52px" Width="352px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td valign="top">
                    </td>
                    <td valign="top">
                        <asp:HiddenField ID="HFFeePaymentID" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                    </td>
                    <td valign="middle">
                        <asp:Button ID="BtnSave" runat="server" Text="Save" Width="88px" OnClick="BtnSave_Click" CssClass ="buttons" />
                        <asp:Button ID="BtnCancel" runat="server" Text="Cancel" Width="88px" OnClick="BtnCancel_Click" CssClass ="buttons" /></td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
