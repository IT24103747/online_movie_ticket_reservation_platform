package servlet;

import model.Reservation;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class AdminUpdateReservationServlet extends HttpServlet {
    private String filePath;

    public void init() {
        filePath = getServletContext().getRealPath("/WEB-INF/data/reservations.txt");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String action = request.getParameter("action"); // "accept" or "reject"
        String status = "pending";
        if ("accept".equals(action)) status = "accepted";
        else if ("reject".equals(action)) status = "rejected";

        List<Reservation> reservations = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = br.readLine()) != null) {
                Reservation r = Reservation.fromFileString(line);
                if (r.getId() == id) {
                    r.setStatus(status);
                }
                reservations.add(r);
            }
        }

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filePath))) {
            for (Reservation r : reservations) {
                bw.write(r.toFileString());
                bw.newLine();
            }
        }

        response.sendRedirect("AdminViewReservationsServlet?updated=1");
    }
}
