<%@ Page Language="VB" MasterPageFile="~/mainmaster.master" AutoEventWireup="false"
    CodeFile="Login.aspx.vb" Inherits="Login" %>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="headerlabel">
        <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/key.jpg" />
        <asp:Label ID="LblLogonText" runat="server" Font-Bold="True"></asp:Label>
    </div>
    <div class="centerbox">
        <div class="simplebordered">
            <div id="PromptText" runat="server" >
                To use the features provided by this application, you have to log in. Please provide
                your user name and password:</div>
            <asp:Label ID="LoginError" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label><br />
            <table>
                <tr>
                    <td style="width: 81px">
                        <asp:Label ID="LblUserName" runat="server" Text="User Name"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="Username" runat="server" Width="152px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="width: 81px">
                        <asp:Label ID="LBLPassword" runat="server" Text="Password"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="Password" runat="server" TextMode="Password" Width="152px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td style="width: 81px">
                    </td>
                    <td>
                        <asp:ImageButton ID="Button1" runat="server" AlternateText="Login" ImageUrl="~/Images/login.gif"
                            PostBackUrl="~/login.aspx" /></td>
                </tr>
            </table>
        </div>
        <div class="simplebordered" id="HelpText" runat="server" >
            If you have problems accessing the system, please contact your system administrator</div>
    </div>
</asp:Content>
