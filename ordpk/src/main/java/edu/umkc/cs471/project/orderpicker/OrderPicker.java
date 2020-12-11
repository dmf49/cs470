package edu.umkc.cs471.project.orderpicker;



import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

public class OrderPicker {
    public static void main(String[] args) {
        OrderPicker main = new OrderPicker();
        String product_name = args[0];
        try {
            main.run(product_name);
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }

	private void run(String productName) {
		System.out.println("Product name searching for:: " + productName);
		
		
		
		
		Connection connection = null;
		ResultSet resultSet = null;
		String sql = "select a.assigned, a.store_num, c.tote_num, e.name, count(e.name) as CNT from assignment a, assignment_contains_tote b, tote c, tote_has_product d, product_type e "
				+ "where " + "a.assignment_id = b.assignment_id and " + "b.tote_id = c.tote_id and "
				+ "c.tote_id = d.tote_id and " + "d.product_id = e.product_id " + "and e.name = ? "
				+ "group by e.name , c.tote_num";
			
		Properties prop = null;
			
	        try (InputStream input = OrderPicker.class.getClassLoader().getResourceAsStream("db.properties")) 
	        {

	            prop = new Properties();

	            if (input == null) {
	                System.out.println("Sorry, unable to find config.properties");
	                return;
	            }

	            //load a properties file from class path, inside static method
	            prop.load(input);

	            //get the property value and print it out
	            System.out.println(prop.getProperty("datasource.url"));
	            System.out.println(prop.getProperty("datasource.user"));
	            System.out.println(prop.getProperty("datasource.password"));

	        } 
	        catch (IOException ex) {
	            ex.printStackTrace();
	        }
	
	

	        try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			//String mysqlConnServ = "database-1.c4n8mwgsa6gv.ap-northeast-2.rds.amazonaws.com";
			connection = DriverManager.getConnection(prop.getProperty("datasource.url")+ "user="+ prop.getProperty("datasource.user") + "&password=" + prop.getProperty("datasource.password"));
			
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, productName);
		    resultSet = ps.executeQuery();

			System.out.println("Searching the product, store_num, and tote number...." );

			while (resultSet.next()) {
				int storeNum = resultSet.getInt("store_num");
				int toteNum = resultSet.getInt("tote_num");
				int count = resultSet.getInt("CNT");
				Boolean assigned = resultSet.getBoolean("assigned");

				System.out.println("storeNum = " + storeNum + " tote Number=" + toteNum + ", count =  " + count + ", is assigned = " + assigned.booleanValue());
			}
		} catch (ClassNotFoundException cle) {
			cle.printStackTrace();
		} catch (SQLException sqle) {
			sqle.printStackTrace();
		} finally {
			if ( resultSet != null )
			{
				try {
					resultSet.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			if (connection != null) {
				try {
					connection.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

	}
}