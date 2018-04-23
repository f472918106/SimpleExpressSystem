<%@ WebHandler Language="C#" Class="SaveExpress" %>

using System;
using System.Web;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;

public class SaveExpress : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        SqlHelper helper = null;
        try
        {
            helper = new SqlHelper();
            string ExpressCode = context.Request["ExpressCode"];
            string ExpressTitle = context.Request["ExpressTitle"];
            string StudentId = context.Request["StudentId"];
            string SenderId = context.Request["SenderId"];
            string DormId = context.Request["DormId"];

            string sql = "insert into express (id,code,title,dorm_id,student_id,sender_id,delegate_time,status)" +
                " values(@id,@code,@title,@dorm_id,@student_id,@sender_id,@delegate_time,0)";
            SqlParameter[] p = new SqlParameter[7];
            p[0] = new SqlParameter("@id", Guid.NewGuid().ToString());
            p[1] = new SqlParameter("@code", ExpressCode);
            p[2] = new SqlParameter("@title", ExpressTitle);
            p[3] = new SqlParameter("@dorm_id", DormId);
            p[4] = new SqlParameter("@student_id", StudentId);
            p[5] = new SqlParameter("@sender_id", SenderId);
            p[6] = new SqlParameter("@delegate_time", DateTime.Now);

            helper.Save(sql, p);
            context.Response.Redirect("Dispatch.aspx");
        }
        catch (Exception e)
        {
            context.Response.Write(e.Message);
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