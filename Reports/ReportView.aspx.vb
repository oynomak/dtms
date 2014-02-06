Imports System.IO
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared

Partial Class Reports_ReportView
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Dim report As String = Request.QueryString("report")

            Dim path As String = CrystalReportSource1.AppRelativeTemplateSourceDirectory
            Dim reppath As String = Server.MapPath(path)
            Dim reportpath As String = reppath & "\" & report & ".rpt"

            CrystalReportSource1.ReportDocument.Load(reportpath)

            '//Pass any parameters to the report
            Dim district As String
            If Session("level") = "district" Then
                district = Session("levelname") & " DISTRICT"
            Else
                district = Session("levelname")
            End If

            Dim rep As CrystalDecisions.CrystalReports.Engine.ReportDocument = CrystalReportSource1.ReportDocument

            If CrystalReportSource1.ReportDocument.ParameterFields.Count > 0 Then
                If rep.ParameterFields("@district") IsNot Nothing Then
                    CrystalReportSource1.ReportDocument.SetParameterValue("@district", district)
                End If

                If rep.ParameterFields("@startdate") IsNot Nothing Then
                    Dim startdate As Date = Server.HtmlDecode(Request.QueryString("startdate"))
                    SetParameter(CrystalReportSource1.ReportDocument, "@startdate", startdate)
                    'CrystalReportSource1.ReportDocument.SetParameterValue("@startdate", startdate)
                End If

                If rep.ParameterFields("@enddate") IsNot Nothing Then
                    Dim enddate As Date = Server.HtmlDecode(Request.QueryString("enddate"))
                    SetParameter(CrystalReportSource1.ReportDocument, "@enddate", enddate)
                    'CrystalReportSource1.ReportDocument.SetParameterValue("@enddate", enddate)
                End If

                If rep.ParameterFields("@SectorID") IsNot Nothing Then
                    If Request.QueryString("sectid") IsNot Nothing Then
                        Dim sectid As Integer = Server.HtmlDecode(Request.QueryString("sectid"))
                        SetParameter(CrystalReportSource1.ReportDocument, "@sectorid", sectid)
                        'CrystalReportSource1.ReportDocument.SetParameterValue("@SectorID", sectid)
                    ElseIf Request.QueryString("SectorID") IsNot Nothing Then
                        Dim sectorid As Integer = Server.HtmlDecode(Request.QueryString("SectorID"))
                        SetParameter(CrystalReportSource1.ReportDocument, "@sectorid", sectorid)
                        'CrystalReportSource1.ReportDocument.SetParameterValue("@SectorID", sectorid)
                    End If
                End If

                If rep.ParameterFields("@TaxType") IsNot Nothing Then
                    Dim TaxType As Integer = Server.HtmlDecode(Request.QueryString("taxtype"))
                    SetParameter(CrystalReportSource1.ReportDocument, "@taxtype", TaxType)
                    'CrystalReportSource1.ReportDocument.SetParameterValue("@TaxType", TaxType)
                End If

                If rep.ParameterFields("@TaxTypeID") IsNot Nothing Then
                    Dim TaxTypeID As Integer = Server.HtmlDecode(Request.QueryString("taxtypeID"))
                    SetParameter(CrystalReportSource1.ReportDocument, "@taxtypeid", TaxTypeID)
                    'CrystalReportSource1.ReportDocument.SetParameterValue("@TaxTypeID", TaxTypeID)
                End If

                If rep.ParameterFields("@DistrictID") IsNot Nothing Then
                    Dim DistrictID As Integer = Server.HtmlDecode(Request.QueryString("DistrictID"))
                    SetParameter(CrystalReportSource1.ReportDocument, "@districtid", DistrictID)
                    'CrystalReportSource1.ReportDocument.SetParameterValue("@DistrictID", DistrictID)
                End If


                'CrystalReportSource1.ReportDocument.SetParameterValue("@sector", sector)
                'CrystalReportSource1.ReportDocument.SetParameterValue("@cell", cell)

            End If

            'CrystalReportViewer1.RefreshReport()

            LogonToReport(CrystalReportSource1.ReportDocument)

            '//Export to PDF
            Dim oStream As MemoryStream

            oStream = CrystalReportSource1.ReportDocument.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat)
            Response.Clear()
            Response.Buffer = True
            Response.ContentType = "application/pdf"
            Response.BinaryWrite(oStream.ToArray())

        Catch nex As NullReferenceException
            Response.Write(nex.InnerException.ToString)
        Catch ex As Exception
            Response.Write(ex.InnerException.ToString)
        End Try

        Response.End()
    End Sub

    Private Sub SetParameter(ByRef report As CrystalDecisions.CrystalReports.Engine.ReportDocument, ByVal ParameterName As String, ByVal ParameterValue As String)
        Dim crParameterDiscreteValue As ParameterDiscreteValue
        Dim crParameterFieldDefinitions As ParameterFieldDefinitions
        Dim crParameterFieldLocation As ParameterFieldDefinition
        Dim crParameterValues As ParameterValues

        ' Get the report parameters collection. 
        crParameterFieldDefinitions = report.DataDefinition.ParameterFields

        crParameterFieldLocation = crParameterFieldDefinitions.Item(ParameterName)
        crParameterValues = crParameterFieldLocation.CurrentValues
        crParameterDiscreteValue = New CrystalDecisions.Shared.ParameterDiscreteValue
        crParameterDiscreteValue.Value = ParameterValue
        crParameterValues.Add(crParameterDiscreteValue)
        crParameterFieldLocation.ApplyCurrentValues(crParameterValues)

    End Sub

    Private Sub LogonToReport(ByVal oRpt As ReportDocument)

        Dim Server As String, Database As String

        '//Assume we are using a trusted connection
        Dim connectionstring As String
        connectionstring = Session("connection")

        Server = connectionstring.Split(";").GetValue(3)
        Server = Server.Split("=").GetValue(1)
        Database = connectionstring.Split(";").GetValue(2)
        Database = Database.Split("=").GetValue(1)
        

        Dim logonInfo As New TableLogOnInfo
        Dim table As Table

        ' Set the logon information for each table.
        For Each table In oRpt.Database.Tables
            ' Get the TableLogOnInfo object.
            logonInfo = table.LogOnInfo
            ' Set the server , database name, 

            logonInfo.ConnectionInfo.ServerName = Server
            logonInfo.ConnectionInfo.DatabaseName = Database

            ' Apply the connection information to the table.
            table.ApplyLogOnInfo(logonInfo)
        Next table

    End Sub

End Class
