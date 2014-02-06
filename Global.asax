<%@ Application Language="VB" %>

<script runat="server">

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application startup
    End Sub
    
    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application shutdown
    End Sub
        
    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when an unhandled error occurs
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a new session is started
        Dim conn As String = ConfigurationManager.ConnectionStrings("TMSConnection").ConnectionString
        Session("connection") = conn
        
        Dim level As String = ConfigurationManager.AppSettings("level")
        Session("level") = level
        
        Dim levelname As String = ConfigurationManager.AppSettings("levelname")
        Session("levelname") = levelname
        
        '//Save the districtid in the settings table if we are the district level
        
        If level = "district" Then
            Dim settings As TMSDAL.Settings = New TMSDAL.Settings
            settings.UpdateDistrict(conn, levelname)
        End If
        
        Session.Timeout = ConfigurationManager.AppSettings("timeout")
       
        Dim dataDirectory As String = AppDomain.CurrentDomain.GetData("DataDirectory").ToString
        Dim languagepath As String = dataDirectory & "\Language.xml"

        Dim labels As New Language.UserInterfaceLabels
        labels.Load(languagepath)
        
        Session.Add("labels", labels)
        
        '//Set default language to English
        Session.Add("language", "en")
        
    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a session ends. 
        ' Note: The Session_End event is raised only when the sessionstate mode
        ' is set to InProc in the Web.config file. If session mode is set to StateServer 
        ' or SQLServer, the event is not raised.
        
    End Sub
       
</script>