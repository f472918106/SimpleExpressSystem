<%@ WebHandler Language="C#" Class="SenderHandler" %>

using System;
using System.Web;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;

public class SenderHandler : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        SqlHelper helper = null;
        try
        {
            helper = new SqlHelper();
            DataTable dt = helper.Query("select * from express", null);
            JsonResult result = new JsonResult();
            result.Code = 0;
            foreach(DataRow dr in dt.Rows)
            {
                Express express = new Express();
            }
        }
        catch(Exception e)
        {

        }
        finally
        {

        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}