package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.GesActividadDAO;

@WebServlet(name = "EliminarTarea", urlPatterns = {"/eliminarTarea"})
public class EliminarTarea extends HttpServlet {    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Verificar que exista una sesión activa
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("nUsuario") == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        
        try {
            int idgesActividad = Integer.parseInt(request.getParameter("idgesActividad"));

            // Crear instancia del DAO de GesActividad
            GesActividadDAO gesActividadDAO = new GesActividadDAO();
            
            // Eliminar la tarea
            int status = gesActividadDAO.eliminarTarea(idgesActividad);

            if (status > 0) {
                response.sendRedirect("cpanel.jsp");  // Redirigir al panel de control
            } else {
                response.sendRedirect("mensaje.jsp?titulo=Error&mensaje=No+se+pudo+eliminar+la+tarea&tipo=danger&redireccion=cpanel.jsp");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("mensaje.jsp?titulo=Error&mensaje=ID+de+tarea+inválido&tipo=danger&redireccion=cpanel.jsp");
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
        return "Servlet para eliminar tareas asignadas a usuarios";
    }
}
