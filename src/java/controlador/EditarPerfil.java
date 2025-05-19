package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import modelo.Usuario;
import modelo.UsuarioDAO;

import java.io.IOException;

@WebServlet(name = "EditarPerfil", urlPatterns = {"/editarPerfil"})
public class EditarPerfil extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String usuarioSesion = (String) session.getAttribute("nUsuario");
        String usuarioNuevo = request.getParameter("usuario").trim();
        String claveNueva = request.getParameter("clave").trim();

        UsuarioDAO udao = new UsuarioDAO();
        Usuario usuarioObj = udao.listarDatosPorUsuario(usuarioSesion);

        if (usuarioObj != null) {
            usuarioObj.setUsuario(usuarioNuevo);
            if (!claveNueva.isEmpty()) {
                usuarioObj.setClave(claveNueva); // Recuerda hashear en producción
            }

            int status = udao.actualizarDatosUsuarioYCclave(usuarioObj);

            if (status > 0) {
                session.setAttribute("nUsuario", usuarioNuevo);
                response.sendRedirect("cpanel.jsp");
            } else {
                request.setAttribute("error", "Error al actualizar");
                request.getRequestDispatcher("editarPerfil.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Usuario no encontrado");
            request.getRequestDispatcher("editarPerfil.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("cpanel.jsp"); // O donde quieras redirigir
    }
}
