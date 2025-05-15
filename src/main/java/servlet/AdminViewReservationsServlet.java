package servlet;

import model.Reservation;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class AdminViewReservationsServlet extends HttpServlet {
    private String filePath;

    public void init() {
        filePath = getServletContext().getRealPath("/WEB-INF/data/reservations.txt");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Reservation> reservations = new ArrayList<>();
        File file = new File(filePath);
        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    reservations.add(Reservation.fromFileString(line));
                }
            }
        }
        request.setAttribute("reservations", reservations);
        request.getRequestDispatcher("adminReservations.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
