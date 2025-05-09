package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import services.FileHandler;
import model.CustomerSupport;

import java.io.IOException;

public class CustomerSupportServlet extends HttpServlet {
    private FileHandler fileHandler;

    @Override
    public void init() throws ServletException {
        fileHandler = new FileHandler(getServletContext());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String issueType = request.getParameter("issueType");
        String description = request.getParameter("description");

        CustomerSupport support = new CustomerSupport(name, email, issueType, description);
        fileHandler.saveCustomerSupport(support);

        request.setAttribute("message", "Support request submitted successfully!");
        request.getRequestDispatcher("pages/index.jsp").forward(request, response);
    }
}