package com.pahana.controller.customer;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pahana.dao.CustomerDao;
import com.pahana.model.Customer;

/**
 * Servlet implementation class CustomerServlet
 */
@WebServlet("/CustomerServlet")
public class CustomerServlet extends HttpServlet {
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

	        CustomerDao dao = new CustomerDao();
	        List<Customer> customers = dao.getCustomers(page, PAGE_SIZE);
	        int totalCustomers = dao.getCustomerCount();
	        int totalPages = (int) Math.ceil((double) totalCustomers / PAGE_SIZE);

	        request.setAttribute("customers", customers);
	        request.setAttribute("currentPage", page);
	        request.setAttribute("totalPages", totalPages);
	        request.setAttribute("totalCustomers", totalCustomers);
	        System.out.println("Customers fetched: " + customers.size());
	        request.getRequestDispatcher("View/customer/index.jsp").forward(request, response);
	    }

}
