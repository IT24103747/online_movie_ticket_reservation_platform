package com.moviemanagement.model;

import java.time.LocalDate;

public class Movie {
    private String id;
    private String title;
    private String description;
    private LocalDate releaseDate;
    private boolean available;

    public Movie() {}

    public Movie(String id, String title, String description, LocalDate releaseDate, boolean available) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.releaseDate = releaseDate;
        this.available = available;
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public LocalDate getReleaseDate() { return releaseDate; }
    public void setReleaseDate(LocalDate releaseDate) { this.releaseDate = releaseDate; }
    public boolean isAvailable() { return available; }
    public void setAvailable(boolean available) { this.available = available; }

    @Override
    public String toString() {
        return id + "," + title + "," + description + "," + releaseDate + "," + available;
    }

    public static Movie fromString(String str) {
        String[] parts = str.split(",");
        return new Movie(
                parts[0],
                parts[1],
                parts[2],
                LocalDate.parse(parts[3]),
                Boolean.parseBoolean(parts[4])
        );
    }
}