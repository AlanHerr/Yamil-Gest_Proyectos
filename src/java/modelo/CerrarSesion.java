
package modelo;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Alanh
 */
@WebServlet(name = "CerrarSesion", urlPatterns = {"/cerrarSesion"})
public class CerrarSesion extends HttpServlet {

    // Método para procesar la solicitud de cierre de sesión
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Recuperar la sesión actual
            HttpSession sesion_cli = request.getSession(false);  // false significa que no se crea una nueva si no existe
            
            if (sesion_cli != null) {
                // Invalidar la sesión actual
                sesion_cli.invalidate();
            }
            // Redirigir al usuario a la página de login (index.jsp)
            response.sendRedirect("index.jsp");
        } catch (IOException e) {
            // Si hay un error, establecer un mensaje en la sesión
            HttpSession ses = request.getSession(true);
            ses.setAttribute("mensaje", "Session Activa.");
            ses.setAttribute("exc", e.toString());
        }
    }

    // Método para manejar solicitudes GET
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    // Método para manejar solicitudes POST
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    // Método para obtener información sobre el servlet
    @Override
    public String getServletInfo() {
        return "Servlet para cerrar sesión";
    }
}