Imports System.Data.SqlClient
Public Class UserPermission
#Region "Private Variables"
    Private m_UserPermissionID As System.Int16
    Private m_UserID As System.Int16
    Private m_PermissionID As System.Byte
#End Region

#Region "Public Properties"

    Public Property UserPermissionID() As System.Int16
        Get
            Return m_UserPermissionID
        End Get
        Set(ByVal Value As System.Int16)
            m_UserPermissionID = Value
        End Set
    End Property


    Public Property UserID() As System.Int16
        Get
            Return m_UserID
        End Get
        Set(ByVal Value As System.Int16)
            m_UserID = Value
        End Set
    End Property


    Public Property PermissionID() As System.Byte
        Get
            Return m_PermissionID
        End Get
        Set(ByVal Value As System.Byte)
            m_PermissionID = Value
        End Set
    End Property

#End Region

#Region "Data Access"
    Public Sub Save(ByVal connection As String)

        Dim cn As SqlConnection = New SqlConnection(connection)

        Try
            Dim cmd As SqlCommand = cn.CreateCommand()

            With cmd
                .CommandType = CommandType.StoredProcedure
                .CommandText = "InsertUserPermissions"

                .Parameters.AddWithValue("@UserPermissionID", m_UserPermissionID)
                .Parameters.AddWithValue("@UserID", m_UserID)
                .Parameters.AddWithValue("@PermissionID", m_PermissionID)
            End With

            cn.Open()

            cmd.ExecuteNonQuery()

            cn.Close()
            cn = Nothing

        Catch ex As Exception
            Throw
        End Try
    End Sub



    Public Sub Delete(ByVal connection As String)
        Dim cn As SqlConnection = New SqlConnection(connection)

        Try
            Dim cmd As SqlCommand = cn.CreateCommand()

            With cmd
                .CommandType = CommandType.StoredProcedure
                .CommandText = "DeleteUserPermissions"
                .Parameters.AddWithValue("@ID", m_UserPermissionID)
            End With

            cn.Open()

            cmd.ExecuteNonQuery()
            cn.Close()
            cn = Nothing
        Catch ex As Exception
            '//MsgBox(ex.Message & vbCrLf & "Procedure - " & System.Reflection.MethodBase.GetCurrentMethod.Name.ToString(), '//MsgBoxStyle.Critical, System.Reflection.MethodBase.GetCurrentMethod.Name.ToString())
        End Try
    End Sub




#End Region

End Class