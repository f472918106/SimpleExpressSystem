using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// JsonResult 的摘要说明
/// </summary>
public class JsonResult
{
    public string Code { get; set; }
    public string Message { get; set; }
    public List<object> Data { get; set; }
    public JsonResult()
    {
        Data = new List<object>();
    }
}