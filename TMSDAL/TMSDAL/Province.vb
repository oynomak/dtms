Imports System.Data.SqlClient
Public Class Province
#Region "Private Variables"
    Private m_ProvinceID As System.Byte
    Private m_ProvinceName As System.String
#End Region

#Region "Public Properties"

    Public Property ProvinceID() As System.Byte
        Get
            Return m_ProvinceID
        End Get
        Set(ByVal Value As System.Byte)
            m_ProvinceID = Value
        End Set
    End Property


    Public Property ProvinceName() As System.String
        Get
            Return m_ProvinceName
        End Get
        Set(ByVal Value As System.String)
            m_ProvinceName = Value
        End Set
    End Property

    Private m_NumberOfDistricts As Short
    Public Property NumberOfDistricts() As Short
        Get
            Return m_NumberOfDistricts
        End Get
        Set(ByVal value As Short)
            m_NumberOfDistricts = value
        End Set
    End Property
#End Region

#Region "Data Access"
    Public Sub Load(ByVal connection As String, ByVal ProvinceID As Byte)

        Try

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetProvinceByID"
            cmd.Parameters.AddWithValue("@ID", ProvinceID)

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader()

            Do While dr.Read

                With Me
                    .ProvinceID = ProvinceID
                    .ProvinceName = CStr(dr("ProvinceName"))
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
                .CommandText = "InsertProvinces"

                .Parameters.AddWithValue("@ProvinceID", m_ProvinceID)
                .Parameters.AddWithValue("@ProvinceName", m_ProvinceName)
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
                .CommandText = "DeleteProvinces"
                .Parameters.AddWithValue("@ID", m_ProvinceID)
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

