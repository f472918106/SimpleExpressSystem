<%@ WebHandler Language="C#" Class="UpdateExpressStatus" %>

using System;
using System.Web;

public class UpdateExpressStatus : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        string expressId = context.Request["id"];
        int status = int.Parse(context.Request["status"]);

        try
        {
            ExpressService expressservice = new ExpressService();
            Express express = expressservice.FindExpressById(expressId);
            express.Status = status;
            expressservice.SaveExpress(express);
            JsonResult json = new JsonResult();
            json.Code = 0;
            context.Response.ContentType = "text/json";
            context.Response.Write(json.ToJson());
        }
        catch(Exception e)
        {
            JsonResult json = new JsonResult();
            json.Code = -1;
            json.Message = e.Message;
            context.Response.ContentType = "text/json";
            context.Response.Write(json.ToJson());
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}