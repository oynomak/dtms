Imports System.Data.SqlClient

Public Class TaxType
#Region "Private Variables"
    Private m_TaxTypeID As System.Byte
    Private m_TaxTypeName As System.String
#End Region

#Region "Public Properties"

    Public Property TaxTypeID() As System.Byte
        Get
            Return m_TaxTypeID
        End Get
        Set(ByVal Value As System.Byte)
            m_TaxTypeID = Value
        End Set
    End Property


    Public Property TaxTypeName() As System.String
        Get
            Return m_TaxTypeName
        End Get
        Set(ByVal Value As System.String)
            m_TaxTypeName = Value
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
                .CommandText = "InsertTaxTypes"

                .Parameters.AddWithValue("@TaxTypeID", m_TaxTypeID)
                .Parameters.AddWithValue("@TaxTypeName", m_TaxTypeName)
            End With

            cn.Open()

            cmd.ExecuteNonQuery()

            cn.Close()
            cn = Nothing

        Catch ex As Exception
            Throw
        End Try
    End Sub

    Public Sub Load(ByVal connection As String, ByVal taxtypeid As Byte)

        Try

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure
            cmd.CommandText = "GetTaxTypeByID"
            cmd.Parameters.AddWithValue("@ID", taxtypeid)

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Do While dr.Read
                With Me
                    .TaxTypeID = CByte(dr.GetValue(0))
                    .TaxTypeName = CStr(dr.GetValue(1))
                End With
            Loop

            dr.Close()

            cn.Close()

            cn = Nothing

        Catch ex As Exception
            Throw
            ' MsgBox(ex.Message & vbCrLf & "Procedure - TaxTypes" & System.Reflection.MethodBase.GetCurrentMethod.Name.ToString(), MsgBoxStyle.Critical, System.Reflection.MethodBase.GetCurrentMethod.Name.ToString())

        End Try

    End Sub

    Public Sub Delete(ByVal connection As String)
        Dim cn As SqlConnection = New SqlConnection(connection)

        Try
            Dim cmd As SqlCommand = cn.CreateCommand()

            With cmd
                .CommandType = CommandType.StoredProcedure
                .CommandText = "DeleteTaxTypes"
                .Parameters.AddWithValue("@ID", m_TaxTypeID)
            End With

            cn.Open()

            cmd.ExecuteNonQuery()
            cn.Close()
            cn = Nothing
        Catch ex As Exception
            ' MsgBox(ex.Message & vbCrLf & "Procedure - " & System.Reflection.MethodBase.GetCurrentMethod.Name.ToString(), MsgBoxStyle.Critical, System.Reflection.MethodBase.GetCurrentMethod.Name.ToString())
        End Try
    End Sub




#End Region

End Class


