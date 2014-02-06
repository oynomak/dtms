Imports System.Data.SqlClient

Public Class Business
#Region "Private Variables"
    Private m_BusinessID As Integer
    Private m_PlotNumber As System.String
    Private m_BusinessName As System.String
    Private m_Profession As System.String
    Private m_StartDate As System.DateTime
    Private m_Amount As System.Decimal
    Private m_Address As System.String
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

    Public Property BusinessID() As Integer
        Get
            Return m_BusinessID
        End Get
        Set(ByVal Value As Integer)
            m_BusinessID = Value
        End Set
    End Property


    Public Property PlotNumber() As System.String
        Get
            Return m_PlotNumber
        End Get
        Set(ByVal Value As System.String)
            m_PlotNumber = Value
        End Set
    End Property


    Public Property BusinessName() As System.String
        Get
            Return m_BusinessName
        End Get
        Set(ByVal Value As System.String)
            m_BusinessName = Value
        End Set
    End Property


    Public Property Profession() As System.String
        Get
            Return m_Profession
        End Get
        Set(ByVal Value As System.String)
            m_Profession = Value
        End Set
    End Property


    Public Property StartDate() As System.DateTime
        Get
            Return m_StartDate
        End Get
        Set(ByVal Value As System.DateTime)
            m_StartDate = Value
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


    Public Property Address() As System.String
        Get
            Return m_Address
        End Get
        Set(ByVal Value As System.String)
            m_Address = Value
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
    Public Sub Save(ByVal connection As String, ByVal newbusiness As Boolean)

        Dim cn As SqlConnection = New SqlConnection(connection)

        Try
            Dim cmd As SqlCommand = cn.CreateCommand()

            With cmd
                .CommandType = CommandType.StoredProcedure
                If newbusiness = True Then
                    .CommandText = "InsertBusinesses"
                Else
                    .CommandText = "UpdateBusiness"
                End If

                .Parameters.AddWithValue("@BusinessID", m_BusinessID)
                .Parameters.AddWithValue("@PlotNumber", m_PlotNumber)
                .Parameters.AddWithValue("@BusinessName", m_BusinessName)
                .Parameters.AddWithValue("@Profession", m_Profession)
                .Parameters.AddWithValue("@StartDate", m_StartDate)
                .Parameters.AddWithValue("@Amount", m_Amount)
                .Parameters.AddWithValue("@Address", m_Address)
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
        Dim cn As SqlConnection = New SqlConnection(connection)

        Try
            Dim cmd As SqlCommand = cn.CreateCommand()

            With cmd
                .CommandType = CommandType.StoredProcedure
                .CommandText = "DeleteBusinesses"
                .Parameters.AddWithValue("@BusinessID", m_BusinessID)
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

