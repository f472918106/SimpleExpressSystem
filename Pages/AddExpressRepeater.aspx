<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddExpressRepeater.aspx.cs" Inherits="Pages_AddExpressRepeater" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form>
    <div>
        <table>
            <tr>
                <th>编号</th>
                <th>名称</th>
                <th>宿舍号</th>
                <th>收件人</th>
                <th>派件人</th>
            </tr>
            <asp:Repeater runat="server" ID="ratTable">
                <ItemTemplate>
                    <tr>
                        <td><%#Eval("code") %></td>
                        <td><%#Eval("title") %></td>
                        <td><%#Eval("dorm_id") %></td>
                        <td><%#Eval("student_id") %></td>
                        <td><%#Eval("sender_id") %></td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </table>
    </div>
    </form>
</body>
</html>
