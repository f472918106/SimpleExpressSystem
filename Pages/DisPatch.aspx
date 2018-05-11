<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DisPatch.aspx.cs" Inherits="Pages_DisPatch" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style type="text/css">
        table{
            border-collapse:collapse
        }
        td,th{
            border: 1px solid #a19898
        }
    </style>
    <script type="text/javascript" src="../Scripts/jquery-1.10.2.js"></script>
    <script type="text/javascript">
        function load() {
            $.ajax({
                url: "GetExpress.ashx",
                type: "post",
                dataType: "json",
                success: function (json) {
                    if (json.Code == 0) {
                        var s = "<table width='100%'>";
                        s += "<tr><td>快递单号</td><td>收件人</td><td>楼号</td><td>宿舍号</td><td>派送时间</td><td>接收时间</td><td>快递状态</td><td>操作</td><tr>";
                        for (var i = 0; i < json.Data.length; i++) {
                            s += "<tr>";
                            s += "<td>" + json.Data[i].Express_Code + "</td>";
                            s += "<td>" + json.Data[i].Student_Name + "</td>";
                            s += "<td>" + json.Data[i].Building_Name + "</td>";
                            s += "<td>" + json.Data[i].Dorm_Name + "</td>";

                            if (json.Data[i].DelegateTime == null) {
                                s += "<td>未知</td>";
                            }
                            else {
                                //时间显示问题？已解决
                                var date = new Date(parseInt(json.Data[i].DelegateTime.replace("/Date(", "").replace(")/", ""), 10));
                                var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
                                var currentDate = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
                                s += "<td>" + date.getFullYear() + "-" + month + "-" + currentDate + "</td>";
                            }

                            if (json.Data[i].ReceiveTime == null) {
                                s += "<td>未知</td>";
                            }
                            else {
                                //时间显示问题？已解决
                                var date = new Date(parseInt(json.Data[i].ReceiveTime.replace("/Date(", "").replace(")/", ""), 10));
                                var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
                                var currentDate = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
                                s += "<td>" + date.getFullYear() + "-" + month + "-" + currentDate + "</td>";
                            }

                            if (json.Data[i].Status == 0) {
                                s += "<td>待投递</td>";
                            }
                            else if (json.Data[i].Status == 1) {
                                s += "<td>已签收</td>";
                            }
                            else {
                                s += "<td>已完成</td>";
                            }
                            s += "<td><a href='ModifyExpress.aspx?id="+json.Data[i].Id+"'>修改</a></td>";
                            s += "</tr>";
                        }
                        $("#expressList").html(s);
                    }
                    else {
                        alert(json.Message);
                    }
                }
            })
        }
        $(function () {
            $.ajax({
                url: "GetExpress.ashx",
                type: "post",
                dataType: "json",
                success: function (json) {
                    if(json.Code == 0)
                    {
                        var s = "<table width='100%'>";
                        s += "<tr><td>快递单号</td><td>收件人</td><td>楼号</td><td>宿舍号</td><td>派送时间</td><td>接收时间</td><td>快递状态</td><td>操作</td><tr>";
                        for(var i=0;i<json.Data.length;i++)
                        {
                            s += "<tr>";
                            s += "<td>"+json.Data[i].Express_Code + "</td>";
                            s += "<td>"+json.Data[i].Student_Name + "</td>";
                            s += "<td>" + json.Data[i].Building_Name + "</td>";
                            s += "<td>" + json.Data[i].Dorm_Name + "</td>";

                            if(json.Data[i].DelegateTime==null)
                            {
                                s += "<td>未知</td>";
                            }
                            else
                            {
                                //时间显示问题？已解决
                                var date = new Date(parseInt(json.Data[i].DelegateTime.replace("/Date(","").replace(")/",""), 10));
                                var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
                                var currentDate = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
                                s += "<td>" + date.getFullYear() + "-" + month + "-" + currentDate + "</td>";
                            }

                            if (json.Data[i].ReceiveTime == null) {
                                s += "<td>未知</td>";
                            }
                            else {
                                //时间显示问题？已解决
                                var date = new Date(parseInt(json.Data[i].ReceiveTime.replace("/Date(", "").replace(")/", ""), 10));
                                var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
                                var currentDate = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
                                s += "<td>" + date.getFullYear() + "-" + month + "-" + currentDate + "</td>";
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
                            s += "<td><a href='ModifyExpress.aspx?id=" + json.Data[i].Id + "'>修改</a></td>";
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
        
        /*
        function onclickfinish(id)
        {
            $.ajax({
                url: "UpdateExpressStatus.ashx",
                type: "post",
                data: {"id":id,"status":2}, //属性名id和status可以用双引号包起来
                success: function (response) {
                    if(response.Code==0)
                    {
                        alert("修改成功");
                        load();
                    }
                    else
                    {
                        alert(response.Message);
                    }
                }
            });
        }
        */
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <b>分拣员主页</b>
        <div>
            <a href="AddExpress.aspx">添加快递</a>
        </div>
        <div id="expressList">
            
        </div>
    </div>
    </form>
</body>
</html>
