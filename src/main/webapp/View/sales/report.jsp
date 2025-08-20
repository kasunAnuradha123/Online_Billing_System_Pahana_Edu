<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Daily Sales Report</title>
<style>
body { font-family: Arial, sans-serif; margin: 20px; }
h2 { text-align: center; }
table { width: 100%; border-collapse: collapse; margin-top: 20px; }
th, td { border: 1px solid #000; padding: 8px; text-align: left; }
th { background-color: #f2f2f2; }
.text-right { text-align: right; }
.total-row td { font-weight: bold; }
.print-btn { margin-top: 20px; padding: 10px 20px; background: #4CAF50; color: white; border: none; cursor: pointer; border-radius: 5px; }
.print-btn:hover { background: #45a049; }
.debug { color: red; font-weight: bold; }
</style>
</head>
<body>

<h2>Daily Sales Report</h2>

<!-- Debug Section -->
<div class="debug">
    <c:if test="${empty orders}">
        No orders received from servlet.
    </c:if>

    <c:forEach var="order" items="${orders}">
        <p>Order ID: ${order.id}, Customer: ${order.customerName}, Total: ${order.totalAmount}, Discount: ${order.discount}</p>
        <c:if test="${empty order.items}">
            <p>No items for this order.</p>
        </c:if>
        <c:forEach var="item" items="${order.items}">
            <p>Item Name: ${item.itemName}, Price: ${item.itemPrice}, Qty: ${item.qty}, Total: ${item.total}</p>
        </c:forEach>
    </c:forEach>
</div>

<div>
    <table style="border:none; width:100%;">
        <tr>
            <td><strong>Sales Person:</strong> Zach Posey</td>
            <td class="text-right"><strong>Date:</strong> ${fromDate} to ${toDate}</td>
        </tr>
    </table>
</div>

<table>
    <thead>
        <tr>
            <th>Item No</th>
            <th>Item Name</th>
            <th>Description</th>
            <th class="text-right">Price</th>
            <th class="text-right">Qty</th>
            <th class="text-right">Amount</th>
            <th class="text-right">Tax Rate</th>
            <th class="text-right">Tax</th>
            <th class="text-right">Total</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="order" items="${orders}">
            <c:forEach var="item" items="${order.items}">
                <tr>
                    <td>${item.itemId}</td>
                    <td>${item.itemName}</td>
                    <td>${item.description}</td>
                    <td class="text-right">${item.itemPrice}</td>
                    <td class="text-right">${item.qty}</td>
                    <td class="text-right">${item.total}</td>
                    <td class="text-right">15%</td>
                    <td class="text-right">${item.total * 0.15}</td>
                    <td class="text-right">${item.total * 1.15}</td>
                </tr>
            </c:forEach>
        </c:forEach>
        <tr class="total-row">
            <td colspan="8" class="text-right">Sales Amount</td>
            <td class="text-right">${salesAmount}</td>
        </tr>
        <tr class="total-row">
            <td colspan="8" class="text-right">Sales Tax</td>
            <td class="text-right">${salesAmount * 0.15}</td>
        </tr>
        <tr class="total-row">
            <td colspan="8" class="text-right">Sales Total</td>
            <td class="text-right">${salesAmount * 1.15}</td>
        </tr>
    </tbody>
</table>

<button class="print-btn" onclick="window.print()">Print Report</button>

</body>
</html>
