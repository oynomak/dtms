<%@ Page Language="VB" MasterPageFile="~/mainmaster.master" AutoEventWireup="false"
    CodeFile="taxpayerdetails.aspx.vb" Inherits="taxpayerdetails" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="centerbox">
        <div class="headerlabel">
            <asp:Image ID="headerimage" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/taxpayer.jpg" />
            <asp:Label ID="LblTaxPayerDetails" runat="server" Font-Bold="True"></asp:Label>
        </div>
        <div class="printerlabel">
            <asp:HyperLink ID="HLEditTaxpayer" runat="server" Text="Edit Taxpayer details" NavigateUrl="~/taxpayer.aspx"></asp:HyperLink>
            &nbsp;&nbsp;&nbsp;<asp:HyperLink ID="HLDeleteTaxPayer" runat="server" Text="Delete Taxpayer" NavigateUrl="~/taxpayer.aspx"></asp:HyperLink>
        </div>
        <div class="simplebordered">
            <table>
                <tr>
                    <td width="100" style="height: 23px" nowrap="noWrap">
                        <asp:Label ID="LblNames" runat="server" Text="Name" Width="66px" Font-Bold="True"></asp:Label>
                    </td>
                    <td style="width: 335px; height: 23px;" colspan="3">
                        <asp:Label ID="LblNamesData" runat="server" Width="376px"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td width="100" style="height: 23px" nowrap="noWrap">
                        <asp:Label ID="LblSector" runat="server" Text="Sector" Width="66px" Font-Bold="True"></asp:Label>
                    </td>
                    <td style="width: 184px; height: 23px;">
                        <asp:Label ID="LblSectorData" runat="server" Width="66px"></asp:Label>
                    </td>
                    <td style="width: 52px; height: 23px;">
                        <asp:Label ID="lblCellID" runat="server" Text="Cell" Width="64px" Font-Bold="True"></asp:Label>
                    </td>
                    <td style="width: 335px; height: 23px;">
                        <asp:Label ID="LblCellData" runat="server" Text="Cell" Width="66px"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="height: 24px" nowrap="noWrap">
                        <asp:Label ID="lblFileNumber" runat="server" Text="File number" Width="73px" Font-Bold="True"></asp:Label>
                    </td>
                    <td style="width: 335px; height: 24px;" colspan="3">
                        <asp:Label ID="LblFileNumberData" runat="server" Width="216px"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="height: 26px" nowrap="noWrap">
                        <asp:Label ID="lblAddress" runat="server" Text="Address" Font-Bold="True"></asp:Label>
                    </td>
                    <td style="width: 335px; height: 26px;" colspan="3">
                        <asp:Label ID="LblAddressData" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="height: 25px" nowrap="noWrap">
                        <asp:Label ID="lblTelephone" runat="server" Text="Telephone" Font-Bold="True"></asp:Label>
                    </td>
                    <td style="width: 184px; height: 25px;">
                        <asp:Label ID="lblTelephoneData" runat="server"></asp:Label>
                    </td>
                    <td style="width: 52px; height: 25px;">
                        <asp:Label ID="lblMobile" runat="server" Text="Mobile" Font-Bold="True"></asp:Label></td>
                    <td style="width: 335px; height: 25px;">
                        <asp:Label ID="lblMobileData" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td style="height: 27px" nowrap="noWrap">
                        <asp:Label ID="lblProffession" runat="server" Text="Profession" Font-Bold="True"></asp:Label>
                    </td>
                    <td style="width: 335px; height: 27px;" colspan="3">
                        <asp:Label ID="lblProffessionData" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="height: 23px" nowrap="noWrap">
                        <asp:Label ID="lblDOB" runat="server" Text="Date of birth" Width="120px" Font-Bold="True"></asp:Label>
                    </td>
                    <td style="width: 335px; height: 23px;" colspan="3">
                        <asp:Label ID="lblDOBData" runat="server" Text="Date of birth" Width="384px"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="height: 27px" nowrap="noWrap">
                        <asp:Label ID="lblIDNumber" runat="server" Text="ID number" Width="85px" Font-Bold="True"></asp:Label>
                    </td>
                    <td style="width: 184px; height: 27px;">
                        <asp:Label ID="lblIDNumberData" runat="server" Width="85px"></asp:Label>
                    </td>
                    <td style="width: 52px; height: 27px;">
                        <asp:Label ID="lblIDType" runat="server" Text="ID Type" Width="184px" Font-Bold="True"></asp:Label></td>
                    <td style="width: 335px; height: 27px;">
                        <asp:Label ID="lblIDTypeData" runat="server" Width="232px"></asp:Label>
                </tr>
                <tr>
                    <td style="height: 27px" nowrap="noWrap">
                        <asp:Label ID="lblTin" runat="server" Text="TIN" Font-Bold="True"></asp:Label>
                    </td>
                    <td style="width: 335px; height: 27px;" colspan="3">
                        <asp:Label ID="lblTinData" runat="server" Width="232px"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td nowrap="noWrap">
                        <asp:Label ID="lblEmail" runat="server" Text="Email" Font-Bold="True"></asp:Label>
                    </td>
                    <td colspan="3">
                        <asp:Label ID="lblEmailData" runat="server" Text="Email" Width="424px"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <div id="BankAccounts" runat="server">
            <div class="headerlabel">
                <asp:Image ID="Image1" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/bank.jpg" />
                <asp:Label ID="LblBanks" runat="server" Font-Bold="True"></asp:Label>
            </div>
            <div class="printerlabel">
                <asp:HyperLink ID="HLEditBanks" runat="server" Text="Edit Taxpayer Bank details" NavigateUrl="~/taxpayer.aspx"></asp:HyperLink>
            </div>
            <div class="simplebordered">
                <asp:Table ID="TblBanks" runat="server" Width="240px">
                </asp:Table>
            </div>
        </div>
        <div id="LandParcels" runat="server">
            <div class="headerlabel">
                <asp:Image ID="Image2" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/region.jpg" />
                <asp:Label ID="lblLandParcels" runat="server" Font-Bold="True"></asp:Label>
            </div>
            <div class="printerlabel">
                <asp:HyperLink ID="HLEditLandParcels" runat="server" Text="Edit Taxpayer Land Parcel details"
                    NavigateUrl="~/taxpayer.aspx"></asp:HyperLink>
            </div>
            <div class="simplebordered">
                <asp:Table ID="TblLandParcels" runat="server" Width="240px">
                </asp:Table>
            </div>
        </div>
        <div id="Businesses" runat="server">
            <div class="headerlabel">
                <asp:Image ID="Image3" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/bank.jpg" />
                <asp:Label ID="LblBusinesses" runat="server" Font-Bold="True"></asp:Label>
            </div>
            <div class="printerlabel">
                <asp:HyperLink ID="HLEditBusinesses" runat="server" Text="Edit Taxpayer Business details"
                    NavigateUrl="~/taxpayer.aspx"></asp:HyperLink>
            </div>
            <div class="simplebordered">
                <asp:Table ID="TblBusinesses" runat="server" Width="240px">
                </asp:Table>
            </div>
        </div>
        
        <div id="HouseTenants" runat="server">
            <div class="headerlabel">
                <asp:Image ID="Image4" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/bank.jpg" />
                <asp:Label ID="LblTenants" runat="server" Font-Bold="True"></asp:Label>
            </div>
            <div class="printerlabel">
                <asp:HyperLink ID="HLEditTenants" runat="server" Text="Edit Taxpayer Tenants' details" NavigateUrl="~/taxpayer.aspx"></asp:HyperLink>
            </div>
            <div class="simplebordered">
                <asp:Table ID="TblTenants" runat="server" Width="240px">
                </asp:Table>
            </div>
        </div>
        <div id="TaxPayerProperties" runat="server">
            
            <div class="headerlabel">
                <asp:Image ID="Image5" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Images/bank.jpg" />
                <asp:Label ID="LblProperties" runat="server" Font-Bold="True"></asp:Label>
            </div>
            <div class="printerlabel">
                <asp:HyperLink ID="HLEditProperties" runat="server" Text="Edit Taxpayer Property details" NavigateUrl="~/taxpayer.aspx"></asp:HyperLink>
            </div>
            <div class="simplebordered">
                <asp:Table ID="TblProperties" runat="server" Width="240px">
                </asp:Table>
            </div>
        </div>
    </div>
</asp:Content>
