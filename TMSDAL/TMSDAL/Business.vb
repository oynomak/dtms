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
#End Region

#Region "Public Properties"

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

    Private m_TaxPayerID As Integer
    Public Property TaxPayerID() As Integer
        Get
            Return m_TaxPayerID
        End Get
        Set(ByVal value As Integer)
            m_TaxPayerID = value
        End Set
    End Property


#End Region

#Region "Data Access"

    Public Sub Load(ByVal connection As String, ByVal ID As Integer)

        Try

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetBusinessByID"
            cmd.Parameters.AddWithValue("@ID", ID)

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Do While dr.Read

                With Me
                    .BusinessID = CInt(dr.GetValue(0))
                    .PlotNumber = CStr(dr.GetValue(1))
                    .BusinessName = CStr(dr.GetValue(2))
                    .Profession = CStr(dr.GetValue(3))
                    .StartDate = CDate(dr.GetValue(4))
                    .Amount = CDec(dr.GetValue(5))
                    .Address = CStr(dr.GetValue(6))
                    .TaxPayerID = CInt(dr("TaxpayerID"))
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
                .CommandText = "InsertBusinesses"

                .Parameters.AddWithValue("@BusinessID", m_BusinessID)
                .Parameters.AddWithValue("@PlotNumber", m_PlotNumber)
                .Parameters.AddWithValue("@BusinessName", m_BusinessName)
                .Parameters.AddWithValue("@Profession", m_Profession)
                .Parameters.AddWithValue("@StartDate", m_StartDate)
                .Parameters.AddWithValue("@Amount", m_Amount)
                .Parameters.AddWithValue("@Address", m_Address)
                .Parameters.AddWithValue("@TaxPayerID", m_TaxPayerID)
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
                .Parameters.AddWithValue("@ID", m_BusinessID)
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
