package com.pahana.controller;

import java.io.IOException;
import java.util.List;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pahana.dao.ItemDao;
import com.pahana.model.Item;

/**
 * Servlet implementation class BillingServlet
 */
@WebServlet("/BillingServlet")
public class BillingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE = 10; // rows per page
       
  
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int page = 1;
        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException ignored) {}
        }

        ItemDao dao = new ItemDao();
        List<Item> items = dao.getItems(page, PAGE_SIZE);
        int totalItems = dao.getItemCount();
        int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);

        request.setAttribute("items", items);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalItems", totalItems);
        
        request.getRequestDispatcher("View/billing/index.jsp").forward(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
