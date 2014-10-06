package com.my.shop;
/*================此乃业务逻辑层 初步有了分层思想======================= */
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Category {
	int id;
	int pid;
	String name;
	String descr;
	boolean leaf;
	int grade;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescr() {
		return descr;
	}
	public void setDescr(String descr) {
		this.descr = descr;
	}

	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public boolean isLeaf() {
		return leaf;
	}
	public void setLeaf(boolean leaf) {
		this.leaf = leaf;
	}
	
	public static void addCate(Category c){
		CategoryDAO.save(c);
	}
	
	public static List<Category> getCList(List<Category> list,int id){
		CategoryDAO.getCList(list , id);
		return list;
	}
	
	public static List<Category> getCList(){
		return CategoryDAO.getCList();
		
	}
	
	public void addLittleChild(Category c){
		Category.addChild(c.getId(), c.getName(), c.getDescr());
	}
	
	public static void addChild(int pid,String name,String descr){
		CategoryDAO.addChild(pid, name, descr);
	}
	
	public static void addRoot(String name,String descr){
		Category c = new Category();
		c.setId(-1);
		c.setName(name);
		c.setDescr(descr);
		c.setLeaf(true);
		c.setPid(0);
		c.setGrade(1);
		addCate(c);
		//CategoryDAO.save(c); 二者皆可
		//CategoryDAO.addChild(0, name, descr);
	}
	
	public static Category  getById(int id ){
		return CategoryDAO.getById(id);
	}
	//这个方法有点问题 但是逻辑应该没错 而且有isleaf这方法 搞不懂添加这个来干什么
	public static boolean idisleaf(){
		return CategoryDAO.idisleaf();
	}
	public static void delete(int pid,int id){
		CategoryDAO.delete(pid,id);
	}
	
	public void update(){
			Connection c = DB.getConn();
			String sql = "update category set name = ?,  descr = ? where id = "+this.id;
			PreparedStatement ps = DB.getPst(c, sql);
		
			try {
				ps.setString(1,name );
				ps.setString(2, descr);
				//gettime 返回long类型 timestamp 构造函数能传 
				ps.executeUpdate();
				DB.closeC(c);
				DB.closePst(ps);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}
	
	public static List<Category> getChildrenList(Category ca){
		return CategoryDAO.getChildrenList(ca);
	}
	
	public static List<Category> getParentList(){
		return CategoryDAO.getParentList();
	}
}
