package com.my.shop.DAO;

import java.util.Date;
import java.util.List;

import com.my.shop.Product;

public interface ProductDAO {
	public void addProducts(Product p);
	public List<Product> getProducts();
	
	public List<Product> getProducts(int pageNo,int pageSize);
	
	public List<Product> searchProducts(int[] idArray,
										String keyword,
										double lownormalPrice,
										double highnormalPrice,
										double lowmemberPrice,
										double highmemberPrice,
										Date start, Date end,
										int pageNo, int pageSize
										);
	
	public List<Product> searchProducts(String name);
	 
	public boolean deleteProductByCategoryId(int categoryId);
	
	public void deleteProductById(int id);
	
	public void updateProduct(Product p);
	public int getTotalpage(int pageSize);
	public String getCategoryNameById(int id);
	public int getTotalpage(List<Product> l, int[] idArray, String keyword,
			double lownormalPrice, double highnormalPrice,
			double lowmemberPrice, double highmemberPrice, Date start,
			Date end,int pageNo,int pageSize);
	public Product getProductById(int id);
	public List<Product> lastproduct(int count);
	public int getTotalpageWithoutId(List<Product> l, String keyword,
			double lownormalPrice, double highnormalPrice,
			double lowmemberPrice, double highmemberPrice, Date start,
			Date end, int pageNo, int pageSize);
	
}
