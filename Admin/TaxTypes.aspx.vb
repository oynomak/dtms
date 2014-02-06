
Partial Class Admin_TaxTypes
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        '//Check to see whether we are adding,editing or deleting a TaxType
        Dim action As String = Request.QueryString("action")

        If action Is Nothing Then '//Adding here
            LblAddTaxType.Text = "Add Tax Type"
            BtnAddTaxType.Text = "Add Tax Type"
            HFTaxTypeID.Value = Convert.ToString(0)
        Else

            Dim currentTaxType As TMSDAL.TaxType = New TMSDAL.TaxType
            Dim ProvID As Byte = Request.QueryString("id")
            currentTaxType.Load(Session("connection"), ProvID)

            If action = "edit" Then '//editing here
                If IsPostBack = False Then
                    LblAddTaxType.Text = "Change Tax Type Name"
                    BtnAddTaxType.Text = "Change Tax Type Name"
                    txtTaxTypeName.Text = currentTaxType.TaxTypeName
                    HFTaxTypeID.Value = Convert.ToString(currentTaxType.TaxTypeID)
                End If
            End If
            If (action = "remove") Then '//removing here
                currentTaxType.Delete(Session("connection"))
                Response.Redirect("taxtypes.aspx")
            End If

        End If

        LblTaxTypes.Text = "Tax Types"
        '//Show the existing TaxTypes
        ShowTaxTypes()

    End Sub

    Protected Sub BtnAddTaxType_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnAddTaxType.Click
        Dim taxtype As TMSDAL.TaxType = New TMSDAL.TaxType
        taxtype.TaxTypeName = txtTaxTypeName.Text
        taxtype.TaxTypeID = CByte(HFTaxTypeID.Value)
        taxtype.Save(Session("connection"))

        Response.Redirect("taxtypes.aspx")

    End Sub

    Private Sub AddCell(ByVal text As String, ByVal row As TableRow)
        Dim tc As TableCell = New TableCell
        tc.Text = text
        row.Cells.Add(tc)
    End Sub

    Private Sub ShowTaxTypes()

        '//Load the TaxTypes from the database
        Dim TaxTypes As TMSDAL.TaxTypes = New TMSDAL.TaxTypes
        TaxTypes.Load(Session("connection"))

        TblTaxTypes.Width = New Unit("100%")

        Dim tr As TableRow

        '//Header
        tr = New TableRow
        AddCell("Tax Type", tr)
        AddCell("", tr)
        AddCell("", tr)


        tr.CssClass = "tableheader"
        TblTaxTypes.Rows.Add(tr)

        '//Data

        For Each tt As TMSDAL.TaxType In TaxTypes
            tr = New TableRow()
            AddCell(tt.TaxTypeName, tr)
            AddCell("<A href='TaxTypes.aspx?id=" & tt.TaxTypeID.ToString & "&action=edit'>Edit</A>", tr)
            AddCell("<A href='TaxTypes.aspx?id=" & tt.TaxTypeID.ToString & "&action=remove'>Remove</A>", tr)
            TblTaxTypes.Rows.Add(tr)
        Next

    End Sub

End Class
