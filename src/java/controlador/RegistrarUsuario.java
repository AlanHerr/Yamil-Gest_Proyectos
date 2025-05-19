/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Usuario;
import modelo.UsuarioDAO;

/**
 *
 * @author Alanh
 */
@WebServlet(name = "RegistrarUsuario", urlPatterns = {"/RegistrarUsuario"})
public class RegistrarUsuario extends HttpServlet {

    // Método para procesar la solicitud del formulario de registro
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Recuperar los datos del formulario
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String email = request.getParameter("email");
        String usuario = request.getParameter("usuario");
        String clave = request.getParameter("clave");
        int perfil = Integer.parseInt(request.getParameter("perfil")); // Asumiendo que el perfil es un número

        // Crear un objeto Usuario
        Usuario nuevoUsuario = new Usuario();
        nuevoUsuario.setNombre(nombre);
        nuevoUsuario.setApellido(apellido);
        nuevoUsuario.setEmail(email);
        nuevoUsuario.setUsuario(usuario);
        nuevoUsuario.setClave(clave);
        nuevoUsuario.setIdperfil(perfil); // Establecer el perfil

        // Usar UsuarioDAO para almacenar el usuario en la base de datos
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        int status = usuarioDAO.agregarUsuario(nuevoUsuario);

        // Verificar si el registro fue exitoso
        if (status > 0) {
            response.sendRedirect("index.jsp"); // Redirigir a una página de éxito
        } else {
            response.sendRedirect("error.jsp"); // Redirigir a una página de error
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
        return "Servlet para registrar un nuevo usuario";
    }
}