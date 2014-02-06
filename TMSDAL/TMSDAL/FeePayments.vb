Imports System.Data.SqlClient

Public Class FeePayments

    Implements ICollection

    Implements IEnumerable

    Private mCol As Collection

    Public Sub Load(ByVal connection As String)

        Try

            Dim cn As SqlConnection = New SqlConnection(Connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetFeePayments"

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oFeePayment As FeePayment

            Do While dr.Read

                oFeePayment = New FeePayment

                With oFeePayment

                    .PaymentID = CLng(dr.GetValue(0))

                    .TaxPayerID = CInt(dr.GetValue(1))

                    .Designation = CStr(dr.GetValue(2))

                    .PaymentDate = CDate(dr.GetValue(3))

                    .Amount = CDec(dr.GetValue(4))

                End With

                Add(oFeePayment)

            Loop

            dr.Close()

            cn.Close()

            cn = Nothing

        Catch ex As Exception

            '//MsgBox(ex.Message & vbCrLf & "Procedure - FeePayments" & System.Reflection.MethodBase.GetCurrentMethod.Name.ToString(), '//MsgBoxStyle.Critical, System.Reflection.MethodBase.GetCurrentMethod.Name.ToString())

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

    Public Sub Add(ByVal FeePayment As FeePayment)

        If Not FeePayment Is Nothing Then

            mCol.Add(FeePayment)

        End If

    End Sub

    Public Sub Remove(ByVal FeePaymentId As Integer, ByVal connection As String)

        Dim oFeePayment As FeePayment

        Dim i As Integer

        For Each oFeePayment In Me

            i += 1

            If oFeePayment.PaymentID = FeePaymentId Then

                oFeePayment.Delete(connection)

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

    Default Public Overloads ReadOnly Property Item(ByVal index As Integer) As FeePayment

        Get

            Dim p_FeePayment As FeePayment = Nothing

            For Each p_FeePayment In Me

                If p_FeePayment.PaymentID = index Then

                    Exit For

                End If

            Next
            Return p_FeePayment
        End Get

    End Property

   

End Class
