<%@ Page Language="C#" MasterPageFile="~/mainmaster.master" AutoEventWireup="true"
    CodeFile="TaxPayer.aspx.cs" Inherits="TaxPayer" Title="TaxPayer Details" %>

<%@ Register Assembly="System.Web, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="System.Web.UI" TagPrefix="cc1" %>
<%@ Register Assembly="DevExpress.Web.ASPxDataControls.v6.2, Version=6.2.4.0, Culture=neutral, PublicKeyToken=79868b8147b5eae4"
    Namespace="DevExpress.Web.ASPxDataControls" TagPrefix="dxwdc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="centerbox">
        <div class="headerlabel">
            <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/taxpayer.jpg" />
            <asp:Label ID="lblHeader" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <div>
                <asp:Label ID="LblRequired" runat="server" Text="* indicates a mandatory (required) field"
                    Font-Bold="true"></asp:Label>
                    <br />
                    <asp:Label ID="LblError" runat="server" Font-Bold="true" ForeColor ="red" ></asp:Label>
            </div>
            <br />
            <table align="center">
                <tr>
                    <td nowrap="noWrap">
                        <asp:Label ID="LblNames" runat="server" Text="Names"></asp:Label>
                        <asp:Label ID="lblStar" runat="server" Text="*" ForeColor="red" Font-Bold="true"
                            Font-Size="Larger"></asp:Label>
                    </td>
                    <td colspan="3">
                        <asp:TextBox ID="txtTaxPayerName" runat="server" Width="500px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td nowrap="noWrap">
                        <asp:Label ID="LblSector" runat="server" Text="Sector"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="DDLSector" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DDLSector_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td nowrap="noWrap">
                        <asp:Label ID="lblCellID" runat="server" Text="Cell"></asp:Label>
                        <asp:Label ID="Label1" runat="server" Text="*" ForeColor="red" Font-Bold="true" Font-Size="Larger"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="cboCellID" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td nowrap="noWrap">
                        <asp:Label ID="lblFileNumber" runat="server" Text="File number"></asp:Label>
                    </td>
                    <td colspan="3">
                        <asp:TextBox ID="txtFileNumber" runat="server" Width="168px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td nowrap="noWrap">
                        <asp:Label ID="lblAddress" runat="server" Text="Address"></asp:Label>
                        <asp:Label ID="Label6" runat="server" Text="*" ForeColor="red" Font-Bold="true" Font-Size="Larger"></asp:Label>
                    </td>
                    <td colspan="3">
                        <asp:TextBox ID="txtAddress" runat="server" Width="600px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td nowrap="noWrap">
                        <asp:Label ID="lblTelephone" runat="server" Text="Telephone"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtTelephone" runat="server" Width="168px"></asp:TextBox>
                    </td>
                    <td nowrap="noWrap">
                        <asp:Label ID="lblMobile" runat="server" Text="Mobile"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtMobile" runat="server" Width="168px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td nowrap="noWrap">
                        <asp:Label ID="lblProffession" runat="server" Text="Profession"></asp:Label>
                        <asp:Label ID="Label2" runat="server" Text="*" ForeColor="red" Font-Bold="true" Font-Size="Larger"></asp:Label>
                    </td>
                    <td colspan="3">
                        <asp:TextBox ID="txtProffession" runat="server" Width="168px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td nowrap="noWrap">
                        <asp:Label ID="lblDOB" runat="server" Text="Date of birth"></asp:Label>
                        <asp:Label ID="Label3" runat="server" Text="*" ForeColor="red" Font-Bold="true" Font-Size="Larger"></asp:Label>
                    </td>
                    <td colspan="3">
                        <dxwdc:ASPxDateEdit ID="DEDOB" runat="server" Width="232px" TabIndex="0" VisibleDate="2008-05-27">
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
                </tr>
                <tr>
                    <td nowrap="noWrap">
                        <asp:Label ID="lblIDNumber" runat="server" Text="ID number"></asp:Label>
                        <asp:Label ID="Label4" runat="server" Text="*" ForeColor="red" Font-Bold="true" Font-Size="Larger"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtIDNumber" runat="server" Width="168px"></asp:TextBox>
                    </td>
                    <td nowrap="noWrap">
                        <asp:Label ID="lblIDType" runat="server" Text="ID Type"></asp:Label>
                        <asp:Label ID="Label5" runat="server" Text="*" ForeColor="red" Font-Bold="true" Font-Size="Larger"></asp:Label></td>
                    <td>
                        <asp:DropDownList ID="DDLIDType" runat="server" Width="176px">
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td nowrap="noWrap">
                        <asp:Label ID="lblTin" runat="server" Text="TIN"></asp:Label>
                    </td>
                    <td colspan="3">
                        <asp:TextBox ID="txtTin" runat="server" Width="168px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td nowrap="noWrap">
                        <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label>
                    </td>
                    <td colspan="3">
                        <asp:TextBox ID="txtEmail" runat="server" Width="440px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td nowrap="noWrap">
                    </td>
                    <td colspan="3">
                        <asp:Button ID="BtnSave" runat="server" Text="Save" Width="80px" OnClick="Button1_Click"
                            CssClass="buttons" />
                        <asp:Button ID="BtnCancel" runat="server" Text="Cancel" Width="80px" OnClick="BtnCancel_Click"
                            CssClass="buttons" />
                        <asp:HiddenField ID="HFTaxPayerID" runat="server" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
