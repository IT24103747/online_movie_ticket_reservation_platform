package com.moviemanagement.servlet;

import com.moviemanagement.model.Movie;
import com.moviemanagement.service.MovieService;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.time.*;

@WebServlet("/movies")
public class MovieServlet extends HttpServlet {
    private MovieService movieService;

    @Override
    public void init() {
        movieService = new MovieService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            if (action == null) action = "list";

            switch (action) {
                case "new": showNewForm(request, response); break;
                case "edit": showEditForm(request, response); break;
                case "delete": deleteMovie(request, response); break;
                default: listMovies(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            if ("add".equals(action)) {
                addMovie(request, response);
            } else if ("update".equals(action)) {
                updateMovie(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void listMovies(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("movies", movieService.getMoviesSortedByReleaseDate());
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/html/add.html").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        Movie movie = movieService.getMovieById(id);
        if (movie == null) {
            response.sendRedirect(request.getContextPath() + "/movies");
            return;
        }
        request.setAttribute("movie", movie);
        request.getRequestDispatcher("/html/edit.html").forward(request, response);
    }

    private void addMovie(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        LocalDate releaseDate = LocalDate.parse(request.getParameter("releaseDate"));
        boolean available = Boolean.parseBoolean(request.getParameter("available"));

        Movie newMovie = new Movie(null, title, description, releaseDate, available);
        movieService.addMovie(newMovie);
        response.sendRedirect(request.getContextPath() + "/movies");
    }

    private void updateMovie(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        LocalDate releaseDate = LocalDate.parse(request.getParameter("releaseDate"));
        boolean available = Boolean.parseBoolean(request.getParameter("available"));

        Movie movie = new Movie(id, title, description, releaseDate, available);
        movieService.updateMovie(movie);
        response.sendRedirect(request.getContextPath() + "/movies");
    }

    private void deleteMovie(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String id = request.getParameter("id");
        movieService.deleteMovie(id);
        response.sendRedirect(request.getContextPath() + "/movies");
    }
}