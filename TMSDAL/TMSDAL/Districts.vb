Imports System.Data.SqlClient

Public Class Districts

    Implements ICollection

    Implements IEnumerable

    Private mCol As Collection

    Public Sub Load(ByVal connection As String, ByVal provinceID As Byte)

        Try

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetDistricts"
            cmd.Parameters.AddWithValue("@ProvinceID", provinceID)
            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oDistrict As District

            Do While dr.Read

                oDistrict = New District

                With oDistrict

                    .DistrictID = CShort(dr.GetValue(0))
                    .ProvinceID = CByte(dr.GetValue(1))
                    .DistrictName = CStr(dr.GetValue(2))
                    .NumberOfSectors = CInt(dr("NumberOfSectors"))
                End With

                Add(oDistrict)

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

            cmd.CommandText = "GetDistricts"

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oDistrict As District

            Do While dr.Read

                oDistrict = New District

                With oDistrict

                    .DistrictID = CShort(dr.GetValue(0))

                    .ProvinceID = CByte(dr.GetValue(1))

                    .DistrictName = CStr(dr.GetValue(2))

                End With

                Add(oDistrict)

            Loop

            dr.Close()

            cn.Close()

            cn = Nothing

        Catch ex As Exception

            '//MsgBox(ex.Message & vbCrLf & "Procedure - Districts" & System.Reflection.MethodBase.GetCurrentMethod.Name.ToString(), '//MsgBoxStyle.Critical, System.Reflection.MethodBase.GetCurrentMethod.Name.ToString())

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

    Public Sub Add(ByVal District As District)

        If Not District Is Nothing Then

            mCol.Add(District)

        End If

    End Sub

    Public Sub Remove(ByVal DistrictId As Integer, ByVal connection As String)

        Dim oDistrict As District

        Dim i As Integer

        For Each oDistrict In Me

            i += 1

            If oDistrict.DistrictID = DistrictID Then

                oDistrict.Delete(Connection)

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

    Default Public Overloads ReadOnly Property Item(ByVal index As Integer) As District

        Get

            Dim p_District As District = Nothing

            For Each p_District In Me

                If p_District.DistrictID = index Then

                    Exit For

                End If

            Next
            Return p_District
        End Get

    End Property

    Default Public Overloads ReadOnly Property Item(ByVal name As String) As District

        Get

            Dim p_District As District = Nothing

            For Each p_District In Me

                If p_District.DistrictName = name Then

                    Exit For

                End If

            Next
            Return p_District
        End Get

    End Property

End Class