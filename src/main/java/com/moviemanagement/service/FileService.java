package com.moviemanagement.service;

import com.moviemanagement.model.Movie;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

public class FileService {
    private static final String FILE_PATH = "movies.txt";

    public static void saveMovies(List<Movie> movies) throws IOException {
        List<String> lines = movies.stream()
                .map(Movie::toString)
                .collect(Collectors.toList());
        Files.write(Paths.get(FILE_PATH), lines);
    }

    public static List<Movie> loadMovies() throws IOException {
        if (!Files.exists(Paths.get(FILE_PATH))) {
            return new ArrayList<>();
        }
        return Files.lines(Paths.get(FILE_PATH))
                .filter(line -> !line.trim().isEmpty())
                .map(line -> {
                    try {
                        return Movie.fromString(line);
                    } catch (Exception e) {
                        System.err.println("Skipping invalid movie line: " + line);
                        return null;
                    }
                })
                .filter(Objects::nonNull)
                .collect(Collectors.toList());
    }
}