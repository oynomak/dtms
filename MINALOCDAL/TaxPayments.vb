
Imports System.Data.SqlClient

Public Class TaxPayments

    Implements ICollection

    Implements IEnumerable

    Private mCol As Collection

    Private m_deleted As Integer
    Private m_inserted As Integer
    Private m_updated As Integer

    Public ReadOnly Property Deleted() As Integer
        Get
            Return m_deleted
        End Get
    End Property

    Public ReadOnly Property Updated() As Integer
        Get
            Return m_updated
        End Get
    End Property

    Public ReadOnly Property Inserted() As Integer
        Get
            Return m_inserted
        End Get
    End Property

    Public Sub UpdateLocalServer(ByVal connection As String)
        Try
            '//Insert,update,delete the tax payments to the MINALOC server
            For Each payer As TaxPayment In Me
                If payer.Action = "I" Then
                    payer.Save(connection, True)
                    m_inserted += 1
                ElseIf payer.Action = "U" Then
                    payer.Save(connection, False)
                    m_updated += 1
                ElseIf payer.Action = "D" Then
                    payer.Delete(connection)
                    m_deleted += 1
                End If
            Next
        Catch ex As Exception
            Throw
        End Try
    End Sub

    Public Sub LoadFromDistrict(ByVal connection As String, ByVal lastupdate As Date)

        Try

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetNewTaxPayments"
            cmd.Parameters.AddWithValue("@lastdate", lastupdate)

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oTaxPayment As TaxPayment

            Do While dr.Read

                oTaxPayment = New TaxPayment

                With oTaxPayment

                    .PaymentID = CLng(dr.GetValue(0))

                    .TaxPayerID = CInt(dr.GetValue(1))

                    .PaymentDate = CDate(dr.GetValue(2))

                    .Amount = CDec(dr.GetValue(3))

                    .Description = CStr(dr.GetValue(4))

                    .Cashier = CStr(dr.GetValue(5))

                    .TaxTypeID = CByte(dr.GetValue(6))

                    .CellID = CShort(dr.GetValue(7))
                    .Action = CStr(dr("Action"))

                End With

                Add(oTaxPayment)

            Loop

            dr.Close()

            cn.Close()

            cn = Nothing

        Catch ex As Exception

            Throw

        End Try

    End Sub

    Public Sub Load(ByVal connection As String)

        Try

            Dim cn As SqlConnection = New SqlConnection(Connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetTaxPayments"

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oTaxPayment As TaxPayment

            Do While dr.Read

                oTaxPayment = New TaxPayment

                With oTaxPayment

                    .PaymentID = CLng(dr.GetValue(0))

                    .TaxPayerID = CInt(dr.GetValue(1))

                    .PaymentDate = CDate(dr.GetValue(2))

                    .Amount = CDec(dr.GetValue(3))

                    .Description = CStr(dr.GetValue(4))

                    .Cashier = CStr(dr.GetValue(5))

                    .TaxTypeID = CByte(dr.GetValue(6))

                    .CellID = CShort(dr.GetValue(7))

                End With

                Add(oTaxPayment)

            Loop

            dr.Close()

            cn.Close()

            cn = Nothing

        Catch ex As Exception

            Throw

        End Try

    End Sub

    Public Sub CopyTo(ByVal array As System.Array, ByVal index As Integer) Implements System.Collections.ICollection.CopyTo

        CopyTo(array, index)

    End Sub

    Public ReadOnly Property Count() As Integer Implements System.Collections.ICollection.Count

        Get

            Return mCol.Count

        End Get

    End Property

    Public Function GetEnumerator() As System.Collections.IEnumerator Implements System.Collections.IEnumerable.GetEnumerator

        Return mCol.GetEnumerator

    End Function

    Public ReadOnly Property IsSynchronized() As Boolean Implements System.Collections.ICollection.IsSynchronized

        Get

            Return True

        End Get

    End Property

    Public ReadOnly Property SyncRoot() As Object Implements System.Collections.ICollection.SyncRoot

        Get

            Return mCol

        End Get

    End Property

    Public Sub Add(ByVal TaxPayment As TaxPayment)

        If Not TaxPayment Is Nothing Then

            mCol.Add(TaxPayment)

        End If

    End Sub

    Public Sub Remove(ByVal TaxPaymentId As Integer, ByVal connection As String)

        Dim oTaxPayment As TaxPayment

        Dim i As Integer

        For Each oTaxPayment In Me

            i += 1

            If oTaxPayment.PaymentID = TaxPaymentId Then

                oTaxPayment.Delete(connection)

                mCol.Remove(i)

                Exit For

            End If

        Next

    End Sub

    Public Sub New()

        mCol = New Collection

    End Sub

    Protected Overrides Sub Finalize()

        MyBase.Finalize()
    End Sub
End Class