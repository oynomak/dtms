Imports System.Data.SqlClient

Public Class BankAccount
#Region "Private Variables"
    Private m_BankAccountID As Integer
    Private m_BankBranchID As System.Int16
    Private m_AccountNumber As System.String
    Private m_TaxPayerID As Integer
    Private m_CellID As System.Int16
#End Region

#Region "Public Properties"
    Private m_Action As String
    Public Property Action() As String
        Get
            Return m_Action
        End Get
        Set(ByVal value As String)
            m_Action = value
        End Set
    End Property

    Public Property BankAccountID() As Integer
        Get
            Return m_BankAccountID
        End Get
        Set(ByVal Value As Integer)
            m_BankAccountID = Value
        End Set
    End Property


    Public Property BankBranchID() As System.Int16
        Get
            Return m_BankBranchID
        End Get
        Set(ByVal Value As System.Int16)
            m_BankBranchID = Value
        End Set
    End Property


    Public Property AccountNumber() As System.String
        Get
            Return m_AccountNumber
        End Get
        Set(ByVal Value As System.String)
            m_AccountNumber = Value
        End Set
    End Property


    Public Property TaxPayerID() As Integer
        Get
            Return m_TaxPayerID
        End Get
        Set(ByVal Value As Integer)
            m_TaxPayerID = Value
        End Set
    End Property


    Public Property CellID() As System.Int16
        Get
            Return m_CellID
        End Get
        Set(ByVal Value As System.Int16)
            m_CellID = Value
        End Set
    End Property

#End Region

#Region "Data Access"
    Public Sub Save(ByVal connection As String, ByVal newaccount As Boolean)

        Dim cn As SqlConnection = New SqlConnection(connection)

        Try
            Dim cmd As SqlCommand = cn.CreateCommand()

            With cmd
                .CommandType = CommandType.StoredProcedure
                If newaccount = True Then
                    .CommandText = "InsertBankAccounts"
                Else
                    .CommandText = "UpdateBankAccount"
                End If

                .Parameters.AddWithValue("@BankAccountID", m_BankAccountID)
                .Parameters.AddWithValue("@BankBranchID", m_BankBranchID)
                .Parameters.AddWithValue("@AccountNumber", m_AccountNumber)
                .Parameters.AddWithValue("@TaxPayerID", m_TaxPayerID)
                .Parameters.AddWithValue("@CellID", m_CellID)
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
        Dim cn As SqlConnection = New SqlConnection(Connection)

        Try
            Dim cmd As SqlCommand = cn.CreateCommand()

            With cmd
                .CommandType = CommandType.StoredProcedure
                .CommandText = "DeleteBankAccounts"
                .Parameters.AddWithValue("@BankAccountID", m_BankAccountID)
                .Parameters.AddWithValue("@CellID", m_CellID)
            End With

            cn.Open()

            cmd.ExecuteNonQuery()
            cn.Close()
            cn = Nothing

        Catch sqlex As SqlException
            If sqlex.ErrorCode = -2146232060 Then

            ElseIf sqlex.Message.Contains("FOREIGN") Then
                '//Ignore record and Continue: This record has no parent taxpayer
            Else
                Throw
            End If

        Catch ex As Exception
            Throw
        End Try
    End Sub




#End Region

End Class
