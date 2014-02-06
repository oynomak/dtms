Imports System.Data.SqlClient

Public Class User
#Region "Private Variables"
    Private m_UserID As System.Int16
    Private m_DistrictID As System.Int16
    Private m_UserName As System.String
    Private m_Password As System.String
#End Region

#Region "Public Properties"

    Private m_FullName As String
    Public Property FullName() As String
        Get
            Return m_FullName
        End Get
        Set(ByVal value As String)
            m_FullName = value
        End Set
    End Property

    Private m_Status As Integer
    Public Property Status() As Integer
        Get
            Return m_Status
        End Get
        Set(ByVal value As Integer)
            m_Status = value
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


    Public Property DistrictID() As System.Int16
        Get
            Return m_DistrictID
        End Get
        Set(ByVal Value As System.Int16)
            m_DistrictID = Value
        End Set
    End Property


    Public Property UserName() As System.String
        Get
            Return m_UserName
        End Get
        Set(ByVal Value As System.String)
            m_UserName = Value
        End Set
    End Property


    Public Property Password() As System.String
        Get
            Return m_Password
        End Get
        Set(ByVal Value As System.String)
            m_Password = Value
        End Set
    End Property

#End Region

#Region "Data Access"

    Public Sub Load(ByVal connection As String, ByVal username As String)

        Try

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetUserByUserName"
            cmd.Parameters.AddWithValue("@username", username)

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader


            Do While dr.Read

                With Me

                    .UserID = CShort(dr.GetValue(0))

                    .DistrictID = CShort(dr.GetValue(1))

                    .UserName = CStr(dr.GetValue(2))

                    .Password = CStr(dr.GetValue(3))
                    .FullName = CStr(dr("FullName"))
                    .Status = CInt(dr("Status"))

                End With

            Loop

            dr.Close()

            cn.Close()

            cn = Nothing

        Catch ex As Exception

            Throw

        End Try

    End Sub


    Public Sub Load(ByVal connection As String, ByVal userid As Integer)

        Try

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetUserByID"
            cmd.Parameters.AddWithValue("@ID", userid)

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader


            Do While dr.Read

                With Me

                    .UserID = CShort(dr.GetValue(0))

                    .DistrictID = CShort(dr.GetValue(1))

                    .UserName = CStr(dr.GetValue(2))

                    .Password = CStr(dr.GetValue(3))
                    .FullName = CStr(dr("FullName"))
                    .Status = CInt(dr("Status"))

                End With

            Loop

            dr.Close()

            cn.Close()

            cn = Nothing

        Catch ex As Exception

            Throw

        End Try

    End Sub

    Public Sub Save(ByVal connection As String)

        Dim cn As SqlConnection = New SqlConnection(connection)

        Try
            Dim cmd As SqlCommand = cn.CreateCommand()

            With cmd
                .CommandType = CommandType.StoredProcedure
                .CommandText = "InsertUsers"
                .Parameters.AddWithValue("@UserID", m_UserID)
                .Parameters.AddWithValue("@DistrictID", m_DistrictID)
                .Parameters.AddWithValue("@UserName", m_UserName)
                .Parameters.AddWithValue("@Password", m_Password)
                .Parameters.AddWithValue("@FullName", m_FullName)
                .Parameters.AddWithValue("@Status", m_Status)
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
                .CommandText = "DeleteUsers"
                .Parameters.AddWithValue("@ID", m_UserID)
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
