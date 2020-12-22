import java.sql.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/Minus")
public class Minus extends HttpServlet {
    public Minus() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        try {
            String _name = request.getParameter("name");
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
            String sql = "select quantity from " + table_name + " where name = \"" + _name +"\";";
            ResultSet rs = stmt.executeQuery(sql);
            rs.next();
            int _quantity = rs.getInt(1);
            if(_quantity > 1) {
                _quantity--;
                sql = "update " + table_name + " set quantity = " + _quantity + " where name = \"" + _name + "\";";

            }
            else {
                sql = "delete from " + table_name + " where name = \"" + _name + "\";";

            }
            stmt.executeUpdate(sql);
            stmt.close();
            response.sendRedirect("index.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

