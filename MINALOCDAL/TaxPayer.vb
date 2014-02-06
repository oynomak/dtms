Imports System.Data.SqlClient

Public Class TaxPayer
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
    Private m_Names As System.String
#End Region

#Region "Public Properties"

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

    Private m_Action As String
    Public Property Action() As String
        Get
            Return m_Action
        End Get
        Set(ByVal value As String)
            m_Action = value
        End Set
    End Property



    Public Property Names() As System.String
        Get
            Return m_Names
        End Get
        Set(ByVal Value As System.String)
            m_Names = Value
        End Set
    End Property

#End Region

#Region "Data Access"

    Public Function Save(ByVal connection As String, ByVal newtaxpayer As Boolean) As Boolean

        Dim cn As SqlConnection = New SqlConnection(connection)

        Try
            Dim cmd As SqlCommand = cn.CreateCommand()

            With cmd
                .CommandType = Data.CommandType.StoredProcedure

                If newtaxpayer = True Then
                    .CommandText = "InsertTaxPayers"
                Else
                    .CommandText = "UpdateTaxPayer"
                End If

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

            cmd.ExecuteNonQuery()

            cn.Close()
            cn = Nothing
            Return True

        Catch sqlex As SqlException
            If sqlex.ErrorCode = -2146232060 Then
                '//Continue: this record exists
            Else
                Throw
            End If
        Catch ex As Exception
            Throw
        End Try
    End Function



    Public Function Delete(ByVal connection As String) As Boolean
        Dim cn As SqlConnection = New SqlConnection(connection)

        Try
            Dim cmd As SqlCommand = cn.CreateCommand()

            With cmd
                .CommandType = Data.CommandType.StoredProcedure
                .CommandText = "DeleteTaxPayers"
                .Parameters.AddWithValue("@ID", m_CellID)
                .Parameters.AddWithValue("@TaxpayerID", m_TaxPayerID)
            End With

            cn.Open()

            cmd.ExecuteNonQuery()
            cn.Close()
            cn = Nothing

            Return True

        Catch ex As Exception
            Throw
        End Try
    End Function




#End Region

End Class
