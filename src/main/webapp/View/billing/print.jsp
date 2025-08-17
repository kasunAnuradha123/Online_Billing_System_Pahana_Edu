<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.pahana.dao.*"%>
<%@ page import="com.pahana.model.*"%>
<%
    int orderId = (Integer) request.getAttribute("billingId"); // From servlet

    OrderDao orderDao = new OrderDao();
    OrderItemDao orderItemDao = new OrderItemDao();
    ItemDao itemDao = new ItemDao();
    CustomerDao customerDao = new CustomerDao();

    Order order = orderDao.getOrderById(orderId); 
    List<OrderItem> items = orderItemDao.getItemsByOrderId(orderId); 
    Customer customer = customerDao.getCustomerById(order.getCustomerId());
%>
<!DOCTYPE html>
<html>
<head>
    <title>Print Bill - Pahana Edu</title>
    <style>
        body { font-family: monospace; width: 300px; margin: 0 auto; }
        h2, h3 { text-align: center; margin: 2px 0; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { padding: 4px; text-align: left; }
        .right { text-align: right; }
        .total-row { border-top: 1px solid #000; font-weight: bold; }
        hr { border: 0; border-top: 1px dashed #000; margin: 5px 0; }
        .footer { text-align: center; margin-top: 10px; font-size: 12px; }
    </style>
</head>
<body onload="window.print()">
    <h2>Pahana Edu BookShop</h2>
    <h3>Some Address, Colombo, Sri Lanka</h3>
    <p style="text-align:center;">Phone: +9479032174</p>
    <hr>

    <p>
        <strong>Customer:</strong> <%= customer.getName() %><br>
        <strong>Contact:</strong> <%= customer.getTP() %><br>
        <strong>Order ID:</strong> <%= order.getId() %><br>
        <strong>Date:</strong> <%= order.getCreatedAt() %><br>
    </p>
    <hr>

    <table>
        <thead>
            <tr>
                <th>Item</th>
                <th class="right">Qty</th>
                <th class="right">Price</th>
                <th class="right">Total</th>
            </tr>
        </thead>
        <tbody>
            <%
                double subtotal = 0;
                for(OrderItem item : items) {
                    Item fullItem = itemDao.getItemById(item.getItemId()); // fetch item from ItemDao
                    String itemName = (fullItem != null) ? fullItem.getName() : "Unknown Item";

                    double lineTotal = item.getItemPrice().doubleValue() * item.getQty();
                    subtotal += lineTotal;
            %>
            <tr>
                <td><%= itemName %></td>
                <td class="right"><%= item.getQty() %></td>
                <td class="right"><%= String.format("%.2f", item.getItemPrice()) %></td>
                <td class="right"><%= String.format("%.2f", lineTotal) %></td>
            </tr>
            <% } %>
        </tbody>
    </table>
    <hr>
    <table>
        <tr>
            <td>Subtotal</td>
            <td class="right"><%= String.format("%.2f", subtotal) %></td>
        </tr>
        <tr>
            <td>Discount</td>
            <td class="right"><%= order.getDiscount() %></td>
        </tr>
        <tr class="total-row">
            <td>Total</td>
            <td class="right"><%= String.format("%.2f", subtotal - order.getDiscount().doubleValue()) %></td>
        </tr>
    </table>

    <div class="footer">
        Thank you for your purchase!<br> Visit again for more books.
    </div>
</body>
</html>
