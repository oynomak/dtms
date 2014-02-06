<%@ Page Language="VB" MasterPageFile="~/mainmaster.master" AutoEventWireup="false" CodeFile="TaxPayments.aspx.vb" Inherits="TaxPayments" title="Untitled Page" %>

<%@ Register Assembly="DevExpress.Web.ASPxDataControls.v6.2, Version=6.2.4.0, Culture=neutral, PublicKeyToken=79868b8147b5eae4"
    Namespace="DevExpress.Web.ASPxDataControls" TagPrefix="dxwdc" %>

<%@ Register Assembly="DevExpress.Web.ASPxGrid.v6.2, Version=6.2.4.0, Culture=neutral, PublicKeyToken=79868b8147b5eae4"
    Namespace="DevExpress.Web.ASPxGrid" TagPrefix="dxwg" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="centerbox">
        <div class="headerlabel">
            <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/tax.jpg" />
            <asp:Label ID="lblHeader" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="printerlabel" >
        <asp:Hyperlink ID="HLAddPayment" runat ="server" NavigateUrl="~/TaxPayment.aspx" ></asp:Hyperlink>
        </div>
        <div class="simplebordered">
            <dxwg:ASPxGrid ID="ASPxGrid1" runat="server" AutoGenerateColumns="False" BorderColor="#6787B8" BorderStyle="Solid" DataKeyField="PaymentID" DataSourceID="SqlDataSource1" ExpandBtnHeight="11px" ExpandBtnWidth="11px" HeaderHeight="25px" ReadOnly="True" RowBtnWidth="18px" SearchBtnWidth="17px" SelectedBackColor="49, 106, 197" StatusBarItemSpacing="0" TabIndex="0">
                <ExpandBtnStyle BackColor="#F9F9F9" BorderColor="#6787B8" BorderStyle="Solid" BorderWidth="1px">
                    <PressedStyle BackColor="#D0D0D0" BorderColor="Navy" ForeColor="Black">
                    </PressedStyle>
                    <HotTrackStyle BackColor="White" BorderColor="Navy">
                    </HotTrackStyle>
                </ExpandBtnStyle>
                <RowBtnStyle BorderStyle="None">
                </RowBtnStyle>
                <FooterStyle BackColor="#B0CBF1" FixedHeight="True" FixedWidth="True" Font-Bold="True"
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
                <GroupItemStyle BackColor="#C1D8F7" BorderColor="#6787B8" Wrap="False" FixedWidth="True">
                </GroupItemStyle>
                <HeaderStyle BorderStyle="None" FixedHeight="True" FixedWidth="True" Font-Bold="True"
                    Wrap="False" />
                <NavigatorButtons Cancel="False" DeleteRow="False" EditRow="False" InsertRow="False"
                    Ok="False" />
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
                <AppearanceOptions ShowSearchItem="True" />
                <TitleStyle BackColor="#6787B8" ForeColor="White" />
                <LookAndFeel Kind="Office2003">
                    <ElementsSettings DropDownButtonWidth="17px" ScrollBarBackColor="247, 245, 241" ScrollBarMargin="1"
                        ScrollBarSize="17px" />
                    <PopupStyle BorderColor="#6787B8" Font-Names="Verdana" Font-Size="8pt">
                    </PopupStyle>
                    <ButtonStyle BackColor="#84ABE3" BorderColor="#6787B8" Font-Names="Verdana" Font-Size="8pt"
                        ForeColor="Black" Margin="1" UseHotTrackStyle="True" UsePressedStyle="True" Wrap="False">
                        <Filters>
                            <dxwdc:LookAndFeelStyleGradientFilter EndColor="132, 171, 227" StartColor="221, 236, 254">
                            </dxwdc:LookAndFeelStyleGradientFilter>
                        </Filters>
                        <PressedStyle BackColor="#FFCA86" BorderColor="Navy" ForeColor="Black">
                            <Filters>
                                <dxwdc:LookAndFeelStyleGradientFilter EndColor="255, 202, 134" StartColor="254, 148, 80">
                                </dxwdc:LookAndFeelStyleGradientFilter>
                            </Filters>
                        </PressedStyle>
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
                <BehaviorOptions AllowAppend="False" AllowDelete="False" AllowInsert="False" EnableGrouping="False"
                    InitializeFocusedRow="False" />
                <GroupIndentStyle BackColor="#C1D8F7">
                </GroupIndentStyle>
                <SearchBtnStyle FixedWidth="True">
                </SearchBtnStyle>
                <Columns>
                    <dxwg:BoundColumn DataField="PaymentDate" HeaderText="Date" VisibleIndex="0">
                    </dxwg:BoundColumn>
                    <dxwg:BoundColumn DataField="TaxPayerName" HeaderText="Taxpayer" VisibleIndex="1">
                    </dxwg:BoundColumn>
                    <dxwg:BoundColumn DataField="Amount" HeaderText="Amount" VisibleIndex="2" EnableSearch="False">
                    </dxwg:BoundColumn>
                    <dxwg:BoundColumn DataField="Description" HeaderText="Description" VisibleIndex="3" EnableSearch="False">
                    </dxwg:BoundColumn>
                    <dxwg:BoundColumn DataField="TaxType" HeaderText="Tax Type" VisibleIndex="4" EnableSearch="False">
                    </dxwg:BoundColumn>
                    <dxwg:BoundColumn DataField="Cashier" HeaderText="Cashier" VisibleIndex="5" EnableSearch="False">
                    </dxwg:BoundColumn>
                    <dxwg:TemplateColumn VisibleIndex="6" Width="40px">
                        <ItemTemplate>
                            <asp:HyperLink ID="HLEdit" Text="Edit" NavigateUrl='~/taxpayment.aspx' runat="server"></asp:HyperLink>
                        </ItemTemplate>
                        <ClientSideEvents>
                            <BindCell>
                                function(source,e) {
                                 var HLEdit = ASPxClientUtils.GetChildByTagName(e.htmlElement,"A", 0); 
                                 var Value =  e.row.GetDataControllerRow().GetValueByFieldName("paymentid");
                                 HLEdit.innerHTML ="Edit"; 
                                 HLEdit.href="taxpayment.aspx?id=" + Value;
                                 }</BindCell>
                        </ClientSideEvents>
                    </dxwg:TemplateColumn>
                    <dxwg:TemplateColumn VisibleIndex="7" Width="40px">
                        <ItemTemplate>
                            <asp:HyperLink ID="HLDelete" Text="Delete" NavigateUrl='~/taxpayment.aspx' runat="server"></asp:HyperLink>
                        </ItemTemplate>
                        <ClientSideEvents>
                            <BindCell>
                                function(source,e) {
                                 var HLEdit = ASPxClientUtils.GetChildByTagName(e.htmlElement,"A", 0); 
                                 var Value =  e.row.GetDataControllerRow().GetValueByFieldName("paymentid");
                                 HLEdit.innerHTML ="Delete"; 
                                 HLEdit.href="taxpayment.aspx?id=" + Value + "&action=delete";
                                 }</BindCell>
                        </ClientSideEvents>
                    </dxwg:TemplateColumn>
                    
                </Columns>
                <GroupPanelStyle BackColor="#3E6DB9" Font-Bold="True" ForeColor="#DDECFE">
                </GroupPanelStyle>
                <ItemStyle BackColor="White" FixedWidth="True" Font-Size="7.5pt" VerticalAlign="Middle"
                    Wrap="False" />
                <AlternatingItemStyle BackColor="#E7F2FE" />
            </dxwg:ASPxGrid> 
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TMSConnection %>"
                SelectCommand="GetTaxPayments" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        </div>
    </div>
</asp:Content>

