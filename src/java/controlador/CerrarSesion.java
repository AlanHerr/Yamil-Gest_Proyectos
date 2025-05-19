package controlador;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet para manejar el cierre de sesión
 * @author Alanh
 */
@WebServlet(name = "CerrarSesion", urlPatterns = {"/cerrarSesion"})
public class CerrarSesion extends HttpServlet {

    private static final Logger logger = Logger.getLogger(CerrarSesion.class.getName());
    
    // Método para procesar la solicitud de cierre de sesión
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Recuperar la sesión actual
            HttpSession sesionCli = request.getSession(false);  // false significa que no se crea una nueva si no existe
            
            if (sesionCli != null) {
                // Guardar el nombre de usuario para mostrar mensaje
                String nombreUsuario = (String) sesionCli.getAttribute("nUsuario");
                
                // Invalidar la sesión actual
                sesionCli.invalidate();
                  // Registrar el cierre de sesión (para depuración)
                if (nombreUsuario != null) {
                    logger.log(Level.INFO, "Usuario ''{0}'' ha cerrado sesión", nombreUsuario);
                }
                
                // En lugar de redirigir con parámetros, vamos a usar
                // un enfoque más seguro utilizando atributos de solicitud
                request.setAttribute("titulo", "Sesión Finalizada");
                request.setAttribute("mensaje", "Has cerrado sesión correctamente. ¡Hasta pronto!");
                request.setAttribute("tipo", "info");
                request.setAttribute("redireccion", "index.jsp");
                
                // Forward a la página de mensaje
                request.getRequestDispatcher("mensaje.jsp").forward(request, response);
                return;
            }
            // Redirigir al usuario a la página de login (index.jsp)
            response.sendRedirect("index.jsp");
        } catch (IOException e) {
            // Si hay un error, registrar y redirigir
            logger.log(Level.SEVERE, "Error al cerrar sesión: {0}", e.getMessage());
            response.sendRedirect("index.jsp?error=true");
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
