Imports System.Data.SqlClient

Public Class Businesses

    Implements ICollection

    Implements IEnumerable

    Private mCol As Collection

    Public Sub Load(ByVal connection As String, ByVal TaxPayerID As Integer)

        Try

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetBusinessesByTaxpayerID"
            cmd.Parameters.AddWithValue("@TaxPayerID", TaxPayerID)

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oBusinesse As Business

            Do While dr.Read

                oBusinesse = New Business

                With oBusinesse
                    .BusinessID = CInt(dr.GetValue(0))
                    .PlotNumber = CStr(dr.GetValue(1))
                    .BusinessName = CStr(dr.GetValue(2))
                    .Profession = CStr(dr.GetValue(3))
                    .StartDate = CDate(dr.GetValue(4))
                    .Amount = CDec(dr.GetValue(5))
                    .Address = CStr(dr.GetValue(6))
                    .TaxPayerID = CInt(dr("TaxpayerID"))
                End With

                Add(oBusinesse)

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

            cmd.CommandText = "GetBusinessesByPhrase"
            cmd.Parameters.AddWithValue("@phrase", searchphrase)

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oBusinesse As Business

            Do While dr.Read

                oBusinesse = New Business

                With oBusinesse
                    .BusinessID = CInt(dr.GetValue(0))
                    .PlotNumber = CStr(dr.GetValue(1))
                    .BusinessName = CStr(dr.GetValue(2))
                    .Profession = CStr(dr.GetValue(3))
                    .StartDate = CDate(dr.GetValue(4))
                    .Amount = CDec(dr.GetValue(5))
                    .Address = CStr(dr.GetValue(6))
                End With

                Add(oBusinesse)

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

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetBusinesses"

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oBusinesse As Business

            Do While dr.Read

                oBusinesse = New Business

                With oBusinesse

                    .BusinessID = CInt(dr.GetValue(0))

                    .PlotNumber = CStr(dr.GetValue(1))

                    .BusinessName = CStr(dr.GetValue(2))

                    .Profession = CStr(dr.GetValue(3))

                    .StartDate = CDate(dr.GetValue(4))

                    .Amount = CDec(dr.GetValue(5))

                    .Address = CStr(dr.GetValue(6))

                End With

                Add(oBusinesse)

            Loop

            dr.Close()

            cn.Close()

            cn = Nothing

        Catch ex As Exception

            '//MsgBox(ex.Message & vbCrLf & "Procedure - Businesses" & System.Reflection.MethodBase.GetCurrentMethod.Name.ToString(), '//MsgBoxStyle.Critical, System.Reflection.MethodBase.GetCurrentMethod.Name.ToString())

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

    Public Sub Add(ByVal Business As Business)

        If Not Business Is Nothing Then

            mCol.Add(Business)

        End If

    End Sub

    Public Sub Remove(ByVal BusinesseId As Integer, ByVal connection As String)

        Dim oBusinesse As Business

        Dim i As Integer

        For Each oBusinesse In Me

            i += 1

            If oBusinesse.BusinessID = BusinesseId Then

                oBusinesse.Delete(connection)

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

    Default Public Overloads ReadOnly Property Item(ByVal index As Integer) As Business

        Get

            Dim p_Businesse As Business = Nothing

            For Each p_Businesse In Me

                If p_Businesse.BusinessID = index Then

                    Exit For

                End If

            Next
            Return p_Businesse
        End Get

    End Property

    Default Public Overloads ReadOnly Property Item(ByVal name As String) As Business

        Get

            Dim p_Businesse As Business = Nothing

            For Each p_Businesse In Me

                If p_Businesse.BusinessName = name Then

                    Exit For

                End If

            Next
            Return p_Businesse
        End Get

    End Property

End Class

