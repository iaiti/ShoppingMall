package com.my.shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import com.my.shop.DAO.ProductDAO;
import com.my.shop.DAO.ProductMysql;

public class ProductManager {
	 
	 private static ProductManager pm =null;
	 //private ProductManager(){}
	 static {
		 //一个小时的解决 半小时debug 都不晓得空指针处在哪里  本来pm就是null啊 还有原来的product用了id的条件语句
		 //没删除 不过这是小问题  逻辑出现严重错误  大问题！ 不过会用 在tomcat环境下的debug了
		 if(pm == null){
			 pm = new ProductManager();
			 pm.setPd(new ProductMysql());
		 }
	 }
	 
	 public static ProductManager getInstance(){
		 return pm;
	 }
	ProductDAO  pd = null;
//	 	int id;
//		String name;
//		String descr;
//		double normalPrice;
//		double memberPrece;
//		Timestamp pdate;
//		int categoryId;
	
	public String getCategoryNameById(int id){
		return pd.getCategoryNameById(id);
	}
	public List<Product> getProducts(){
		return pd.getProducts();
	}
	
	public List<Product> getProducts(int pageNo,int pageSize){
		return pd.getProducts(pageNo, pageSize);
	}
	
	public List<Product> searchProducts(int[] idArray,
										String keyword,
										double lownormalPrice,
										double highnormalPrice,
										double lowmemberPrice,
										double highmemberPrice,
										Date start, Date end,
										int pageNo, int pageSize
										){
		return pd.searchProducts(idArray, keyword, lownormalPrice, highnormalPrice, lowmemberPrice, highmemberPrice, start, end, pageNo, pageSize);
	}
	
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
				return pd.getTotalpage(l,idArray, keyword, lownormalPrice, 
						highnormalPrice, lowmemberPrice, highmemberPrice, 
						start, end, pageNo, pageSize);
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
				return pd.getTotalpageWithoutId(l, keyword, lownormalPrice, 
						highnormalPrice, lowmemberPrice, highmemberPrice, 
						start, end, pageNo, pageSize);
	}
	
	public int getTotalpage(int pageSize){
		return pd.getTotalpage(pageSize);
	}
	
	public List<Product> searchProducts(String name){
			return null;
	}
	 
	public boolean deleteProductByCategoryId(int categoryId){
		return false;
	}
	public void deleteProductById(int id){
		pd.deleteProductById(id);
	}
	public boolean deleteProductById(int idArray[]){
		return false;
	}
	
	public void updateProduct(Product p){
		pd.updateProduct(p);
	}

	public ProductDAO getPd() {
		return pd;
	}

	public void setPd(ProductDAO pd) {
		this.pd = pd;
	}
	
	public void addProducts(Product p){
		pd.addProducts(p);
	}
	
	public Product getProductById(int id ){
		return pd.getProductById( id );
	}
	
	public List<Product> lastproduct(int count){
		return pd.lastproduct(count);
}
}
