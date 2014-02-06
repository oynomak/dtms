Imports System.Data.SqlClient
Imports System.ComponentModel

Public Class TaxPayer
    Public parent As TaxpayerList
#Region "Private Variables"
    Private m_TaxPayerID As Integer
    Private m_CellID As System.Int16
    Private m_FileNumber As System.String
    Private m_Address As System.String
    Private m_Telephone As System.String
    Private m_Mobile As System.String
    Private m_Profession As System.String
    Private m_DateOfBirth As System.DateTime
    Private m_IDNumber As System.String
    Private m_IDType As System.String
    Private m_TIN As System.String
    Private m_Email As System.String
#End Region

#Region "Public Properties"

    Private m_Banks As BankAccounts
    Private m_Landparcels As LandParcels
    Private m_HouseTenants As HouseTenants
    Private m_Businesses As Businesses

    Public Property Businesses() As Businesses
        Get
            Return m_Businesses
        End Get
        Set(ByVal value As Businesses)
            m_Businesses = value
        End Set
    End Property

    Public Property Tenants() As HouseTenants
        Get
            Return m_HouseTenants
        End Get
        Set(ByVal value As HouseTenants)
            m_HouseTenants = value
        End Set
    End Property

    Public Property LandParcels() As LandParcels
        Get
            Return m_Landparcels
        End Get
        Set(ByVal value As LandParcels)
            m_Landparcels = value
        End Set
    End Property

    Public Property Banks() As BankAccounts
        Get
            Return m_Banks
        End Get
        Set(ByVal value As BankAccounts)
            m_Banks = value
        End Set
    End Property


    Private m_Names As String
    Public Property Names() As String
        Get
            Return m_Names
        End Get
        Set(ByVal value As String)
            m_Names = value
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


    Public Property FileNumber() As System.String
        Get
            Return m_FileNumber
        End Get
        Set(ByVal Value As System.String)
            m_FileNumber = Value
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


    Public Property Telephone() As System.String
        Get
            Return m_Telephone
        End Get
        Set(ByVal Value As System.String)
            m_Telephone = Value
        End Set
    End Property


    Public Property Mobile() As System.String
        Get
            Return m_Mobile
        End Get
        Set(ByVal Value As System.String)
            m_Mobile = Value
        End Set
    End Property

    Private m_Cell As String
    Public Property Cell() As String
        Get
            Return m_Cell
        End Get
        Set(ByVal value As String)
            m_Cell = value
        End Set
    End Property



    Private m_Sector As String
    Public Property Sector() As String
        Get
            Return m_Sector
        End Get
        Set(ByVal value As String)
            m_Sector = value
        End Set
    End Property


    Private m_Status As Integer
    Public Property Status() As Integer
        Get
            Return m_Status
        End Get
        Set(ByVal value As Integer)
            m_Status = value
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


    Public Property DateOfBirth() As System.DateTime
        Get
            Return m_DateOfBirth
        End Get
        Set(ByVal Value As System.DateTime)
            m_DateOfBirth = Value
        End Set
    End Property


    Public Property IDNumber() As System.String
        Get
            Return m_IDNumber
        End Get
        Set(ByVal Value As System.String)
            m_IDNumber = Value
        End Set
    End Property


    Public Property IDType() As System.String
        Get
            Return m_IDType
        End Get
        Set(ByVal Value As System.String)
            m_IDType = Value
        End Set
    End Property


    Public Property TIN() As System.String
        Get
            Return m_TIN
        End Get
        Set(ByVal Value As System.String)
            m_TIN = Value
        End Set
    End Property


    Public Property Email() As System.String
        Get
            Return m_Email
        End Get
        Set(ByVal Value As System.String)
            m_Email = Value
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

            cmd.CommandText = "GetTaxPayerByID"
            cmd.Parameters.AddWithValue("@ID", ID)

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader
            Do While dr.Read

                With Me
                    .TaxPayerID = CInt(dr.GetValue(0))
                    .CellID = CShort(dr.GetValue(1))
                    .FileNumber = CStr(dr.GetValue(2))
                    .Address = CStr(dr.GetValue(3))
                    .Telephone = CStr(dr.GetValue(4))
                    .Mobile = CStr(dr.GetValue(5))
                    .Profession = CStr(dr.GetValue(6))
                    .DateOfBirth = CDate(dr.GetValue(7))
                    .IDNumber = CStr(dr.GetValue(8))
                    .IDType = CStr(dr.GetValue(9))
                    .TIN = CStr(dr.GetValue(10))
                    .Email = CStr(dr.GetValue(11))
                    .Names = CStr(dr("Names"))
                    .Sector = CStr(dr("Sector"))
                    .Cell = CStr(dr("Cell"))
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
                .CommandText = "InsertTaxPayers"

                .Parameters.AddWithValue("@TaxPayerID", m_TaxPayerID)
                .Parameters.AddWithValue("@CellID", m_CellID)
                .Parameters.AddWithValue("@FileNumber", m_FileNumber)
                .Parameters.AddWithValue("@Address", m_Address)
                .Parameters.AddWithValue("@Telephone", m_Telephone)
                .Parameters.AddWithValue("@Mobile", m_Mobile)
                .Parameters.AddWithValue("@Profession", m_Profession)
                .Parameters.AddWithValue("@DateOfBirth", m_DateOfBirth)
                .Parameters.AddWithValue("@IDNumber", m_IDNumber)
                .Parameters.AddWithValue("@IDType", m_IDType)
                .Parameters.AddWithValue("@TIN", m_TIN)
                .Parameters.AddWithValue("@Email", m_Email)
                .Parameters.AddWithValue("@Names", m_Names)
            End With

            cn.Open()

            Dim dr As SqlDataReader = cmd.ExecuteReader()

            If m_TaxPayerID = 0 Then
                Do While dr.Read
                    m_TaxPayerID = CInt(dr.GetValue(0))
                Loop
            End If


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
                .CommandText = "DeleteTaxPayers"
                .Parameters.AddWithValue("@ID", m_TaxPayerID)
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
    Public Sub New()

    End Sub

    Public Sub New(ByVal ID As Integer)
        m_TaxPayerID = ID
    End Sub

    Public Overrides Function ToString() As String
        Dim sb As New IO.StringWriter()
        sb.Write(Me.Names)
        Return sb.ToString()
    End Function
End Class

