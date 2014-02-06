
Imports System.Data.SqlClient

Public Class TaxPayers

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
            For Each payer As TaxPayer In Me
                If payer.Action = "I" Then
                    If payer.Save(connection, True) = True Then
                        m_inserted += 1
                    End If
                ElseIf payer.Action = "U" Then
                    If payer.Save(connection, False) = True Then
                        m_updated += 1
                    End If
                ElseIf payer.Action = "D" Then
                    If payer.Delete(connection) = True Then
                        m_deleted += 1
                    End If
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

            cmd.CommandText = "GetNewTaxPayers"
            cmd.Parameters.AddWithValue("@lastdate", lastupdate)

            cmd.CommandTimeout = 1000

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oTaxPayer As TaxPayer

            Do While dr.Read

                oTaxPayer = New TaxPayer

                With oTaxPayer

                    .TaxPayerID = CInt(dr.GetValue(0))

                    .CellID = CShort(dr.GetValue(1))

                    .FileNumber = CStr(dr.GetValue(2))

                    .Address = CStr(dr.GetValue(3))

                    .Telephone = CStr(dr.GetValue(4))

                    .Mobile = CStr(dr.GetValue(5))

                    .Profession = CStr(dr.GetValue(6))

                    .DateOfBirth = CDate(dr.GetValue(7))

                    .IDNumber = CStr(dr.GetValue(8))

                    .IDType = CStr(dr.GetValue(9))

                    .TIN = CStr(dr.GetValue(10))

                    .Email = CStr(dr.GetValue(11))

                    .Names = CStr(dr.GetValue(12))
                    .Action = CStr(dr("Action"))

                End With

                Add(oTaxPayer)

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

            cmd.CommandText = "GetTaxPayers"

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oTaxPayer As TaxPayer

            Do While dr.Read

                oTaxPayer = New TaxPayer

                With oTaxPayer

                    .TaxPayerID = CInt(dr.GetValue(0))

                    .CellID = CShort(dr.GetValue(1))

                    .FileNumber = CStr(dr.GetValue(2))

                    .Address = CStr(dr.GetValue(3))

                    .Telephone = CStr(dr.GetValue(4))

                    .Mobile = CStr(dr.GetValue(5))

                    .Profession = CStr(dr.GetValue(6))

                    .DateOfBirth = CDate(dr.GetValue(7))

                    .IDNumber = CStr(dr.GetValue(8))

                    .IDType = CStr(dr.GetValue(9))

                    .TIN = CStr(dr.GetValue(10))

                    .Email = CStr(dr.GetValue(11))

                    .Names = CStr(dr.GetValue(12))

                End With

                Add(oTaxPayer)

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

    Public Sub Add(ByVal TaxPayer As TaxPayer)

        If Not TaxPayer Is Nothing Then

            mCol.Add(TaxPayer)

        End If

    End Sub

    Public Sub Remove(ByVal TaxPayerId As Integer, ByVal connection As String)

        Dim oTaxPayer As TaxPayer

        Dim i As Integer

        For Each oTaxPayer In Me

            i += 1

            If oTaxPayer.TaxPayerID = TaxPayerID Then

                oTaxPayer.Delete(Connection)

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

    Default Public Overloads ReadOnly Property Item(ByVal index As Integer) As TaxPayer

        Get

            Dim p_TaxPayer As TaxPayer = Nothing

            For Each p_TaxPayer In Me

                If p_TaxPayer.TaxPayerID = index Then

                    Exit For
                End If

            Next

            Return p_TaxPayer

        End Get

    End Property

    Default Public Overloads ReadOnly Property Item(ByVal name As String) As TaxPayer

        Get

            Dim p_TaxPayer As TaxPayer = Nothing

            For Each p_TaxPayer In Me

                If p_TaxPayer.Names = name Then

                    Exit For
                End If

            Next

            Return p_TaxPayer

        End Get

    End Property

    
End Class


