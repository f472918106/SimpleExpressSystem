<%@ WebHandler Language="C#" Class="SenderHandler" %>

using System;
using System.Web;
using System.Data;
using System.Web.Script.Serialization;
using System.Web.SessionState;
using System.Collections.Generic;

public class SenderHandler : IHttpHandler,IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        try
        {
            ExpressService expressservice = new ExpressService();
            string accountId = (String)context.Session["accountId"];
            List<Express> list = expressservice.FindExpress("r.account_id='"+accountId+"'");

            JsonResult result = new JsonResult();
            result.Code = 0;
            result.Data = new List<object>();
            foreach(Express x in list)
            {
                result.Data.Add(x);
            }

            context.Response.ContentType = "text/json";
            context.Response.Write(result.ToJson());
        }
        catch(Exception e)
        {
            JsonResult result = new JsonResult();
            result.Code = 1;//0成功，1失败 
            result.Message = e.Message;
            context.Response.ContentType = "text/json";
            context.Response.Write(result.ToJson());
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}