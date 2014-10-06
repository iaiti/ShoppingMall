package com.my.shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import com.my.shop.DAO.OrderFormDAO;
import com.my.shop.DAO.OrderFormDAO;
import com.my.shop.DAO.OrderFormMysql;

public class OrderFormManager {
	 
	 private static OrderFormManager om =null;
	 static {
		 if(om == null){
			 om = new OrderFormManager ();
			 om.setOd(new OrderFormMysql());
		 }
	 }
	 
	 public static OrderFormManager getInstance(){
		 return om;
	 }
	 OrderFormDAO  od = null;
//	 	int id;
//		String name;
//		String descr;
//		double normalPrice;
//		double memberPrece;
//		Timestamp odate;
//		int categoryId;
	
	public List<OrderItem> getOrderItemById(int id){
		return od.getOrderItemById(id);
	}
	public OrderForm getOrderFormById(int id){
		return od.getOrderFormById(id);
	}
//	public List<OrderForm> getOrderForms(){
//		return od.getOrderForms();
//	}
//	
	public List<OrderForm> getOrderForms(int pageNo,int pageSize){
		return od.getOrderForms(pageNo, pageSize);
	}
	public void orderdelete(int id){
		od.orderdelete(id);
	}
//	
//	public List<OrderForm> searchOrderForms(int[] idArray,
//										String keyword,
//										double lownormalPrice,
//										double highnormalPrice,
//										double lowmemberPrice,
//										double highmemberPrice,
//										Date start, Date end,
//										int pageNo, int pageSize
//										){
//		return od.searchOrderForms(idArray, keyword, lownormalPrice, highnormalPrice, lowmemberPrice, highmemberPrice, start, end, pageNo, pageSize);
//	}
//	
//	public int getTotalpage(List<OrderForm> l,
//			int[] idArray,
//			String keyword,
//			double lownormalPrice,
//			double highnormalPrice,
//			double lowmemberPrice,
//			double highmemberPrice,
//			Date start, Date end,
//			int pageNo,int pageSize
//			){
//				return od.getTotalpage(l,idArray, keyword, lownormalPrice, 
//						highnormalPrice, lowmemberPrice, highmemberPrice, 
//						start, end, pageNo, pageSize);
//}
//	
	public int getTotalpage(int pageSize){
		return od.getTotalpage(pageSize);
	}
//	
//	public List<OrderForm> searchOrderForms(String name){
//			return null;
//	}
//	 
//	public boolean deleteOrderFormByCategoryId(int categoryId){
//		return false;
//	}
//	public void deleteOrderFormById(int id){
//		od.deleteOrderFormById(id);
//	}
//	public boolean deleteOrderFormById(int idArray[]){
//		return false;
//	}
//	
	public void updateOrderForm(OrderForm p){
		od.updateOrderForm(p);
	}

	public OrderFormDAO getod() {
		return od;
	}

	public void setOd(OrderFormDAO od) {
		this.od = od;
	}
	
	public void addOrderForms(OrderForm p){
		od.addOrderForms(p);
	}
//	
//	public OrderForm getOrderFormById(int id ){
//		return od.getOrderFormById( id );
//	}
//	
//	public List<OrderForm> lastOrderForm(int count){
//		return od.lastOrderForm(count);
//	}
}
