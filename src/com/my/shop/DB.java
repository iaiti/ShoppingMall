package com.my.shop;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


//此处是单例模式
public class DB  {
		static{
			//初始化 先执行这里的东西
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		//这是单例 一般不new 自己的对象 跟clender很像 getinstance
		//事实证明 不是我的javabean写得错  主要是这里出现问题了 
		public DB(){} //果然 private出现问题  暂时不知道原因
		//不用问了  原来import和usebean 后者是帮你实例出类来了 所以用private时候 当然拿不到 
		//import的话自己要用new来弄出实例
		public static Connection getConn(){
				Connection conn = null;
			try{
				
				conn = DriverManager.getConnection("jdbc:mysql://localhost/shop?user=root&password=sql&useUnicode=true&characterEncoding=utf-8");
			} catch (SQLException e){
				e.printStackTrace();
			}
			
			return conn;
		}
		
		public static PreparedStatement getPst(Connection conn,String sql,boolean generated){
			PreparedStatement pst = null;
			if(conn != null){
				try {
					pst =  conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			return pst;
		}
		
		public static PreparedStatement getPst(Connection conn,String sql){
			PreparedStatement pst = null;
			if(conn != null){
				try {
					pst =  conn.prepareStatement(sql);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			return pst;
		}
		
		public static Statement getSt(Connection conn){
			Statement st = 	null;
			if(conn != null){
				try {
					st = conn.createStatement();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			return st;
		}
		
		public static ResultSet getRs(Statement st,String sql){
			ResultSet rs = null;
			if(st != null){
				try {
					rs = st.executeQuery(sql);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			return rs;
		}
		
		public static ResultSet getRs(Connection c,String sql){
			ResultSet rs = null;
			if(c != null){
				try {
					rs = c.createStatement().executeQuery(sql);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			return rs;
		}
		
		public static void executeUpdate(Connection c,String sql){
			Statement st = null;
			if(c!=null){
				try {
					st = c.createStatement();
					st.executeUpdate(sql);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
		}
		//query是select 用 而updateexecute：
//        用于执行返回多个结果集、多个更新计数或二者组合的语句。也可用于执行 INSERT、UPDATE 或 DELETE 语句。
		public static void executeQuery(Connection c,String sql){
			Statement st = null;
			if(c!=null){
				try {
					st = c.createStatement();
					st.executeQuery(sql);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
		}
		public static void closeC(Connection conn){
			if(conn != null){
				try {
					conn.close();
					conn = null;
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		public static void closeSt(Statement st){
			if(st != null){
				try {
					st.close();
					st = null;
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		public static void closeRs(ResultSet rs){
			if(rs != null){
				try {
					rs.close();
					rs = null;
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		public static void closePst(PreparedStatement pst){
			if(pst != null){
				try {
					pst.close();
					pst = null;
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
	


	
}

