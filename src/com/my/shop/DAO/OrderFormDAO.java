package com.my.shop.DAO;



import java.util.List;

import com.my.shop.OrderForm;
import com.my.shop.OrderItem;



public interface OrderFormDAO {
	public void addOrderForms(OrderForm p);
//	public List<OrderForm> getOrderForms();
//	
	public List<OrderForm> getOrderForms(int pageNo,int pageSize);
//	
//	public List<OrderForm> searchOrderForms(int[] idArray,
//										String keyword,
//										double lownormalPrice,
//										double highnormalPrice,
//										double lowmemberPrice,
//										double highmemberPrice,
//										Date start, Date end,
//										int pageNo, int pageSize
//										);
//	
//	public List<OrderForm> searchOrderForms(String name);
//	 
//	public boolean deleteOrderFormByCategoryId(int categoryId);
//	
//	public void deleteOrderFormById(int id);
//	
//	public void updateOrderForm(OrderForm p);
	public int getTotalpage(int pageSize);
	public List<OrderItem> getOrderItemById(int id);
//	public int getTotalpage(List<OrderForm> l, int[] idArray, String keyword,
//			double lownormalPrice, double highnormalPrice,
//			double lowmemberPrice, double highmemberPrice, Date start,
//			Date end,int pageNo,int pageSize);
//	public OrderForm getOrderFormById(int id);
//	public List<OrderForm> lastOrderForm(int count);
	public OrderForm getOrderFormById(int id);
	public void updateOrderForm(OrderForm p);
	public void orderdelete(int id);
	
}
