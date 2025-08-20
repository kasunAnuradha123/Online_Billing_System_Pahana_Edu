package com.pahana.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.pahana.dao.OrderDao;
import com.pahana.model.Order;

@WebServlet("/SalesReportServlet")
public class SalesReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fromDate = request.getParameter("from");
        String toDate = request.getParameter("to");

        if (fromDate == null || toDate == null) {
            response.getWriter().println("Please provide both from and to dates.");
            return;
        }

        OrderDao orderDao = new OrderDao();
        List<Order> orders = orderDao.getOrdersByDateRangeWithItems(fromDate, toDate);
        System.out.println("Orders fetched: " + orders.size()); // <-- debug
     // Precompute total sales amount
        double salesAmount = 0;
        for (Order order : orders) {
            double orderTotal = 0;
            if (order.getItems() != null) {
                for (var item : order.getItems()) {
                    orderTotal += item.getTotal().doubleValue();
                }
            }
            // order.setOrderTotal(orderTotal); <-- remove this line
            salesAmount += orderTotal;
        }


        request.setAttribute("orders", orders);
        request.setAttribute("fromDate", fromDate);
        request.setAttribute("toDate", toDate);
        request.setAttribute("salesAmount", salesAmount);

        request.getRequestDispatcher("/View/sales/report.jsp").forward(request, response);
    }
}
