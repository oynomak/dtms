
Imports System.Data.SqlClient

Public Class BankBranch
#Region "Private Variables"
    Private m_BankBranchID As System.Int16
    Private m_BankID As System.Byte
    Private m_BankBranchName As System.String
    Private m_DistrictID As System.Int16
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

    Public Property BankBranchID() As System.Int16
        Get
            Return m_BankBranchID
        End Get
        Set(ByVal Value As System.Int16)
            m_BankBranchID = Value
        End Set
    End Property


    Public Property BankID() As System.Byte
        Get
            Return m_BankID
        End Get
        Set(ByVal Value As System.Byte)
            m_BankID = Value
        End Set
    End Property


    Public Property BankBranchName() As System.String
        Get
            Return m_BankBranchName
        End Get
        Set(ByVal Value As System.String)
            m_BankBranchName = Value
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
    Public Sub Save(ByVal connection As String, ByVal newbranch As Boolean)

        Dim cn As SqlConnection = New SqlConnection(connection)

        Try
            Dim cmd As SqlCommand = cn.CreateCommand()

            With cmd
                .CommandType = CommandType.StoredProcedure
                If newbranch = True Then
                    .CommandText = "InsertBankBranches"
                Else
                    .CommandText = "UpdateBankBranch"
                End If

                .Parameters.AddWithValue("@BankBranchID", m_BankBranchID)
                .Parameters.AddWithValue("@BankID", m_BankID)
                .Parameters.AddWithValue("@BankBranchName", m_BankBranchName)
                .Parameters.AddWithValue("@DistrictID", m_DistrictID)
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



    Public Sub Delete(ByVal connection As String)
        Dim cn As SqlConnection = New SqlConnection(connection)

        Try
            Dim cmd As SqlCommand = cn.CreateCommand()

            With cmd
                .CommandType = CommandType.StoredProcedure
                .CommandText = "DeleteBankBranches"
                .Parameters.AddWithValue("@BankBranchID", m_BankBranchID)
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

