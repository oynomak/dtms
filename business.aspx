<%@ Page Language="C#" MasterPageFile="~/mainmaster.master" AutoEventWireup="true"
    CodeFile="business.aspx.cs" Inherits="business" Title="Untitled Page" %>

<%@ Register Assembly="DevExpress.Web.ASPxDataControls.v6.2, Version=6.2.4.0, Culture=neutral, PublicKeyToken=79868b8147b5eae4"
    Namespace="DevExpress.Web.ASPxDataControls" TagPrefix="dxwdc" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="centerbox">
        <div class="headerlabel">
            <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/region.jpg" />
            <asp:Label ID="LblBusiness" runat="server" Font-Bold="True"></asp:Label>
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
                    <td valign="top">
                        <asp:Label ID="LblProfession" runat="server" Text="Profession"></asp:Label>
                        <asp:Label ID="lblStar" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                            Text="*"></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="txtProfession" runat="server" Width="128px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="LblBusinessName" runat="server" Text="Business Name"></asp:Label>
                        <asp:Label ID="Label1" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                            Text="*"></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="txtBusinessName" runat="server" Width="130px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="LblStartingDate" runat="server" Text="Starting Date"></asp:Label>
                        <asp:Label ID="Label2" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                            Text="*"></asp:Label>
                    </td>
                    <td valign="top">
                        <dxwdc:aspxdateedit id="StartingDate" runat="server" tabindex="0" visibledate="2008-05-27"
                            width="232px">
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
                        </dxwdc:aspxdateedit>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="LblAmount" runat="server" Text="Amount"></asp:Label>
                        <asp:Label ID="Label3" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                            Text="*"></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="txtAmount" runat="server" Width="128px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="LblAddress" runat="server" Text="Address"></asp:Label>
                        <asp:Label ID="Label4" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                            Text="*"></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="txtAddress" runat="server" Width="440px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <asp:Label ID="lblPlotNumber" runat="server" Text="Plot No."></asp:Label>
                        <asp:Label ID="Label5" runat="server" Font-Bold="true" Font-Size="Larger" ForeColor="red"
                            Text="*"></asp:Label>
                    </td>
                    <td valign="top">
                        <asp:TextBox ID="txtPlotNumber" runat="server" Width="128px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        <asp:HiddenField ID="HFTaxPayerID" runat="server" />
                        <asp:HiddenField ID="HFBusinessID" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                    </td>
                    <td valign="top">
                        <asp:Button ID="BtnSave" runat="server" Text=" Save " OnClick="Button1_Click" CssClass="buttons" />
                        <asp:Button ID="BtnCancel" runat="server" Text="Cancel" OnClick="Button2_Click" CssClass="buttons" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
