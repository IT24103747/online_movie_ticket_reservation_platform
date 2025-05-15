package com.moviemanagement.service;

import com.moviemanagement.model.Movie;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

public class MovieService {
    private List<Movie> movies;

    public MovieService() {
        try {
            this.movies = FileService.loadMovies();
        } catch (IOException e) {
            this.movies = new ArrayList<>();
        }
    }

    public void addMovie(Movie movie) throws IOException {
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
        throw new IllegalArgumentException("Movie not found with id: " + updatedMovie.getId());
    }

    public void deleteMovie(String id) throws IOException {
        if (!movies.removeIf(m -> m.getId().equals(id))) {
            throw new IllegalArgumentException("Movie not found with id: " + id);
        }
        FileService.saveMovies(movies);
    }
}