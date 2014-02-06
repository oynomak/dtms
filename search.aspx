<%@ Page Language="VB" MasterPageFile="~/mainmaster.master" AutoEventWireup="false"
    CodeFile="search.aspx.vb" Inherits="search" Title="Untitled Page" %>

<%@ Register Assembly="DevExpress.Web.ASPxTabControl.v6.2, Version=6.2.4.0, Culture=neutral, PublicKeyToken=79868b8147b5eae4"
    Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dxwtc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="centerbox">
        <div class="headerlabel">
        <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/find.jpg" />
        <asp:Label ID="LblHeader" runat="server" Font-Bold="True"></asp:Label>
    </div>
    <div class="simplebordered">
        <dxwtc:ASPxPageControl ID="PageControl" runat="server" TabAlign ="Justify" TabSpacing="15px" >
            <TabPages>
                <dxwtc:TabPage Text ="Taxpayers(3)">
                </dxwtc:TabPage>
                <dxwtc:TabPage Text ="Businesses(1)">
                </dxwtc:TabPage>
                <dxwtc:TabPage Text ="Land Parcels(0)">
                </dxwtc:TabPage>
                <dxwtc:TabPage Text ="Tenants(2)">
                </dxwtc:TabPage>                                
            </TabPages>
        </dxwtc:ASPxPageControl>
    </div>
    </div>
</asp:Content>
