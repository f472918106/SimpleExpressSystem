<%@ WebHandler Language="C#" Class="StudentHandler" %>

using System;
using System.Web;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class StudentHandler : IHttpHandler,IRequiresSessionState{

    public void ProcessRequest (HttpContext context) {
       SqlHelper helper = null;
        try
        {
            helper = new SqlHelper();
            string accountId = (String)context.Session["accountId"];
            string sql = "select e.id,e.code,s.code as student_code, "+
                "s.name,s.id as student_id,b.building_name, "+
                "d.dorm_name, e.delegate_time,e.receive_time,e.status "+
                "from express e "+
                "inner join student s on e.student_id=s.id "+
                "inner join dorm d on e.dorm_id=d.id "+
                "inner join building b on d.building_id=b.id "+
                "inner join sender r on e.sender_id=r.id "+
                "where s.account_id='"+accountId+"'";
            DataTable dt = helper.Query(sql, null);
            JsonResult result = new JsonResult();
            result.Code = 0;
            foreach(DataRow dr in dt.Rows)
            {
                Express express = new Express();
                express.Id = dr["id"].ToString();
                express.Code = dr["code"].ToString();
                express.Student_Code = dr["student_code"].ToString();
                express.Student_Name = dr["name"].ToString();
                express.Student_Id = dr["student_id"].ToString();
                express.Building_Name = dr["building_name"].ToString();
                express.Dorm_Name = dr["dorm_name"].ToString();

                if (dr["delegate_time"] == DBNull.Value)
                    express.DelegateTime = null;
                else
                    express.DelegateTime = DateTime.Parse(dr["delegate_time"].ToString());

                if (dr["receive_time"] == DBNull.Value)
                    express.ReceiveTime = null;
                else
                    express.ReceiveTime = DateTime.Parse(dr["receive_time"].ToString());

                express.Status = int.Parse(dr["status"].ToString());

                result.Data.Add(express);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            // 将result对象转换为json字符串
            string json = js.Serialize(result);
            context.Response.ContentType = "text/json";
            context.Response.Write(json);
        }
        catch(Exception e)
        {
            JsonResult result = new JsonResult();
            result.Code = 0;//0成功，1失败 
            result.Message = e.Message;
            JavaScriptSerializer js = new JavaScriptSerializer();
            string json = js.Serialize(result);
            context.Response.ContentType = "text/json";
            context.Response.Write(json);
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