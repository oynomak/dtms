Imports System.Data.SqlClient

Public Class BankBranches

    Implements ICollection

    Implements IEnumerable

    Private mCol As Collection

    Public Sub Load(ByVal connection As String, ByVal BankID As Byte)

        Try

            Dim cn As SqlConnection = New SqlConnection(connection)

            cn.Open()

            Dim cmd As SqlCommand = cn.CreateCommand()

            cmd.CommandType = CommandType.StoredProcedure

            cmd.CommandText = "GetBankBranches"
            cmd.Parameters.AddWithValue("@ID", BankID)

            cmd.CommandTimeout = 500

            Dim dr As SqlDataReader = cmd.ExecuteReader

            Dim oBankBranche As BankBranch

            Do While dr.Read

                oBankBranche = New BankBranch

                With oBankBranche

                    .BankBranchID = CShort(dr.GetValue(0))

                    .BankID = CByte(dr.GetValue(1))

                    .BankBranchName = CStr(dr.GetValue(2))

                End With

                Add(oBankBranche)

            Loop

            dr.Close()

            cn.Close()

            cn = Nothing

        Catch ex As Exception

            '//MsgBox(ex.Message & vbCrLf & "Procedure - BankBranches" & System.Reflection.MethodBase.GetCurrentMethod.Name.ToString(), '//MsgBoxStyle.Critical, System.Reflection.MethodBase.GetCurrentMethod.Name.ToString())

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

    Public Sub Add(ByVal BankBranche As BankBranch)

        If Not BankBranche Is Nothing Then

            mCol.Add(BankBranche)

        End If

    End Sub

    Public Sub Remove(ByVal BankBrancheId As Integer, ByVal connection As String)

        Dim oBankBranche As BankBranch

        Dim i As Integer

        For Each oBankBranche In Me

            i += 1

            If oBankBranche.BankBranchID = BankBrancheId Then

                oBankBranche.Delete(connection)

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

    Default Public Overloads ReadOnly Property Item(ByVal index As Integer) As BankBranch

        Get

            Dim p_BankBranche As BankBranch = Nothing

            For Each p_BankBranche In Me

                If p_BankBranche.BankBranchID = index Then

                    Exit For

                End If

            Next
            Return p_BankBranche
        End Get

    End Property

    Default Public Overloads ReadOnly Property Item(ByVal name As String) As BankBranch

        Get

            Dim p_BankBranche As BankBranch = Nothing

            For Each p_BankBranche In Me

                If p_BankBranche.BankBranchName = name Then

                    Exit For

                End If

            Next
            Return p_BankBranche
        End Get

    End Property

End Class

