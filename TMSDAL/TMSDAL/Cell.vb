Imports System.Data.SqlClient
Public Class Cell
#Region "Private Variables"
    Private m_CellID As System.Int16
    Private m_SectorID As System.Int16
    Private m_CellName As System.String
#End Region

#Region "Public Properties"

    Public Property CellID() As System.Int16
        Get
            Return m_CellID
        End Get
        Set(ByVal Value As System.Int16)
            m_CellID = Value
        End Set
    End Property


    Public Property SectorID() As System.Int16
        Get
            Return m_SectorID
        End Get
        Set(ByVal Value As System.Int16)
            m_SectorID = Value
        End Set
    End Property


    Public Property CellName() As System.String
        Get
            Return m_CellName
        End Get
        Set(ByVal Value As System.String)
            m_CellName = Value
        End Set
    End Property

#End Region

#Region "Data Access"
    Public Sub Load(ByVal connection As String, ByVal cellid As Short)

        Try

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetCellByID"
            cmd.Parameters.AddWithValue("@ID", cellid)

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader
            Do While dr.Read

                With Me
                    .CellID = CShort(dr.GetValue(0))
                    .SectorID = CShort(dr.GetValue(1))
                    .CellName = CStr(dr.GetValue(2))
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
                .CommandText = "InsertCells"

                .Parameters.AddWithValue("@CellID", m_CellID)
                .Parameters.AddWithValue("@SectorID", m_SectorID)
                .Parameters.AddWithValue("@CellName", m_CellName)
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
                .CommandText = "DeleteCells"
                .Parameters.AddWithValue("@ID", m_CellID)
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
