package com.pahana.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.pahana.model.User;
import com.pahana.util.DBConnection;

public class UserDao {

	public User getUserByUsernameAndPassword(String username, String password) {
		User user = null;

		try (Connection conn = DBConnection.getConnection()) {
			String sql = "SELECT * FROM users WHERE username=? AND password=?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, username);
			stmt.setString(2, password);

			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				user = new User();
				user.setId(rs.getInt("id"));
				user.setUsername(rs.getString("username"));
				user.setRole(rs.getString("role"));
				user.setCreatedAt(rs.getDate("created_at"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return user;
	}

	// Get paginated users
	public List<User> getUsers(int page, int pageSize) {
		List<User> users = new ArrayList<>();
		String sql = "SELECT * FROM users ORDER BY id DESC LIMIT ?, ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

			stmt.setInt(1, (page - 1) * pageSize); // offset
			stmt.setInt(2, pageSize); // limit

			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				User user = new User();
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				user.setRole(rs.getString("role"));
				users.add(user);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return users;
	}

	// Count total users (for pagination)
	public int getUserCount() {
		int count = 0;
		String sql = "SELECT COUNT(*) FROM users";
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

	// Add new user

	public void addUser(User user) {
		// generate username (first letter of name + random 4-digit number)
		String generatedUsername = user.getName().replaceAll("\\s+", "").toLowerCase();

		String sql = "INSERT INTO users (name, username, password, role, created_at) VALUES (?, ?, ?, ?, NOW())";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

			stmt.setString(1, user.getName());
			stmt.setString(2, generatedUsername); // auto-generated username
			stmt.setString(3, user.getPassword());
			stmt.setString(4, user.getRole());

			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// Update user
	public void updateUser(User user) {
		String sql;
		if (user.getPassword() == null || user.getPassword().isEmpty()) {
			sql = "UPDATE users SET name = ?, role = ? WHERE id = ?";
		} else {
			sql = "UPDATE users SET name = ?, password = ?, role = ? WHERE id = ?";
		}
		System.out.println(user.getRole());
		System.out.println(user.getName());
		System.out.println(user.getPassword());

		try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, user.getName());

			if (user.getPassword() == null || user.getPassword().isEmpty()) {
				stmt.setString(2, user.getRole());
				stmt.setInt(3, user.getId());
			} else {
				stmt.setString(2, user.getPassword());
				stmt.setString(3, user.getRole());
				stmt.setInt(4, user.getId());
			}
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// Delete user
	public void deleteUser(int id) {
		String sql = "DELETE FROM users WHERE id=?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

			stmt.setInt(1, id);
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
