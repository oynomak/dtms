Imports System.Data.SqlClient

Public Class Sectors

    Implements ICollection

    Implements IEnumerable

    Private mCol As Collection

    Public Sub Load(ByVal connection As String, ByVal districtID As Short)

        Try

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetSectors"
            cmd.Parameters.AddWithValue("@districtID", districtID)

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oSector As Sector

            Do While dr.Read

                oSector = New Sector

                With oSector

                    .SectorID = CShort(dr.GetValue(0))
                    .DistrictID = CShort(dr.GetValue(1))
                    .SectorName = CStr(dr.GetValue(2))
                    .NumberOfCells = CInt(dr("NumberOfCells"))

                End With

                Add(oSector)

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

            cmd.CommandText = "GetSectors"

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oSector As Sector

            Do While dr.Read

                oSector = New Sector

                With oSector

                    .SectorID = CShort(dr.GetValue(0))

                    .DistrictID = CShort(dr.GetValue(1))

                    .SectorName = CStr(dr.GetValue(2))

                End With

                Add(oSector)

            Loop

            dr.Close()

            cn.Close()

            cn = Nothing

        Catch ex As Exception

            '//MsgBox(ex.Message & vbCrLf & "Procedure - Sectors" & System.Reflection.MethodBase.GetCurrentMethod.Name.ToString(), '//MsgBoxStyle.Critical, System.Reflection.MethodBase.GetCurrentMethod.Name.ToString())

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

    Public Sub Add(ByVal Sector As Sector)

        If Not Sector Is Nothing Then

            mCol.Add(Sector)

        End If

    End Sub

    Public Sub Remove(ByVal SectorId As Integer, ByVal connection As String)

        Dim oSector As Sector

        Dim i As Integer

        For Each oSector In Me

            i += 1

            If oSector.SectorID = SectorID Then

                oSector.Delete(Connection)

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

    Default Public Overloads ReadOnly Property Item(ByVal index As Integer) As Sector

        Get

            Dim p_Sector As Sector = Nothing

            For Each p_Sector In Me

                If p_Sector.SectorID = index Then

                    Exit For

                End If

            Next
            Return p_Sector
        End Get

    End Property

    Default Public Overloads ReadOnly Property Item(ByVal name As String) As Sector

        Get

            Dim p_Sector As Sector = Nothing

            For Each p_Sector In Me

                If p_Sector.SectorName = name Then

                    Exit For

                End If

            Next
            Return p_Sector
        End Get

    End Property

End Class
