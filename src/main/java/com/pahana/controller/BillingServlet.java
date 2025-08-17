package com.pahana.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pahana.dao.CustomerDao;
import com.pahana.dao.ItemDao;
import com.pahana.dao.OrderDao;
import com.pahana.dao.OrderItemDao;
import com.pahana.model.Customer;
import com.pahana.model.Item;
import com.pahana.model.Order;
import com.pahana.model.OrderItem;

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
        //getItems
        ItemDao dao = new ItemDao();
        List<Item> items = dao.getItems(page, PAGE_SIZE);
        int totalItems = dao.getItemCount();
        int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);
        
        //getCustomers
        CustomerDao customerDao = new CustomerDao();
        List<Customer> customers = customerDao.getAllCustomers();

        request.setAttribute("items", items);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalItems", totalItems);
        request.setAttribute("customers", customers);
        
        request.getRequestDispatcher("View/billing/index.jsp").forward(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
        try {
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            double subtotal = Double.parseDouble(request.getParameter("subtotal"));
            double discount = Double.parseDouble(request.getParameter("discount"));
            double total = Double.parseDouble(request.getParameter("total"));
            // Create Order object
            Order order = new Order();
            order.setCustomerId(customerId);
            order.setTotalAmount(new java.math.BigDecimal(total));
            order.setDiscount(new java.math.BigDecimal(discount));
            order.setCreatedAt(new java.sql.Timestamp(System.currentTimeMillis()));

            // Save Order and get orderId
            OrderDao orderDao = new OrderDao();
            int orderId = orderDao.saveOrder(order);

            if (orderId > 0) {
                // Save Order Items
                OrderItemDao itemDao = new OrderItemDao();
                ItemDao itemDataDao = new ItemDao();
                int i = 0;
                while (request.getParameter("items[" + i + "][itemId]") != null) {
                	System.out.println("items[0][itemId] = " + request.getParameter("items[0][itemId]"));

                    int itemId = Integer.parseInt(request.getParameter("items[" + i + "][itemId]"));
                    int qty = Integer.parseInt(request.getParameter("items[" + i + "][qty]"));
                    double price = Double.parseDouble(request.getParameter("items[" + i + "][price]"));

                    OrderItem item = new OrderItem();
                    item.setOrderId(orderId);
                    item.setItemId(itemId);
                    item.setQty(qty);
                    item.setItemPrice(new BigDecimal(price));
                    item.setTotal(new BigDecimal(price * qty));

                    item.setCreatedAt(new java.sql.Timestamp(System.currentTimeMillis()));

                    itemDao.saveOrderItem(item);
                 // Update stock quantity in items table
                    Item currentItem = itemDataDao.getItemById(itemId);
                    System.out.print(currentItem);
                    if (currentItem != null) {
                        int newStock = currentItem.getStockQuantity() - qty; // subtract sold quantity
                        if (newStock < 0) newStock = 0; // prevent negative stock
                        currentItem.setStockQuantity(newStock);
                        itemDataDao.updateStockQuantity(currentItem); // implement this method in ItemDao
                    }
                    i++;
                }
                
                //send sms
             
//                CustomerDao customerDao = new CustomerDao();
//                Customer customer = customerDao.getCustomerById(customerId);

//                String sms = "Thank you for shopping at Pahana Edu BookShop! "
//                        + "Your order #" + orderId
//                        + " is confirmed. Total: LKR " + String.format("%.2f", total)
//                        + ". Visit us again!";
//
//
//                if (sms.length() > 160) {
//                    sms = sms.substring(0, 160);
//                }
//
//                String encodedMessage = java.net.URLEncoder.encode(sms, "UTF-8");
//                String userId = "30080";       
//                String apiKey = "37BDCgiy9EZkFyY14GMk";
//                String localNumber = customer.getTP();    
//                String internationalNumber = "+94" + localNumber.substring(1);
//                String urlStr = "https://app.notify.lk/api/v1/send"
//                        + "?user_id=" + userId
//                        + "&api_key=" + apiKey
//                        + "&sender_id=NotifyDEMO"
//                        + "&to=" + internationalNumber
//                        + "&message=" + encodedMessage;
//
//                try {
//                    java.net.URL url = new java.net.URL(urlStr);
//                    java.net.HttpURLConnection conn = (java.net.HttpURLConnection) url.openConnection();
//                    conn.setRequestMethod("GET");
//                    int responseCode = conn.getResponseCode();
//                    System.out.println("SMS response code: " + responseCode);
//                } catch (Exception e) {
//                    e.printStackTrace();
//                }


                // Forward to print page
                request.setAttribute("billingId", orderId);
                request.getRequestDispatcher("View/billing/print.jsp").forward(request, response);

            } else {
                response.getWriter().println("Failed to save order.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }


}
