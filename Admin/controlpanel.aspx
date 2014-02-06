<%@ Page Language="VB" MasterPageFile="~/mainmaster.master" AutoEventWireup="false"
    CodeFile="controlpanel.aspx.vb" Inherits="controlpanel" Title="Untitled Page" %>

<%@ Register Assembly="DevExpress.Web.ASPxMenu.v6.2, Version=6.2.4.0, Culture=neutral, PublicKeyToken=79868b8147b5eae4"
    Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dxwm" %>
<%@ Register Assembly="System.Web, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="System.Web.UI" TagPrefix="cc1" %>
<%@ Register Assembly="DevExpress.Web.ASPxDataControls.v6.2, Version=6.2.4.0, Culture=neutral, PublicKeyToken=79868b8147b5eae4"
    Namespace="DevExpress.Web.ASPxDataControls" TagPrefix="dxwdc" %>
<%@ Register Assembly="DevExpress.Web.ASPxTabControl.v6.2, Version=6.2.4.0, Culture=neutral, PublicKeyToken=79868b8147b5eae4"
    Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dxwtc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="centerbox">
        <div class="headerlabel">
            <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/settings.jpg" />
            <asp:Label ID="lblHeader" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <dxwtc:ASPxPageControl ID="PageControl" runat="server" ActiveTabIndex="0" Height="200px"
                TabAlign="Justify" TabSpacing="15px" Width="544px">
                <TabPages>
                    <dxwtc:TabPage Text="Regions" Name="Regions">
                        <Controls>
                            <dxwm:ASPxMenu ID="RegionsMenu" runat="server" Orientation="Vertical">
                                <Items>
                                    <dxwm:MenuItem NavigateUrl="~/Admin/Provinces.aspx" Text="Manage the Provinces List">
                                    </dxwm:MenuItem>
                                    <dxwm:MenuItem NavigateUrl="~/Admin/Districts.aspx" Text="Manage the Districts List">
                                    </dxwm:MenuItem>
                                    <dxwm:MenuItem NavigateUrl="~/Admin/Sectors.aspx" Text="Manage the Sectors List">
                                    </dxwm:MenuItem>
                                    <dxwm:MenuItem NavigateUrl="~/Admin/Cells.aspx" Text="Manage the Cells List">
                                    </dxwm:MenuItem>
                                </Items>
                            </dxwm:ASPxMenu>
                        </Controls>
                    </dxwtc:TabPage>
                    <dxwtc:TabPage Text="Security">
                        <Controls>
                            <dxwm:ASPxMenu ID="SecurityMenu" runat="server" Orientation="Vertical">
                                <Items>
                                    <dxwm:MenuItem Text="Manage Users who can access this application">
                                    </dxwm:MenuItem>
                                    <dxwm:MenuItem Text="Manage User Permissions">
                                    </dxwm:MenuItem>
                                </Items>
                            </dxwm:ASPxMenu>
                        </Controls>
                    </dxwtc:TabPage>
                    <dxwtc:TabPage Text="Payment Types &amp; Banks">
                        <Controls>
                            <dxwm:ASPxMenu ID="PaymentsMenu" runat="server" Orientation="Vertical">
                                <Items>
                                    <dxwm:MenuItem NavigateUrl="~/Admin/Banks.aspx" Text="Manage Banks used to pay taxes and fees"
                                        Name="Banks">
                                    </dxwm:MenuItem>
                                    <dxwm:MenuItem Name="taxtypes" NavigateUrl="~/Admin/TaxTypes.aspx" Text="Manage the types of taxes payed">
                                    </dxwm:MenuItem>
                                </Items>
                            </dxwm:ASPxMenu>
                        </Controls>
                    </dxwtc:TabPage>
                </TabPages>
                <LoadingPanelImage Url="~/Images/Plastic Blue/tcLoading.gif" />
                <ActiveTabStyle BackColor="#3E5395" ForeColor="White">
                    <HoverStyle BackColor="#3E5395">
                        <BackgroundImage ImageUrl="~/Images/Plastic Blue/tcTabABack.gif" Repeat="RepeatX" />
                    </HoverStyle>
                    <BackgroundImage ImageUrl="~/Images/Plastic Blue/tcTabABack.gif" Repeat="RepeatX" />
                    <Border BorderColor="#2C4182" />
                </ActiveTabStyle>
                <TabStyle BackColor="White">
                    <Paddings PaddingBottom="4px" PaddingLeft="14px" PaddingRight="14px" PaddingTop="4px" />
                    <HoverStyle>
                        <BackgroundImage ImageUrl="~/Images/Plastic Blue/tcTabHBack.gif" />
                    </HoverStyle>
                    <BackgroundImage ImageUrl="~/Images/Plastic Blue/tcTabBack.gif" Repeat="NoRepeat" />
                    <Border BorderColor="#CCCCCC" />
                </TabStyle>
                <LoadingPanelStyle ForeColor="#AAAAAA" ImageSpacing="6px">
                </LoadingPanelStyle>
                <ContentStyle>
                    <BackgroundImage ImageUrl="~/Images/Plastic Blue/tcContentBack.gif" Repeat="RepeatX" />
                    <Border BorderColor="#CCCCCC" />
                    <BorderTop BorderWidth="0px" />
                </ContentStyle>
            </dxwtc:ASPxPageControl>
        </div>
    </div>
</asp:Content>
