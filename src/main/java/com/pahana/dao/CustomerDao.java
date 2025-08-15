package com.pahana.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.pahana.model.Customer;
import com.pahana.util.DBConnection;

public class CustomerDao {
	
	public List<Customer> getCustomers(int page, int pageSize) {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT id, account_number, name, address, telephone_number, created_at " +
                "FROM customers LIMIT ?, ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

        	stmt.setInt(1, (page - 1) * pageSize); // offset
            stmt.setInt(2, pageSize);              // limit

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Customer customer = new Customer();
                customer.setId(rs.getInt("id"));
                customer.setAccountNumber(rs.getString("account_number"));
                customer.setName(rs.getString("name"));
                customer.setAddress(rs.getString("address"));
                customer.setTP(rs.getString("telephone_number"));
                customer.setCreatedAt(rs.getDate("created_at"));
                customers.add(customer);
            }
            System.out.println("Customers fetched from DB: " + customers.size());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    public int getCustomerCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM customers";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

}
