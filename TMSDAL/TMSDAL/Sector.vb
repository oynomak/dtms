Imports System.Data.SqlClient
Public Class Sector
#Region "Private Variables"
    Private m_SectorID As System.Int16
    Private m_DistrictID As System.Int16
    Private m_SectorName As System.String
#End Region

#Region "Public Properties"

    Public Property SectorID() As System.Int16
        Get
            Return m_SectorID
        End Get
        Set(ByVal Value As System.Int16)
            m_SectorID = Value
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


    Public Property SectorName() As System.String
        Get
            Return m_SectorName
        End Get
        Set(ByVal Value As System.String)
            m_SectorName = Value
        End Set
    End Property

    Private m_NumberOfCells As Integer
    Public Property NumberOfCells() As Integer
        Get
            Return m_NumberOfCells
        End Get
        Set(ByVal value As Integer)
            m_NumberOfCells = value
        End Set
    End Property
#End Region

#Region "Data Access"
    Public Sub Load(ByVal connection As String, ByVal sectorid As Short)

        Try

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetSectorByID"
            cmd.Parameters.AddWithValue("@ID", sectorid)

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader
            Do While dr.Read

                With Me

                    .SectorID = CShort(dr.GetValue(0))

                    .DistrictID = CShort(dr.GetValue(1))

                    .SectorName = CStr(dr.GetValue(2))

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
                .CommandText = "InsertSectors"

                .Parameters.AddWithValue("@SectorID", m_SectorID)
                .Parameters.AddWithValue("@DistrictID", m_DistrictID)
                .Parameters.AddWithValue("@SectorName", m_SectorName)
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
                .CommandText = "DeleteSectors"
                .Parameters.AddWithValue("@ID", m_SectorID)
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
