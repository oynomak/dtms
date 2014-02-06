Imports System.Data.SqlClient

Public Class FeePayment
#Region "Private Variables"
    Private m_PaymentID As System.Int64
    Private m_TaxPayerID As Integer
    Private m_Designation As System.String
    Private m_PaymentDate As System.DateTime
    Private m_Amount As System.Decimal
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

    Public Property PaymentID() As System.Int64
        Get
            Return m_PaymentID
        End Get
        Set(ByVal Value As System.Int64)
            m_PaymentID = Value
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


    Public Property Designation() As System.String
        Get
            Return m_Designation
        End Get
        Set(ByVal Value As System.String)
            m_Designation = Value
        End Set
    End Property


    Public Property PaymentDate() As System.DateTime
        Get
            Return m_PaymentDate
        End Get
        Set(ByVal Value As System.DateTime)
            m_PaymentDate = Value
        End Set
    End Property


    Public Property Amount() As System.Decimal
        Get
            Return m_Amount
        End Get
        Set(ByVal Value As System.Decimal)
            m_Amount = Value
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
    Public Sub Save(ByVal connection As String, ByVal newfeepayment As Boolean)

        Dim cn As SqlConnection = New SqlConnection(connection)

        Try
            Dim cmd As SqlCommand = cn.CreateCommand()

            With cmd
                .CommandType = CommandType.StoredProcedure
                If newfeepayment = True Then
                    .CommandText = "InsertFeePayments"
                Else
                    .CommandText = "UpdateFeePayment"
                End If

                .Parameters.AddWithValue("@PaymentID", m_PaymentID)
                .Parameters.AddWithValue("@TaxPayerID", m_TaxPayerID)
                .Parameters.AddWithValue("@Designation", m_Designation)
                .Parameters.AddWithValue("@PaymentDate", m_PaymentDate)
                .Parameters.AddWithValue("@Amount", m_Amount)
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



    Public Sub Delete(ByVal connection As String)
        Dim cn As SqlConnection = New SqlConnection(Connection)

        Try
            Dim cmd As SqlCommand = cn.CreateCommand()

            With cmd
                .CommandType = CommandType.StoredProcedure
                .CommandText = "DeleteFeePayments"
                .Parameters.AddWithValue("@PaymentID", m_PaymentID)
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




#End Region

End Class
