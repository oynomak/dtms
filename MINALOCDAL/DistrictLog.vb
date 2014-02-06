Imports System.Data.SqlClient

Public Class DistrictLog
#Region "Private Variables"
    Private m_LogID As System.Int64
    Private m_District As System.String
    Private m_RecordsInserted As Integer
    Private m_RecordsUpdated As Integer
    Private m_RecordsDeleted As Integer
    Private m_Created As System.DateTime
#End Region

#Region "Public Properties"

    Public Property LogID() As System.Int64
        Get
            Return m_LogID
        End Get
        Set(ByVal Value As System.Int64)
            m_LogID = Value
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


    Public Property RecordsInserted() As Integer
        Get
            Return m_RecordsInserted
        End Get
        Set(ByVal Value As Integer)
            m_RecordsInserted = Value
        End Set
    End Property

    Private m_Text As String
    Public Property Text() As String
        Get
            Return m_Text
        End Get
        Set(ByVal value As String)
            m_Text = value
        End Set
    End Property


    Public Property RecordsUpdated() As Integer
        Get
            Return m_RecordsUpdated
        End Get
        Set(ByVal Value As Integer)
            m_RecordsUpdated = Value
        End Set
    End Property


    Public Property RecordsDeleted() As Integer
        Get
            Return m_RecordsDeleted
        End Get
        Set(ByVal Value As Integer)
            m_RecordsDeleted = Value
        End Set
    End Property


    Public Property Created() As System.DateTime
        Get
            Return m_Created
        End Get
        Set(ByVal Value As System.DateTime)
            m_Created = Value
        End Set
    End Property

#End Region

#Region "Data Access"
    Public Sub Load(ByVal connection As String, ByVal districtname As String)

        Try

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetLatestDistrictLog"
            cmd.Parameters.AddWithValue("@Name", districtname)

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Do While dr.Read

                With Me

                    .LogID = CLng(dr.GetValue(0))

                    .District = CStr(dr.GetValue(1))

                    .RecordsInserted = CInt(dr.GetValue(2))

                    .RecordsUpdated = CInt(dr.GetValue(3))

                    .RecordsDeleted = CInt(dr.GetValue(4))

                    .Created = CDate(dr.GetValue(5))
                    '.Text = CStr(dr("Text"))
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
                .CommandText = "InsertDistrictLog"

                .Parameters.AddWithValue("@LogID", m_LogID)
                .Parameters.AddWithValue("@District", m_District)
                .Parameters.AddWithValue("@RecordsInserted", m_RecordsInserted)
                .Parameters.AddWithValue("@RecordsUpdated", m_RecordsUpdated)
                .Parameters.AddWithValue("@RecordsDeleted", m_RecordsDeleted)
                .Parameters.AddWithValue("@Created", m_Created)
                .Parameters.AddWithValue("@Text", m_Text)
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
                .CommandText = "DeleteDistrictLog"
                .Parameters.AddWithValue("@ID", m_LogID)
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
