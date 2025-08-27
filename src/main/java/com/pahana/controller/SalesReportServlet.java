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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fromDate = request.getParameter("from");
        String toDate = request.getParameter("to");

        if (fromDate == null || toDate == null) {
            response.getWriter().println("Please provide both 'from' and 'to' dates.");
            return;
        }

       
        if (fromDate.compareTo(toDate) > 0) {
            String temp = fromDate;
            fromDate = toDate;
            toDate = temp;
        }

        OrderDao orderDao = new OrderDao();
        List<Order> orders = orderDao.getOrdersByDateRangeWithItems(fromDate, toDate);

      
        double salesAmount = 0;
        for (Order order : orders) {
            if (order.getItems() != null) {
                double orderTotal = order.getItems().stream()
                        .mapToDouble(item -> item.getTotal().doubleValue())
                        .sum();
                salesAmount += orderTotal;
            }
        }

        // ✅ Set attributes for JSP
        request.setAttribute("orders", orders);
        request.setAttribute("fromDate", fromDate);
        request.setAttribute("toDate", toDate);
        request.setAttribute("salesAmount", salesAmount);

        // ✅ Forward to report JSP
        request.getRequestDispatcher("/View/sales/report.jsp").forward(request, response);
    }
}
