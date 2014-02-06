Imports System.Data.SqlClient

Public Class Cells

    Implements ICollection

    Implements IEnumerable

    Private mCol As Collection

    Public Sub Load(ByVal connection As String, ByVal SectorID As Short)

        Try

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetCells"
            cmd.Parameters.AddWithValue("@sectorid", SectorID)

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oCell As Cell

            Do While dr.Read

                oCell = New Cell

                With oCell
                    .CellID = CShort(dr.GetValue(0))
                    .SectorID = CShort(dr.GetValue(1))
                    .CellName = CStr(dr.GetValue(2))
                End With

                Add(oCell)

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

            cmd.CommandText = "GetCells"

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oCell As Cell

            Do While dr.Read

                oCell = New Cell

                With oCell

                    .CellID = CShort(dr.GetValue(0))

                    .SectorID = CShort(dr.GetValue(1))

                    .CellName = CStr(dr.GetValue(2))

                End With

                Add(oCell)

            Loop

            dr.Close()

            cn.Close()

            cn = Nothing

        Catch ex As Exception

            '//MsgBox(ex.Message & vbCrLf & "Procedure - Cells" & System.Reflection.MethodBase.GetCurrentMethod.Name.ToString(), '//MsgBoxStyle.Critical, System.Reflection.MethodBase.GetCurrentMethod.Name.ToString())

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

    Public Sub Add(ByVal Cell As Cell)

        If Not Cell Is Nothing Then

            mCol.Add(Cell)

        End If

    End Sub

    Public Sub Remove(ByVal CellId As Integer, ByVal connection As String)

        Dim oCell As Cell

        Dim i As Integer

        For Each oCell In Me

            i += 1

            If oCell.CellID = CellID Then

                oCell.Delete(Connection)

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

    Default Public Overloads ReadOnly Property Item(ByVal index As Integer) As Cell

        Get

            Dim p_Cell As Cell = Nothing

            For Each p_Cell In Me

                If p_Cell.CellID = index Then

                    Exit For

                End If

            Next
            Return p_Cell
        End Get

    End Property

    Default Public Overloads ReadOnly Property Item(ByVal name As String) As Cell

        Get

            Dim p_Cell As Cell = Nothing

            For Each p_Cell In Me

                If p_Cell.CellName = name Then

                    Exit For

                End If

            Next
            Return p_Cell
        End Get

    End Property

End Class
