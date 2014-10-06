package com.my.shop;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UserManager {
	public static List<User> showuser() {
		List<User> list = new ArrayList<User>();
		String sql = "select * from user";
		ResultSet rs  = null;
		Connection c = DB.getConn();
		try {
			
			rs = DB.getRs(c, sql);
			while(rs.next()){
				User user  = new User();
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("username"));
				user.setPhone(rs.getString("phone"));
				user.setAddr(rs.getString("addr"));
				user.setRdate(rs.getDate("rdate"));
				list.add(user);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DB.closeRs(rs);
			DB.closeC(c);
		}
		return list;
	}
	
	public static void deleteuser(int id ) {
		List<User> list = new ArrayList<User>();
		String sql = "delete from user where id ="+id;
		Connection c = DB.getConn();
		Statement st = DB.getSt(c);
		try {
			st.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeSt(st);
			DB.closeC(c);
			
		}
		
	}
	
	public static void userExist(String u,String p) {
		String sql = "select * from user";
		ResultSet rs  = null;
		Connection c = DB.getConn();
		try {
			
			rs = DB.getRs(c, sql);
			while(rs.next()){
				User user  = new User();
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("username"));
				user.setPhone(rs.getString("phone"));
				user.setAddr(rs.getString("addr"));
				user.setRdate(rs.getDate("rdate"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DB.closeRs(rs);
			DB.closeC(c);
		}
	}
}
