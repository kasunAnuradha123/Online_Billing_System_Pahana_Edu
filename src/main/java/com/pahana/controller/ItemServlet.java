package com.pahana.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.pahana.dao.ItemDao;
import com.pahana.model.Item;

@WebServlet("/ItemServlet")
public class ItemServlet extends HttpServlet {
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

        ItemDao dao = new ItemDao();
        List<Item> items = dao.getItems(page, PAGE_SIZE);
        int totalItems = dao.getItemCount();
        int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);

        request.setAttribute("items", items);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalItems", totalItems);

        request.getRequestDispatcher("View/item/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        ItemDao dao = new ItemDao();
        String action = request.getParameter("action");
        List<String> errors = new ArrayList<>();

        // Collect form values
        String itemCode = request.getParameter("item_code") != null ? request.getParameter("item_code").trim() : "";
        String name = request.getParameter("name") != null ? request.getParameter("name").trim() : "";
        String purchasePriceStr = request.getParameter("purchase_price") != null ? request.getParameter("purchase_price").trim() : "";
        String sellingPriceStr = request.getParameter("selling_price") != null ? request.getParameter("selling_price").trim() : "";
        String stockQuantityStr = request.getParameter("stock_quantity") != null ? request.getParameter("stock_quantity").trim() : "";

        

        // No errors → proceed with action
        if ("add".equalsIgnoreCase(action)) {
        	// Validation
            if (itemCode.isEmpty()) errors.add("Item code is required.");
            if (name.isEmpty()) errors.add("Item name is required.");
            BigDecimal purchasePrice = null;
            BigDecimal sellingPrice = null;
            int stockQuantity = 0;
            try {
                purchasePrice = new BigDecimal(purchasePriceStr);
                if (purchasePrice.compareTo(BigDecimal.ZERO) < 0) errors.add("Purchase price cannot be negative.");
            } catch (NumberFormatException e) {
                errors.add("Invalid purchase price.");
            }
            try {
                sellingPrice = new BigDecimal(sellingPriceStr);
                if (sellingPrice.compareTo(BigDecimal.ZERO) < 0) errors.add("Selling price cannot be negative.");
            } catch (NumberFormatException e) {
                errors.add("Invalid selling price.");
            }
            try {
                stockQuantity = Integer.parseInt(stockQuantityStr);
                if (stockQuantity < 0) errors.add("Stock quantity cannot be negative.");
            } catch (NumberFormatException e) {
                errors.add("Invalid stock quantity.");
            }

            // If errors, return to JSP with data
            if (!errors.isEmpty()) {
                request.setAttribute("errors", errors);
                request.setAttribute("formItemCode", itemCode);
                request.setAttribute("formName", name);
                request.setAttribute("formPurchasePrice", purchasePriceStr);
                request.setAttribute("formSellingPrice", sellingPriceStr);
                request.setAttribute("formStockQuantity", stockQuantityStr);
                // Add a flag to indicate which modal to open
                if ("add".equalsIgnoreCase(action)) {
                    request.setAttribute("openModal", "add");
                }


                doGet(request, response);
                return;
            }
        	
            Item item = new Item();
            item.setItemCode(itemCode);
            item.setName(name);
            item.setPurchasePrice(purchasePrice);
            item.setSellingPrice(sellingPrice);
            item.setStockQuantity(stockQuantity);
            dao.addItem(item);

            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "Item added successfully!");

        } else if ("edit".equalsIgnoreCase(action)) {
        	// Validation
            if (itemCode.isEmpty()) errors.add("Item code is required.");
            if (name.isEmpty()) errors.add("Item name is required.");
            BigDecimal purchasePrice = null;
            BigDecimal sellingPrice = null;
            int stockQuantity = 0;
            try {
                purchasePrice = new BigDecimal(purchasePriceStr);
                if (purchasePrice.compareTo(BigDecimal.ZERO) < 0) errors.add("Purchase price cannot be negative.");
            } catch (NumberFormatException e) {
                errors.add("Invalid purchase price.");
            }
            try {
                sellingPrice = new BigDecimal(sellingPriceStr);
                if (sellingPrice.compareTo(BigDecimal.ZERO) < 0) errors.add("Selling price cannot be negative.");
            } catch (NumberFormatException e) {
                errors.add("Invalid selling price.");
            }
            try {
                stockQuantity = Integer.parseInt(stockQuantityStr);
                if (stockQuantity < 0) errors.add("Stock quantity cannot be negative.");
            } catch (NumberFormatException e) {
                errors.add("Invalid stock quantity.");
            }

            // If errors, return to JSP with data
            if (!errors.isEmpty()) {
                request.setAttribute("errors", errors);
                request.setAttribute("formItemCode", itemCode);
                request.setAttribute("formName", name);
                request.setAttribute("formPurchasePrice", purchasePriceStr);
                request.setAttribute("formSellingPrice", sellingPriceStr);
                request.setAttribute("formStockQuantity", stockQuantityStr);
               
                if ("edit".equalsIgnoreCase(action)) {
                    request.setAttribute("openModal", "edit");
                    request.setAttribute("editId", request.getParameter("id"));
                }


                // Set which modal to open
                doGet(request, response);
                return;
            }
            Item item = new Item();
            item.setId(Integer.parseInt(request.getParameter("id")));
            item.setItemCode(itemCode);
            item.setName(name);
            item.setPurchasePrice(purchasePrice);
            item.setSellingPrice(sellingPrice);
            item.setStockQuantity(stockQuantity);
            dao.updateItem(item);

            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "Item updated successfully!");

        } else if ("delete".equalsIgnoreCase(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.deleteItem(id);

                HttpSession session = request.getSession();
                session.setAttribute("successMessage", "Item deleted successfully!");
            } catch (NumberFormatException e) {
                HttpSession session = request.getSession();
                session.setAttribute("successMessage", "Invalid item ID.");
            }
        }

        response.sendRedirect("ItemServlet");
    }
}
