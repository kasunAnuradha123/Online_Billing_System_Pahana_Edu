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

@WebServlet("/CustomerServlet")
public class CustomerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final int PAGE_SIZE = 10; // rows per page

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// LIST CUSTOMERS
		int page = 1;
		if (request.getParameter("page") != null) {
			try {
				page = Integer.parseInt(request.getParameter("page"));
			} catch (NumberFormatException ignored) {
			}
		}

		CustomerDao dao = new CustomerDao();
		List<Customer> customers = dao.getCustomers(page, PAGE_SIZE);
		int totalCustomers = dao.getCustomerCount();
		int totalPages = (int) Math.ceil((double) totalCustomers / PAGE_SIZE);

		request.setAttribute("customers", customers);
		request.setAttribute("currentPage", page);
		request.setAttribute("totalPages", totalPages);
		request.setAttribute("totalCustomers", totalCustomers);

		
		request.getRequestDispatcher("View/customer/index.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		CustomerDao dao = new CustomerDao();
		String action = request.getParameter("action");

		if ("add".equalsIgnoreCase(action)) {
			// ADD CUSTOMER
			Customer c = new Customer();
			c.setAccountNumber(dao.generateAccountNumber());
			c.setName(request.getParameter("name"));
			c.setAddress(request.getParameter("address"));
			c.setTP(request.getParameter("tp"));
			dao.addCustomer(c);

		} else if ("edit".equalsIgnoreCase(action)) {
			// EDIT CUSTOMER
			Customer c = new Customer();
			c.setId(Integer.parseInt(request.getParameter("id")));
			c.setName(request.getParameter("name"));
			c.setAddress(request.getParameter("address"));
			c.setTP(request.getParameter("tp"));
			dao.updateCustomer(c);

		} else if ("delete".equalsIgnoreCase(action)) {
			// DELETE CUSTOMER
			int id = Integer.parseInt(request.getParameter("id"));
			dao.deleteCustomer(id);
		}

		// Redirect to customer list after action
		response.sendRedirect("CustomerServlet");
	}
}
