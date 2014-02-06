Imports System.Data.SqlClient

Public Class DistrictServer
#Region "Private Variables"
    Private m_ServerID As System.Byte
    Private m_District As System.String
    Private m_ServerName As System.String
#End Region

#Region "Public Properties"

    Public Property ServerID() As System.Byte
        Get
            Return m_ServerID
        End Get
        Set(ByVal Value As System.Byte)
            m_ServerID = Value
        End Set
    End Property


    Public Property District() As System.String
        Get
            Return m_District
        End Get
        Set(ByVal Value As System.String)
            m_District = Value
        End Set
    End Property


    Public Property ServerName() As System.String
        Get
            Return m_ServerName
        End Get
        Set(ByVal Value As System.String)
            m_ServerName = Value
        End Set
    End Property

#End Region

#Region "Data Access"
    Public Sub Load(ByVal connection As String, ByVal DistrictName As String)

        Try

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetDistrictServerByDistrict"
            cmd.Parameters.AddWithValue("@Name", DistrictName)

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Do While dr.Read

                With Me

                    .ServerID = CByte(dr.GetValue(0))

                    .District = CStr(dr.GetValue(1))

                    .ServerName = CStr(dr.GetValue(2))

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
                .CommandText = "InsertDistrictServers"

                .Parameters.AddWithValue("@ServerID", m_ServerID)
                .Parameters.AddWithValue("@District", m_District)
                .Parameters.AddWithValue("@ServerName", m_ServerName)
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
                .CommandText = "DeleteDistrictServers"
                .Parameters.AddWithValue("@ID", m_ServerID)
            End With

            cn.Open()

            cmd.ExecuteNonQuery()
            cn.Close()
            cn = Nothing
        Catch ex As Exception
            Throw
        End Try
    End Sub




#End Region

End Class
