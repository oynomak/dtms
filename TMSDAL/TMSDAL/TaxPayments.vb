
Imports System.Data.SqlClient

Public Class TaxPayments

    Implements ICollection

    Implements IEnumerable

    Private mCol As Collection
    Private m_total As Decimal

    Public ReadOnly Property TotalTax() As Decimal
        Get
            Return m_total
        End Get
    End Property


    Public Sub LoadTotal(ByVal connection As String)

        Try

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetTotalTaxPayments"

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Do While dr.Read
                m_total = CDec(dr("Total"))
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
                    .TaxPayerName = CStr(dr("TaxPayerName"))
                    .Cashier = CStr(dr("Cashier"))
                    .TaxTypeID = CByte(dr("TaxTypeID"))
                    .TaxType = CStr(dr("TaxType"))
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

    Default Public Overloads ReadOnly Property Item(ByVal index As Integer) As TaxPayment

        Get

            Dim p_TaxPayment As TaxPayment = Nothing

            For Each p_TaxPayment In Me

                If p_TaxPayment.PaymentID = index Then

                    Exit For

                End If

            Next
            Return p_TaxPayment
        End Get

    End Property

    

End Class
