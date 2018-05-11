﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_ModifyExpress : System.Web.UI.Page
{
    public Express CurrentExpress { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {
        ExpressService expressservice = new ExpressService();
        if (!IsPostBack)
        {
            string id = Request["id"];
            CurrentExpress = expressservice.FindExpressById(id);
        }

    }
}