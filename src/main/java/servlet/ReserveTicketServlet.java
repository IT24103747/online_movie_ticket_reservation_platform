package servlet;

import model.Reservation;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class ReserveTicketServlet extends HttpServlet {
    private String filePath;

    public void init() {
        String dataDir = getServletContext().getRealPath("/WEB-INF/data");
        File directory = new File(dataDir);
        if (!directory.exists()) directory.mkdirs();
        filePath = dataDir + File.separator + "reservations.txt";
        File file = new File(filePath);
        if (!file.exists()) {
            try { file.createNewFile(); }
            catch (IOException e) { throw new RuntimeException("Failed to create reservations file", e); }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userName = request.getParameter("userName");
        String movie = request.getParameter("movie");
        String showTime = request.getParameter("showTime");
        int seats;
        try {
            seats = Integer.parseInt(request.getParameter("seats"));
        } catch (NumberFormatException e) {
            response.sendRedirect("reserveTicket.jsp?error=Invalid+seat+number");
            return;
        }

        int nextId = getNextId();
        Reservation reservation = new Reservation(nextId, userName, movie, showTime, seats, "pending");

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(reservation.toFileString());
            writer.newLine();
        } catch (IOException e) {
            response.sendRedirect("reserveTicket.jsp?error=Storage+failed");
            return;
        }
        response.sendRedirect("reserveTicket.jsp?success=1");
    }

    private int getNextId() {
        File file = new File(filePath);
        if (!file.exists() || file.length() == 0) return 1;
        int maxId = 0;
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Reservation r = Reservation.fromFileString(line);
                if (r.getId() > maxId) maxId = r.getId();
            }
        } catch (IOException | NumberFormatException e) {
            System.err.println("Error reading IDs: " + e.getMessage());
        }
        return maxId + 1;
    }
}
