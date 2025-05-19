package listeners;

import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;
import java.util.Date;
import java.text.SimpleDateFormat;

/**
 * Listener para monitorear eventos de sesión (creación y destrucción)
 * @author Alanh
 */
@WebListener
public class SessionListener implements HttpSessionListener {
    
    private SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
    
    @Override
    public void sessionCreated(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        String sessionId = session.getId();
        
        // Registrar la creación de la sesión
        System.out.println("=========================================");
        System.out.println("Sesión creada: " + sessionId);
        System.out.println("Fecha y hora: " + dateFormat.format(new Date()));
        System.out.println("Tiempo máximo de inactividad: " + session.getMaxInactiveInterval() + " segundos");
        System.out.println("=========================================");
        
        // Almacenar la hora de creación en la sesión
        session.setAttribute("sessionCreationTime", System.currentTimeMillis());
    }
    
    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        String sessionId = session.getId();
        
        // Calcular tiempo de duración de la sesión si está disponible
        String sessionDuration = "Desconocido";
        Object creationTimeObj = session.getAttribute("sessionCreationTime");
        if (creationTimeObj != null) {
            long creationTime = (Long) creationTimeObj;
            long currentTime = System.currentTimeMillis();
            long durationMs = currentTime - creationTime;
            
            // Convertir a minutos y segundos
            long minutes = (durationMs / 1000) / 60;
            long seconds = (durationMs / 1000) % 60;
            
            sessionDuration = minutes + " minutos, " + seconds + " segundos";
        }
        
        // Registrar la destrucción de la sesión
        System.out.println("=========================================");
        System.out.println("Sesión destruida: " + sessionId);
        System.out.println("Fecha y hora: " + dateFormat.format(new Date()));
        if (session.getAttribute("nUsuario") != null) {
            System.out.println("Usuario: " + session.getAttribute("nUsuario"));
        }
        System.out.println("Duración de la sesión: " + sessionDuration);
        System.out.println("=========================================");
    }
}
