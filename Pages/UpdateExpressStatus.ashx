<%@ WebHandler Language="C#" Class="UpdateExpressStatus" %>

using System;
using System.Web;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;

public class UpdateExpressStatus : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        string expressId = context.Request["id"];
        int status = int.Parse(context.Request["status"]);

        SqlHelper helper = null;
        try
        {
            helper = new SqlHelper();
            string sql = "update express set status=@status where id=@id";
            SqlParameter[] p = new SqlParameter[2];
            p[0] = new SqlParameter("@status", status);
            p[1] = new SqlParameter("@id", expressId);
            helper.Save(sql, p);
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
        finally
        {
            if(helper!=null)
            {
                helper.DisConnect();
            }
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}