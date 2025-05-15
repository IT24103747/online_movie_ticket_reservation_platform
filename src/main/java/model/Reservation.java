package model;

public class Reservation {
    private int id;
    private String userName;
    private String movie;
    private String showTime;
    private int seats;
    private String status;

    public Reservation(int id, String userName, String movie, String showTime, int seats, String status) {
        this.id = id;
        this.userName = userName;
        this.movie = movie;
        this.showTime = showTime;
        this.seats = seats;
        this.status = status;
    }

    // Getters
    public int getId() { return id; }
    public String getUserName() { return userName; }
    public String getMovie() { return movie; }
    public String getShowTime() { return showTime; }
    public int getSeats() { return seats; }
    public String getStatus() { return status; }

    // Setter for status
    public void setStatus(String status) { this.status = status; }

    // Utility to parse from file line
    public static Reservation fromFileString(String line) {
        // Example: id|userName|movie|showTime|seats|status
        String[] parts = line.split("\\|");
        return new Reservation(
                Integer.parseInt(parts[0]),
                parts[1],
                parts[2],
                parts[3],
                Integer.parseInt(parts[4]),
                parts[5]
        );
    }

    // Utility to write as file line
    public String toFileString() {
        return id + "|" + userName + "|" + movie + "|" + showTime + "|" + seats + "|" + status;
    }
}
