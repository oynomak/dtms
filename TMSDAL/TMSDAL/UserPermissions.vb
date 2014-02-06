Imports System.Data.SqlClient

Public Class UserPermissions

    Implements ICollection

    Implements IEnumerable

    Private mCol As Collection

    Public Sub Load(ByVal connection As String)

        Try

            Dim cn As SqlConnection = New SqlConnection(Connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetUserPermissions"

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oUserPermission As UserPermission

            Do While dr.Read

                oUserPermission = New UserPermission

                With oUserPermission

                    .UserPermissionID = CShort(dr.GetValue(0))

                    .UserID = CShort(dr.GetValue(1))

                    .PermissionID = CByte(dr.GetValue(2))

                End With

                Add(oUserPermission)

            Loop

            dr.Close()

            cn.Close()

            cn = Nothing

        Catch ex As Exception

            '//MsgBox(ex.Message & vbCrLf & "Procedure - UserPermissions" & System.Reflection.MethodBase.GetCurrentMethod.Name.ToString(), '//MsgBoxStyle.Critical, System.Reflection.MethodBase.GetCurrentMethod.Name.ToString())

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

    Public Sub Add(ByVal UserPermission As UserPermission)

        If Not UserPermission Is Nothing Then

            mCol.Add(UserPermission)

        End If

    End Sub

    Public Sub Remove(ByVal UserPermissionId As Integer, ByVal connection As String)

        Dim oUserPermission As UserPermission

        Dim i As Integer

        For Each oUserPermission In Me

            i += 1

            If oUserPermission.UserPermissionID = UserPermissionID Then

                oUserPermission.Delete(Connection)

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

    Default Public Overloads ReadOnly Property Item(ByVal index As Integer) As UserPermission

        Get

            Dim p_UserPermission As UserPermission = Nothing

            For Each p_UserPermission In Me

                If p_UserPermission.UserPermissionID = index Then

                    Exit For

                End If

            Next
            Return p_UserPermission
        End Get

    End Property

    
End Class

