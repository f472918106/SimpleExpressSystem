<%@ WebHandler Language="C#" Class="GetSender" %>

using System;
using System.Web;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Web.Script.Serialization;

public class GetSender : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        SqlHelper helper = null;
        try
        {
            helper = new SqlHelper();
            string sql = "select * from sender";
            DataTable dt = helper.Query(sql, null);
            JsonResult result = new JsonResult();
            result.Code = 0;
            foreach(DataRow dr in dt.Rows)
            {
                Sender sender = new Sender();
                sender.Id = dr["id"].ToString();
                sender.SenderName = dr["sender_name"].ToString();
                result.Data.Add(sender);
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