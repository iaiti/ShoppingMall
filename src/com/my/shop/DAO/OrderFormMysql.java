package com.my.shop.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.my.shop.CartItem;
import com.my.shop.Category;
import com.my.shop.DB;
import com.my.shop.OrderForm;
import com.my.shop.OrderItem;
import com.my.shop.Product;
import com.my.shop.User;

public class OrderFormMysql implements OrderFormDAO {
	public void addOrderForms(OrderForm o) {
		Connection con = null;
		String sql = "";
		ResultSet rsKey = null;
		PreparedStatement ps = null;
		try {
			// 这么多的东西 把提交设成false先

			// insert into ware values (null,null,null,null,null,null,null);
			con = DB.getConn();
			con.setAutoCommit(false);
			sql = "insert into salesorder values (null,?,?,?,?)";
			ps = DB.getPst(con, sql, true);
			ps.setInt(1, o.getUserid());
			ps.setString(2, o.getAddr());
			ps.setTimestamp(3, o.getOdate());
			ps.setInt(4, o.getStatus());
			ps.executeUpdate();
			// 这个不会写 忘了key的东西 不过大概知道是什么东西 是拿到自动的id 把id拿到 salesitem里面 做表关联
			rsKey = ps.getGeneratedKeys();
			rsKey.next();
			int key = rsKey.getInt(1);

			String sql2 = "insert into salesitem values (null,?,?,?,?)";
			PreparedStatement pst = DB.getPst(con, sql2);
			//少了一个preparestatement  一个的话重叠 怪不得没执行循环
			List<CartItem> items = o.getC().getItems();
			//System.out.println(items.size()); 
			//醉掉了 pst放在for循环里面 那个每次get之后  肯定是一个新初始化的 那executeBatch肯定不行啦
			pst = DB.getPst(con, sql2);
			for (int i = 0; i <items.size(); i++) {
				CartItem ci = items.get(i);
				System.out.println(ci.getProductId());
				
				pst.setInt(1, ci.getProductId());
				pst.setDouble(2, ci.getAllPrice());
				pst.setInt(3, ci.getCount());
				pst.setInt(4, key);
				
				pst.addBatch();
			}
			//batch 批处理
			// 批处理的东西 全部加入 一次性解决
			pst.executeBatch();
			con.commit();
			con.setAutoCommit(true);

		} catch (SQLException e) {
			try {
				con.setAutoCommit(true);
				con.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			DB.closeRs(rsKey);
			DB.closePst(ps);
			DB.closeC(con);
		}
	}

	public OrderForm getOrderFormById(int id){
		String sql = "";
		ResultSet rs = null;
		Connection con = null;
		OrderForm of = new OrderForm();
			try {
				con = DB.getConn();
				sql = "select salesorder.id,salesorder.userid,salesorder.addr,salesorder.odate,salesorder.status"+
					 ",user.id uid,user.username,user.pw ,user.rdate ,user.phone,user.addr uaddr "+
					 "from salesorder join user on (saleSorder.userid = user.id) where salesorder.id = "+id;
				
				rs = DB.getRs(con, sql);
				while (rs.next()) {
					User u = new User();
					u.setAddr(rs.getString("uaddr"));
					u.setId(rs.getInt("uid"));
					u.setPw(rs.getString("pw"));
					u.setRdate(rs.getTimestamp("rdate"));
					u.setPhone(rs.getString("phone"));
					u.setName(rs.getString("username"));
					
					of.setU(u);
					// 这步有了经验 所以知道哪里有错 一旦getindex的名字拿错的话 整个都显示不了所以要注意
					of.setAddr(rs.getString("addr"));
					of.setId(rs.getInt("id"));
					of.setUserid(rs.getInt("userid"));
					of.setOdate(rs.getTimestamp("odate"));
					of.setStatus(rs.getInt("status"));

				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				DB.closeRs(rs);
				DB.closeC(con);
			}
			return of;
		
	}
	
	public void updateOrderForm(OrderForm p){
		Connection c = DB.getConn();
		String sql = "update salesorder set status = ? where id = "+p.getId();
		//System.out.println(sql);
		PreparedStatement ps = DB.getPst(c, sql);
		System.out.println(p.getStatus());
		//System.out.println(p.getName());
		try {
			ps.setInt(1,p.getStatus());
			//gettime 返回long类型 timestamp 构造函数能传 
			ps.executeUpdate();
			DB.closeC(c);
			DB.closePst(ps);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	// public List<OrderForm> getOrderForms(){
	// //还是老问题 l要= new什么 不然 l=null 什么都没有罢了
	// List<OrderForm> l = new ArrayList<OrderForm>();
	// String sql = "";
	// ResultSet rs = null;
	// Connection con = null;
	// try {
	// con = DB.getConn();
	// sql = "select * from ware ";
	// rs = DB.getRs(con, sql);
	// while(rs.next()){
	// OrderForm p = new OrderForm();
	// //这步有了经验 所以知道哪里有错 一旦getindex的名字拿错的话 整个都显示不了所以要注意
	// p.setId(rs.getInt("id"));
	// p.setName(rs.getString("name"));
	// p.setDescr(rs.getString("descr"));
	// p.setNormalPrice(rs.getDouble("normalPrice"));
	// p.setMemberPrice(rs.getDouble("memberPrice"));
	// p.setPdate(rs.getTimestamp("pdate"));
	// p.setCategoryId(rs.getInt("categoryId"));
	// l.add(p);
	// }
	// } catch (SQLException e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// } finally{
	// DB.closeRs(rs);
	// DB.closeC(con);
	// }
	// return l;
	// }

	public List<OrderForm> getOrderForms(int pageNo, int pageSize) {
		List<OrderForm> l = new ArrayList<OrderForm>();
		String sql = "";
		ResultSet rs = null;
		Connection con = null;
		if (pageNo - 1 >= 0) {
			try {
				con = DB.getConn();
				sql = "select salesorder.id,salesorder.userid,salesorder.addr,salesorder.odate,salesorder.status"+
					 ",user.id uid,user.username,user.pw ,user.rdate ,user.phone,user.addr uaddr "+
					 "from salesorder join user on (saleSorder.userid = user.id) limit " + (pageNo - 1)
						* pageSize + "," + pageSize;
				// System.out.println(sql);
				rs = DB.getRs(con, sql);
				while (rs.next()) {
					User u = new User();
					u.setAddr(rs.getString("uaddr"));
					u.setId(rs.getInt("uid"));
					u.setPw(rs.getString("pw"));
					u.setRdate(rs.getTimestamp("rdate"));
					u.setPhone(rs.getString("phone"));
					u.setName(rs.getString("username"));
					
					OrderForm o = new OrderForm();
					o.setU(u);
					// 这步有了经验 所以知道哪里有错 一旦getindex的名字拿错的话 整个都显示不了所以要注意
					o.setId(rs.getInt("id"));
					o.setUserid(rs.getInt("userid"));
					o.setAddr(rs.getString("addr"));
					o.setOdate(rs.getTimestamp("odate"));
					o.setStatus(rs.getInt("status"));

					l.add(o);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				DB.closeRs(rs);
				DB.closeC(con);
			}
			return l;
		}
		return null;
	}

	//	
	// public int getTotalpage(List<OrderForm> l,
	// int[] idArray,
	// String keyword,
	// double lownormalPrice,
	// double highnormalPrice,
	// double lowmemberPrice,
	// double highmemberPrice,
	// Date start, Date end,
	// int pageNo,int pageSize
	// ){
	// int totalpage = 0;
	// String sql = "";
	// String condition = "";
	// ResultSet rs = null;
	// Connection con = null;
	// con = DB.getConn();
	// //此处设计得十分精妙 如果 拿不到值 就不用where 但是 多个值得时候 又不能有多个where
	// // 用了where 1=1 后面可以用and 连接
	// sql = "select count(*) from ware where 1=1 ";
	// if(idArray!=null && idArray.length>0){
	// condition = "(";
	// for(int i = 0; i < idArray.length; i ++){
	// if (i < idArray.length -1){
	// condition += idArray[i]+",";
	// } else {
	// condition += idArray[i];
	// }
	//					
	// }
	// condition += ")";
	// sql += "and categoryid in "+condition;
	// }
	// if(keyword!=null && !keyword.trim().equals("")){
	//				
	// sql += " and name like '%"+keyword+"%' or descr like '%"+keyword+"%'" ;
	// }
	// if(lownormalPrice >= 0){
	// sql += " and normalPrice >"+lownormalPrice;
	// }
	// if(highnormalPrice > 0){
	// sql += " and normalPrice <"+highnormalPrice;
	// }
	// if(lowmemberPrice >= 0){
	// sql += " and normalPrice >"+lowmemberPrice;
	// }
	// if(highmemberPrice >= 0){
	// sql += " and normalPrice <"+highmemberPrice;
	// }
	// if(start != null){
	// sql += " and pdate > '"+new
	// SimpleDateFormat("yyyy-MM-dd").format(start)+"'";
	// }
	// if(end != null){
	// sql += " and pdate < '"+new
	// SimpleDateFormat("yyyy-MM-dd").format(end)+"'";
	// }
	// //System.out.println(sql);
	// rs = DB.getRs(con, sql);
	// try {
	// rs.next();
	// totalpage = (rs.getInt(1) + pageSize -1 )/pageSize;
	// } catch (SQLException e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// }
	//			
	// return totalpage;
	// }
	//	
	public List<OrderItem> getOrderItemById(int id) {
		List<OrderItem> l = new ArrayList<OrderItem>();
		String sql = "";
		ResultSet rs = null;
		Connection con = null;
			try {
				con = DB.getConn();
				//自己发现问题 2013年4月3日1:12:28   终于找到  传进来的id是orderid bingo！
				sql = "select salesorder.id,salesorder.userid,salesorder.addr,salesorder.odate,salesorder.status,"+
				 "salesitem.id sid,salesitem.productid,salesitem.unitprice,salesitem.pcount,salesitem.orderid ,"+
				 "ware.id wid,ware.name wname,ware.descr,ware.normalprice,ware.memberprice,ware.pdate,ware.categoryid "+
				 "from salesorder join salesitem on (salesorder.id = salesitem.orderid) " +
				 "join ware on (salesitem.productid = ware.id) where salesitem.orderid="+id;
				// System.out.println(sql);
				rs = DB.getRs(con, sql);
				while (rs.next()) {
					Product p = new Product();
					//这步有了经验  所以知道哪里有错 一旦getindex的名字拿错的话  整个都显示不了所以要注意
					p.setId(rs.getInt("wid"));
					p.setName(rs.getString("wname"));
					p.setDescr(rs.getString("descr"));
					p.setNormalPrice(rs.getDouble("normalPrice"));
					p.setMemberPrice(rs.getDouble("memberPrice"));
					p.setPdate(rs.getTimestamp("pdate"));
					p.setCategoryId(rs.getInt("categoryId"));
					
					OrderForm o = new OrderForm();
					// 这步有了经验 所以知道哪里有错 一旦getindex的名字拿错的话 整个都显示不了所以要注意
					o.setId(rs.getInt("id"));
					o.setUserid(rs.getInt("userid"));
					o.setAddr(rs.getString("addr"));
					o.setOdate(rs.getTimestamp("odate"));
					o.setStatus(rs.getInt("status"));
					
					OrderItem oi = new OrderItem();
					// 这步有了经验 所以知道哪里有错 一旦getindex的名字拿错的话 整个都显示不了所以要注意
					oi.setId(rs.getInt("sid"));
					oi.setProductid(rs.getInt("productid"));
					oi.setUnitprice(rs.getDouble("unitprice"));
					oi.setPcount(rs.getInt("pcount"));
					oi.setOrderid(rs.getInt("orderid"));
					oi.setP(p);
					oi.setOf(o);
					l.add(oi);
					
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				DB.closeRs(rs);
				DB.closeC(con);
			}
			return l;
	}

	//
	// //自行成功解决搜索问题
	// public List<OrderForm> searchOrderForms(int[] idArray,
	// String keyword,
	// double lownormalPrice,
	// double highnormalPrice,
	// double lowmemberPrice,
	// double highmemberPrice,
	// Date start, Date end,
	// int pageNo, int pageSize
	// ){
	// List<OrderForm> l = new ArrayList<OrderForm>();
	// String sql = "";
	// String condition = "";
	// String limit = " ";
	// if(pageNo == 0){
	// limit = " ";
	// } else {
	// limit = " limit "+(pageNo-1)*pageSize+","+pageSize;
	// }
	// ResultSet rs = null;
	// Connection con = null;
	// try {
	// con = DB.getConn();
	// //此处设计得十分精妙 如果 拿不到值 就不用where 但是 多个值得时候 又不能有多个where
	// // 用了where 1=1 后面可以用and 连接
	// sql = "select * from ware where 1=1 ";
	// if(idArray!=null && idArray.length>0){
	// condition = "(";
	// for(int i = 0; i < idArray.length; i ++){
	// if (i < idArray.length -1){
	// condition += idArray[i]+",";
	// // System.out.println(condition);
	// } else {
	// condition += idArray[i];
	// }
	//					
	// }
	// condition += ")";
	// sql += "and categoryid in "+condition;
	// }
	// if(keyword!=null && !keyword.trim().equals("")){
	//				
	// sql += " and name like '%"+keyword+"%' or descr like '%"+keyword+"%'" ;
	// }
	// if(lownormalPrice >= 0){
	// sql += " and normalPrice >"+lownormalPrice;
	// }
	// if(highnormalPrice > 0){
	// sql += " and normalPrice <"+highnormalPrice;
	// }
	// if(lowmemberPrice >= 0){
	// sql += " and normalPrice >"+lowmemberPrice;
	// }
	// if(highmemberPrice >= 0){
	// sql += " and normalPrice <"+highmemberPrice;
	// }
	// if(start != null){
	// sql += " and pdate > '"+new
	// SimpleDateFormat("yyyy-MM-dd").format(start)+"'";
	// }
	// if(end != null){
	// sql += " and pdate < '"+new
	// SimpleDateFormat("yyyy-MM-dd").format(end)+"'";
	// }
	// sql += limit;
	// //System.out.println(sql);
	// rs = DB.getRs(con, sql);
	// while(rs.next()){
	// OrderForm p = new OrderForm();
	// //这步有了经验 所以知道哪里有错 一旦getindex的名字拿错的话 整个都显示不了所以要注意
	// p.setId(rs.getInt("id"));
	// p.setName(rs.getString("name"));
	// p.setDescr(rs.getString("descr"));
	// p.setNormalPrice(rs.getDouble("normalPrice"));
	// p.setMemberPrice(rs.getDouble("memberPrice"));
	// p.setPdate(rs.getTimestamp("pdate"));
	// p.setCategoryId(rs.getInt("categoryId"));
	// l.add(p);
	// }
	// } catch (SQLException e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// } finally{
	// DB.closeRs(rs);
	// DB.closeC(con);
	// }
	// if(pageNo == 0){
	// return null;
	// }
	// return l;
	// }
	//	
	// public List<OrderForm> searchOrderForms(String name){
	// return null;
	// }
	//	 
	// public boolean deleteOrderFormByCategoryId(int categoryId){
	// return false;
	// }
	//	
	// /* (non-Javadoc)
	// * @see com.my.shop.DAO.OrderFormDAO#deleteOrderFormById(int)
	// * 严重问题 debug后才发现 sql语句堆在一起 切记要用空格
	// * 问题二 js里面直接的变量等于是没用的 要变量value等于 看来得好好去看一下js
	// */
	// public void deleteOrderFormById(int id){
	// String sql = "delete from ware where id = "+ id;
	// Connection con = null;
	// con = DB.getConn();
	// DB.executeUpdate(con, sql);
	// DB.closeC(con);
	// }
	//	
	//	
	// public boolean deleteOrderFormById(int idArray[]){
	// return false;
	// }
	//	
	// public void updateOrderForm(OrderForm p){
	// Connection c = DB.getConn();
	// String sql = "update ware set name = ?, descr = ? , normalPrice = ? ,
	// memberPrice = ? ," +
	// "categoryId = ? where id = "+p.getId();
	// //System.out.println(sql);
	// PreparedStatement ps = DB.getPst(c, sql);
	// //System.out.println(p.getName());
	// try {
	// ps.setString(1,p.getName());
	// ps.setString(2,p.getDescr());
	// ps.setDouble(3,p.getNormalPrice());
	// ps.setDouble(4,p.getMemberPrice());
	// ps.setInt(5,p.getCategoryId());
	// //gettime 返回long类型 timestamp 构造函数能传
	// ps.executeUpdate();
	// DB.closeC(c);
	// DB.closePst(ps);
	// } catch (SQLException e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// }
	// }
	//
	// /* (non-Javadoc)
	// * @see com.my.shop.DAO.OrderFormDAO#addOrderForms(com.my.shop.OrderForm)
	// */
	// @Override
	//	
	//
	// 分层后 爽！ 不像之前jsp和html混搭 回去看都感觉很复杂 现在感觉很有层次感
	public int getTotalpage(int pageSize) {
		int totalpage = 0;
		Connection c = null;
		ResultSet rs = null;
		String sql = "select count(*) from salesorder";

		try {
			c = DB.getConn();
			rs = DB.getRs(c, sql);
			rs.next();
			// 神奇的算法 回来的一路上一直推算 其实该计算是 rs.getInt(1) -1 )/pageSize +1 前者超出后整除少一加一
			// 刚刚整除时减一 加一 没有超过时减一还是没有超过 妙
			totalpage = (rs.getInt(1) + pageSize - 1) / pageSize;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeRs(rs);
			DB.closeC(c);
		}
		return totalpage;

	}
	
	public void orderdelete(int id){
		String sql = "delete from salesorder where id = "+ id;
		String sql2 = "delete from salesitem where orderid = "+ id;
		Connection con = null;
		con = DB.getConn();
		DB.executeUpdate(con, sql);
		DB.executeUpdate(con, sql2);
		DB.closeC(con);
	}

	// public OrderForm getOrderFormById(int id){
	// String sql = "";
	// ResultSet rs = null;
	// Connection con = null;
	// // 又犯致命错误 把它等于null p等于null什么都没有 还能调用方法吗 显然不能嘛 自己写错了
	// OrderForm p = new OrderForm();
	// try {
	// con = DB.getConn();
//	 sql = "select
//	 ware.id,ware.name,ware.descr,ware.normalprice,ware.memberprice,ware.pdate,ware.categoryid"+
//	 ",category.id cid,category.pid,category.name cname,category.descr
//	 cdescr,category.isleaf,category.grade "+
//	 "from ware join category on (ware.categoryid = category.id) where ware.id
//	 = "+id;
	// // System.out.println(sql);
	// rs = DB.getRs(con, sql);
	// if(rs.next()){
	// // 这步有了经验 所以知道哪里有错 一旦getindex的名字拿错的话 整个都显示不了所以要注意
	// p.setId(rs.getInt("id"));
	// p.setName(rs.getString("name"));
	// p.setDescr(rs.getString("descr"));
	// p.setNormalPrice(rs.getDouble("normalPrice"));
	// p.setMemberPrice(rs.getDouble("memberPrice"));
	// p.setPdate(rs.getTimestamp("pdate"));
	// p.setCategoryId(rs.getInt("categoryId"));
	// Category c = new Category();
	// c.setPid(rs.getInt("pid"));
	// c.setId(rs.getInt("cid"));
	// c.setName(rs.getString("cname"));
	// c.setDescr(rs.getString("cdescr"));
	// c.setLeaf(rs.getInt("isleaf")==0 ? true:false);
	// c.setGrade(rs.getInt("grade"));
	// p.setCategory(c);
	// }
	// } catch (SQLException e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// } finally{
	// DB.closeRs(rs);
	// DB.closeC(con);
	// }
	// return p;
	// }
	// public List<OrderForm> lastOrderForm(int count){
	// List<OrderForm> l = new ArrayList<OrderForm>();
	// String sql = "";
	// ResultSet rs = null;
	// Connection con = null;
	// try {
	// con = DB.getConn();
	// sql = "select * from ware order by pdate desc limit 0, "+count;
	// rs = DB.getRs(con, sql);
	// while(rs.next()){
	// OrderForm p = new OrderForm();
	// //这步有了经验 所以知道哪里有错 一旦getindex的名字拿错的话 整个都显示不了所以要注意
	// p.setId(rs.getInt("id"));
	// p.setName(rs.getString("name"));
	// p.setDescr(rs.getString("descr"));
	// p.setNormalPrice(rs.getDouble("normalPrice"));
	// p.setMemberPrice(rs.getDouble("memberPrice"));
	// p.setPdate(rs.getTimestamp("pdate"));
	// p.setCategoryId(rs.getInt("categoryId"));
	// l.add(p);
	// }
	// } catch (SQLException e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// } finally{
	// DB.closeRs(rs);
	// DB.closeC(con);
	// }
	// return l;
	// }

}
