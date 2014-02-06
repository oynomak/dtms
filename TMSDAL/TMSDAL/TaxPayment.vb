Imports System.Data.SqlClient
Public Class TaxPayment
#Region "Private Variables"
    Private m_PaymentID As System.Int64
    Private m_TaxPayerID As Integer
    Private m_PaymentDate As System.DateTime
    Private m_Amount As System.Decimal
    Private m_Description As System.String
#End Region

#Region "Public Properties"

    Public Property PaymentID() As System.Int64
        Get
            Return m_PaymentID
        End Get
        Set(ByVal Value As System.Int64)
            m_PaymentID = Value
        End Set
    End Property

    Private m_TaxTypeID As Byte
    Public Property TaxTypeID() As Byte
        Get
            Return m_TaxTypeID
        End Get
        Set(ByVal value As Byte)
            m_TaxTypeID = value
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

    Private m_TaxPayerName As String
    Public Property TaxPayerName() As String
        Get
            Return m_TaxPayerName
        End Get
        Set(ByVal value As String)
            m_TaxPayerName = value
        End Set
    End Property


    Private m_Cashier As String
    Public Property Cashier() As String
        Get
            Return m_Cashier
        End Get
        Set(ByVal value As String)
            m_Cashier = value
        End Set
    End Property



    Public Property Description() As System.String
        Get
            Return m_Description
        End Get
        Set(ByVal Value As System.String)
            m_Description = Value
        End Set
    End Property

#End Region
    Private m_TaxType As String
    Public Property TaxType() As String
        Get
            Return m_TaxType
        End Get
        Set(ByVal value As String)
            m_TaxType = value
        End Set
    End Property



#Region "Data Access"

    Public Sub Load(ByVal connection As String, ByVal ID As Byte)

        Try

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetTaxPaymentByID"
            cmd.Parameters.AddWithValue("@ID", ID)

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Do While dr.Read

                With Me
                    .PaymentID = CLng(dr.GetValue(0))
                    .TaxPayerID = CInt(dr.GetValue(1))
                    .PaymentDate = CDate(dr.GetValue(2))
                    .Amount = CDec(dr.GetValue(3))
                    .Description = CStr(dr.GetValue(4))
                    .TaxPayerName = CStr(dr("TaxPayerName"))
                    .Cashier = CStr(dr("Cashier"))
                    .TaxTypeID = CByte(dr("TaxTypeID"))
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
                .CommandText = "InsertTaxPayments"

                .Parameters.AddWithValue("@PaymentID", m_PaymentID)
                .Parameters.AddWithValue("@TaxPayerID", m_TaxPayerID)
                .Parameters.AddWithValue("@PaymentDate", m_PaymentDate)
                .Parameters.AddWithValue("@Amount", m_Amount)
                .Parameters.AddWithValue("@Description", m_Description)
                .Parameters.AddWithValue("@Cashier", m_Cashier)
                .Parameters.AddWithValue("@TaxTypeID", m_TaxTypeID)
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
                .CommandText = "DeleteTaxPayments"
                .Parameters.AddWithValue("@ID", m_PaymentID)
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
