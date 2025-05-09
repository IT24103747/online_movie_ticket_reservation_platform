package model;

public class CustomerSupport {
    private String name;
    private String email;
    private String issueType;
    private String description;

    public CustomerSupport(String name, String email, String issueType, String description) {
        this.name = name;
        this.email = email;
        this.issueType = issueType;
        this.description = description;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getIssueType() {
        return issueType;
    }

    public String getDescription() {
        return description;
    }
}