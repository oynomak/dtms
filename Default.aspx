<%@ Page Language="C#" MasterPageFile="~/mainmaster.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.ASPxDataControls.v6.2, Version=6.2.4.0, Culture=neutral, PublicKeyToken=79868b8147b5eae4"
    Namespace="DevExpress.Web.ASPxDataControls" TagPrefix="dxwdc" %>
<%@ Register Assembly="DevExpress.Web.ASPxGrid.v6.2, Version=6.2.4.0, Culture=neutral, PublicKeyToken=79868b8147b5eae4"
    Namespace="DevExpress.Web.ASPxGrid" TagPrefix="dxwg" %>
<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="centerbox">
        <div class="headerlabel" id="PaymentsHeader" runat="server">
            <asp:Image ID="taximage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/tax.jpg" />
            <asp:Label ID="LblPayments" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered" id="PaymentsBox" runat="server">
            <ul>
                <li>
                    <asp:HyperLink ID="HLNewPayment" runat="server" Text="Post a New Payment" NavigateUrl="~/taxpayment.aspx"></asp:HyperLink>
                </li>
                <li>
                    <asp:HyperLink ID="HLNewFeePayment" runat="server" Text="Post a New Fee Payment"
                        NavigateUrl="~/feepayment.aspx"></asp:HyperLink>
                </li>
            </ul>
        </div>
        <div class="headerlabel" id="TaxpayersHeader" runat="server">
            <asp:Image ID="Image1" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/taxpayer.jpg" />
            <asp:Label ID="LblTaxpayers" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered" id="TaxpayersBox" runat="server">
            <ul>
                <li>
                    <asp:HyperLink ID="HLNewTaxPayer" runat="server" Text="Register a New TaxPayer" NavigateUrl="~/TaxPayer.aspx"></asp:HyperLink>
                </li>
                <li>
                    <asp:HyperLink ID="HLTaxPayerDetails" runat="server" Text="View TaxPayer Details" NavigateUrl="~/taxpayers.aspx"></asp:HyperLink>
                </li>
            </ul>
        </div>
        <div class="headerlabel">
            <asp:Image ID="Image2" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/reports.jpg" />
            <asp:Label ID="LblReports" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <ul>
                <li>
                    <asp:HyperLink ID="HLTaxpaymentsThisMonth" runat="server" Text="Tax Payments this month"></asp:HyperLink></li><li>
                        <asp:HyperLink ID="HLTaxPayersBySector" runat="server" Text="Taxpayers By Sector and Cell"></asp:HyperLink></li><li>
                            <asp:HyperLink ID="HLMore" runat="server" Text="More...."></asp:HyperLink></li></ul>
        </div>
        <div class="headerlabel" id="DataHeader" runat="server">
            <asp:Image ID="Image3" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/data.jpg" />
            <asp:Label ID="LblDistrictData" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered" id="DataBox" runat="server">
            <dxwg:ASPxGrid ID="ASPxGrid1" runat="server" DataSourceID="SqlDataSource1" DataKeyField="DistrictID"
                TabIndex="0" AutoGenerateColumns="False" BorderColor="#6787B8" BorderStyle="Solid"
                ExpandBtnHeight="11px" ExpandBtnWidth="11px" HeaderHeight="25px" RowBtnWidth="18px"
                SearchBtnWidth="17px" SelectedBackColor="49, 106, 197" StatusBarItemSpacing="0"
                PageSize="6">
                <FooterStyle FixedHeight="True" FixedWidth="True" BackColor="#B0CBF1" Font-Bold="True"
                    Wrap="False" />
                <StatusBars>
                    <dxwg:StatusBar Height="20px" StatusBarType="Regular">
                        <BarItems>
                            <dxwdc:BarStatusSection StatusSectionType="Status">
                            </dxwdc:BarStatusSection>
                            <dxwdc:BarStatusSection StatusSectionType="VisibleInterval">
                            </dxwdc:BarStatusSection>
                            <dxwdc:BarStatusSection StatusSectionType="TotalVisible">
                            </dxwdc:BarStatusSection>
                            <dxwdc:BarStatusSection StatusSectionType="TotalRows">
                            </dxwdc:BarStatusSection>
                        </BarItems>
                    </dxwg:StatusBar>
                </StatusBars>
                <GroupItemStyle Wrap="True" BackColor="#C1D8F7" BorderColor="#6787B8">
                </GroupItemStyle>
                <HeaderStyle FixedHeight="True" FixedWidth="True" Wrap="False" BorderStyle="None"
                    Font-Bold="True" />
                <ButtonBars>
                    <dxwg:ButtonBar ButtonBarType="Navigator">
                        <BarItems>
                            <dxwdc:BarButton ButtonType="MoveFirst">
                            </dxwdc:BarButton>
                            <dxwdc:BarButton ButtonType="MovePrevPage">
                            </dxwdc:BarButton>
                            <dxwdc:BarButton ButtonType="MovePrev">
                            </dxwdc:BarButton>
                            <dxwdc:BarTwoStateEditorButton ButtonType="ChangePageSize">
                            </dxwdc:BarTwoStateEditorButton>
                            <dxwdc:BarButton ButtonType="MoveNext">
                            </dxwdc:BarButton>
                            <dxwdc:BarButton ButtonType="MoveNextPage">
                            </dxwdc:BarButton>
                            <dxwdc:BarButton ButtonType="MoveLast">
                            </dxwdc:BarButton>
                            <dxwdc:BarButton ButtonType="Refresh">
                            </dxwdc:BarButton>
                        </BarItems>
                    </dxwg:ButtonBar>
                </ButtonBars>
                <SearchBtnStyle FixedWidth="True">
                </SearchBtnStyle>
                <ItemStyle FixedWidth="True" Wrap="False" BackColor="White" Font-Size="7.5pt" VerticalAlign="Middle" />
                <Columns>
                    <dxwg:BoundColumn DataField="DistrictName" HeaderText="District" VisibleIndex="0">
                    </dxwg:BoundColumn>
                    <dxwg:BoundColumn DataField="Created" HeaderText="Last Updated" VisibleIndex="1">
                    </dxwg:BoundColumn>
                    <dxwg:BoundColumn DataField="RecordsInserted" HeaderText="New Records" VisibleIndex="2">
                    </dxwg:BoundColumn>
                    <dxwg:BoundColumn DataField="RecordsUpdated" HeaderText="Changed Records" VisibleIndex="3">
                    </dxwg:BoundColumn>
                    <dxwg:BoundColumn DataField="RecordsDeleted" HeaderText="Removed Records" VisibleIndex="4">
                    </dxwg:BoundColumn>
                </Columns>
                <ExpandBtnStyle BackColor="#F9F9F9" BorderColor="#6787B8" BorderStyle="Solid" BorderWidth="1px">
                    <PressedStyle BackColor="#D0D0D0" BorderColor="Navy" ForeColor="Black">
                    </PressedStyle>
                    <HotTrackStyle BackColor="White" BorderColor="Navy">
                    </HotTrackStyle>
                </ExpandBtnStyle>
                <RowBtnStyle BorderStyle="None">
                </RowBtnStyle>
                <GroupedHeaderStyle BorderColor="#6787B8" BorderStyle="Solid" BorderWidth="1px">
                    <PressedStyle BorderColor="Navy">
                    </PressedStyle>
                    <HotTrackStyle BorderColor="Navy">
                    </HotTrackStyle>
                </GroupedHeaderStyle>
                <SearchEditorStyle BorderColor="White">
                </SearchEditorStyle>
                <BarBtnEditorStyle BorderStyle="None">
                </BarBtnEditorStyle>
                <AppearanceOptions ShowGroupPanel="False" />
                <TitleStyle BackColor="#6787B8" ForeColor="White" />
                <LookAndFeel Kind="Office2003">
                    <ElementsSettings DropDownButtonWidth="17px" ScrollBarBackColor="247, 245, 241" ScrollBarMargin="1"
                        ScrollBarSize="17px" />
                    <PopupStyle BorderColor="#6787B8" Font-Names="Verdana" Font-Size="8pt">
                    </PopupStyle>
                    <ButtonStyle BackColor="#84ABE3" BorderColor="#6787B8" Font-Names="Verdana" Font-Size="8pt"
                        ForeColor="Black" Margin="1" UseHotTrackStyle="True" UsePressedStyle="True" Wrap="False">
                        <PressedStyle BackColor="#FFCA86" BorderColor="Navy" ForeColor="Black">
                            <Filters>
                                <dxwdc:LookAndFeelStyleGradientFilter EndColor="255, 202, 134" StartColor="254, 148, 80">
                                </dxwdc:LookAndFeelStyleGradientFilter>
                            </Filters>
                        </PressedStyle>
                        <Filters>
                            <dxwdc:LookAndFeelStyleGradientFilter EndColor="132, 171, 227" StartColor="221, 236, 254">
                            </dxwdc:LookAndFeelStyleGradientFilter>
                        </Filters>
                        <HotTrackStyle BackColor="#FFD599" BorderColor="Navy" ForeColor="Black">
                            <Filters>
                                <dxwdc:LookAndFeelStyleGradientFilter EndColor="255, 213, 153" StartColor="255, 243, 202">
                                </dxwdc:LookAndFeelStyleGradientFilter>
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
                                StartColor="221, 236, 254">
                            </dxwdc:LookAndFeelStyleGradientFilter>
                        </Filters>
                    </ScrollBarButtonStyle>
                </LookAndFeel>
                <ButtonBarStyle BorderColor="#6787B8" BorderStyle="Solid" BorderWidth="1px">
                </ButtonBarStyle>
                <HeaderDraggedStyle BorderColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
                    <Filters>
                        <dxwdc:LookAndFeelStyleAlphaFilter FinishOpacity="50" FinishX="50">
                        </dxwdc:LookAndFeelStyleAlphaFilter>
                    </Filters>
                </HeaderDraggedStyle>
                <StatusBarStyle BackColor="#DDECFE" BorderStyle="None">
                    <Filters>
                        <dxwdc:LookAndFeelStyleGradientFilter EndColor="132, 171, 227" StartColor="221, 236, 254">
                        </dxwdc:LookAndFeelStyleGradientFilter>
                    </Filters>
                </StatusBarStyle>
                <FooterItemStyle BackColor="#B0CBF1">
                </FooterItemStyle>
                <BarBtnStyle BorderStyle="None">
                    <PressedStyle BorderStyle="Solid">
                    </PressedStyle>
                    <HotTrackStyle BorderStyle="Solid">
                    </HotTrackStyle>
                </BarBtnStyle>
                <PreviewStyle BackColor="#F9FCFF" ForeColor="#5881B9">
                </PreviewStyle>
                <SearchItemStyle BackColor="#C1D8F7">
                </SearchItemStyle>
                <BehaviorOptions AllowAppend="False" AllowDelete="False" AllowEdit="False" AllowInsert="False"
                    AutoEdit="False" />
                <GroupIndentStyle BackColor="#C1D8F7">
                </GroupIndentStyle>
                <GroupPanelStyle BackColor="#3E6DB9" Font-Bold="True" ForeColor="#DDECFE">
                </GroupPanelStyle>
                <AlternatingItemStyle BackColor="#E7F2FE" />
            </dxwg:ASPxGrid>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TMSConnection %>"
                SelectCommand="GetDistrictLog" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
