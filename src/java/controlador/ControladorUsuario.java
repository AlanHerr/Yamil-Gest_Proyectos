/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Usuario;
import modelo.UsuarioDAO;

/**
 *
 * @author Alanh
 */
public class ControladorUsuario extends HttpServlet {

    // Método principal para procesar la solicitud de registro
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Declaración de variables
        String identificacion;
        String nombre;
        String apellido;
        String email;
        String usuario;
        String clave;
        int idperfil;  // Cambiar de String a int

        // Obtener los parámetros del formulario
        identificacion = request.getParameter("cidentificacion");
        nombre = request.getParameter("cnombre");
        apellido = request.getParameter("capellido");
        email = request.getParameter("cmail");
        usuario = request.getParameter("cusuario");
        clave = request.getParameter("cclave");

        // Convertir idperfil a int
        try {
            idperfil = Integer.parseInt(request.getParameter("idperfil"));
        } catch (NumberFormatException e) {
            // Si no se puede convertir, redirigir a error
            response.sendRedirect("error.jsp");
            return;
        }

        // Verificar que los parámetros no sean null o vacíos
        if (identificacion == null || nombre == null || apellido == null || email == null ||
            usuario == null || clave == null || 
            identificacion.trim().isEmpty() || nombre.trim().isEmpty() || 
            apellido.trim().isEmpty() || email.trim().isEmpty() ||
            usuario.trim().isEmpty() || clave.trim().isEmpty()) {

            // Redirigir a una página de error si algún campo está vacío
            response.sendRedirect("error.jsp");
            return;
        }

        // Mostrar los datos recibidos (opcional, para depuración)
        System.out.println("Parámetros recibidos del formulario:");
        System.out.println("Identificación: " + identificacion);
        System.out.println("Nombre: " + nombre);
        System.out.println("Apellido: " + apellido);
        System.out.println("Email: " + email);
        System.out.println("Usuario: " + usuario);
        System.out.println("Clave: " + clave);
        System.out.println("Perfil: " + idperfil);

        // Crear una instancia de Usuario
        Usuario u = new Usuario();
        u.setIdentificacion(identificacion);
        u.setNombre(nombre);
        u.setApellido(apellido);
        u.setEmail(email);
        u.setUsuario(usuario);
        u.setClave(clave);
        u.setIdperfil(idperfil); // Ahora se pasa un int

        // Crear una instancia de UsuarioDAO
        UsuarioDAO udao = new UsuarioDAO();

        // Intentar agregar el usuario a la base de datos
        int status = udao.agregarUsuario(u);

        // Verificar el estado de la operación
        if (status > 0) {
            // Si la inserción fue exitosa, redirigir a la página de éxito
            response.sendRedirect("mensajeExitoso.jsp");
        } else {
            // Si hubo un problema, redirigir a la página de error
            response.sendRedirect("error.jsp");
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
        return "Servlet para procesar el registro de usuarios";
    }
}