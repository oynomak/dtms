Imports System.Data.SqlClient

Public Class Provinces

    Implements ICollection

    Implements IEnumerable

    Private mCol As Collection

    Public Sub Load(ByVal connection As String)

        Try

            Dim cn As SqlConnection = New SqlConnection(Connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetProvinces"

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oProvince As Province

            Do While dr.Read

                oProvince = New Province

                With oProvince
                    .ProvinceID = CByte(dr.GetValue(0))
                    .ProvinceName = CStr(dr.GetValue(1))
                    .NumberOfDistricts = CShort(dr("NumberOfDistricts"))
                End With

                Add(oProvince)

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

    Public Sub Add(ByVal Province As Province)

        If Not Province Is Nothing Then

            mCol.Add(Province)

        End If

    End Sub

    Public Sub Remove(ByVal ProvinceId As Integer, ByVal connection As String)

        Dim oProvince As Province

        Dim i As Integer

        For Each oProvince In Me

            i += 1

            If oProvince.ProvinceID = ProvinceID Then

                oProvince.Delete(Connection)

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

    Default Public Overloads ReadOnly Property Item(ByVal index As Integer) As Province

        Get

            Dim p_Province As Province = Nothing

            For Each p_Province In Me

                If p_Province.ProvinceID = index Then

                    Exit For

                End If

            Next
            Return p_Province
        End Get

    End Property

    Default Public Overloads ReadOnly Property Item(ByVal name As String) As Province

        Get

            Dim p_Province As Province = Nothing

            For Each p_Province In Me

                If p_Province.ProvinceName = name Then

                    Exit For

                End If

            Next
            Return p_Province
        End Get

    End Property

End Class
