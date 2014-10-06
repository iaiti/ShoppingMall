package com.my.shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


//现在来说的话 这个不是表现层 像session。jsp的用include就将其载入  fulsh为false 就是一边载入内容 一边执行整个页面
//没用bean  而用import 把这些集合起来  任意的jsp页面只需要简单地调用即可

//2013-9-13 13:55:37 现在看  user少了dao的一层 model和dao混在一起了
public class User {
	private int id ;
	private String name;
	private String pw;
	//private int grade;
	private Date rdate;
	private String addr;
	private String phone;
	private String email;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public Date getRdate() {
		return rdate;
	}
	public void setRdate(Date rdate) {
		this.rdate = rdate;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public void savesql() {
		Connection c = DB.getConn();
		String sql = "insert into user values (null,?,?,?,?,?)";
		PreparedStatement ps = DB.getPst(c, sql);
	
		try {
			ps.setString(1,name );
			ps.setString(2, pw);
			ps.setString(3, phone);
			ps.setString(4, addr);
			//gettime 返回long类型 timestamp 构造函数能传 
			ps.setTimestamp(5, new Timestamp(rdate.getTime()));
			ps.executeUpdate();
			DB.closeC(c);
			DB.closePst(ps);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//list的东西忘记  动态数组 把所有的信息put进去 
	public static List<User> showuser() {
		List<User> list = new ArrayList<User>();
		String sql = "select * from user";
		ResultSet rs  = null;
		Connection c = null;
		try {
			c = DB.getConn();
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
	
	//验证用户是否登录
	public static User validate(String name,String pw) throws UserNotFoundException, PasswordWrongException{
		User u = new User();
		//user u = null 错误之处 等于null了不就什么都没有了
		//肯定new一下 user里面才有各成员变量
		//jsp里面调用该方法亦是如此 你只是返回而已 要把它等于 u才有用
		ResultSet rs  = null;
		Connection c = null;
		try {
			String sql = "select * from user where username = '"+name+"'";
			c = DB.getConn();
			rs = DB.getRs(c, sql);
			if(!rs.next()||rs==null){
				//自定义异常 有趣的方法
				throw new UserNotFoundException();
			} else if(!rs.getString("pw").equals(pw)){
				throw new PasswordWrongException();
			} else {
				
					u.setId(rs.getInt("id"));
					u.setName(rs.getString("username"));
					u.setPhone(rs.getString("phone"));
					u.setAddr(rs.getString("addr"));
					u.setRdate(rs.getDate("rdate"));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeRs(rs);
			DB.closeC(c);
		}
		return u;
	}
	
	public void updatesql() {
		Connection c = DB.getConn();
		String sql = "update user set username = ?,  phone = ?, addr = ? where id = "+this.id;
		PreparedStatement ps = DB.getPst(c, sql);
	
		try {
			ps.setString(1,name );
			ps.setString(2, phone);
			ps.setString(3, addr);
			//gettime 返回long类型 timestamp 构造函数能传 
			ps.executeUpdate();
			DB.closeC(c);
			DB.closePst(ps);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
}
