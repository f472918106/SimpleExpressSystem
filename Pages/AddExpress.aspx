<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddExpress.aspx.cs" Inherits="Pages_AddExpress" %>

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
                    }
                    else
                    {
                        alert(response.Message);
                    }
                }
            });
        }
        $(function () {
            LoadBuildings();
        });
    </script>
</head>
<body>
    <form id="form1">
    <div>
        <p>
            编号<input style="width:150px" type="text" id="ExpressCode" name="ExpressCode" value="" />
        </p>
        <p>
            名称<input style="width:150px" type="text" id="ExpressTitle" name="ExpressTitle" value="" />
        </p>
        <p>
            楼号<select style="width:150px" id="BuildingId" name="BuildingId"></select>
        </p>
        <p>
            宿舍号<select style="width:150px" id="DormId" name="DormId"></select>
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
