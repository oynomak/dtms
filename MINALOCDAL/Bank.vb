Imports System.Data.SqlClient

Public Class Bank
#Region "Private Variables"
    Private m_BankID As System.Byte
    Private m_BankName As System.String
    Private m_DistrictID As System.Int16
#End Region

#Region "Public Properties"

    Public Property BankID() As System.Byte
        Get
            Return m_BankID
        End Get
        Set(ByVal Value As System.Byte)
            m_BankID = Value
        End Set
    End Property


    Public Property BankName() As System.String
        Get
            Return m_BankName
        End Get
        Set(ByVal Value As System.String)
            m_BankName = Value
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

#End Region

#Region "Data Access"
    Public Sub Save(ByVal connection As String)

        Dim cn As SqlConnection = New SqlConnection(connection)

        Try
            Dim cmd As SqlCommand = cn.CreateCommand()

            With cmd
                .CommandType = CommandType.StoredProcedure
                .CommandText = "InsertBanks"

                .Parameters.AddWithValue("@BankID", m_BankID)
                .Parameters.AddWithValue("@BankName", m_BankName)
                .Parameters.AddWithValue("@DistrictID", m_DistrictID)
            End With

            cn.Open()

            cmd.ExecuteNonQuery()

            cn.Close()

        Catch sqlex As SqlException
            If sqlex.ErrorCode = -2146232060 Then

            ElseIf sqlex.Message.Contains("FOREIGN") Then
                '//Ignore record and Continue: This record has no parent taxpayer
            Else
                Throw
            End If
            cn = Nothing

        Catch ex As Exception
            Throw
        End Try
    End Sub



    Public Sub Delete(ByVal connection As String)
        Dim cn As SqlConnection = New SqlConnection(Connection)

        Try
            Dim cmd As SqlCommand = cn.CreateCommand()

            With cmd
                .CommandType = CommandType.StoredProcedure
                .CommandText = "DeleteBanks"
                .Parameters.AddWithValue("@BankID", m_BankID)
                .Parameters.AddWithValue("@DistrictID", m_DistrictID)
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

