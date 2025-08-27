<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Sales Report</title>
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
</style>
</head>
<body>

<h2>Pahana Edu BookShop - Sales Report</h2>

    <h3 style="text-align:center;">Some Address, Colombo, Sri Lanka</h3>
    <p style="text-align:center;">Phone: +94719032174</p>

<div>
<strong>Date:</strong> ${fromDate} to ${toDate}
   
</div>

<table>
    <thead>
        <tr>
            <th>Order ID</th>
            <th>Customer</th>
            <th>Item Name</th>
            <th class="text-right">Price</th>
            <th class="text-right">Qty</th>
            <th class="text-right">Amount</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="order" items="${orders}">
            <c:forEach var="item" items="${order.items}">
                <tr>
                    <td>${order.id}</td>
                    <td>${order.customerName}</td>
                    <td>${item.itemName}</td>
                    <td class="text-right"><fmt:formatNumber value="${item.itemPrice}" type="currency"  currencySymbol="Rs. "/></td>
                    <td class="text-right">${item.qty}</td>
                    <td class="text-right"><fmt:formatNumber value="${item.total}" type="currency"  currencySymbol="Rs. "/></td>
                </tr>
            </c:forEach>
            <tr class="total-row">
                <td colspan="5" class="text-right">Discount for Order ${order.id}</td>
                <td class="text-right">
                    <fmt:formatNumber value="${order.discount != null ? order.discount : 0}" type="currency"  currencySymbol="Rs. "/>
                </td>
            </tr>
             <tr class="total-row">
            <td colspan="5" class="text-right">Grand Total After Discount</td>
            <td class="text-right"><fmt:formatNumber value="${order.totalAmount}" type="currency"  currencySymbol="Rs. "/></td>
        </tr>
        <tr><td colspan="6"></td></tr>
        </c:forEach>
        <tr class="total-row">
            <td colspan="5" class="text-right"> Total Sales</td>
            <td class="text-right"><fmt:formatNumber value="${salesAmount}" type="currency"  currencySymbol="Rs. "/></td>
        </tr>
    </tbody>
</table>

<button class="print-btn" onclick="window.print()">Print Report</button>

</body>
</html>
