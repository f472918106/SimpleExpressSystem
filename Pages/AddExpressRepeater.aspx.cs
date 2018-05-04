using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;

public partial class Pages_AddExpressRepeater : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string connString = @"Data Source=DESKTOP-BG6JJLQ;Database=Express;Integrated Security=true";
        SqlConnection conn = new SqlConnection(connString);
        string sqlstr = "select code,title,dorm_id,student_id,sender_id from express";
        SqlCommand comm = new SqlCommand(sqlstr, conn);
        DataSet ds = new DataSet();
        conn.Open();
        SqlDataAdapter da = new SqlDataAdapter(sqlstr, conn);
        conn.Close();
        da.Fill(ds);
        ratTable.DataSource = ds.Tables[0];
        ratTable.DataBind();
    }
}