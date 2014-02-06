<%@ Page Language="VB" MasterPageFile="~/Reports/reportmaster.master" AutoEventWireup="false" CodeFile="ReportView.aspx.vb" Inherits="Reports_ReportView" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=10.2.3600.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ContentPlaceHolderID ="ContentPlaceHolder1" runat ="server">

    <div>
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="True"
            EnableDatabaseLogonPrompt="True" EnableParameterPrompt="False" Height="50px"
            ReportSourceID="CrystalReportSource1" Width="350px" DisplayGroupTree="False" EnableDrillDown="False" HasCrystalLogo="False" HasExportButton="False" HasGotoPageButton="False" HasSearchButton="False" HasToggleGroupTreeButton="False" HasZoomFactorList="False" HyperlinkTarget="_blank" PrintMode="ActiveX" SeparatePages="False" />
        <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
            <Report FileName="Reports\TaxpayerRegistry.rpt">
            </Report>
        </CR:CrystalReportSource>
    
    </div>
    </asp:Content>