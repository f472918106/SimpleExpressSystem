<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Sender.aspx.cs" Inherits="Pages_Sender" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script type="text/javascript" src="../Scripts/jquery-1.10.2.js"></script>
    <script type="text/javascript">
        $(function () {
            $.ajax({
                url: "SenderHandler.ashx",
                type: "post",
                dataType: "json",
                success: function (json) {
                    if(json.Code == 0)
                    {
                        var s = "";
                        for(var i=0;i<json.Data.length;i++)
                        {
                            s += json.Data[i].Code + " ";
                            s += json.Data[i].Student_Name + " ";
                            s += json.Data[i].Building_Name + " ";
                            s += json.Data[i].Dorm_Name + " ";

                            if(json.Data[i].DelegateTime==null)
                            {
                                s += "未知 ";
                            }
                            else
                            {
                                s += json.Data[i].DelegateTime+" ";
                            }

                            if (json.Data[i].ReceiveTime == null) {
                                s += "未知 ";
                            }
                            else {
                                s += json.Data[i].ReceiveTime + " ";
                            }

                            if(json.Data[i].Status==0)
                            {
                                s += "待投递 ";
                            }
                            else if(json.Data[i].Status==1)
                            {
                                s += "已签收 ";
                            }
                            else
                            {
                                s += "已完成 ";
                            }
                            s += "<br>";
                        }
                        $("#expressList").html(s);
                    }
                    else
                    {
                        alert(json.Message);
                    }
                }
            })
        });

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <b>派送员主页</b>
        <div id="expressList">
            
        </div>
    </div>
    </form>
</body>
</html>
