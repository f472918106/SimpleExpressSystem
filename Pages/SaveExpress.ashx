<%@ WebHandler Language="C#" Class="SaveExpress" %>

using System;
using System.Web;

public class SaveExpress : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        try
        {
            Express express = new Express();
            ExpressService expressservice = new ExpressService();
            express.Express_Code = context.Request["ExpressCode"];
            express.Express_Title = context.Request["ExpressTitle"];
            express.Student_Id= context.Request["StudentId"];
            express.Sender_Id = context.Request["SenderId"];
            express.Dorm_Id = context.Request["DormId"];
            expressservice.SaveExpress(express);
            context.Response.Redirect("Dispatch.aspx");
        }
        catch (Exception e)
        {
            context.Response.Write(e.Message);
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

} 