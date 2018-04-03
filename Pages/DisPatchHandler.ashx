<%@ WebHandler Language="C#" Class="DisPatchHandler" %>

using System;
using System.Web;

public class DisPatchHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Write("Hello World");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}