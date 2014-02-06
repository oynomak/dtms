Imports System.Data.SqlClient

Public Class TaxTypes

    Implements ICollection

    Implements IEnumerable

    Private mCol As Collection

    Public Sub Load(ByVal connection As String)

        Try

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetTaxTypes"

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oTaxType As TaxType

            Do While dr.Read

                oTaxType = New TaxType

                With oTaxType

                    .TaxTypeID = CByte(dr.GetValue(0))

                    .TaxTypeName = CStr(dr.GetValue(1))

                End With

                Add(oTaxType)

            Loop

            dr.Close()

            cn.Close()

            cn = Nothing

        Catch ex As Exception

            MsgBox(ex.Message & vbCrLf & "Procedure - TaxTypes" & System.Reflection.MethodBase.GetCurrentMethod.Name.ToString(), MsgBoxStyle.Critical, System.Reflection.MethodBase.GetCurrentMethod.Name.ToString())

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

    Public Sub Add(ByVal TaxType As TaxType)

        If Not TaxType Is Nothing Then

            mCol.Add(TaxType)

        End If

    End Sub

    Public Sub Remove(ByVal TaxTypeId As Integer, ByVal connection As String)

        Dim oTaxType As TaxType

        Dim i As Integer

        For Each oTaxType In Me

            i += 1

            If oTaxType.TaxTypeID = TaxTypeId Then

                oTaxType.Delete(connection)

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

    Default Public Overloads ReadOnly Property Item(ByVal index As Integer) As TaxType

        Get

            Dim p_TaxType As TaxType = Nothing

            For Each p_TaxType In Me

                If p_TaxType.TaxTypeID = index Then

                    Exit For
                End If

            Next

            Return p_TaxType

        End Get

    End Property

    Default Public Overloads ReadOnly Property Item(ByVal name As String) As TaxType

        Get

            Dim p_TaxType As TaxType = Nothing

            For Each p_TaxType In Me

                If p_TaxType.TaxTypeName = name Then

                    Exit For
                End If

            Next

            Return p_TaxType

        End Get

    End Property

End Class
