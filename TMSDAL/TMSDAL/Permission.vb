Imports System.Data.SqlClient
Public Class Permission
#Region "Private Variables"
    Private m_PermissionID As System.Byte
    Private m_PermissionName As System.String
#End Region

#Region "Public Properties"

    Public Property PermissionID() As System.Byte
        Get
            Return m_PermissionID
        End Get
        Set(ByVal Value As System.Byte)
            m_PermissionID = Value
        End Set
    End Property


    Public Property PermissionName() As System.String
        Get
            Return m_PermissionName
        End Get
        Set(ByVal Value As System.String)
            m_PermissionName = Value
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
                .CommandText = "InsertPermissions"

                .Parameters.AddWithValue("@PermissionID", m_PermissionID)
                .Parameters.AddWithValue("@PermissionName", m_PermissionName)
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
                .CommandText = "DeletePermissions"
                .Parameters.AddWithValue("@ID", m_PermissionID)
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
