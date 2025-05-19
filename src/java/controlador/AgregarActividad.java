package controlador;

import modelo.Conexion;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AgregarActividad", urlPatterns = {"/agregarActividad"})
public class AgregarActividad extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Recuperar datos del formulario
        String nombre = request.getParameter("nombre");
        String enlace = request.getParameter("enlace");
        String fechaLimite = request.getParameter("fecha");
        String horaLimite = request.getParameter("hora");

        if (nombre == null || enlace == null || fechaLimite == null || horaLimite == null ||
            nombre.trim().isEmpty() || enlace.trim().isEmpty() || fechaLimite.trim().isEmpty() || horaLimite.trim().isEmpty()) {
            response.sendRedirect("error.jsp");
            return;
        }

        try (Connection con = new Conexion().crearConexion()) {
            String sql = "INSERT INTO actividades (nom_actividad, enlace, fecha_limite, hora_limite) VALUES (?, ?, ?, ?)";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, nombre);
                ps.setString(2, enlace);
                ps.setString(3, fechaLimite);
                ps.setString(4, horaLimite);

                int resultado = ps.executeUpdate();

                if (resultado > 0) {
                    response.sendRedirect("cpanel.jsp");
                } else {
                    response.sendRedirect("error.jsp");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet para agregar actividades con fecha y hora límite";
    }
}