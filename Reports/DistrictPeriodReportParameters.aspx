<%@ Page Language="C#" MasterPageFile="~/mainmaster.master" AutoEventWireup="true" CodeFile="DistrictPeriodReportParameters.aspx.cs" Inherits="Reports_DistrictPeriodReportParameters" Title="Untitled Page" %>
<%@ Register Assembly="DevExpress.Web.ASPxDataControls.v6.2, Version=6.2.4.0, Culture=neutral, PublicKeyToken=79868b8147b5eae4"
    Namespace="DevExpress.Web.ASPxDataControls" TagPrefix="dxwdc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="centerbox">
        <div class="headerlabel">
            <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/reports.jpg" />
            <asp:Label ID="lblHeader" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <table>
                <tr>
                    <td style="width: 91px">
                        <asp:Label ID="LblStartDate" runat="server" Text="Start Date"></asp:Label>
                    </td>
                    <td style="width: 131px">
                        <dxwdc:ASPxDateEdit ID="DEStartDate" runat="server" TabIndex="0" VisibleDate="2008-02-12">
                            <EditorProperties DaysPadding="0" ShowSeparator="False">
                                <FooterStyle BackColor="#B0CBF1">
                                    <BorderTop Color="103, 135, 184" Style="solid" Width="1px" />
                                </FooterStyle>
                                <LookAndFeel Kind="Office2003">
                                    <ElementsSettings DropDownButtonWidth="17px" ScrollBarBackColor="247, 245, 241" ScrollBarMargin="1"
                                        ScrollBarSize="17px" />
                                    <PopupStyle BorderColor="#6787B8" Font-Names="Verdana" Font-Size="8pt">
                                    </PopupStyle>
                                    <ButtonStyle BackColor="#84ABE3" BorderColor="#6787B8" Font-Names="Verdana" Font-Size="8pt"
                                        ForeColor="Black" Margin="1" UseHotTrackStyle="True" UsePressedStyle="True" Wrap="False">
                                        <PressedStyle BackColor="#FFCA86" BorderColor="Navy" ForeColor="Black">
                                            <Filters>
                                                <dxwdc:LookAndFeelStyleGradientFilter EndColor="255, 202, 134" StartColor="254, 148, 80" />
                                            </Filters>
                                        </PressedStyle>
                                        <Filters>
                                            <dxwdc:LookAndFeelStyleGradientFilter EndColor="132, 171, 227" StartColor="221, 236, 254" />
                                        </Filters>
                                        <HotTrackStyle BackColor="#FFD599" BorderColor="Navy" ForeColor="Black">
                                            <Filters>
                                                <dxwdc:LookAndFeelStyleGradientFilter EndColor="255, 213, 153" StartColor="255, 243, 202" />
                                            </Filters>
                                        </HotTrackStyle>
                                    </ButtonStyle>
                                    <LabelStyle Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" />
                                    <EditorStyle BackColor="White" BorderColor="#6787B8" Font-Names="Verdana" Font-Size="8pt"
                                        ForeColor="Black">
                                    </EditorStyle>
                                    <ScrollBarButtonStyle BackColor="#84ABE3">
                                        <Filters>
                                            <dxwdc:LookAndFeelStyleGradientFilter EndColor="132, 171, 227" GradientMode="Horizontal"
                                                StartColor="221, 236, 254" />
                                        </Filters>
                                    </ScrollBarButtonStyle>
                                </LookAndFeel>
                                <HeaderStyle BorderStyle="None" Font-Bold="True" />
                                <DayStyle BorderColor="#E7F2FE" BorderStyle="Solid" BorderWidth="1px" />
                                <DayHeaderStyle BackColor="#C1D8F7" Font-Bold="True">
                                    <BorderTop Color="103, 135, 184" Style="solid" Width="1px" />
                                    <BorderBottom Color="103, 135, 184" Style="solid" Width="1px" />
                                </DayHeaderStyle>
                                <SelectedStyle BackColor="#316AC5" BorderColor="#6787B8" ForeColor="White">
                                </SelectedStyle>
                                <FooterButtonStyle BackColor="#EDEDEB">
                                </FooterButtonStyle>
                                <CalendarStyle BackColor="#E7F2FE">
                                </CalendarStyle>
                            </EditorProperties>
                        </dxwdc:ASPxDateEdit>
                    </td>
                    <td style="width: 59px">
                        <asp:Label ID="LblEndDate" runat="server" Text="End Date"></asp:Label>
                    </td>
                    <td>
                        <dxwdc:ASPxDateEdit ID="DEEndDate" runat="server" TabIndex="0" VisibleDate="2008-02-12">
                            <EditorProperties DaysPadding="0" ShowSeparator="False">
                                <FooterStyle BackColor="#B0CBF1">
                                    <BorderTop Color="103, 135, 184" Style="solid" Width="1px" />
                                </FooterStyle>
                                <LookAndFeel Kind="Office2003">
                                    <ElementsSettings DropDownButtonWidth="17px" ScrollBarBackColor="247, 245, 241" ScrollBarMargin="1"
                                        ScrollBarSize="17px" />
                                    <PopupStyle BorderColor="#6787B8" Font-Names="Verdana" Font-Size="8pt">
                                    </PopupStyle>
                                    <ButtonStyle BackColor="#84ABE3" BorderColor="#6787B8" Font-Names="Verdana" Font-Size="8pt"
                                        ForeColor="Black" Margin="1" UseHotTrackStyle="True" UsePressedStyle="True" Wrap="False">
                                        <PressedStyle BackColor="#FFCA86" BorderColor="Navy" ForeColor="Black">
                                            <Filters>
                                                <dxwdc:LookAndFeelStyleGradientFilter EndColor="255, 202, 134" StartColor="254, 148, 80" />
                                            </Filters>
                                        </PressedStyle>
                                        <Filters>
                                            <dxwdc:LookAndFeelStyleGradientFilter EndColor="132, 171, 227" StartColor="221, 236, 254" />
                                        </Filters>
                                        <HotTrackStyle BackColor="#FFD599" BorderColor="Navy" ForeColor="Black">
                                            <Filters>
                                                <dxwdc:LookAndFeelStyleGradientFilter EndColor="255, 213, 153" StartColor="255, 243, 202" />
                                            </Filters>
                                        </HotTrackStyle>
                                    </ButtonStyle>
                                    <LabelStyle Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" />
                                    <EditorStyle BackColor="White" BorderColor="#6787B8" Font-Names="Verdana" Font-Size="8pt"
                                        ForeColor="Black">
                                    </EditorStyle>
                                    <ScrollBarButtonStyle BackColor="#84ABE3">
                                        <Filters>
                                            <dxwdc:LookAndFeelStyleGradientFilter EndColor="132, 171, 227" GradientMode="Horizontal"
                                                StartColor="221, 236, 254" />
                                        </Filters>
                                    </ScrollBarButtonStyle>
                                </LookAndFeel>
                                <HeaderStyle BorderStyle="None" Font-Bold="True" />
                                <DayStyle BorderColor="#E7F2FE" BorderStyle="Solid" BorderWidth="1px" />
                                <DayHeaderStyle BackColor="#C1D8F7" Font-Bold="True">
                                    <BorderTop Color="103, 135, 184" Style="solid" Width="1px" />
                                    <BorderBottom Color="103, 135, 184" Style="solid" Width="1px" />
                                </DayHeaderStyle>
                                <SelectedStyle BackColor="#316AC5" BorderColor="#6787B8" ForeColor="White">
                                </SelectedStyle>
                                <FooterButtonStyle BackColor="#EDEDEB">
                                </FooterButtonStyle>
                                <CalendarStyle BackColor="#E7F2FE">
                                </CalendarStyle>
                            </EditorProperties>
                        </dxwdc:ASPxDateEdit>
                    </td>
                </tr>
                <tr>
                    <td style="width: 91px">
                        <asp:Label ID="LblDistricts" runat="server" Text="Select a District"></asp:Label></td>
                    <td style="width: 131px">
                        <asp:DropDownList ID="DDLDistricts" runat="server" Width="120px">
                        </asp:DropDownList></td>
                    <td style="width: 59px">
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td style="width: 91px; height: 26px">
                        &nbsp; &nbsp;
                    </td>
                    <td style="width: 131px; height: 26px">
                    </td>
                    <td style="width: 59px; height: 26px">
                    </td>
                    <td style="height: 26px">
                    </td>
                </tr>
                <tr>
                    <td colspan="4" >
                        <asp:Button ID="BtnViewReport" runat="server" Text="Button" OnClick="BtnViewReport_Click" /></td>
                </tr>
                <tr>
                <td style="width: 91px">
                    <asp:HiddenField ID="HFReportName" runat="server" />
                </td>
                </tr> 
            </table>
        </div>
    </div>
</asp:Content>

