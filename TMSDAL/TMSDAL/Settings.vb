Imports System.Data.SqlClient

Public Class Settings
    Public Sub UpdateDistrict(ByVal connection As String, ByVal DistrictName As String)
        Dim cn As SqlConnection = New SqlConnection(connection)

        Try
            Dim cmd As SqlCommand = cn.CreateCommand()

            With cmd
                .CommandType = CommandType.StoredProcedure
                .CommandText = "UpdateSettings"
                .Parameters.AddWithValue("@DistrictName", DistrictName)
            End With

            cn.Open()

            cmd.ExecuteNonQuery()

            cn.Close()
            cn = Nothing

        Catch ex As Exception
            Throw
        End Try
    End Sub
End Class
