<%@ Page Language="C#" MasterPageFile="~/mainmaster.master" AutoEventWireup="true"
    CodeFile="User.aspx.cs" Inherits="User" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="headerlabel">
        <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/user.jpg" />
        <asp:Label ID="LblHeader" runat="server" Font-Bold="True"></asp:Label>
    </div>
    <table border="0">
    <tr>
            <td>
                <asp:Label ID="lblFullName" runat="server" Text="Full Name" Width="104px"></asp:Label></td>
            <td>
                <asp:TextBox ID="TxtFullname" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblUserName" runat="server" Text="User name" Width="104px"></asp:Label></td>
            <td>
                <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblPassword" runat="server" Text="Password" Width="88px"></asp:Label></td>
            <td>
                <asp:TextBox ID="txtPassword" runat="server" Height="16px" TextMode="Password" Width="144px"></asp:TextBox></td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:HiddenField ID="HFUserID" runat="server" />
                <asp:HiddenField ID="HFPassword" runat="server" />
                <asp:HiddenField ID="HFStatus" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
                <asp:Button ID="BtnSave" runat="server" Text="Save" Width="80px" OnClick="BtnSave_Click" />
                <asp:Button ID="BtnCancel" runat="server" Text="Cancel" Width="72px" OnClick="BtnCancel_Click" /></td>
        </tr>
    </table>
</asp:Content>
