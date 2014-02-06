<%@ Page Language="C#" MasterPageFile="~/mainmaster.master" AutoEventWireup="true"
    CodeFile="landparcel.aspx.cs" Inherits="landparcel" Title="Untitled Page" %>

<%@ Register Assembly="DevExpress.Web.ASPxDataControls.v6.2, Version=6.2.4.0, Culture=neutral, PublicKeyToken=79868b8147b5eae4"
    Namespace="DevExpress.Web.ASPxDataControls" TagPrefix="dxwdc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="centerbox">
        <div class="headerlabel">
            <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/region.jpg" />
            <asp:Label ID="LblAddLandParcel" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div>
            <div>
                <asp:Label ID="LblRequired" runat="server" Font-Bold="true" Text="* indicates a mandatory (required) field"></asp:Label>
                <br />
                <asp:Label ID="LblError" runat="server" Font-Bold="true" ForeColor="red"></asp:Label>
            </div>
            <br />
            <div class="simplebordered">
                <table width ="100%">
                    <tr>
                        <td valign="top" width="100px">
                            <asp:Label ID="lblPlotNumber" runat="server" Text="Plot No."></asp:Label>
                            <asp:Label ID="lblStar" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                                Text="*"></asp:Label>
                        </td>
                        <td valign="top">
                            <asp:TextBox ID="txtPlotNumber" runat="server" Width="96px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <asp:Label ID="LblYear" runat="server" Text="Year"></asp:Label>
                            <asp:Label ID="Label1" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                                Text="*"></asp:Label>
                        </td>
                        <td valign="top">
                            <asp:DropDownList ID="ddlyears" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <asp:Label ID="LblStandingLevel" runat="server" Text="Standing Level"></asp:Label>
                            <asp:Label ID="Label2" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                                Text="*"></asp:Label>
                        </td>
                        <td valign="top">
                            <asp:DropDownList ID="DDLStandingLevel" runat="server" Width="80px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <asp:Label ID="LblLandTitle" runat="server" Text="Land Title"></asp:Label>
                            <asp:Label ID="Label3" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                                Text="*"></asp:Label>
                        </td>
                        <td valign="top">
                            <asp:TextBox ID="txtLandTitle" runat="server" Width="96px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <asp:Label ID="LblTitleNumber" runat="server" Text="Title No."></asp:Label>
                            <asp:Label ID="Label4" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                                Text="*"></asp:Label>
                        </td>
                        <td valign="top">
                            <asp:TextBox ID="txtTitleNumber" runat="server" Width="96px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <asp:Label ID="LblUsage" runat="server" Text="Usage"></asp:Label>
                            <asp:Label ID="Label5" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                                Text="*"></asp:Label>
                        </td>
                        <td valign="top">
                            <asp:TextBox ID="txtUsage" runat="server" Width="96px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <asp:Label ID="LblHouses" runat="server" Text="#Houses"></asp:Label>
                            <asp:Label ID="Label6" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                                Text="*"></asp:Label>
                        </td>
                        <td valign="top">
                            <asp:DropDownList ID="DDLHouses" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <asp:Label ID="LblContractNumber" runat="server" Text="Contract No."></asp:Label>
                            <asp:Label ID="Label7" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                                Text="*"></asp:Label>
                        </td>
                        <td valign="top">
                            <asp:TextBox ID="txtContractNumber" runat="server" Width="96px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <asp:Label ID="LblContractDate" runat="server" Text="Contract date"></asp:Label>
                            <asp:Label ID="Label8" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                                Text="*"></asp:Label>
                        </td>
                        <td valign="top">
                            <dxwdc:ASPxDateEdit ID="ContractDate" runat="server" TabIndex="0" VisibleDate="2008-07-04"
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
                                                    <devexpress.web.aspxdatacontrols.lookandfeelstylegradientfilter EndColor="255, 213, 153" StartColor="255, 243, 202" />
                                                </Filters>
                                            </HotTrackStyle>
                                            <PressedStyle BackColor="#FFCA86" BorderColor="Navy" ForeColor="Black">
                                                <Filters>
                                                    <devexpress.web.aspxdatacontrols.lookandfeelstylegradientfilter EndColor="255, 202, 134" StartColor="254, 148, 80" />
                                                </Filters>
                                            </PressedStyle>
                                            <Filters>
                                                <devexpress.web.aspxdatacontrols.lookandfeelstylegradientfilter EndColor="132, 171, 227" StartColor="221, 236, 254" />
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
                                                <devexpress.web.aspxdatacontrols.lookandfeelstylegradientfilter EndColor="132, 171, 227" GradientMode="Horizontal"
                                                    StartColor="221, 236, 254" />
                                            </Filters>
                                        </ScrollBarButtonStyle>
                                        <ElementsSettings DropDownButtonWidth="17px" ScrollBarBackColor="247, 245, 241" ScrollBarMargin="1"
                                            ScrollBarSize="17px" />
                                    </LookAndFeel>
                                </EditorProperties>
                            </dxwdc:ASPxDateEdit>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <asp:Label ID="LblLandTax" runat="server" Text="Land Tax"></asp:Label>
                            <asp:Label ID="Label9" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                                Text="*"></asp:Label>
                        </td>
                        <td valign="top">
                            <asp:TextBox ID="txtLandTax" runat="server" Width="96px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;</td>
                        <td>
                            <asp:HiddenField ID="HFLandParcelID" runat="server" />
                            <asp:HiddenField ID="HFTaxPayerID" runat="server" />
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                        </td>
                        <td valign="top">
                            <asp:Button ID="BtnSave" runat="server" Text=" Save " OnClick="BtnSave_Click" />
                            <asp:Button ID="BtnCancel" runat="server" Text=" Cancel" OnClick="BtnCancel_Click" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
