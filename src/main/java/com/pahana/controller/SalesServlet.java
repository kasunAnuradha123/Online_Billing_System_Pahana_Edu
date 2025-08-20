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
        OrderItemDao itemDao = new OrderItemDao();
        
        if ("report".equalsIgnoreCase(action)) {
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");

            List<Order> reportOrders = orderDao.getOrdersByDateRange(startDate, endDate);
            request.setAttribute("orders", reportOrders);
            request.setAttribute("reportMode", true); // flag to show it's a report
            request.getRequestDispatcher("View/sales/index.jsp").forward(request, response);
            return;
        }

        if ("delete".equalsIgnoreCase(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                orderDao.deleteOrder(id); 
                session.setAttribute("successMessage", "Order deleted successfully!");
            } catch (NumberFormatException e) {
                session.setAttribute("errorMessage", "Invalid order ID!");
            }
        } else if ("view".equalsIgnoreCase(action)) {
            try {
                int orderId = Integer.parseInt(request.getParameter("id"));
                List<OrderItem> items = itemDao.getItemsByOrderId(orderId);

                // Return JSON
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");

                StringBuilder json = new StringBuilder("[");
                for (int i = 0; i < items.size(); i++) {
                    OrderItem item = items.get(i);
                    json.append("{")
                        .append("\"name\":\"").append(item.getItemName()).append("\",")
                        .append("\"itemPrice\":").append(item.getItemPrice()).append(",")
                        .append("\"qty\":").append(item.getQty()).append(",")
                        .append("\"total\":").append(item.getTotal())
                        .append("}");
                    if (i < items.size() - 1) json.append(",");
                }
                json.append("]");
                response.getWriter().write(json.toString());

                return; // stop further redirect
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error loading items");
                return;
            }
        }

        response.sendRedirect(request.getContextPath() + "/SalesServlet");
    }

}




