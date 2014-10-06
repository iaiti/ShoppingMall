package com.my.shop;

//Cart 手推车 和购物车差不多吧
public class CartItem {
	int productId;
	int count;
	double price;
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public double getTotalPrice(){
		return this.price * this.count;
	}
	public double getAllPrice(){
		return this.price * this.count;
	}
}
