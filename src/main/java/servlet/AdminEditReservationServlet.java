package servlet;

import model.Reservation;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class AdminEditReservationServlet extends HttpServlet {
    private String filePath;

    public void init() {
        filePath = getServletContext().getRealPath("/WEB-INF/data/reservations.txt");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String userName = request.getParameter("userName");
        String movie = request.getParameter("movie");
        String showTime = request.getParameter("showTime");
        int seats = Integer.parseInt(request.getParameter("seats"));
        String status = request.getParameter("status");

        List<Reservation> reservations = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = br.readLine()) != null) {
                Reservation r = Reservation.fromFileString(line);
                if (r.getId() == id) {
                    r = new Reservation(id, userName, movie, showTime, seats, status);
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
        response.sendRedirect("AdminViewReservationsServlet?edited=1");
    }
}
