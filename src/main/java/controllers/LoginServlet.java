package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import services.FileHandler;
import model.Users;

import java.io.IOException;

public class LoginServlet extends HttpServlet {
    private FileHandler fileHandler;

    @Override
    public void init() throws ServletException {
        fileHandler = new FileHandler(getServletContext());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        Users user = fileHandler.validateUser(username, password, role);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            if ("admin".equals(role)) {
                response.sendRedirect("pages/adminDashboard.jsp");
            } else {
                response.sendRedirect("pages/index.jsp");
            }
        } else {
            request.setAttribute("error", "Invalid username, password, or role.");
            request.getRequestDispatcher("pages/login.jsp").forward(request, response);
        }
    }
}