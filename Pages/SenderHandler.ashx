<%@ WebHandler Language="C#" Class="SenderHandler" %>

using System;
using System.Web;

public class SenderHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}