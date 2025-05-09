package services;

import model.Users;
import model.Feedback;
import model.CustomerSupport;

import jakarta.servlet.ServletContext;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileHandler {
    private final ServletContext servletContext;
    private final List<Users> users = new ArrayList<>();

    public FileHandler(ServletContext servletContext) {
        this.servletContext = servletContext;
        loadUsers();
    }

    private void loadUsers() {
        String filePath = servletContext.getRealPath("/data/users.txt");
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty() || line.startsWith("#")) {
                    continue;
                }
                String[] parts = line.split(",");
                if (parts.length == 3) {
                    users.add(new Users(parts[0].trim(), parts[1].trim(), parts[2].trim()));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public Users validateUser(String username, String password, String role) {
        return users.stream()
                .filter(u -> u.getUsername().equals(username) && u.getPassword().equals(password) && u.getRole().equals(role))
                .findFirst()
                .orElse(null);
    }

    public void saveFeedback(Feedback feedback) {
        String filePath = servletContext.getRealPath("/data/feedback.txt");
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(String.format("%s,%s,%s,%s%n",
                    escapeCsv(feedback.getName()),
                    escapeCsv(feedback.getEmail()),
                    feedback.getRating(),
                    escapeCsv(feedback.getComments())));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void saveCustomerSupport(CustomerSupport support) {
        String filePath = servletContext.getRealPath("/data/customerSupport.txt");
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(String.format("%s,%s,%s,%s%n",
                    escapeCsv(support.getName()),
                    escapeCsv(support.getEmail()),
                    escapeCsv(support.getIssueType()),
                    escapeCsv(support.getDescription())));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private String escapeCsv(String value) {
        if (value == null) return "";
        if (value.contains(",") || value.contains("\"") || value.contains("\n")) {
            return "\"" + value.replace("\"", "\"\"") + "\"";
        }
        return value;
    }
}