package com.pahana.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pahana.dao.UserDao;
import com.pahana.model.User;

/**
 * Servlet implementation class UserServlet
 */
@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
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

        UserDao dao = new UserDao();
        List<User> users = dao.getUsers(page, PAGE_SIZE);
        int totalUsers = dao.getUserCount();
        int totalPages = (int) Math.ceil((double) totalUsers / PAGE_SIZE);

        request.setAttribute("users", users);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalUsers", totalUsers);

        request.getRequestDispatcher("View/users/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        UserDao dao = new UserDao();
        String action = request.getParameter("action");

        List<String> errors = new ArrayList<>();

        String name = request.getParameter("name") != null ? request.getParameter("name").trim() : "";
        String password = request.getParameter("password") != null ? request.getParameter("password").trim() : "";
        String role = request.getParameter("role") != null ? request.getParameter("role").trim() : "";

        if ("add".equalsIgnoreCase(action)) {
            if (name.isEmpty()) {
                errors.add("Name is required.");
            }
            if (password.isEmpty()) {
                errors.add("Password is required.");
            }
            if (role.isEmpty()) {
                errors.add("Role is required.");
            }

            if (!errors.isEmpty()) {
                request.setAttribute("errors", errors);
                request.setAttribute("formName", name);
                request.setAttribute("formRole", role);
                request.setAttribute("formPw", password);
                request.setAttribute("openModal", "add");
                doGet(request, response);
                return;
            }

            User u = new User();
            u.setName(name);
            u.setPassword(password);
            u.setRole(role);
            dao.addUser(u);

            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "User added successfully!");

        } else if ("edit".equalsIgnoreCase(action)) {
            if (name.isEmpty()) {
                errors.add("Name is required.");
            }
            if (role.isEmpty()) {
                errors.add("Role is required.");
            }
            
            if (!errors.isEmpty()) {
                request.setAttribute("errors", errors);
                request.setAttribute("formName", name);
                request.setAttribute("formRole", role);
                request.setAttribute("formpw", password);
                request.setAttribute("openModal", "edit");
                request.setAttribute("editId", request.getParameter("id"));
                doGet(request, response);
                return;
            }

            User u = new User();
            u.setId(Integer.parseInt(request.getParameter("id")));
            u.setName(name);
            u.setPassword(password); // update password if changed
            u.setRole(role);
            dao.updateUser(u);

            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "User updated successfully!");

        } else if ("delete".equalsIgnoreCase(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.deleteUser(id);

                HttpSession session = request.getSession();
                session.setAttribute("successMessage", "User deleted successfully!");
            } catch (NumberFormatException e) {
                HttpSession session = request.getSession();
                session.setAttribute("errorMessage", "Invalid user ID.");
            }
        }

        // Redirect back to servlet (refresh list)
        response.sendRedirect("UserServlet");
    }
}
