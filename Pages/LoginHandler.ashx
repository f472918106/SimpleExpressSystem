<%@ WebHandler Language="C#" Class="LoginHandler" %>

using System;
using System.Web;
using System.Data.Sql;  //访问sqlserver必加
using System.Data;  //访问sqlserver必加
using System.Data.SqlClient;    //访问sqlserver必加

public class LoginHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        string username = context.Request["username"];
        //获取请求中指定name对应的html元素的value
        string password = context.Request["password"];
        //获取请求中指定name对应的html元素的value
        try
        {
            SqlHelper helper = new SqlHelper();
            string IfExsistStr = "select * from account where id=@user_name and password=@password";
            SqlParameter[] parameter = new SqlParameter[2];
            parameter[0] = new SqlParameter("@user_name", username);
            parameter[1] = new SqlParameter("@password", password);
            DataTable dt = helper.Query(IfExsistStr,parameter);
            if(dt.Rows.Count>0)
            {
                string role_id = dt.Rows[0]["role_id"].ToString();
                //获取查询结果第1行 role_id列的值
                if(role_id=="2")
                {
                    context.Response.Redirect("Dispatch.aspx");
                    //将url重定向与分拣员页面
                }
                else if(role_id=="3")
                {
                    context.Response.Redirect("Sender.aspx");
                    //将url重定向到派送员页面
                }
                else
                {
                    context.Response.Redirect("Student.aspx");
                    //将url重定向到学生页面
                }
            }
            else
            {
                throw new Exception("用户名或密码错误");
            }
        }
        catch(Exception e)
        {
            context.Response.ContentType = "text/html";
            context.Response.Write("<html><body><script type='text/javascript'>");
            context.Response.Write("alert('" + e.Message + "');");
            context.Response.Write("window.location.href='Login.aspx';");
            context.Response.Write("</script></body></html>");
            context.Response.End();
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