package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Usuario;
import modelo.UsuarioDAO;

@WebServlet(name = "EditarUsuario", urlPatterns = {"/editarUsuario"})
public class EditarUsuario extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        int id = Integer.parseInt(request.getParameter("cidd"));
        String usuario = request.getParameter("cusuario").trim();
        String claveNueva = request.getParameter("cclave").trim();

        UsuarioDAO udao = new UsuarioDAO();
        Usuario uActual = udao.listarDatos_Id(id);

        if (uActual == null) {
            response.sendRedirect("error.jsp");
            return;
        }

        uActual.setUsuario(usuario);

        // Actualizar clave solo si el campo no está vacío
        if (!claveNueva.isEmpty()) {
            // Aquí puedes agregar hashing si tienes implementado
            uActual.setClave(claveNueva);
        }

        int status = udao.actualizarDatosUsuarioYCclave(uActual);

        if (status > 0) {
            response.sendRedirect("listaUsuarios.jsp");
        } else {
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Para evitar que se acceda directamente por GET sin contexto, redirigimos
        response.sendRedirect("listaUsuarios.jsp");
    }
}
