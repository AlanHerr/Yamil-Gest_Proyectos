package filtros;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Filtro de seguridad para verificar sesiones de usuario activas
 * @author Alanh
 */
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
        
        // Establecer codificación UTF-8 para todas las solicitudes
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // Obtener la sesión actual (sin crear una nueva si no existe)
        HttpSession session = httpRequest.getSession(false);
        
        // Verificar si hay una sesión activa con usuario autenticado
        boolean isAuthenticated = (session != null && session.getAttribute("nUsuario") != null);
        
        // Si la solicitud es para un recurso público (CSS, JS, imágenes), permitir acceso
        String requestURI = httpRequest.getRequestURI();
        boolean isResourceRequest = requestURI.contains(".css") || 
                                   requestURI.contains(".js") || 
                                   requestURI.contains(".png") || 
                                   requestURI.contains(".jpg") ||
                                   requestURI.contains(".gif") ||
                                   requestURI.contains(".ico");
          // Verificar si es una URL pública (siempre permitida)
        boolean isPublicPage = requestURI.endsWith("/index.jsp") || 
                              requestURI.endsWith("/regUsuario.jsp") ||
                              requestURI.contains("/mensaje.jsp") ||
                              requestURI.contains("/CtrolValidar") ||
                              requestURI.contains("/RegistrarUsuario") ||
                              requestURI.contains("/diagnostico_") ||
                              requestURI.contains("/solucion_");
        
        System.out.println("### SessionFilter: URI=" + requestURI + 
                         ", Autenticado=" + isAuthenticated + 
                         ", RecursoPublico=" + isResourceRequest + 
                         ", PaginaPublica=" + isPublicPage);
        
        if (isAuthenticated || isResourceRequest || isPublicPage) {
            // Configurar encabezados para evitar almacenamiento en caché de páginas protegidas
            httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            httpResponse.setHeader("Pragma", "no-cache");
            httpResponse.setDateHeader("Expires", 0);
            
            // Continuar con la cadena de filtros
            chain.doFilter(request, response);
        } else {
            // Redirigir a la página de inicio de sesión con mensaje informativo
            String message = java.net.URLEncoder.encode("Debe iniciar sesión para acceder a esta página", "UTF-8");
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/index.jsp?mensaje=" + message);
        }
    }
    
    @Override
    public void destroy() {
        // Método de destrucción
    }
}
