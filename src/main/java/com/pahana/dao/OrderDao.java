package com.pahana.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import com.pahana.model.Order;
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


}
