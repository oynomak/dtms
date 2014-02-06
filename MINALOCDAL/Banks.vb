Imports System.Data.SqlClient

Public Class Banks

    Implements ICollection

    Implements IEnumerable

    Private mCol As Collection

    Public Sub Load(ByVal connection As String)

        Try

            Dim cn As SqlConnection = New SqlConnection(Connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetBanks"

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oBank As Bank

            Do While dr.Read

                oBank = New Bank

                With oBank

                    .BankID = CByte(dr.GetValue(0))

                    .BankName = CStr(dr.GetValue(1))

                    .DistrictID = CShort(dr.GetValue(2))

                End With

                Add(oBank)

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

    Public Sub Add(ByVal Bank As Bank)

        If Not Bank Is Nothing Then

            mCol.Add(Bank)

        End If

    End Sub

    Public Sub Remove(ByVal BankId As Integer, ByVal connection As String)

        Dim oBank As Bank

        Dim i As Integer

        For Each oBank In Me

            i += 1

            If oBank.BankID = BankID Then

                oBank.Delete(Connection)

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

    Default Public Overloads ReadOnly Property Item(ByVal index As Integer) As Bank

        Get

            Dim p_Bank As Bank = Nothing

            For Each p_Bank In Me

                If p_Bank.BankID = index Then

                    Exit For
                End If

            Next

            Return p_Bank

        End Get

    End Property

    Default Public Overloads ReadOnly Property Item(ByVal name As String) As Bank

        Get

            Dim p_Bank As Bank = Nothing

            For Each p_Bank In Me

                If p_Bank.BankName = name Then

                    Exit For
                End If

            Next

            Return p_Bank

        End Get

    End Property

End Class


