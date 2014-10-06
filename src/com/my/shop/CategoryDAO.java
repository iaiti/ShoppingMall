package com.my.shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
	//静态方法  static void 一段时间没看忘了 和void 的区别 
	//数据库与实体类分开 便于后期变更 只需操作此处 就行了 如果数据库 更换  那就好很多了
	public static void save(Category c) {
		Connection con = null;
		String sql = "";
		PreparedStatement ps =null;
		try {
			con = DB.getConn();
			if(c.getId()==-1){
				 sql = "insert into category values (null,?,?,?,?,?)";
			} else {
				sql = "insert into category values ("+c.getId()+",?,?,?,?,?)";
			}
			ps = DB.getPst(con, sql);
			ps.setInt(1, c.pid);
			ps.setString(2, c.name);
			ps.setString(3, c.descr);
			ps.setInt(4, c.isLeaf() ? 0 : 1);
			ps.setInt(5, c.grade);
			//gettime 返回long类型 timestamp 构造函数能传 
			ps.executeUpdate();
			DB.closeC(con);
			DB.closePst(ps);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void getCList(List<Category> l,int id){
		String sql = "";
		ResultSet rs  = null;
		Connection con = null;
		try{
			con = DB.getConn();
			getCList(con,l, id);
		} finally {
			DB.closeC(con);
		}
	}
	
	public static void getCList(Connection con,List<Category> l,int id){
		String sql = "";
		ResultSet rs  = null;
		try {
			con = DB.getConn();
			sql = "select * from category where pid = "+id;
			rs = DB.getRs(con, sql);
			while(rs.next()){
				Category c = new Category();
				//这步有了经验  所以知道哪里有错 一旦getindex的名字拿错的话  整个都显示不了所以要注意
				c.setPid(rs.getInt("pid"));
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				c.setDescr(rs.getString("descr"));
				c.setLeaf(rs.getInt("isleaf")==0 ? true:false);
				c.setGrade(rs.getInt("grade"));
				l.add(c);
				//我没写这个  我直接 select全部元素  但想想 后面页面要显示单独的一个类别 还是 把id穿进去好
				//但此处巨大问题  每次循环都connection  这个肯定卡死！
				//传 0  因为所有的 父类pid为 0  再递归调用 方法
				if(!c.isLeaf()){
					c.getCList(l,c.getId());
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DB.closeRs(rs);
		}
	}
	

	public static void addChild(int pid, String name, String descr) {
		// TODO Auto-generated method stub
		//首先 将像save一样存入数据库
		//改叶子节点
		Connection con = null;
		ResultSet rs = null;
		String sql = "insert into category values (null,?,?,?,?,?)";
		String sql2 = "select * from category where id="+pid;
		PreparedStatement ps = null;
		try {
			//昨晚问题  con没拿到就先rs 所以报了空指针错误 接下来的问题 rs如果没有next rs。getInt就是null 光标没有移动
			con = DB.getConn();
			con.setAutoCommit(false);
			rs = DB.getRs(con,sql2);
			rs.next();
			int grade = rs.getInt("grade");
			ps = DB.getPst(con, sql);
			ps.setInt(1, pid);
			ps.setString(2, name);
			ps.setString(3, descr);
			ps.setInt(4, 0);
			ps.setInt(5, grade+1);
			//ps.setInt(5, 2);
			ps.executeUpdate();
			DB.executeUpdate(con, "update category set isleaf = 1 where id ="+pid );
			con.commit();
			con.setAutoCommit(true);
			//gettime 返回long类型 timestamp 构造函数能传 
			
		} catch (SQLException e) {
			try {
				//出错则 撤销更改
				con.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeRs(rs);
			DB.closePst(ps);
			DB.closeC(con);
		}
	}
	
	public static Category getById(int id ){
		Category c = null;
		String sql = "";
		ResultSet rs  = null;
		Connection con = null;
		try {
			con = DB.getConn();
			sql = "select * from category where id = "+id;
			rs = DB.getRs(con, sql);
			while(rs.next()){
				c = new Category();
				//这步有了经验  所以知道哪里有错 一旦getindex的名字拿错的话  整个都显示不了所以要注意
				c.setPid(rs.getInt("pid"));
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				c.setDescr(rs.getString("descr"));
				c.setLeaf(rs.getInt("isleaf")==0 ? true:false);
				c.setGrade(rs.getInt("grade"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DB.closeRs(rs);
			DB.closeC(con);
		}
		return c;
	}
	//自己想到 其实delete之后还有一点没做到的地方 如果子类全被删了 那么原来的非叶子节点应该变成叶子节点
	//所以比原来的多传了一个id参数进去  找他的父类节点
	public static void delete(int pid,int id) {
		Connection con = null;
		ResultSet rs = null;
		int i = 0;
		//递归  其实方法没错 只是拿的时候先看有谁以该id为pid 先删除子类
		String sql = "select * from category where pid = "+ pid;
		String dsql = "delete from category where id = "+ id;
		con = DB.getConn();
		rs = DB.getRs(con, sql);
		try {
			if(pid!=0){
			while(rs.next()){
				delete(rs.getInt("id"),id);
				}
			}
			
				DB.executeUpdate(con, dsql);
			DB.executeUpdate(con, "update category set isleaf = 0 where id ="+id );
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//都说注意 update 和query 两者  记住
		
		
	}

	public static boolean idisleaf() {
		// TODO Auto-generated method stub
		Category c = new Category();
		if(c.isLeaf()){
			return true;
		} 
		return false;
	}

	public static List<Category> getCList() {
		List<Category> l  = new ArrayList<Category>();
		String sql = "";
		ResultSet rs  = null;
		Connection con = null;
		try {
			con = DB.getConn();
			sql = "select * from category" ;
			rs = DB.getRs(con, sql);
			while(rs.next()){
				Category c = new Category();
				//这步有了经验  所以知道哪里有错 一旦getindex的名字拿错的话  整个都显示不了所以要注意
				c.setPid(rs.getInt("pid"));
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				c.setDescr(rs.getString("descr"));
				c.setLeaf(rs.getInt("isleaf")==0 ? true:false);
				c.setGrade(rs.getInt("grade"));
				l.add(c);
				//我没写这个  我直接 select全部元素  但想想 后面页面要显示单独的一个类别 还是 把id穿进去好
				//但此处巨大问题  每次循环都connection  这个肯定卡死！
				//传 0  因为所有的 父类pid为 0  再递归调用 方法
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DB.closeRs(rs);
		}
		return l;
	}
	
	public static List<Category> getChildrenList(Category ca) {
		List<Category> l  = new ArrayList<Category>();
		String sql = "";
		ResultSet rs  = null;
		Connection con = null;
		try {
			con = DB.getConn();
			sql = "select * from category where pid ="+ca.getId() ;
			rs = DB.getRs(con, sql);
			while(rs.next()){
				Category c = new Category();
				//这步有了经验  所以知道哪里有错 一旦getindex的名字拿错的话  整个都显示不了所以要注意
				c.setPid(rs.getInt("pid"));
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				c.setDescr(rs.getString("descr"));
				c.setLeaf(rs.getInt("isleaf")==0 ? true:false);
				c.setGrade(rs.getInt("grade"));
				l.add(c);
				//我没写这个  我直接 select全部元素  但想想 后面页面要显示单独的一个类别 还是 把id穿进去好
				//但此处巨大问题  每次循环都connection  这个肯定卡死！
				//传 0  因为所有的 父类pid为 0  再递归调用 方法
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DB.closeRs(rs);
		}
		return l;
	}
	
	public static List<Category> getParentList(){
		List<Category> l  = new ArrayList<Category>();
		String sql = "";
		ResultSet rs  = null;
		Connection con = null;
		try {
			con = DB.getConn();
			sql = "select * from category where pid =0" ;
			rs = DB.getRs(con, sql);
			while(rs.next()){
				Category c = new Category();
				//这步有了经验  所以知道哪里有错 一旦getindex的名字拿错的话  整个都显示不了所以要注意
				c.setPid(rs.getInt("pid"));
				c.setId(rs.getInt("id"));
				c.setName(rs.getString("name"));
				c.setDescr(rs.getString("descr"));
				c.setLeaf(rs.getInt("isleaf")==0 ? true:false);
				c.setGrade(rs.getInt("grade"));
				l.add(c);
				//我没写这个  我直接 select全部元素  但想想 后面页面要显示单独的一个类别 还是 把id穿进去好
				//但此处巨大问题  每次循环都connection  这个肯定卡死！
				//传 0  因为所有的 父类pid为 0  再递归调用 方法
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DB.closeRs(rs);
		}
		return l;
	}
	
}
