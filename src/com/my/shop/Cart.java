package com.my.shop;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Cart {
	List<CartItem> items = new ArrayList<CartItem>();

	public List<CartItem> getItems() {
		return items;
	}

	public void setItems(List<CartItem> items) {
		this.items = items;
	}
	
	public void addItem(CartItem item){
//		for(Iterator<CartItem> i = getItems().iterator(); i.hasNext();){
//			CartItem ci = new CartItem();
//			ci = i.next();
//			if(item.getProductId() == ci.getProductId() ){
//				ci.setCount(ci.getCount()+1);
//				
//			}
//		}
//		另一种方法
		for(int i = 0;i<items.size();i++){
			CartItem ci = items.get(i);
			if(item.getProductId() == ci.getProductId() ){
				ci.setCount(ci.getCount()+1);
				return;
			}
		}
		items.add(item);
	}

	public void deleteItem(){
		
	}
	public void updateItem(){
		
	}
	public double getAllPrice(){
		CartItem ci = new CartItem();
		double all = 0;
		for(Iterator<CartItem> i = getItems().iterator(); i.hasNext();){
			ci = i.next();
			all += ci.getAllPrice();
		}
		return all;
	}
}
