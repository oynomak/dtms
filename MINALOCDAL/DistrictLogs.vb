
Imports System.Data.SqlClient

Public Class DistrictLogs

    Implements ICollection

    Implements IEnumerable

    Private mCol As Collection

    Public Sub Load(ByVal connection As String)

        Try

            Dim cn As SqlConnection = New SqlConnection(Connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetDistrictLog"

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oDistrictLog As DistrictLog

            Do While dr.Read

                oDistrictLog = New DistrictLog

                With oDistrictLog

                    .LogID = CLng(dr.GetValue(0))

                    .District = CStr(dr.GetValue(1))

                    .RecordsInserted = CInt(dr.GetValue(2))

                    .RecordsUpdated = CInt(dr.GetValue(3))

                    .RecordsDeleted = CInt(dr.GetValue(4))

                    .Created = CDate(dr.GetValue(5))

                End With

                Add(oDistrictLog)

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

    Public Sub Add(ByVal DistrictLog As DistrictLog)

        If Not DistrictLog Is Nothing Then

            mCol.Add(DistrictLog)

        End If

    End Sub

    Public Sub Remove(ByVal DistrictLogId As Integer, ByVal connection As String)

        Dim oDistrictLog As DistrictLog

        Dim i As Integer

        For Each oDistrictLog In Me

            i += 1

            If oDistrictLog.LogID = DistrictLogId Then

                oDistrictLog.Delete(connection)

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

    Default Public Overloads ReadOnly Property Item(ByVal index As Integer) As DistrictLog

        Get

            Dim p_DistrictLog As DistrictLog = Nothing

            For Each p_DistrictLog In Me

                If p_DistrictLog.LogID = index Then

                    Exit For
                End If

            Next

            Return p_DistrictLog

        End Get

    End Property

    Default Public Overloads ReadOnly Property Item(ByVal name As String) As DistrictLog

        Get

            Dim p_DistrictLog As DistrictLog = Nothing

            For Each p_DistrictLog In Me

                If p_DistrictLog.District = name Then

                    Exit For
                End If

            Next

            Return p_DistrictLog

        End Get

    End Property

End Class

