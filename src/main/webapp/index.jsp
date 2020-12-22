<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%--
  Created by IntelliJ IDEA.
  User: zhaoyunxiao
  Date: 2020/12/7
  Time: 7:56 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>WebLab</title>
</head>
<body>
<h4>库存:</h4>
<table>
    <tr>
        <td>商品名称</td>
        <td>库存数量</td>
        <td>增加</td>
        <td>减少</td>
        <td>删除</td>
    </tr>
    <%
        String driver_name = "com.mysql.cj.jdbc.Driver";
        String user_name = "root";
        String password = "fqmzwmhx";
        String db_name = "test";
        String table_name = "stock";

        //url指定要访问的数据库和访问数据库的用户及密码
        String url = "jdbc:mysql://localhost/" + db_name + "?user=" + user_name + "&password=" + password;
        //加载mysql数据库驱动
        Class.forName(driver_name);
        Connection conn = DriverManager.getConnection(url);

        Statement stmt = conn.createStatement();
        String sql = "select * from " + table_name;
        ResultSet rs = stmt.executeQuery(sql);


        while (rs.next()) {
            out.println("<tr>");
            String _name = rs.getString(1);
            String _quantity = rs.getString(2);
            out.println("<td>" + _name + "</td>");
            out.println("<td>" + _quantity + "</td>");
            out.println("<td><form action=\"Add\" method=\"get\" name = \"add"+_name+"\">" +
                    "<input type=\"hidden\" value=\""+_name +"\" name=\"name\">"+
                    "<input type=\"submit\" value=\"+\">" +
                    "</form>"+
                    "</td>");
            out.println("<td><form action=\"Minus\" method=\"get\"name = \"minus"+_name+"\">" +
                    "<input type=\"hidden\" value=\""+_name +"\" name=\"name\">"+
                    "<input type=\"submit\" value=\"-\">" +
                    "</form>"+
                    "</td>");
            out.println("<td><form action=\"Delete\" method=\"get\" name = \"delete"+_name+"\">" +
                    "<input type=\"hidden\" value=\""+_name +"\" name=\"name\">"+
                    "<input type=\"submit\" value=\"x\">" +
                    "</form>"+
                    "</td>");
            out.println("</tr>");
        }

        rs.close();
        conn.close();

    %>
</table>

<h4>新增或修改:</h4>
<form name="input" action="Insert" method="get">
    商品名称: <input type="text" name="name">
    商品数量: <input type="number" name="quantity">
    <input type="submit" value="提交">
</form>
</body>
</html>
