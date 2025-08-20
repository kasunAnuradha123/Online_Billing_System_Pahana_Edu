package com.pahana.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.pahana.dao.UserDao;
import com.pahana.model.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 🔹 Validate required fields
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {

            request.setAttribute("errorMessage", "Username and Password are required!");
            request.getRequestDispatcher("View/auth/login.jsp").forward(request, response);
            return; // stop further execution
        }

        UserDao userDao = new UserDao();
        User user = userDao.getUserByUsernameAndPassword(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("loggedUser", user);

            // Optional: Set session timeout in seconds (e.g., 2h)
            session.setMaxInactiveInterval(2 * 60 * 60);

            response.sendRedirect(request.getContextPath() + "/BillingServlet");
        } else {
            request.setAttribute("errorMessage", "Invalid username or password!");
            request.getRequestDispatcher("View/auth/login.jsp").forward(request, response);
        }
    }
}
