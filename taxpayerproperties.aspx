<%@ Page Language="C#" MasterPageFile="~/mainmaster.master" AutoEventWireup="true"
    CodeFile="taxpayerproperties.aspx.cs" Inherits="taxpayerproperties" Title="Untitled Page" %>

<%@ Register Assembly="DevExpress.Web.ASPxDataControls.v6.2, Version=6.2.4.0, Culture=neutral, PublicKeyToken=79868b8147b5eae4"
    Namespace="DevExpress.Web.ASPxDataControls" TagPrefix="dxwdc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="centerbox">
        <div class="headerlabel">
            <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/bank.jpg" />
            <asp:Label ID="LblAddProperty" runat="server" Font-Bold="True"></asp:Label>
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
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td colspan="2" align="center">
                        <asp:Label ID="LblPropertyValue" runat="server" Text="Property Value"></asp:Label>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="LblUse" runat="server" Text="Use"></asp:Label>
                        <asp:Label ID="Label1" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                            Text="*"></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:Label ID="LblOwnerName" runat="server" Text="Owner's Name"></asp:Label>
                        <asp:Label ID="Label2" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                            Text="*"></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:Label ID="LblDateOfAcquisition" runat="server" Text="Date of Acquisition"></asp:Label>
                        <asp:Label ID="Label3" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                            Text="*"></asp:Label>
                    </td>
                    <td valign="top" align="center">
                        <asp:Label ID="LblOwnerPropertyValue" runat="server" Text="Owner"></asp:Label>
                        <asp:Label ID="Label4" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                            Text="*"></asp:Label>
                    </td>
                    <td valign="top" align="center">
                        <asp:Label ID="lblDistrictPropertyValue" runat="server" Text="District"></asp:Label>
                        <asp:Label ID="Label5" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                            Text="*"></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:Label ID="LblPlotNumber" runat="server" Text="Plot No."></asp:Label>
                        <asp:Label ID="Label6" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                            Text="*"></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:Label ID="LblPropertyTax" runat="server" Text="Tax"></asp:Label>
                        <asp:Label ID="Label7" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                            Text="*"></asp:Label>
                    </td>
                    <td valign="top">
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:TextBox ID="txtUse" runat="server" Width="110px"></asp:TextBox>
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="txtOwnerName" runat="server" Width="160px"></asp:TextBox>
                    </td>
                    <td valign="top">
                        <dxwdc:ASPxDateEdit ID="DateOfAcquisition" runat="server" TabIndex="0" VisibleDate="2008-05-27"
                            Width="100px">
                            <EditorProperties DaysPadding="0" ShowSeparator="False">
                                <CalendarStyle BackColor="#E7F2FE">
                                </CalendarStyle>
                                <DayHeaderStyle BackColor="#C1D8F7" Font-Bold="True">
                                    <BorderTop Color="103, 135, 184" Style="solid" Width="1px" />
                                    <BorderBottom Color="103, 135, 184" Style="solid" Width="1px" />
                                </DayHeaderStyle>
                                <DayStyle BorderColor="#E7F2FE" BorderStyle="Solid" BorderWidth="1px" />
                                <FooterStyle BackColor="#B0CBF1">
                                    <BorderTop Color="103, 135, 184" Style="solid" Width="1px" />
                                </FooterStyle>
                                <FooterButtonStyle BackColor="#EDEDEB">
                                </FooterButtonStyle>
                                <HeaderStyle BorderStyle="None" Font-Bold="True" />
                                <SelectedStyle BackColor="#316AC5" BorderColor="#6787B8" ForeColor="White">
                                </SelectedStyle>
                                <LookAndFeel Kind="Office2003">
                                    <ButtonStyle BackColor="#84ABE3" BorderColor="#6787B8" Font-Names="Verdana" Font-Size="8pt"
                                        ForeColor="Black" Margin="1" UseHotTrackStyle="True" UsePressedStyle="True" Wrap="False">
                                        <HotTrackStyle BackColor="#FFD599" BorderColor="Navy" ForeColor="Black">
                                            <Filters>
                                                <dxwdc:LookAndFeelStyleGradientFilter EndColor="255, 213, 153" StartColor="255, 243, 202" />
                                            </Filters>
                                        </HotTrackStyle>
                                        <PressedStyle BackColor="#FFCA86" BorderColor="Navy" ForeColor="Black">
                                            <Filters>
                                                <dxwdc:LookAndFeelStyleGradientFilter EndColor="255, 202, 134" StartColor="254, 148, 80" />
                                            </Filters>
                                        </PressedStyle>
                                        <Filters>
                                            <dxwdc:LookAndFeelStyleGradientFilter EndColor="132, 171, 227" StartColor="221, 236, 254" />
                                        </Filters>
                                    </ButtonStyle>
                                    <EditorStyle BackColor="White" BorderColor="#6787B8" Font-Names="Verdana" Font-Size="8pt"
                                        ForeColor="Black">
                                    </EditorStyle>
                                    <LabelStyle Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" />
                                    <PopupStyle BorderColor="#6787B8" Font-Names="Verdana" Font-Size="8pt">
                                    </PopupStyle>
                                    <ScrollBarButtonStyle BackColor="#84ABE3">
                                        <Filters>
                                            <dxwdc:LookAndFeelStyleGradientFilter EndColor="132, 171, 227" GradientMode="Horizontal"
                                                StartColor="221, 236, 254" />
                                        </Filters>
                                    </ScrollBarButtonStyle>
                                    <ElementsSettings DropDownButtonWidth="17px" ScrollBarBackColor="247, 245, 241" ScrollBarMargin="1"
                                        ScrollBarSize="17px" />
                                </LookAndFeel>
                            </EditorProperties>
                        </dxwdc:ASPxDateEdit>
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="txtOwnerPropertyValue" runat="server" Width="85px"></asp:TextBox>
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="txtDistrictPropertyValue" runat="server" Width="85px"></asp:TextBox>
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="txtPlotNumber" runat="server" Width="65px"></asp:TextBox>
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="txtPropertyTax" runat="server" Width="70px"></asp:TextBox>
                    </td>
                    <td valign="top">
                        <asp:Button ID="BtnAddProperty" runat="server" Text=" Add " OnClick="BtnAddProperty_Click"
                            CssClass="buttons" /></td>
                </tr>
                <tr>
                    <td>
                        <asp:HiddenField ID="HFTaxPayerID" runat="server" />
                    </td>
                    <td>
                        <asp:HiddenField ID="HFPropertyID" runat="server" />
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
        </div>
        <div class="headerlabel">
            <asp:Image ID="Image1" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/bank.jpg" />
            <asp:Label ID="LblProperties" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <asp:Table ID="TblProperties" runat="server" Width="240px">
            </asp:Table>
        </div>
        <div class="simplebordered">
            <table>
                <tr>
                    <td>
                        <asp:Button ID="BtnBack" runat="server" Text=" Back " OnClick="BtnBack_Click" CssClass="buttons" />
                        <asp:Button ID="BtnNext" runat="server" Text="Finish" OnClick="BtnNext_Click" CssClass="buttons" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
