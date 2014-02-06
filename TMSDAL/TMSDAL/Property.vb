Imports System.Data.SqlClient
Public Class [Property]

#Region "Private Variables"
    Private m_PropertyID As Integer
    Private m_PlotNumber As System.String
    Private m_OwnersName As System.String
    Private m_Usage As System.String
    Private m_DateOfAcquisition As System.DateTime
    Private m_OwnerValuation As System.Decimal
    Private m_DistrictValuation As System.Decimal
#End Region

#Region "Public Properties"

    Private m_Amount As Decimal
    Public Property Amount() As Decimal
        Get
            Return m_Amount
        End Get
        Set(ByVal value As Decimal)
            m_Amount = value
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


    Public Property PropertyID() As Integer
        Get
            Return m_PropertyID
        End Get
        Set(ByVal Value As Integer)
            m_PropertyID = Value
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


    Public Property OwnersName() As System.String
        Get
            Return m_OwnersName
        End Get
        Set(ByVal Value As System.String)
            m_OwnersName = Value
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


    Public Property DateOfAcquisition() As System.DateTime
        Get
            Return m_DateOfAcquisition
        End Get
        Set(ByVal Value As System.DateTime)
            m_DateOfAcquisition = Value
        End Set
    End Property


    Public Property OwnerValuation() As System.Decimal
        Get
            Return m_OwnerValuation
        End Get
        Set(ByVal Value As System.Decimal)
            m_OwnerValuation = Value
        End Set
    End Property


    Public Property DistrictValuation() As System.Decimal
        Get
            Return m_DistrictValuation
        End Get
        Set(ByVal Value As System.Decimal)
            m_DistrictValuation = Value
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

            cmd.CommandText = "GetPropertyByID"
            cmd.Parameters.AddWithValue("@ID", ID)

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader
            Do While dr.Read
                With Me

                    .PropertyID = CInt(dr.GetValue(0))

                    .PlotNumber = CStr(dr.GetValue(1))

                    .OwnersName = CStr(dr.GetValue(2))

                    .Usage = CStr(dr.GetValue(3))

                    .DateOfAcquisition = CDate(dr.GetValue(4))

                    .OwnerValuation = CDec(dr.GetValue(5))

                    .DistrictValuation = CDec(dr.GetValue(6))
                    .Amount = CDec(dr("Amount"))

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
                .CommandText = "InsertProperties"

                .Parameters.AddWithValue("@PropertyID", m_PropertyID)
                .Parameters.AddWithValue("@PlotNumber", m_PlotNumber)
                .Parameters.AddWithValue("@OwnersName", m_OwnersName)
                .Parameters.AddWithValue("@Usage", m_Usage)
                .Parameters.AddWithValue("@DateOfAcquisition", m_DateOfAcquisition)
                .Parameters.AddWithValue("@OwnerValuation", m_OwnerValuation)
                .Parameters.AddWithValue("@DistrictValuation", m_DistrictValuation)
                .Parameters.AddWithValue("@TaxPayerID", m_TaxPayerID)
                .Parameters.AddWithValue("@Amount", m_Amount)
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
                .CommandText = "DeleteProperties"
                .Parameters.AddWithValue("@ID", m_PropertyID)
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
