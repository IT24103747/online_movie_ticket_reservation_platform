package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import services.FileHandler;
import model.Feedback;

import java.io.IOException;

public class FeedbackServlet extends HttpServlet {
    private FileHandler fileHandler;

    @Override
    public void init() throws ServletException {
        fileHandler = new FileHandler(getServletContext());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String rating = request.getParameter("rating");
        String comments = request.getParameter("comments");

        Feedback feedback = new Feedback(name, email, rating, comments);
        fileHandler.saveFeedback(feedback);

        request.setAttribute("message", "Feedback submitted successfully!");
        request.getRequestDispatcher("pages/index.jsp").forward(request, response);
    }
}