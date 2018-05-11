<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ModifyExpress.aspx.cs" Inherits="Pages_ModifyExpress" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script type="text/javascript" src="../Scripts/jquery-1.10.2.js"></script>
    <script type="text/javascript">
        function LoadBuildings() {
            $.ajax({
                url: "GetBuilding.ashx",
                type: "POST",
                dataType: "json",
                success: function (response) {
                    if(response.Code==0)
                    {
                        var s = "";
                        for(var i=0;i<response.Data.length;i++)
                        {
                            s += "<option value='"+response.Data[i].Id+"'>"+response.Data[i].BuildingName+"</option>";
                        }
                        $("#BuildingId").html(s);
                        LoadDorms();
                    }
                    else
                    {
                        alert(response.Message);
                    }
                }
            });
        }

        function LoadSender() {
            $.ajax({
                url: "GetSender.ashx",
                type: "POST",
                dataType: "json",
                success: function (response) {
                    if (response.Code == 0) {
                        var s = "";
                        for (var i = 0; i < response.Data.length; i++) {
                            s += "<option value='" + response.Data[i].Id + "'>" + response.Data[i].SenderName + "</option>";
                        }
                        $("#SenderId").html(s);
                    }
                    else {
                        alert(response.Message);
                    }
                }
            });
        }

        function LoadDorms() {
            //级联，列出指定宿舍楼全部宿舍
            var buildingId = $("#BuildingId").val();
            if(buildingId==null||buildingId=="")
            {
                alert("宿舍楼号为空");
                return;
            }
            $.ajax({
                url: "GetDorm.ashx",
                type: "POST",
                dataType: "json",
                data: {"buildingId":buildingId},
                success: function (response) {
                    if (response.Code == 0) {
                        var s = "";
                        for (var i = 0; i < response.Data.length; i++) {
                            s += "<option value='" + response.Data[i].Id + "'>" + response.Data[i].DormName + "</option>";
                        }
                        $("#DormId").html(s);
                        LoadStudents();
                    }
                    else {
                        alert(response.Message);
                    }
                }
            });
        }

        function LoadStudents() {
            var dormId = $("#DormId").val();
            if(dormId==null||dormId=="")
            {
                alert("宿舍号为空");
                return;
            }
            $.ajax({
                url: "GetStudent.ashx",
                type: "POST",
                dataType: "json",
                data: { "dormId": dormId },
                success: function (response) {
                    if (response.Code == 0) {
                        var s = "";
                        for (var i = 0; i < response.Data.length; i++) {
                            s += "<option value='" + response.Data[i].Id + "'>" + response.Data[i].StudentName + "</option>";
                        }
                        $("#StudentId").html(s);
                    }
                    else
                    {
                        alert(response.Message);
                    }
                }
            });
        }

        function OnBuildingChanged() {
            LoadDorms();
        }

        function OnDormChanged() {
            LoadStudents();
        }

        $(function () {
            LoadBuildings();
            LoadSender();
        });
    </script>
</head>
<body>
    <form id="form1" action="SaveExpress.ashx" method="post">
    <div>
        <input type="hidden" name="ExpressId" id="ExpressId" value="<%= CurrentExpress.Id %>" />
        <p>
            编号<input style="width:150px" type="text" id="ExpressCode" name="ExpressCode" value="<%= CurrentExpress.Express_Code %>" />
        </p>
        <p>
            名称<input style="width:150px" type="text" id="ExpressTitle" name="ExpressTitle" value="<%= CurrentExpress.Express_Title %>" />
        </p>
        <p>
            楼号<select style="width:150px" id="BuildingId" name="BuildingId" onchange="OnBuildingChanged();"></select>
        </p>
        <p>
            宿舍号<select style="width:150px" id="DormId" name="DormId" onchange="OnDormChanged();"></select>
        </p>
        <p>
            收件人<select style="width:150px" id="StudentId" name="StudentId"></select>
        </p>
        <p>
            派件人<select style="width:150px" id="SenderId" name="SenderId"></select>
        </p>
        <p>
            <input type="submit" name="submit" value="提交" />
        </p>
    </div>
    </form>
</body>
</html>
