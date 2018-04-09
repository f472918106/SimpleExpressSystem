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
                        var s = "<table style='width:100%' border='1'>";
                        s += "<tr><td>快递单号</td><td>收件人</td><td>楼号</td><td>宿舍号</td><td>派送时间</td><td>接收时间</td><td>快递状态</td><td>操作</td><tr>";
                        for(var i=0;i<json.Data.length;i++)
                        {
                            s += "<tr>";
                            s += "<td>"+json.Data[i].Code + "</td>";
                            s += "<td>"+json.Data[i].Student_Name + "</td>";
                            s += "<td>" + json.Data[i].Building_Name + "</td>";
                            s += "<td>" + json.Data[i].Dorm_Name + "</td>";

                            if(json.Data[i].DelegateTime==null)
                            {
                                s += "<td>未知</td>";
                            }
                            else
                            {
                                s += "<td>" + json.Data[i].DelegateTime + "</td>";
                            }

                            if (json.Data[i].ReceiveTime == null) {
                                s += "<td>未知</td>";
                            }
                            else {
                                s += "<td>" + json.Data[i].ReceiveTime + "</td>";
                            }

                            if(json.Data[i].Status==0)
                            {
                                s += "<td>待投递</td>";
                            }
                            else if(json.Data[i].Status==1)
                            {
                                s += "<td>已签收</td>";
                            }
                            else
                            {
                                s += "<td>已完成</td>";
                            }
                            s += "<td><input type='button' value='完成' onclick='onclickfinish(\""+json.Data[i].Id+"\");'></td>";
                            s += "</tr>";
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
        
        function onclickfinish(id)
        {
            $.ajax({
                url: "UpdateExpressStatus.ashx",
                type: "post",
                data: {"id":id,"status":2}, //属性名id和status可以用双引号包起来
                success: function (response) {

                }
            });
        }
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
