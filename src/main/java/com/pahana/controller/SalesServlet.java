package com.pahana.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pahana.dao.OrderDao;
import com.pahana.dao.OrderItemDao;
import com.pahana.model.Order;
import com.pahana.model.OrderItem;

@WebServlet("/SalesServlet")
public class SalesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE = 10;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int page = 1;
        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException ignored) {}
        }

        OrderDao orderDao = new OrderDao();
        OrderItemDao itemDao = new OrderItemDao();

        List<Order> orders = orderDao.getOrders(page, PAGE_SIZE); // create this method
        int totalOrders = orderDao.getOrderCount(); // create this method
        int totalPages = (int) Math.ceil((double) totalOrders / PAGE_SIZE);

        request.setAttribute("orders", orders);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalOrders", totalOrders);

        request.getRequestDispatcher("View/sales/index.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        OrderDao orderDao = new OrderDao();

        if ("delete".equalsIgnoreCase(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                orderDao.deleteOrder(id); // create this method in OrderDao
                session.setAttribute("successMessage", "Order deleted successfully!");
            } catch (NumberFormatException e) {
                session.setAttribute("errorMessage", "Invalid order ID!");
            }
        }

        response.sendRedirect(request.getContextPath() + "/SalesServlet");
    }
}
