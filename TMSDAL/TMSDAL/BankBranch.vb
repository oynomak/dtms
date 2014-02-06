Imports System.Data.SqlClient
Public Class BankBranch
#Region "Private Variables"
    Private m_BankBranchID As System.Int16
    Private m_BankID As System.Byte
    Private m_BankBranchName As System.String
#End Region

#Region "Public Properties"

    Public Property BankBranchID() As System.Int16
        Get
            Return m_BankBranchID
        End Get
        Set(ByVal Value As System.Int16)
            m_BankBranchID = Value
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


    Public Property BankBranchName() As System.String
        Get
            Return m_BankBranchName
        End Get
        Set(ByVal Value As System.String)
            m_BankBranchName = Value
        End Set
    End Property

#End Region

#Region "Data Access"

    Public Sub Load(ByVal connection As String, ByVal ID As Byte)

        Try

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetBankBranchByID"
            cmd.Parameters.AddWithValue("@ID", ID)

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader
            Do While dr.Read

                With Me

                    .BankBranchID = CShort(dr.GetValue(0))

                    .BankID = CByte(dr.GetValue(1))

                    .BankBranchName = CStr(dr.GetValue(2))

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
                .CommandText = "InsertBankBranches"

                .Parameters.AddWithValue("@BankBranchID", m_BankBranchID)
                .Parameters.AddWithValue("@BankID", m_BankID)
                .Parameters.AddWithValue("@BankBranchName", m_BankBranchName)
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
                .CommandText = "DeleteBankBranches"
                .Parameters.AddWithValue("@ID", m_BankBranchID)
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

