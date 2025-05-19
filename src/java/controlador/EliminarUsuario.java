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
import modelo.UsuarioDAO;

/**
 *
 * @author Alanh
 */
@WebServlet(name = "EliminarUsuario", urlPatterns = {"/eliminarUsuario"})
public class EliminarUsuario extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        int id = Integer.parseInt(request.getParameter("id"));
        UsuarioDAO udao = new UsuarioDAO();
        int status = udao.eliminarDatos(id);

        if (status > 0) {
            response.sendRedirect("listaUsuarios.jsp");
        }
    }
}