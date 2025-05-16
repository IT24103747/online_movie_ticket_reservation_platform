package com.moviemanagement.service;

import com.moviemanagement.model.Movie;
import java.io.*;
import java.util.*;
import java.util.stream.*;

public class MovieService {
    private List<Movie> movies;

    public MovieService() {
        try {
            this.movies = FileService.loadMovies();
        } catch (IOException e) {
            this.movies = new ArrayList<>();
            System.err.println("Error loading movies: " + e.getMessage());
        }
    }

    public void addMovie(Movie movie) throws IOException {
        validateMovie(movie);
        movie.setId(UUID.randomUUID().toString());
        movies.add(movie);
        FileService.saveMovies(movies);
    }

    public List<Movie> getAllMovies() {
        return new ArrayList<>(movies);
    }

    public List<Movie> getMoviesSortedByReleaseDate() {
        return movies.stream()
                .sorted(Comparator.comparing(Movie::getReleaseDate))
                .collect(Collectors.toList());
    }

    public Movie getMovieById(String id) {
        return movies.stream()
                .filter(m -> m.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    public void updateMovie(Movie updatedMovie) throws IOException {
        for (int i = 0; i < movies.size(); i++) {
            if (movies.get(i).getId().equals(updatedMovie.getId())) {
                movies.set(i, updatedMovie);
                FileService.saveMovies(movies);
                return;
            }
        }
    }

    public void deleteMovie(String id) throws IOException {
        movies.removeIf(m -> m.getId().equals(id));
        FileService.saveMovies(movies);
    }

    private void validateMovie(Movie movie) {
        if (movie.getTitle() == null || movie.getTitle().trim().isEmpty()) {
            throw new IllegalArgumentException("Title cannot be empty");
        }
        if (movie.getReleaseDate() == null) {
            throw new IllegalArgumentException("Release date cannot be empty");
        }
    }
}