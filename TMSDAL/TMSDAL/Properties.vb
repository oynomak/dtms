Imports System.Data.SqlClient

Public Class Properties

    Implements ICollection

    Implements IEnumerable

    Private mCol As Collection

    Public Sub Load(ByVal connection As String, ByVal taxPayerID As Integer)

        Try

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetPropertiesByTaxPayerID"
            cmd.Parameters.AddWithValue("@TaxPayerID", taxPayerID)

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oProperyt As [Property]

            Do While dr.Read

                oProperyt = New [Property]

                With oProperyt

                    .PropertyID = CInt(dr.GetValue(0))

                    .PlotNumber = CStr(dr.GetValue(1))

                    .OwnersName = CStr(dr.GetValue(2))

                    .Usage = CStr(dr.GetValue(3))

                    .DateOfAcquisition = CDate(dr.GetValue(4))

                    .OwnerValuation = CDec(dr.GetValue(5))

                    .DistrictValuation = CDec(dr.GetValue(6))
                    .Amount = CDec(dr("Amount"))

                End With

                Add(oProperyt)

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

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetProperties"

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oProperyt As [Property]

            Do While dr.Read

                oProperyt = New [Property]

                With oProperyt

                    .PropertyID = CInt(dr.GetValue(0))

                    .PlotNumber = CStr(dr.GetValue(1))

                    .OwnersName = CStr(dr.GetValue(2))

                    .Usage = CStr(dr.GetValue(3))

                    .DateOfAcquisition = CDate(dr.GetValue(4))

                    .OwnerValuation = CDec(dr.GetValue(5))

                    .DistrictValuation = CDec(dr.GetValue(6))
                    .Amount = CDec(dr("Amount"))
                End With

                Add(oProperyt)

            Loop

            dr.Close()

            cn.Close()

            cn = Nothing

        Catch ex As Exception

            '//MsgBox(ex.Message & vbCrLf & "Procedure - Properties" & System.Reflection.MethodBase.GetCurrentMethod.Name.ToString(), '//MsgBoxStyle.Critical, System.Reflection.MethodBase.GetCurrentMethod.Name.ToString())

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

    Public Sub Add(ByVal Properyt As [Property])

        If Not Properyt Is Nothing Then

            mCol.Add(Properyt)

        End If

    End Sub

    Public Sub Remove(ByVal ProperytId As Integer, ByVal connection As String)

        Dim oProperyt As [Property]

        Dim i As Integer

        For Each oProperyt In Me

            i += 1

            If oProperyt.PropertyID = ProperytId Then

                oProperyt.Delete(connection)

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

    Default Public Overloads ReadOnly Property Item(ByVal index As Integer) As [Property]

        Get

            Dim p_Properyt As [Property] = Nothing

            For Each p_Properyt In Me

                If p_Properyt.PropertyID = index Then

                    Exit For

                End If

            Next
            Return p_Properyt
        End Get

    End Property

    Default Public Overloads ReadOnly Property Item(ByVal name As String) As [Property]

        Get

            Dim p_Properyt As [Property] = Nothing

            For Each p_Properyt In Me

                If p_Properyt.OwnersName = name Then

                    Exit For

                End If

            Next
            Return p_Properyt
        End Get

    End Property

End Class

