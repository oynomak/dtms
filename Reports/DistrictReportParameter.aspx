<%@ Page Language="C#" MasterPageFile="~/mainmaster.master" AutoEventWireup="true"
    CodeFile="DistrictReportParameter.aspx.cs" Inherits="Reports_DistrictReportParameter"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="centerbox">
        <div class="headerlabel">
            <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/images/reports.jpg" />
            <asp:Label ID="lblHeader" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="simplebordered">
            <table>
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
                    <td colspan="4">
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
