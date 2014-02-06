Imports System.Data.SqlClient

Public Class District
#Region "Private Variables"
    Private m_DistrictID As System.Int16
    Private m_ProvinceID As System.Byte
    Private m_DistrictName As System.String
#End Region

#Region "Public Properties"

    Public Property DistrictID() As System.Int16
        Get
            Return m_DistrictID
        End Get
        Set(ByVal Value As System.Int16)
            m_DistrictID = Value
        End Set
    End Property


    Public Property ProvinceID() As System.Byte
        Get
            Return m_ProvinceID
        End Get
        Set(ByVal Value As System.Byte)
            m_ProvinceID = Value
        End Set
    End Property


    Public Property DistrictName() As System.String
        Get
            Return m_DistrictName
        End Get
        Set(ByVal Value As System.String)
            m_DistrictName = Value
        End Set
    End Property

    Private m_NumberOfSectors As Integer
    Public Property NumberOfSectors() As Integer
        Get
            Return m_NumberOfSectors
        End Get
        Set(ByVal value As Integer)
            m_NumberOfSectors = value
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

            cmd.CommandText = "GetDistrictByName"
            cmd.Parameters.AddWithValue("@name", districtname)
            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Do While dr.Read
                With Me
                    .DistrictID = CShort(dr.GetValue(0))
                    .ProvinceID = CByte(dr.GetValue(1))
                    .DistrictName = CStr(dr.GetValue(2))
                End With
            Loop

            dr.Close()
            cn.Close()
            cn = Nothing

        Catch ex As Exception
            Throw
        End Try

    End Sub

    Public Sub Load(ByVal connection As String, ByVal districtID As Short)

        Try

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetDistrictByID"
            cmd.Parameters.AddWithValue("@ID", districtID)
            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Do While dr.Read
                With Me
                    .DistrictID = CShort(dr.GetValue(0))
                    .ProvinceID = CByte(dr.GetValue(1))
                    .DistrictName = CStr(dr.GetValue(2))

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
                .CommandText = "InsertDistricts"

                .Parameters.AddWithValue("@DistrictID", m_DistrictID)
                .Parameters.AddWithValue("@ProvinceID", m_ProvinceID)
                .Parameters.AddWithValue("@DistrictName", m_DistrictName)
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
                .CommandText = "DeleteDistricts"
                .Parameters.AddWithValue("@ID", m_DistrictID)
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
