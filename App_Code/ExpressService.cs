using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// ExpressService 的摘要说明
/// </summary>
public class ExpressService
{
    /// <summary>
    /// 业务层
    /// </summary>
    private ExpressDAO expressDAO;
    public ExpressService()
    {
        expressDAO = new ExpressDAO();
    }

    public List<Express> FindExpress(string condition)
    {
        return expressDAO.Find(condition);
    }

    public Express FindExpressById(string id)
    {
        return expressDAO.FindOne(id);
    }

    public void SaveExpress(Express express)
    {
        if(string.IsNullOrEmpty(express.Id))
        {
            expressDAO.Insert(express);
        }
        else
        {
            expressDAO.Update(express);
        }
    }
}