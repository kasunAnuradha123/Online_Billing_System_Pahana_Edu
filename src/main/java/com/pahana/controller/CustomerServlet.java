package com.pahana.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pahana.dao.CustomerDao;
import com.pahana.model.Customer;

@WebServlet("/CustomerServlet")
public class CustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final int PAGE_SIZE = 10; // rows per page

    @Override
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

        request.getRequestDispatcher("View/customer/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        CustomerDao dao = new CustomerDao();
        String action = request.getParameter("action");

        // Collect validation errors
        List<String> errors = new ArrayList<>();

        String name = request.getParameter("name") != null ? request.getParameter("name").trim() : "";
        String address = request.getParameter("address") != null ? request.getParameter("address").trim() : "";
        String tp = request.getParameter("tp") != null ? request.getParameter("tp").trim() : "";

        // Validate common fields (for both add/edit)
       
        // If no validation errors → proceed with action
        if ("add".equalsIgnoreCase(action)) {
        	 if (name.isEmpty()) {
                 errors.add("Name is required.");
             } else if (name.length() > 100) {
                 errors.add("Name cannot exceed 100 characters.");
             }

             if (address.isEmpty()) {
                 errors.add("Address is required.");
             } else if (address.length() > 255) {
                 errors.add("Address cannot exceed 255 characters.");
             }

             if (tp.isEmpty()) {
                 errors.add("Telephone number is required.");
             } else if (!tp.matches("\\d+")) {
                 errors.add("Telephone number must contain digits only.");
             } else if (tp.length() > 20) {
                 errors.add("Telephone number cannot exceed 20 digits.");
             }

             if (!errors.isEmpty()) {
                 // Send errors back to JSP
                 request.setAttribute("errors", errors);

                 // keep form data so user doesn’t need to retype everything
                 request.setAttribute("formName", name);
                 request.setAttribute("formAddress", address);
                 request.setAttribute("formTP", tp);
                 
              // Add a flag to indicate which modal to open
                 if ("add".equalsIgnoreCase(action)) {
                     request.setAttribute("openModal", "add");
                 }

                 // reload customer list so page doesn’t break
                 doGet(request, response);
                 return;
             }
             System.out.println("Adding customer: " + name + ", " + address + ", " + tp);
            Customer c = new Customer();
            c.setAccountNumber(dao.generateAccountNumber());
            c.setName(name);
            c.setAddress(address);
            c.setTP(tp);
            dao.addCustomer(c);
            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "Customer added successfully!");

        } else if ("edit".equalsIgnoreCase(action)) {
        	 if (name.isEmpty()) {
                 errors.add("Name is required.");
             } else if (name.length() > 100) {
                 errors.add("Name cannot exceed 100 characters.");
             }

             if (address.isEmpty()) {
                 errors.add("Address is required.");
             } else if (address.length() > 255) {
                 errors.add("Address cannot exceed 255 characters.");
             }

             if (tp.isEmpty()) {
                 errors.add("Telephone number is required.");
             } else if (!tp.matches("\\d+")) {
                 errors.add("Telephone number must contain digits only.");
             } else if (tp.length() > 20) {
                 errors.add("Telephone number cannot exceed 20 digits.");
             }

             if (!errors.isEmpty()) {
                 // Send errors back to JSP
                 request.setAttribute("errors", errors);

                 // keep form data so user doesn’t need to retype everything
                 request.setAttribute("formName", name);
                 request.setAttribute("formAddress", address);
                 request.setAttribute("formTP", tp);
                 
              // Add a flag to indicate which modal to open
                 if ("edit".equalsIgnoreCase(action)) {
                     request.setAttribute("openModal", "edit");
                     request.setAttribute("editId", request.getParameter("id"));
                 }

                 // reload customer list so page doesn’t break
                 doGet(request, response);
                 return;
             }

            Customer c = new Customer();
            c.setId(Integer.parseInt(request.getParameter("id")));
            c.setName(name);
            c.setAddress(address);
            c.setTP(tp);
            dao.updateCustomer(c);
            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "Customer updated successfully!");
        } else if ("delete".equalsIgnoreCase(action)) {
        	 try {
        	        int id = Integer.parseInt(request.getParameter("id"));
        	        dao.deleteCustomer(id);

        	        HttpSession session = request.getSession();
        	        session.setAttribute("successMessage", "Customer deleted successfully!");
        	    } catch (NumberFormatException e) {
        	        HttpSession session = request.getSession();
        	        session.setAttribute("successMessage", "Invalid customer ID.");
        	    }
        }

        // Redirect to list after success
        response.sendRedirect("CustomerServlet");
    }
}
