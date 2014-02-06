
Imports System.Data.SqlClient

Public Class LandParcels

    Implements ICollection

    Implements IEnumerable

    Private mCol As Collection

    Public Sub Load(ByVal connection As String, ByVal TaxPayerID As Integer)

        Try

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetLandParcelsByTaxPayerID"
            cmd.Parameters.AddWithValue("@TaxPayerID", TaxPayerID)

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oLandParcel As LandParcel

            Do While dr.Read

                oLandParcel = New LandParcel

                With oLandParcel
                    .LandParcelID = CInt(dr.GetValue(0))
                    .TaxPayerID = CInt(dr.GetValue(1))
                    .PlotNumber = CStr(dr.GetValue(2))
                    .Year = CShort(dr.GetValue(3))
                    .StandingLevel = CStr(dr.GetValue(4))
                    .LandTitle = CStr(dr.GetValue(5))
                    .TitleNumber = CStr(dr.GetValue(6))
                    .Usage = CStr(dr.GetValue(7))
                    .NumberOfHouses = CShort(dr.GetValue(8))
                    .ContractNumber = CStr(dr.GetValue(9))
                    .ContractDate = CDate(dr.GetValue(10))
                    .Amount = CDec(dr("Amount"))
                End With

                Add(oLandParcel)

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

            cmd.CommandText = "GetLandParcelsByPhrase"
            cmd.Parameters.AddWithValue("@phrase", searchphrase)

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oLandParcel As LandParcel

            Do While dr.Read

                oLandParcel = New LandParcel

                With oLandParcel
                    .LandParcelID = CInt(dr.GetValue(0))
                    .TaxPayerID = CInt(dr.GetValue(1))
                    .PlotNumber = CStr(dr.GetValue(2))
                    .Year = CShort(dr.GetValue(3))
                    .StandingLevel = CStr(dr.GetValue(4))
                    .LandTitle = CStr(dr.GetValue(5))
                    .TitleNumber = CStr(dr.GetValue(6))
                    .Usage = CStr(dr.GetValue(7))
                    .NumberOfHouses = CShort(dr.GetValue(8))
                    .ContractNumber = CStr(dr.GetValue(9))
                    .ContractDate = CDate(dr.GetValue(10))
                    .Amount = CDec(dr("Amount"))
                End With

                Add(oLandParcel)

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

            cmd.CommandText = "GetLandParcels"

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oLandParcel As LandParcel

            Do While dr.Read

                oLandParcel = New LandParcel

                With oLandParcel

                    .LandParcelID = CInt(dr.GetValue(0))

                    .TaxPayerID = CInt(dr.GetValue(1))

                    .PlotNumber = CStr(dr.GetValue(2))

                    .Year = CShort(dr.GetValue(3))

                    .StandingLevel = CStr(dr.GetValue(4))

                    .LandTitle = CStr(dr.GetValue(5))

                    .TitleNumber = CStr(dr.GetValue(6))

                    .Usage = CStr(dr.GetValue(7))

                    .NumberOfHouses = CShort(dr.GetValue(8))

                    .ContractNumber = CStr(dr.GetValue(9))

                    .ContractDate = CDate(dr.GetValue(10))

                End With

                Add(oLandParcel)

            Loop

            dr.Close()

            cn.Close()

            cn = Nothing

        Catch ex As Exception

            '//MsgBox(ex.Message & vbCrLf & "Procedure - LandParcels" & System.Reflection.MethodBase.GetCurrentMethod.Name.ToString(), '//MsgBoxStyle.Critical, System.Reflection.MethodBase.GetCurrentMethod.Name.ToString())

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

    Public Sub Add(ByVal LandParcel As LandParcel)

        If Not LandParcel Is Nothing Then

            mCol.Add(LandParcel)

        End If

    End Sub

    Public Sub Remove(ByVal LandParcelId As Integer, ByVal connection As String)

        Dim oLandParcel As LandParcel

        Dim i As Integer

        For Each oLandParcel In Me

            i += 1

            If CDbl(oLandParcel.LandParcelID) = LandParcelId Then

                oLandParcel.Delete(connection)

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

    Default Public Overloads ReadOnly Property Item(ByVal index As Integer) As LandParcel

        Get

            Dim p_LandParcel As LandParcel = Nothing

            For Each p_LandParcel In Me

                If CDbl(p_LandParcel.LandParcelID) = index Then

                    Exit For

                End If

            Next
            Return p_LandParcel
        End Get

    End Property

    Default Public Overloads ReadOnly Property Item(ByVal name As String) As LandParcel

        Get

            Dim p_LandParcel As LandParcel = Nothing

            For Each p_LandParcel In Me

                If p_LandParcel.LandTitle = name Then

                    Exit For

                End If

            Next
            Return p_LandParcel
        End Get

    End Property

End Class