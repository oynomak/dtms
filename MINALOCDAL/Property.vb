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
    Private m_TaxPayerID As Integer
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


    Public Property TaxPayerID() As Integer
        Get
            Return m_TaxPayerID
        End Get
        Set(ByVal Value As Integer)
            m_TaxPayerID = Value
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
    Public Sub Save(ByVal connection As String, ByVal newproperty As Boolean)

        Dim cn As SqlConnection = New SqlConnection(connection)

        Try
            Dim cmd As SqlCommand = cn.CreateCommand()

            With cmd
                .CommandType = CommandType.StoredProcedure
                If newproperty = True Then
                    .CommandText = "InsertProperties"
                Else
                    .CommandText = "UpdateProperty"
                End If

                .Parameters.AddWithValue("@PropertyID", m_PropertyID)
                .Parameters.AddWithValue("@PlotNumber", m_PlotNumber)
                .Parameters.AddWithValue("@OwnersName", m_OwnersName)
                .Parameters.AddWithValue("@Usage", m_Usage)
                .Parameters.AddWithValue("@DateOfAcquisition", m_DateOfAcquisition)
                .Parameters.AddWithValue("@OwnerValuation", m_OwnerValuation)
                .Parameters.AddWithValue("@DistrictValuation", m_DistrictValuation)
                .Parameters.AddWithValue("@TaxPayerID", m_TaxPayerID)
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
        Dim cn As SqlConnection = New SqlConnection(connection)

        Try
            Dim cmd As SqlCommand = cn.CreateCommand()

            With cmd
                .CommandType = CommandType.StoredProcedure
                .CommandText = "DeleteProperties"
                .Parameters.AddWithValue("@PropertyID", m_PropertyID)
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
