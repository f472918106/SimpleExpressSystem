using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Express 的摘要说明
/// </summary>
public class Express
{
    public string Id { get; set; }
    public string Express_Code { get; set; }//Express_Code
    public string Express_Title { get; set; }
    public string Student_Code { get; set; }
    public string Student_Name { get; set; }
    public string Student_Id { get; set; }
    public string Building_Name { get; set; }
    public string Dorm_Name { get; set; }
    public DateTime? ReceiveTime { get; set; }
    public DateTime? DelegateTime { get; set; }
    public int Status { get; set; }
    public Express()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }
}