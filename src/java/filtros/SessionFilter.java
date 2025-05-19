package filtros;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Filtro de seguridad para verificar sesiones de usuario activas
 * @author Alanh
 */
@WebFilter(filterName = "SessionFilter", urlPatterns = {
    /* Páginas JSP protegidas */
    "/cpanel.jsp", 
    "/actividad.jsp", 
    "/administrarTareas.jsp", 
    "/asignarTarea.jsp", 
    "/editarPerfil.jsp", 
    "/EditarUsuario.jsp", 
    "/eliminarActividad.jsp", 
    "/listaUsuarios.jsp", 
    "/verPerfil.jsp",
    /* Servlets protegidos */
    "/eliminarTarea",
    "/marcarTarea",
    "/agregarActividad",
    "/ControladorUsuario",
    "/EditarPerfil",
    "/EditarUsuario",
    "/EliminarUsuario"
})
public class SessionFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Método de inicialización
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // Obtener la sesión actual (sin crear una nueva si no existe)
        HttpSession session = httpRequest.getSession(false);
        
        // Verificar si hay una sesión activa con usuario autenticado
        boolean isAuthenticated = (session != null && session.getAttribute("nUsuario") != null);
        
        // Si la solicitud es para un recurso público (CSS, JS, imágenes), permitir acceso
        String requestURI = httpRequest.getRequestURI();
        boolean isResourceRequest = requestURI.contains(".css") || 
                                   requestURI.contains(".js") || 
                                   requestURI.contains(".png") || 
                                   requestURI.contains(".jpg");
        
        if (isAuthenticated || isResourceRequest) {
            // Configurar encabezados para evitar almacenamiento en caché de páginas protegidas
            httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            httpResponse.setHeader("Pragma", "no-cache");
            httpResponse.setDateHeader("Expires", 0);
            
            // Continuar con la cadena de filtros
            chain.doFilter(request, response);
        } else {
            // Redirigir a la página de inicio de sesión si no está autenticado
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/index.jsp");
        }
    }
    
    @Override
    public void destroy() {
        // Método de destrucción
    }
}
