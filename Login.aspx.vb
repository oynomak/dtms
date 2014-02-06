Imports ActiveDirectory

Partial Class Login
    Inherits System.Web.UI.Page
    Private authenticatedUser As String = Nothing


    Public Sub Page_Load(ByVal o As Object, ByVal e As EventArgs) Handles Me.Load
        Dim labels As Language.UserInterfaceLabels = Session("labels")
        Dim lang As String = Session("language")
        Me.Form.DefaultFocus = "Button1"
        Username.TabIndex = 0
        Username.Focus()

        LblLogonText.Text = labels.GetLabel(lang, "Login to the Taxpayer Management System")

        PromptText.InnerText = labels.GetLabel(lang, "To use the features provided by this application, you have to log in. Please provide your user name and password")
        LblUserName.Text = labels.GetLabel(lang, "Username")
        LBLPassword.Text = labels.GetLabel(lang, "Password")
        HelpText.InnerText = labels.GetLabel(lang, "If you have problems accessing the system, please contact your system administrator")

    End Sub

    
    'Private Sub CheckCredentials()
    '    If (CheckBox1.Checked) Then '// Use their network credentials 
    '        Dim logonuser As String = Request.ServerVariables("LOGON_USER")
    '        If logonuser.Length = 0 Then '// They haven't provided credentials yet
    '            Response.StatusCode = 401
    '            Response.StatusDescription = "Unauthorized"
    '            Response.End()
    '        Else '// They have provided credentials
    '            authenticatedUser = User
    '        End If
    '    Else '// Use the username and password they provide
    '        If (IsPasswordOK(Username.Text, Password.Text)) Then
    '            authenticatedUser = Username.Text
    '        End If
    '    End If

    'End Sub

    Private Function IsPasswordOK(ByVal username As String, ByVal Password As String) As Boolean
        '//Check the database for the username/password pair
        Dim member As TMSDAL.User = New TMSDAL.User

        member.Load(Session("connection"), username)

        If member.UserID > 0 Then
            If member.Password = Password And member.Status <> 0 Then
                Session("username") = username
                Session("user") = member
                Session("userid") = member.UserID
                Return True
            End If
        End If
    End Function

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles Button1.Click
        Dim labels As Language.UserInterfaceLabels = Session("labels")
        Dim lang As String = Session("language")

        If IsPasswordOK(Username.Text, Password.Text) Then

            Dim uName As String = Username.Text
            FormsAuthentication.SetAuthCookie(uName, False)

            Dim returnUrl As String
            If Me.Request.Cookies("returnUrl") Is Nothing Then
                returnUrl = Me.Request.ApplicationPath
            Else
                returnUrl = Me.Request.Cookies("returnUrl").Value
            End If
            Me.Response.Redirect(returnUrl)
        Else
            LoginError.Text = labels.GetLabel(lang, "Invalid username or bad password. Please try again")
        End If

    End Sub
End Class
