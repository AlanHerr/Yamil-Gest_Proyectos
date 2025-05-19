package controlador;

import modelo.Conexion;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "MarcarTareaRealizada", urlPatterns = {"/marcarTarea"})
public class MarcarTareaRealizada extends HttpServlet {    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Verificar que exista una sesión activa
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("nUsuario") == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        
        String idgesActividadStr = request.getParameter("idgesActividad");
        if (idgesActividadStr == null || idgesActividadStr.isEmpty()) {
            response.sendRedirect("cpanel.jsp");
            return;
        }

        int idgesActividad = Integer.parseInt(idgesActividadStr);

        try (Connection con = new Conexion().crearConexion()) {
            String sql = "UPDATE gesActividad SET realizada = TRUE WHERE idgesActividad = ?";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, idgesActividad);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("cpanel.jsp");
    }
}
