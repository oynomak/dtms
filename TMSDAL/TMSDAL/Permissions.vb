
Imports System.Data.SqlClient

Public Class Permissions

    Implements ICollection

    Implements IEnumerable

    Private mCol As Collection

    Public Sub Load(ByVal connection As String)

        Try

            Dim cn As SqlConnection = New SqlConnection(Connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetPermissions"

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oPermission As Permission

            Do While dr.Read

                oPermission = New Permission

                With oPermission

                    .PermissionID = CByte(dr.GetValue(0))

                    .PermissionName = CStr(dr.GetValue(1))

                End With

                Add(oPermission)

            Loop

            dr.Close()

            cn.Close()

            cn = Nothing

        Catch ex As Exception

            '//MsgBox(ex.Message & vbCrLf & "Procedure - Permissions" & System.Reflection.MethodBase.GetCurrentMethod.Name.ToString(), '//MsgBoxStyle.Critical, System.Reflection.MethodBase.GetCurrentMethod.Name.ToString())

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

    Public Sub Add(ByVal Permission As Permission)

        If Not Permission Is Nothing Then

            mCol.Add(Permission)

        End If

    End Sub

    Public Sub Remove(ByVal PermissionId As Integer, ByVal connection As String)

        Dim oPermission As Permission

        Dim i As Integer

        For Each oPermission In Me

            i += 1

            If oPermission.PermissionID = PermissionID Then

                oPermission.Delete(Connection)

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

    Default Public Overloads ReadOnly Property Item(ByVal index As Integer) As Permission

        Get

            Dim p_Permission As Permission = Nothing

            For Each p_Permission In Me

                If p_Permission.PermissionID = index Then

                    Exit For

                End If

            Next
            Return p_Permission
        End Get

    End Property

    Default Public Overloads ReadOnly Property Item(ByVal name As String) As Permission

        Get

            Dim p_Permission As Permission = Nothing

            For Each p_Permission In Me

                If p_Permission.PermissionName = name Then

                    Exit For

                End If

            Next
            Return p_Permission
        End Get

    End Property

End Class
