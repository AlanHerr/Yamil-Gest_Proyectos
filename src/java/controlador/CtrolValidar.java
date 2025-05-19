package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.LoginDAO;
import modelo.Usuario;

@WebServlet(name = "CtrolValidar", urlPatterns = {"/CtrolValidar"})
public class CtrolValidar extends HttpServlet {

    LoginDAO logindao = new LoginDAO();
    Usuario datos = new Usuario();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion_cli = request.getSession(true);
        String accion = request.getParameter("accion");

        if (accion != null && accion.equalsIgnoreCase("Ingresar")) {
            String usu = request.getParameter("cusuario");
            String cla = request.getParameter("cclave");

            // Validar el login contra la base de datos
            datos = logindao.Login_datos(usu, cla);

            if (datos != null && datos.getUsuario() != null) {
                // Guardar el nombre de usuario en sesión
                sesion_cli.setAttribute("nUsuario", datos.getUsuario());

                // 🔥 NUEVO: Guardar el idusu del usuario logueado
                sesion_cli.setAttribute("idUsuario", datos.getIddato()); // o getIdusu()

                // Redirigir al panel de control
                request.getRequestDispatcher("cpanel.jsp").forward(request, response);
            } else {
                // Redirigir al login con error si la validación falla
                response.sendRedirect("index.jsp?error=1");
            }

        } else {
            // Acción no válida: redirigir a login
            response.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("index.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Servlet de validación de usuario";
    }
}