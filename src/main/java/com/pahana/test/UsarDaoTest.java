package com.pahana.test;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import com.pahana.dao.UserDao;
import com.pahana.model.User;

class UsarDaoTest {
	private static UserDao userDao;
	@BeforeAll
	static void setup() {
		userDao = new UserDao();
	}
	@Test
	void testGetUserByUsernameAndPassword() {
		String username = "admin";
		String password = "admin124443";

		User user = userDao.getUserByUsernameAndPassword(username, password);

		assertNotNull(user, "User should not be null");
		assertEquals(username, user.getUsername(), "Username should match");
		assertNotNull(user.getRole(), "Role should not be null");
	}
	@Test
	void testAddUser() {
		User user = new User();
		user.setName("Kasun Anuradha");
		user.setUsername("kasun12332342343434");
		user.setPassword("password123");
		user.setRole("admin");
		userDao.addUser(user);
	}
	@Test
	void testUpdateUser() {
		User user = new User();
		user.setName("Kasun");
		user.setUsername("kasun_anu");
		user.setRole("admin");
		userDao.updateUser(user);
	}

}
