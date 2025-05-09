package model;

public class Feedback {
    private String name;
    private String email;
    private String rating;
    private String comments;

    public Feedback(String name, String email, String rating, String comments) {
        this.name = name;
        this.email = email;
        this.rating = rating;
        this.comments = comments;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getRating() {
        return rating;
    }

    public String getComments() {
        return comments;
    }
}