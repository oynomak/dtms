
Imports System.Data.SqlClient

Public Class DistrictServers

    Implements ICollection

    Implements IEnumerable

    Private mCol As Collection

    Public Sub Load(ByVal connection As String)

        Try

            Dim cn As SqlConnection = New SqlConnection(Connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetDistrictServers"

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oDistrictServer As DistrictServer

            Do While dr.Read

                oDistrictServer = New DistrictServer

                With oDistrictServer

                    .ServerID = CByte(dr.GetValue(0))

                    .District = CStr(dr.GetValue(1))

                    .ServerName = CStr(dr.GetValue(2))

                End With

                Add(oDistrictServer)

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

    Public Sub Add(ByVal DistrictServer As DistrictServer)

        If Not DistrictServer Is Nothing Then

            mCol.Add(DistrictServer)

        End If

    End Sub

    Public Sub Remove(ByVal DistrictServerId As Integer, ByVal connection As String)

        'Dim oDistrictServer As DistrictServer

    End Sub
End Class