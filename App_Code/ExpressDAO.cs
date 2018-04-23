using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;

/// <summary>
/// ExpressDAO 的摘要说明
/// </summary>
public class ExpressDAO
{
    /// <summary>
    /// 数据访问层定义
    /// 封装对express表的实际数据库操作
    /// 提供更简洁的对外接口
    /// </summary>
    public ExpressDAO()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }

    public List<Express> FindExpress(string condition)
    {
        //根据指定条件，找到对应Express
        //condition为查询条件
        SqlHelper helper = null;
        try
        {
            helper = new SqlHelper();
            string sql = "select e.id,e.code,s.code as student_code, " +
                "s.name,s.id as student_id,b.building_name, " +
                "d.dorm_name, e.delegate_time,e.receive_time,e.status " +
                "from express e " +
                "inner join student s on e.student_id=s.id " +
                "inner join dorm d on e.dorm_id=d.id " +
                "inner join building b on d.building_id=b.id " +
                "inner join sender r on e.sender_id=r.id ";

            if(!string.IsNullOrEmpty(condition))
            {
                //如果查询条件不为空，加上where条件
                sql += " where " + condition;
            }

            //定义一个集合存放返回结果
            List<Express> result = new List<Express>();
            DataTable dt = helper.Query(sql, null);
            foreach (DataRow dr in dt.Rows)
            {
                Express express = new Express();
                express.Id = dr["id"].ToString();
                express.Express_Code = dr["code"].ToString();
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

                result.Add(express);
            }
            return result;
        }
        catch (Exception e)
        {
            throw e;
        }
        finally
        {
            if (helper != null)
            {
                helper.DisConnect();
            }
        }
    }

    public Express FindOne(string id)
    {
        //根据指定id，找到对应Express
    }

    public void Insert(Express express)
    {
        //插入快递信息
    }

    public void Update(Express express)
    {
        //更新快递信息
    }

    public void Delete(string id)
    {
        //删除快递信息
    }

    private Express ToExpress(DataRow dr)
    {
        //转换格式
    }
}