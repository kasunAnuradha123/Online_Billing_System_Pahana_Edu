package com.pahana.controller.Login;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pahana.dao.UserDao;
import com.pahana.model.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDao userDao = new UserDao();
        User user = userDao.getUserByUsernameAndPassword(username, password);

        if (user != null) {
            // Login success → Store in session
            HttpSession session = request.getSession();
            session.setAttribute("loggedUser", user);

            response.sendRedirect("pages/dashboard.jsp");
        } else {
            // Login failed → Show error
            request.setAttribute("errorMessage", "Invalid username or password!");
            request.getRequestDispatcher("pages/login.jsp").forward(request, response);
        }
    }
}
