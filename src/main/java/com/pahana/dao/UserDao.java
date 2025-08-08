package com.pahana.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
}




