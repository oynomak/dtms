
Imports System.Data.SqlClient

Public Class LandParcel
#Region "Private Variables"
    Private m_LandParcelID As Integer
    Private m_TaxPayerID As Integer
    Private m_PlotNumber As System.String
    Private m_Year As System.Int16
    Private m_StandingLevel As System.String
    Private m_LandTitle As System.String
    Private m_TitleNumber As System.String
    Private m_Usage As System.String
    Private m_NumberOfHouses As System.Int16
    Private m_ContractNumber As System.String
    Private m_ContractDate As System.DateTime
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

    Public Property LandParcelID() As Integer
        Get
            Return m_LandParcelID
        End Get
        Set(ByVal Value As Integer)
            m_LandParcelID = Value
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


    Public Property PlotNumber() As System.String
        Get
            Return m_PlotNumber
        End Get
        Set(ByVal Value As System.String)
            m_PlotNumber = Value
        End Set
    End Property


    Public Property Year() As System.Int16
        Get
            Return m_Year
        End Get
        Set(ByVal Value As System.Int16)
            m_Year = Value
        End Set
    End Property


    Public Property StandingLevel() As System.String
        Get
            Return m_StandingLevel
        End Get
        Set(ByVal Value As System.String)
            m_StandingLevel = Value
        End Set
    End Property


    Public Property LandTitle() As System.String
        Get
            Return m_LandTitle
        End Get
        Set(ByVal Value As System.String)
            m_LandTitle = Value
        End Set
    End Property


    Public Property TitleNumber() As System.String
        Get
            Return m_TitleNumber
        End Get
        Set(ByVal Value As System.String)
            m_TitleNumber = Value
        End Set
    End Property


    Public Property Usage() As System.String
        Get
            Return m_Usage
        End Get
        Set(ByVal Value As System.String)
            m_Usage = Value
        End Set
    End Property


    Public Property NumberOfHouses() As System.Int16
        Get
            Return m_NumberOfHouses
        End Get
        Set(ByVal Value As System.Int16)
            m_NumberOfHouses = Value
        End Set
    End Property


    Public Property ContractNumber() As System.String
        Get
            Return m_ContractNumber
        End Get
        Set(ByVal Value As System.String)
            m_ContractNumber = Value
        End Set
    End Property


    Public Property ContractDate() As System.DateTime
        Get
            Return m_ContractDate
        End Get
        Set(ByVal Value As System.DateTime)
            m_ContractDate = Value
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
    Public Sub Save(ByVal connection As String, ByVal newland As Boolean)

        Dim cn As SqlConnection = New SqlConnection(connection)

        Try
            Dim cmd As SqlCommand = cn.CreateCommand()

            With cmd
                .CommandType = CommandType.StoredProcedure
                If newland = True Then
                    .CommandText = "InsertLandParcels"
                Else
                    .CommandText = "UpdateLandParcel"
                End If

                .Parameters.AddWithValue("@LandParcelID", m_LandParcelID)
                .Parameters.AddWithValue("@TaxPayerID", m_TaxPayerID)
                .Parameters.AddWithValue("@PlotNumber", m_PlotNumber)
                .Parameters.AddWithValue("@Year", m_Year)
                .Parameters.AddWithValue("@StandingLevel", m_StandingLevel)
                .Parameters.AddWithValue("@LandTitle", m_LandTitle)
                .Parameters.AddWithValue("@TitleNumber", m_TitleNumber)
                .Parameters.AddWithValue("@Usage", m_Usage)
                .Parameters.AddWithValue("@NumberOfHouses", m_NumberOfHouses)
                .Parameters.AddWithValue("@ContractNumber", m_ContractNumber)
                .Parameters.AddWithValue("@ContractDate", m_ContractDate)
                .Parameters.AddWithValue("@Amount", m_Amount)
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
                .CommandText = "DeleteLandParcels"
                .Parameters.AddWithValue("@LandParcelID", m_LandParcelID)
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
