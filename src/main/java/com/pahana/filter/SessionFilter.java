package com.pahana.filter;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

@WebFilter("/View/*") // Protect all View inside /View/
public class SessionFilter implements Filter {
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);

        boolean loggedIn = (session != null && session.getAttribute("loggedUser") != null);
        boolean loginPage = req.getRequestURI().endsWith("login.jsp") || req.getRequestURI().endsWith("LoginServlet");

        if (loggedIn || loginPage) {
            chain.doFilter(request, response); // Continue
        } else {
            res.sendRedirect(req.getContextPath() + "/View/auth/login.jsp");
        }
    }
}
