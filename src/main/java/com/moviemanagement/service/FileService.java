package com.moviemanagement.service;

import com.moviemanagement.model.Movie;
import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.stream.*;

public class FileService {
    private static final String DATA_DIR = "C:\\online_movie_ticket_reservation_platform\\";
    private static final String FILE_PATH = DATA_DIR + "movies.txt";

    static {
        try {
            Files.createDirectories(Paths.get(DATA_DIR));
        } catch (IOException e) {
            System.err.println("Failed to create data directory: " + e.getMessage());
        }
    }

    public static void saveMovies(List<Movie> movies) throws IOException {
        List<String> lines = movies.stream()
                .map(Movie::toString)
                .collect(Collectors.toList());
        Files.write(Paths.get(FILE_PATH), lines,
                StandardOpenOption.CREATE,
                StandardOpenOption.TRUNCATE_EXISTING);
    }

    public static List<Movie> loadMovies() throws IOException {
        Path path = Paths.get(FILE_PATH);
        if (!Files.exists(path)) {
            return new ArrayList<>();
        }
        return Files.lines(path)
                .map(Movie::fromString)
                .collect(Collectors.toList());
    }
}