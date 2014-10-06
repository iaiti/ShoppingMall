package com.my.shop.servlet;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;

import com.my.shop.DB;
import com.my.shop.OrderForm;
import com.my.shop.OrderFormManager;
import com.my.shop.ProductManager;
import com.my.shop.User;

public class ShowProductSalesServlet extends javax.servlet.http.HttpServlet
		implements javax.servlet.Servlet {

	public ShowProductSalesServlet() {
		super();
	}

	static final long serialVersionUID = 1L;

	private CategoryDataset getDataset() {

		DefaultCategoryDataset dataset = new DefaultCategoryDataset();

		String sql = "";
		ResultSet rs = null;
		Connection con = null;
		try {
			con = DB.getConn();
			// select count(id),id from salesitem group by productid;
			// 如果把group删掉会错误 因为
			// count是
			// 计数 总数 后面又有id 两者需要对应 那么是要分组的！用一个sum就可以统计了 bingo!
			sql = "select w.name,sum(s.pcount) from ware w join salesitem s on(w.id = s.productid)" +
					"group by s.productid";
			// System.out.println(sql);
			rs = DB.getRs(con, sql);
			while (rs.next()) {
				// 图中的标示 指明 第二个
				dataset.addValue(rs.getInt(2), rs.getString(1), 
				rs.getString(1));
				
			//test
				//System.out.println(rs.getString(1)+rs.getInt(2));

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeRs(rs);
			DB.closeC(con);
		}
		return dataset;
	}

	/**
	 * 获取一个演示用的简单数据集对象
	 * 
	 * @return
	 */
	/**
	 * 获取一个演示用的组合数据集对象
	 * 
	 * @return
	 */

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		CategoryDataset dataset = getDataset();
		JFreeChart chart = ChartFactory.createBarChart3D("商品销量图", // 图表标题
				"商品", // 目录轴的显示标签
				"销量", // 数值轴的显示标签
				dataset, // 数据集
				// PlotOrientation.VERTICAL, // 图表方向：水平、垂直
				PlotOrientation.VERTICAL, true, // 是否显示图例(对于简单的柱状图必须是false)
				false, // 是否生成工具
				false // 是否生成URL链接
				);
		FileOutputStream fos_jpg = null;
		try {
			try {
				fos_jpg = new FileOutputStream(
						"F:\\werwer\\Shopping0.1\\WebContent\\images\\productsales\\sales.jpg");
				ChartUtilities.writeChartAsJPEG(fos_jpg, 1, chart, 800, 400,null);
				this.getServletContext().getRequestDispatcher(
						"/admin/showproductsales.jsp").forward(request,
						response);
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// 原来为图像质量 1  范围在0.0 到1 之间
		} finally {
			try {
				fos_jpg.close();
			} catch (Exception e) {
			}
		}
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
	}
}