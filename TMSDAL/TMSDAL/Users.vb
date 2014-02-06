Imports System.Data.SqlClient

Public Class Users

    Implements ICollection

    Implements IEnumerable

    Private mCol As Collection

    Public Sub Load(ByVal connection As String)

        Try

            Dim cn As SqlConnection = New SqlConnection(Connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetUsers"

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oUser As User

            Do While dr.Read

                oUser = New User

                With oUser

                    .UserID = CShort(dr.GetValue(0))

                    .DistrictID = CShort(dr.GetValue(1))

                    .UserName = CStr(dr.GetValue(2))

                    .Password = CStr(dr.GetValue(3))
                    .FullName = CStr(dr("FullName"))
                    .Status = CInt(dr("Status"))

                End With

                Add(oUser)

            Loop

            dr.Close()

            cn.Close()

            cn = Nothing

        Catch ex As Exception

            '//MsgBox(ex.Message & vbCrLf & "Procedure - Users" & System.Reflection.MethodBase.GetCurrentMethod.Name.ToString(), '//MsgBoxStyle.Critical, System.Reflection.MethodBase.GetCurrentMethod.Name.ToString())

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

    Public Sub Add(ByVal User As User)

        If Not User Is Nothing Then

            mCol.Add(User)

        End If

    End Sub

    Public Sub Remove(ByVal UserId As Integer, ByVal connection As String)

        Dim oUser As User

        Dim i As Integer

        For Each oUser In Me

            i += 1

            If oUser.UserID = UserID Then

                oUser.Delete(Connection)

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

    Default Public Overloads ReadOnly Property Item(ByVal index As Integer) As User

        Get

            Dim p_User As User = Nothing

            For Each p_User In Me

                If p_User.UserID = index Then

                    Exit For

                End If

            Next
            Return p_User
        End Get

    End Property

    Default Public Overloads ReadOnly Property Item(ByVal name As String) As User

        Get

            Dim p_User As User = Nothing

            For Each p_User In Me

                If p_User.UserName = name Then

                    Exit For

                End If

            Next

            Return p_User

        End Get

    End Property

End Class