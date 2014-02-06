Imports System.Data.SqlClient
Public Class Bank
#Region "Private Variables"
    Private m_BankID As System.Byte
    Private m_BankName As System.String
#End Region

    Public Sub New()
        m_Branches = New BankBranches
    End Sub

#Region "Public Properties"
    Private m_Branches As BankBranches
    Public Property Branches() As BankBranches
        Get
            Return m_Branches
        End Get
        Set(ByVal value As BankBranches)
            m_Branches = value
        End Set
    End Property



    Public Property BankID() As System.Byte
        Get
            Return m_BankID
        End Get
        Set(ByVal Value As System.Byte)
            m_BankID = Value
        End Set
    End Property


    Public Property BankName() As System.String
        Get
            Return m_BankName
        End Get
        Set(ByVal Value As System.String)
            m_BankName = Value
        End Set
    End Property

    Private m_NumberOfBranches As Integer
    Public Property NumberOfBranches() As Integer
        Get
            Return m_Branches.Count
        End Get
        Set(ByVal value As Integer)
            m_NumberOfBranches = value
        End Set
    End Property



#End Region

#Region "Data Access"

    Public Sub LoadBranches(ByVal connection As String, ByVal BankID As Byte)
        m_Branches = New BankBranches
        m_Branches.Load(connection, BankID)
    End Sub

    Public Sub Load(ByVal connection As String, ByVal ID As Byte)

        Try

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetBankByID"
            cmd.Parameters.AddWithValue("@ID", ID)

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Do While dr.Read

                With Me
                    .BankID = CByte(dr.GetValue(0))
                    .BankName = CStr(dr.GetValue(1))
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
                .CommandText = "InsertBanks"

                .Parameters.AddWithValue("@BankID", m_BankID)
                .Parameters.AddWithValue("@BankName", m_BankName)
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
                .CommandText = "DeleteBanks"
                .Parameters.AddWithValue("@ID", m_BankID)
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
