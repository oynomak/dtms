
Imports System.Data.SqlClient

Public Class HouseTenants

    Implements ICollection

    Implements IEnumerable

    Private mCol As Collection

    Public Sub Load(ByVal connection As String, ByVal TaxpayerID As Integer)

        Try

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetHouseTenantsByTaxPayerID"
            cmd.Parameters.AddWithValue("@TaxpayerID", TaxpayerID)

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oHouseTenant As HouseTenant

            Do While dr.Read

                oHouseTenant = New HouseTenant

                With oHouseTenant

                    .HouseID = CInt(dr.GetValue(0))

                    .PlotNumber = CStr(dr.GetValue(1))

                    .FullName = CStr(dr.GetValue(2))

                    .Telephone = CStr(dr.GetValue(3))

                    .Address = CStr(dr.GetValue(4))

                    .Amount = CDec(dr.GetValue(5))
                    .TaxPayerID = CInt(dr("TaxpayerID"))

                End With

                Add(oHouseTenant)

            Loop

            dr.Close()

            cn.Close()

            cn = Nothing

        Catch ex As Exception

            Throw

        End Try

    End Sub

    Public Sub Load(ByVal connection As String, ByVal searchphrase As String)

        Try

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetHouseTenantsByPhrase"
            cmd.Parameters.AddWithValue("@phrase", searchphrase)

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oHouseTenant As HouseTenant

            Do While dr.Read

                oHouseTenant = New HouseTenant

                With oHouseTenant

                    .HouseID = CInt(dr.GetValue(0))

                    .PlotNumber = CStr(dr.GetValue(1))

                    .FullName = CStr(dr.GetValue(2))

                    .Telephone = CStr(dr.GetValue(3))

                    .Address = CStr(dr.GetValue(4))

                    .Amount = CDec(dr.GetValue(5))

                End With

                Add(oHouseTenant)

            Loop

            dr.Close()

            cn.Close()

            cn = Nothing

        Catch ex As Exception

            Throw

        End Try

    End Sub

    Public Sub Load(ByVal connection As String)

        Try

            Dim cn As SqlConnection = New SqlConnection(Connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetHouseTenants"

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oHouseTenant As HouseTenant

            Do While dr.Read

                oHouseTenant = New HouseTenant

                With oHouseTenant

                    .HouseID = CInt(dr.GetValue(0))

                    .PlotNumber = CStr(dr.GetValue(1))

                    .FullName = CStr(dr.GetValue(2))

                    .Telephone = CStr(dr.GetValue(3))

                    .Address = CStr(dr.GetValue(4))

                    .Amount = CDec(dr.GetValue(5))

                End With

                Add(oHouseTenant)

            Loop

            dr.Close()

            cn.Close()

            cn = Nothing

        Catch ex As Exception

            '//MsgBox(ex.Message & vbCrLf & "Procedure - HouseTenants" & System.Reflection.MethodBase.GetCurrentMethod.Name.ToString(), '//MsgBoxStyle.Critical, System.Reflection.MethodBase.GetCurrentMethod.Name.ToString())

        End Try

    End Sub

    Public Sub CopyTo(ByVal array As System.Array, ByVal index As Integer) Implements System.Collections.ICollection.CopyTo

        CopyTo(array, index)

    End Sub

    Public ReadOnly Property Count() As Integer Implements System.Collections.ICollection.Count

        Get

            Return mCol.Count

        End Get

    End Property

    Public Function GetEnumerator() As System.Collections.IEnumerator Implements System.Collections.IEnumerable.GetEnumerator

        Return mCol.GetEnumerator

    End Function

    Public ReadOnly Property IsSynchronized() As Boolean Implements System.Collections.ICollection.IsSynchronized

        Get

            Return True

        End Get

    End Property

    Public ReadOnly Property SyncRoot() As Object Implements System.Collections.ICollection.SyncRoot

        Get

            Return mCol

        End Get

    End Property

    Public Sub Add(ByVal HouseTenant As HouseTenant)

        If Not HouseTenant Is Nothing Then

            mCol.Add(HouseTenant)

        End If

    End Sub

    Public Sub Remove(ByVal HouseTenantId As Integer, ByVal connection As String)

        Dim oHouseTenant As HouseTenant

        Dim i As Integer

        For Each oHouseTenant In Me

            i += 1

            If oHouseTenant.HouseID = HouseTenantId Then

                oHouseTenant.Delete(connection)

                mCol.Remove(i)

                Exit For

            End If

        Next

    End Sub

    Public Sub New()

        mCol = New Collection

    End Sub

    Protected Overrides Sub Finalize()

        MyBase.Finalize()

    End Sub

    Default Public Overloads ReadOnly Property Item(ByVal index As Integer) As HouseTenant

        Get

            Dim p_HouseTenant As HouseTenant = Nothing

            For Each p_HouseTenant In Me

                If p_HouseTenant.HouseID = index Then

                    Exit For

                End If

            Next
            Return p_HouseTenant
        End Get

    End Property

    Default Public Overloads ReadOnly Property Item(ByVal name As String) As HouseTenant

        Get

            Dim p_HouseTenant As HouseTenant = Nothing

            For Each p_HouseTenant In Me

                If p_HouseTenant.FullName = name Then

                    Exit For

                End If

            Next
            Return p_HouseTenant
        End Get

    End Property

End Class

