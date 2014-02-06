Imports System.Data.SqlClient

Public Class HouseTenant
#Region "Private Variables"
    Private m_HouseID As Integer
    Private m_PlotNumber As Integer
    Private m_FullName As System.String
    Private m_Telephone As System.String
    Private m_Address As System.String
    Private m_Amount As System.Decimal
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

    Public Property HouseID() As Integer
        Get
            Return m_HouseID
        End Get
        Set(ByVal Value As Integer)
            m_HouseID = Value
        End Set
    End Property


    Public Property PlotNumber() As Integer
        Get
            Return m_PlotNumber
        End Get
        Set(ByVal Value As Integer)
            m_PlotNumber = Value
        End Set
    End Property


    Public Property FullName() As System.String
        Get
            Return m_FullName
        End Get
        Set(ByVal Value As System.String)
            m_FullName = Value
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


    Public Property Address() As System.String
        Get
            Return m_Address
        End Get
        Set(ByVal Value As System.String)
            m_Address = Value
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
    Public Sub Save(ByVal connection As String, ByVal newtenant As Boolean)

        Dim cn As SqlConnection = New SqlConnection(connection)

        Try
            Dim cmd As SqlCommand = cn.CreateCommand()

            With cmd
                .CommandType = CommandType.StoredProcedure
                If newtenant = True Then
                    .CommandText = "InsertHouseTenants"
                Else
                    .CommandText = "UpdateHouseTenant"
                End If

                .Parameters.AddWithValue("@HouseID", m_HouseID)
                .Parameters.AddWithValue("@PlotNumber", m_PlotNumber)
                .Parameters.AddWithValue("@FullName", m_FullName)
                .Parameters.AddWithValue("@Telephone", m_Telephone)
                .Parameters.AddWithValue("@Address", m_Address)
                .Parameters.AddWithValue("@Amount", m_Amount)
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
                .CommandText = "DeleteHouseTenants"
                .Parameters.AddWithValue("@HouseID", m_HouseID)
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
