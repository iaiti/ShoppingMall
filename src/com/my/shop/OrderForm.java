package com.my.shop;

import java.sql.Timestamp;

public class OrderForm {
	int id;
	int userid;
	String addr;
	Timestamp odate;
	int status;
	User u;
	Cart c;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public Timestamp getOdate() {
		return odate;
	}
	public void setOdate(Timestamp odate) {
		this.odate = odate;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public User getU() {
		return u;
	}
	public void setU(User u) {
		this.u = u;
	}
	public Cart getC() {
		return c;
	}
	public void setC(Cart c) {
		this.c = c;
	}
	public void addOrderForms(){
		OrderFormManager.getInstance().addOrderForms(this);
	}
	
}
