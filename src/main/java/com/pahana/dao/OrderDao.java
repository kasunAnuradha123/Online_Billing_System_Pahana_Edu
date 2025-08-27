package com.pahana.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.pahana.model.Order;
import com.pahana.model.OrderItem;
import com.pahana.util.DBConnection;

public class OrderDao {
	private String itemName;

	public String getItemName() { return itemName; }
	public void setItemName(String itemName) { this.itemName = itemName; }
    // Insert an order and return the generated order ID
    public int saveOrder(Order order) {
        int generatedId = -1;
        String sql = "INSERT INTO orders (customer_id, total_amount, discount, created_at) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, order.getCustomerId());
            ps.setBigDecimal(2, order.getTotalAmount());
            ps.setBigDecimal(3, order.getDiscount());
            ps.setTimestamp(4, order.getCreatedAt());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    generatedId = rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return generatedId;
    }
    
    public Order getOrderById(int orderId) {
        Order order = null;
        String sql = "SELECT * FROM orders WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                order = new Order();
                order.setId(rs.getInt("id"));
                order.setCustomerId(rs.getInt("customer_id"));
                order.setDiscount(rs.getBigDecimal("discount"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                // Add any other order fields if needed
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return order;
    }
    
    public List<Order> getOrders(int page, int pageSize) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, c.name AS customer_name FROM orders o "
                   + "JOIN customers c ON o.customer_id = c.id "
                   + "ORDER BY o.id DESC LIMIT ?, ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, (page - 1) * pageSize);
            stmt.setInt(2, pageSize);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order o = new Order();
                o.setId(rs.getInt("id"));
                o.setCustomerName(rs.getString("customer_name"));
                o.setTotalAmount(rs.getBigDecimal("total_amount"));
                o.setDiscount(rs.getBigDecimal("discount"));
                orders.add(o);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public int getOrderCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM orders";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public boolean deleteOrder(int id) {
        String sql = "DELETE FROM orders WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //sales report query
    public List<Order> getOrdersByDateRangeWithItems(String startDate, String endDate) {
        List<Order> orders = new ArrayList<>();

        String sqlOrders = "SELECT o.*, c.name AS customer_name " +
                           "FROM orders o " +
                           "JOIN customers c ON o.customer_id = c.id " +
                           "WHERE o.created_at BETWEEN ? AND ? " +
                           "ORDER BY o.created_at ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sqlOrders)) {

            stmt.setString(1, startDate + " 00:00:00");
            stmt.setString(2, endDate + " 23:59:59");

          

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setCustomerId(rs.getInt("customer_id"));
                order.setCustomerName(rs.getString("customer_name"));
                order.setTotalAmount(rs.getBigDecimal("total_amount"));
                order.setDiscount(rs.getBigDecimal("discount"));

                
                List<OrderItem> items = new ArrayList<>();
                String sqlItems = "SELECT oi.id, oi.order_id, oi.item_id, i.name AS item_name, oi.item_price, oi.qty " +
                                  "FROM order_items oi " +
                                  "JOIN items i ON oi.item_id = i.id " +
                                  "WHERE oi.order_id = ?";

                try (PreparedStatement stmtItems = conn.prepareStatement(sqlItems)) {
                    stmtItems.setInt(1, order.getId());
                    ResultSet rsItems = stmtItems.executeQuery();
                    while (rsItems.next()) {
                        OrderItem item = new OrderItem();
                        item.setId(rsItems.getInt("id"));
                        item.setOrderId(rsItems.getInt("order_id"));
                        item.setItemId(rsItems.getInt("item_id"));
                        item.setItemName(rsItems.getString("item_name"));
                        item.setItemPrice(rsItems.getBigDecimal("item_price"));
                        item.setQty(rsItems.getInt("qty"));
                        item.setTotal(item.getItemPrice().multiply(new java.math.BigDecimal(item.getQty())));
                        items.add(item);
                    }
                }

                order.setItems(items);
                orders.add(order);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }


}
