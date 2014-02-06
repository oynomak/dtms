Imports System.Data.SqlClient

Public Class Businesses

    Implements ICollection

    Implements IEnumerable

    Private mCol As Collection
    Private m_deleted As Integer
    Private m_inserted As Integer
    Private m_updated As Integer

    Public ReadOnly Property Deleted() As Integer
        Get
            Return m_deleted
        End Get
    End Property

    Public ReadOnly Property Updated() As Integer
        Get
            Return m_updated
        End Get
    End Property

    Public ReadOnly Property Inserted() As Integer
        Get
            Return m_inserted
        End Get
    End Property

    Public Sub UpdateLocalServer(ByVal connection As String)
        Try
            '//Insert,update,delete the taxpayers to the MINALOC server
            For Each payer As Business In Me
                If payer.Action = "I" Then
                    payer.Save(connection, True)
                    m_inserted += 1
                ElseIf payer.Action = "U" Then
                    payer.Save(connection, False)
                    m_updated += 1
                ElseIf payer.Action = "D" Then
                    payer.Delete(connection)
                    m_deleted += 1
                End If
            Next
        Catch ex As Exception
            Throw
        End Try
    End Sub

    Public Sub LoadFromDistrict(ByVal connection As String, ByVal lastupdate As Date)

        Try

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetNewBusinesses"
            cmd.Parameters.AddWithValue("@lastdate", lastupdate)

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

                    .TaxPayerID = CInt(dr.GetValue(7))

                    .CellID = CShort(dr.GetValue(8))
                    .Action = CStr(dr("Action"))
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

            Dim cn As SqlConnection = New SqlConnection(Connection)

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

                    .TaxPayerID = CInt(dr.GetValue(7))

                    .CellID = CShort(dr.GetValue(8))

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


