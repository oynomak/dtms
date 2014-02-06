<%@ Page Language="VB" MasterPageFile="~/mainmaster.master" AutoEventWireup="false"
    CodeFile="deletepayment.aspx.vb" Inherits="deletepayment" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="centerbox">
        <div class="headerlabel">
            <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/deleteitem.jpg" />
            <asp:Label ID="lblHeader" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <asp:Label ID="LblDeletePrompt" runat="server"></asp:Label>
        </div>
        <p>
            &nbsp;</p>
        <div>
            &nbsp;&nbsp;<asp:Button ID="Button1" runat="server" Text=" Yes  " />
            &nbsp;&nbsp;<asp:Button ID="Button2" runat="server" Text="  No  " />
            <asp:HiddenField ID="HFPaymentID" runat="server"></asp:HiddenField>
        </div>
    </div>
</asp:Content>
