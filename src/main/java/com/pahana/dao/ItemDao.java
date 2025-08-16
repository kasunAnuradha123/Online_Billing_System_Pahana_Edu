package com.pahana.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.pahana.model.Customer;
import com.pahana.model.Item;
import com.pahana.util.DBConnection; // Make sure you have a DB connection utility

public class ItemDao {

	// Get paginated items
	public List<Item> getItems(int page, int pageSize) {
		List<Item> items = new ArrayList<>();

		String sql = "SELECT * " + "FROM items ORDER BY id DESC LIMIT ?, ?";
		

		try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

			stmt.setInt(1, (page - 1) * pageSize); // offset
			stmt.setInt(2, pageSize); // limit

			ResultSet rs = stmt.executeQuery();
			
				while (rs.next()) {
					Item item = new Item();
					item.setId(rs.getInt("id"));
					item.setItemCode(rs.getString("item_code"));
					item.setName(rs.getString("name"));
					item.setPurchasePrice(rs.getBigDecimal("purchase_price"));
					item.setSellingPrice(rs.getBigDecimal("selling_price"));
					item.setStockQuantity(rs.getInt("stock_quantity"));
					item.setCreatedAt(rs.getTimestamp("created_at"));
					item.setUpdatedAt(rs.getTimestamp("updated_at"));

					items.add(item);
				}
			

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return items;
	}

	// Get total item count
	public int getItemCount() {
		String sql = "SELECT COUNT(*) FROM items";
		try (Connection conn = DBConnection.getConnection();
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(sql)) {

			if (rs.next()) {
				return rs.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	// Add new item
	public boolean addItem(Item item) {
		String sql = "INSERT INTO items (item_code, name, purchase_price, selling_price, stock_quantity) VALUES (?, ?, ?, ?, ?)";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, item.getItemCode());
			ps.setString(2, item.getName());
			ps.setBigDecimal(3, item.getPurchasePrice());
			ps.setBigDecimal(4, item.getSellingPrice());
			ps.setInt(5, item.getStockQuantity());

			return ps.executeUpdate() > 0;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	// Update item
	public boolean updateItem(Item item) {
		String sql = "UPDATE items SET item_code=?, name=?, purchase_price=?, selling_price=?, stock_quantity=? WHERE id=?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, item.getItemCode());
			ps.setString(2, item.getName());
			ps.setBigDecimal(3, item.getPurchasePrice());
			ps.setBigDecimal(4, item.getSellingPrice());
			ps.setInt(5, item.getStockQuantity());
			ps.setInt(6, item.getId());

			return ps.executeUpdate() > 0;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	// Delete item
	public boolean deleteItem(int id) {
		String sql = "DELETE FROM items WHERE id=?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, id);
			return ps.executeUpdate() > 0;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	// Optional: Get item by ID
	public Item getItemById(int id) {
		String sql = "SELECT * FROM items WHERE id=?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, id);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					Item item = new Item();
					item.setId(rs.getInt("id"));
					item.setItemCode(rs.getString("item_code"));
					item.setName(rs.getString("name"));
					item.setPurchasePrice(rs.getBigDecimal("purchase_price"));
					item.setSellingPrice(rs.getBigDecimal("selling_price"));
					item.setStockQuantity(rs.getInt("stock_quantity"));
					item.setCreatedAt(rs.getTimestamp("created_at"));
					item.setUpdatedAt(rs.getTimestamp("updated_at"));
					return item;
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
}
