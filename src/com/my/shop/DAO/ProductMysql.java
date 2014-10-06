package com.my.shop.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.my.shop.Category;
import com.my.shop.DB;
import com.my.shop.Product;

/**
 * @author admin
 *
 */
/**
 * @author admin
 *
 */
public class ProductMysql implements ProductDAO {
	public List<Product> getProducts(){
		//还是老问题 l要= new什么 不然 l=null 什么都没有罢了
		List<Product> l = new ArrayList<Product>();
		String sql = "";
		ResultSet rs  = null;
		Connection con = null;
		try {
			con = DB.getConn();
			sql = "select * from ware ";
			rs = DB.getRs(con, sql);
			while(rs.next()){
				Product p = new Product();
				//这步有了经验  所以知道哪里有错 一旦getindex的名字拿错的话  整个都显示不了所以要注意
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalPrice"));
				p.setMemberPrice(rs.getDouble("memberPrice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryId"));
				 l.add(p);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DB.closeRs(rs);
			DB.closeC(con);
		}
		return l;
	}
	
	public List<Product> getProducts(int pageNo,int pageSize){
		List<Product> l = new ArrayList<Product>();
		String sql = "";
		ResultSet rs  = null;
		Connection con = null;
		if(pageNo-1 >= 0){
			try {
				con = DB.getConn();
				sql = "select ware.id,ware.name,ware.descr,ware.normalprice,ware.memberprice,ware.pdate,ware.categoryid"+
						",category.id cid,category.pid,category.name cname,category.descr cdescr,category.isleaf,category.grade "+
						"from ware join category on (ware.categoryid = category.id) limit "+(pageNo - 1) * pageSize+","+pageSize;
				//System.out.println(sql);
				rs = DB.getRs(con, sql);
				while(rs.next()){
					Product p = new Product();
					//这步有了经验  所以知道哪里有错 一旦getindex的名字拿错的话  整个都显示不了所以要注意
					p.setId(rs.getInt("id"));
					p.setName(rs.getString("name"));
					p.setDescr(rs.getString("descr"));
					p.setNormalPrice(rs.getDouble("normalPrice"));
					p.setMemberPrice(rs.getDouble("memberPrice"));
					p.setPdate(rs.getTimestamp("pdate"));
					p.setCategoryId(rs.getInt("categoryId"));
					Category c = new Category();
					c.setPid(rs.getInt("pid"));
					c.setId(rs.getInt("cid"));
					c.setName(rs.getString("cname"));
					c.setDescr(rs.getString("cdescr"));
					c.setLeaf(rs.getInt("isleaf")==0 ? true:false);
					c.setGrade(rs.getInt("grade"));
					p.setCategory(c);
					l.add(p);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally{
				DB.closeRs(rs);
				DB.closeC(con);
			}
			return l;
		}
		return null;
	}
	
	
	
	public String getCategoryNameById(int id){
		Connection c = null;
		ResultSet rs = null;
		String s = "";
		
		try {
			String sql = "select * from category where id="+id;
			c = DB.getConn();
			rs = DB.getRs(c, sql);
			rs.next();
			s = rs.getString("name");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return s;
	}
	
	public void  addProducts(Product p){
		Connection con = null;
		String sql = "";
		PreparedStatement ps =null;
		try {
			//insert into ware values (null,null,null,null,null,null,null);
			con = DB.getConn();
			//if(p.getId()==-1){
				 sql = "insert into ware values (null,?,?,?,?,?,?)";
			//} else {
			//	sql = "insert into ware values ("+p.getId()+",?,?,?,?,?,?)";
			//}
			ps = DB.getPst(con, sql);
			ps.setString(1, p.getName());
			ps.setString(2, p.getDescr());
			ps.setDouble(3, p.getNormalPrice());
			ps.setDouble(4, p.getMemberPrice());
			ps.setTimestamp(5, p.getPdate());
			ps.setInt(6, p.getCategoryId());
			//gettime 返回long类型 Date 构造函数能传 
			ps.executeUpdate();
			DB.closeC(con);
			DB.closePst(ps);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	//自行成功解决搜索问题
	public List<Product> searchProducts(int[] idArray,
										String keyword,
										double lownormalPrice,
										double highnormalPrice,
										double lowmemberPrice,
										double highmemberPrice,
										Date start, Date end,
										int pageNo, int pageSize
										){
		List<Product> l = new ArrayList<Product>();
		String sql = "";
		String condition = "";
		String limit = " ";
		if(pageNo == 0){
			 limit = " ";
		} else {
			 limit = " limit "+(pageNo-1)*pageSize+","+pageSize;
		}
		ResultSet rs  = null;
		Connection con = null;
		try {
			con = DB.getConn();
			//此处设计得十分精妙 如果 拿不到值 就不用where 但是 多个值得时候 又不能有多个where 
			// 用了where 1=1 后面可以用and 连接  
			sql = "select * from ware where 1=1 ";
			if(idArray!=null && idArray.length>0){
				condition = "(";
				for(int i = 0; i < idArray.length; i ++){
					if (i < idArray.length -1){
						condition += idArray[i]+",";
					//	System.out.println(condition);
					} else {
						condition += idArray[i];
					}
					
				}
				condition += ")";
				sql += "and categoryid in "+condition;
			}
			if(keyword!=null && !keyword.trim().equals("")){
				
				sql += " and name like '%"+keyword+"%' or descr like '%"+keyword+"%'" ;
			}
			if(lownormalPrice >= 0){
				sql += " and normalPrice >"+lownormalPrice;
			}
			if(highnormalPrice > 0){
				sql += " and normalPrice <"+highnormalPrice;
			}
			if(lowmemberPrice >= 0){
				sql += " and normalPrice >"+lowmemberPrice;
			}
			if(highmemberPrice >= 0){
				sql += " and normalPrice <"+highmemberPrice;
			}
			if(start != null){
				sql += " and pdate > '"+new SimpleDateFormat("yyyy-MM-dd").format(start)+"'";
			}
			if(end != null){
				sql += " and pdate < '"+new SimpleDateFormat("yyyy-MM-dd").format(end)+"'";
			}
			sql += limit;
			//System.out.println(sql);
			rs = DB.getRs(con, sql);
			while(rs.next()){
				Product p = new Product();
				//这步有了经验  所以知道哪里有错 一旦getindex的名字拿错的话  整个都显示不了所以要注意
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalPrice"));
				p.setMemberPrice(rs.getDouble("memberPrice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryId"));
				 l.add(p);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DB.closeRs(rs);
			DB.closeC(con);
		}
		if(pageNo == 0){
			return null;
		}
		return l;
	}
	
	public List<Product> searchProducts(String name){
			return null;
	}
	 
	public boolean deleteProductByCategoryId(int categoryId){
		return false;
	}
	
	/* (non-Javadoc)
	 * @see com.my.shop.DAO.ProductDAO#deleteProductById(int)
	 * 严重问题 debug后才发现 sql语句堆在一起 切记要用空格  
	 * 问题二 js里面直接的变量等于是没用的  要变量value等于 看来得好好去看一下js
	 */
	public void deleteProductById(int id){
		String sql = "delete from ware where id = "+ id;
		Connection con = null;
		con = DB.getConn();
		DB.executeUpdate(con, sql);
		DB.closeC(con);
	}
	
	
	public boolean deleteProductById(int idArray[]){
		return false;
	}
	
	public void updateProduct(Product p){
		Connection c = DB.getConn();
		String sql = "update ware set name = ?,  descr = ? , normalPrice = ? , memberPrice = ? ," +
				"categoryId = ? where id = "+p.getId();
		//System.out.println(sql);
		PreparedStatement ps = DB.getPst(c, sql);
		//System.out.println(p.getName());
		try {
			ps.setString(1,p.getName());
			ps.setString(2,p.getDescr());
			ps.setDouble(3,p.getNormalPrice());
			ps.setDouble(4,p.getMemberPrice());
			ps.setInt(5,p.getCategoryId());
			//gettime 返回long类型 timestamp 构造函数能传 
			ps.executeUpdate();
			DB.closeC(c);
			DB.closePst(ps);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/* (non-Javadoc)
	 * @see com.my.shop.DAO.ProductDAO#addProducts(com.my.shop.Product)
	 */
	@Override
	
	public int getTotalpage(List<Product> l,
			int[] idArray,
			String keyword,
			double lownormalPrice,
			double highnormalPrice,
			double lowmemberPrice,
			double highmemberPrice,
			Date start, Date end,
			int pageNo,int pageSize
			){
		int totalpage = 0;
		String sql = "";
		String condition = "";
		ResultSet rs  = null;
		Connection con = null;
			con = DB.getConn();
			//此处设计得十分精妙 如果 拿不到值 就不用where 但是 多个值得时候 又不能有多个where 
			// 用了where 1=1 后面可以用and 连接  
			sql = "select count(*) from ware where 1=1 ";
			if(idArray!=null && idArray.length>0){
				condition = "(";
				for(int i = 0; i < idArray.length; i ++){
					if (i < idArray.length -1){
						condition += idArray[i]+",";
					} else {
						condition += idArray[i];
					}
					
				}
				condition += ")";
				sql += "and categoryid in "+condition;
			}
			if(keyword!=null && !keyword.trim().equals("")){
				
				sql += " and name like '%"+keyword+"%' or descr like '%"+keyword+"%'" ;
			}
			if(lownormalPrice >= 0){
				sql += " and normalPrice >"+lownormalPrice;
			}
			if(highnormalPrice > 0){
				sql += " and normalPrice <"+highnormalPrice;
			}
			if(lowmemberPrice >= 0){
				sql += " and normalPrice >"+lowmemberPrice;
			}
			if(highmemberPrice >= 0){
				sql += " and normalPrice <"+highmemberPrice;
			}
			if(start != null){
				sql += " and pdate > '"+new SimpleDateFormat("yyyy-MM-dd").format(start)+"'";
			}
			if(end != null){
				sql += " and pdate < '"+new SimpleDateFormat("yyyy-MM-dd").format(end)+"'";
			}
			//System.out.println(sql);
			rs = DB.getRs(con, sql);
			try {
				rs.next();
				totalpage = (rs.getInt(1) + pageSize -1 )/pageSize;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		return totalpage;
	}
	
	public int getTotalpageWithoutId(List<Product> l,
			String keyword,
			double lownormalPrice,
			double highnormalPrice,
			double lowmemberPrice,
			double highmemberPrice,
			Date start, Date end,
			int pageNo,int pageSize
			){
		int totalpage = 0;
		String sql = "";
		String condition = "";
		ResultSet rs  = null;
		Connection con = null;
			con = DB.getConn();
			//此处设计得十分精妙 如果 拿不到值 就不用where 但是 多个值得时候 又不能有多个where 
			// 用了where 1=1 后面可以用and 连接  
			sql = "select count(*) from ware where 1=1 ";
			if(keyword!=null && !keyword.trim().equals("")){
				
				sql += " and name like '%"+keyword+"%' or descr like '%"+keyword+"%'" ;
			}
			if(lownormalPrice >= 0){
				sql += " and normalPrice >"+lownormalPrice;
			}
			if(highnormalPrice > 0){
				sql += " and normalPrice <"+highnormalPrice;
			}
			if(lowmemberPrice >= 0){
				sql += " and normalPrice >"+lowmemberPrice;
			}
			if(highmemberPrice >= 0){
				sql += " and normalPrice <"+highmemberPrice;
			}
			if(start != null){
				sql += " and pdate > '"+new SimpleDateFormat("yyyy-MM-dd").format(start)+"'";
			}
			if(end != null){
				sql += " and pdate < '"+new SimpleDateFormat("yyyy-MM-dd").format(end)+"'";
			}
			//System.out.println(sql);
			rs = DB.getRs(con, sql);
			try {
				rs.next();
				totalpage = (rs.getInt(1) + pageSize -1 )/pageSize;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		return totalpage;
	}
	
	//分层后 爽！ 不像之前jsp和html混搭  回去看都感觉很复杂 现在感觉很有层次感
	public int getTotalpage(int pageSize) {
		int totalpage = 0;
		Connection c = null;
		ResultSet rs = null;
		String sql = "select count(*) from ware";
	
		try {
			c = DB.getConn();
			rs = DB.getRs(c, sql);
			//神奇的算法 回来的一路上一直推算  其实该计算是 rs.getInt(1)  -1 )/pageSize +1 前者超出后整除少一加一
			//刚刚整除时减一 加一  没有超过时减一还是没有超过 妙
			rs.next();
			totalpage = (rs.getInt(1) + pageSize -1 )/pageSize;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DB.closeRs(rs);
			DB.closeC(c);
		}
		return totalpage;
	
	}

	public Product getProductById(int id){
		String sql = "";
		ResultSet rs  = null;
		Connection con = null;
		//又犯致命错误 把它等于null  p等于null什么都没有 还能调用方法吗 显然不能嘛  自己写错了
		Product p = new Product();
		try {
			con = DB.getConn();
			sql = "select ware.id,ware.name,ware.descr,ware.normalprice,ware.memberprice,ware.pdate,ware.categoryid"+
					",category.id cid,category.pid,category.name cname,category.descr cdescr,category.isleaf,category.grade "+
					"from ware join category on (ware.categoryid = category.id)  where ware.id = "+id;
			//System.out.println(sql);
			rs = DB.getRs(con, sql);
			if(rs.next()){
				//这步有了经验  所以知道哪里有错 一旦getindex的名字拿错的话  整个都显示不了所以要注意
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalPrice"));
				p.setMemberPrice(rs.getDouble("memberPrice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryId"));
				Category c = new Category();
				c.setPid(rs.getInt("pid"));
				c.setId(rs.getInt("cid"));
				c.setName(rs.getString("cname"));
				c.setDescr(rs.getString("cdescr"));
				c.setLeaf(rs.getInt("isleaf")==0 ? true:false);
				c.setGrade(rs.getInt("grade"));
				p.setCategory(c);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DB.closeRs(rs);
			DB.closeC(con);
		}
		return p;
	}

	public List<Product> lastproduct(int count){
		List<Product> l = new ArrayList<Product>();
		String sql = "";
		ResultSet rs  = null;
		Connection con = null;
		try {
			con = DB.getConn();
			sql = "select * from ware order  by pdate desc limit 0, "+count;
			rs = DB.getRs(con, sql);
			while(rs.next()){
				Product p = new Product();
				//这步有了经验  所以知道哪里有错 一旦getindex的名字拿错的话  整个都显示不了所以要注意
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalPrice"));
				p.setMemberPrice(rs.getDouble("memberPrice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryId(rs.getInt("categoryId"));
				 l.add(p);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			DB.closeRs(rs);
			DB.closeC(con);
		}
		return l;
	}

}
