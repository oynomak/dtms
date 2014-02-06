Imports System.Data.SqlClient
Public Class HouseTenant
#Region "Private Variables"
    Private m_HouseID As Integer
    Private m_PlotNumber As System.String
    Private m_FullName As System.String
    Private m_Telephone As System.String
    Private m_Address As System.String
    Private m_Amount As System.Decimal
#End Region

#Region "Public Properties"

    Private m_TaxPayerID As Integer
    Public Property TaxPayerID() As Integer
        Get
            Return m_TaxPayerID
        End Get
        Set(ByVal value As Integer)
            m_TaxPayerID = value
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


    Public Property PlotNumber() As System.String
        Get
            Return m_PlotNumber
        End Get
        Set(ByVal Value As System.String)
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

#End Region

#Region "Data Access"

    Public Sub Load(ByVal connection As String, ByVal ID As Integer)

        Try

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetHouseTenantByID"
            cmd.Parameters.AddWithValue("@ID", ID)

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            
            Do While dr.Read

                With Me

                    .HouseID = CInt(dr.GetValue(0))

                    .PlotNumber = CStr(dr.GetValue(1))

                    .FullName = CStr(dr.GetValue(2))

                    .Telephone = CStr(dr.GetValue(3))

                    .Address = CStr(dr.GetValue(4))

                    .Amount = CDec(dr.GetValue(5))

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
                .CommandText = "InsertHouseTenants"

                .Parameters.AddWithValue("@HouseID", m_HouseID)
                .Parameters.AddWithValue("@PlotNumber", m_PlotNumber)
                .Parameters.AddWithValue("@FullName", m_FullName)
                .Parameters.AddWithValue("@Telephone", m_Telephone)
                .Parameters.AddWithValue("@Address", m_Address)
                .Parameters.AddWithValue("@Amount", m_Amount)
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
                .CommandText = "DeleteHouseTenants"
                .Parameters.AddWithValue("@ID", m_HouseID)
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
