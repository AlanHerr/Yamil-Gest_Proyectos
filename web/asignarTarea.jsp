<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="modelo.Conexion" %>

<%
    // Recuperar los parámetros del formulario
    String usuarioId = request.getParameter("usuario"); // id del usuario seleccionado
    String actividadId = request.getParameter("actividad"); // id de la actividad seleccionada

    // Variables de conexión
    Connection con = null;
    PreparedStatement ps = null;
    int estatus = 0; // Variable para almacenar el estado de la inserción

    // Verificar si los parámetros son válidos
    if (usuarioId != null && actividadId != null) {
        try {
            // Establecer conexión con la base de datos
            Conexion cn = new Conexion();
            con = cn.crearConexion();

            // NUEVA CONSULTA para insertar usando idusu
            String query = "INSERT INTO gesActividad (idusu, id_actividad) VALUES (?, ?)";

            // Preparar la consulta
            ps = con.prepareStatement(query);
            ps.setInt(1, Integer.parseInt(usuarioId)); // Asignar idusu (usuario específico)
            ps.setInt(2, Integer.parseInt(actividadId)); // Asignar la id_actividad

            // Ejecutar la consulta de inserción
            estatus = ps.executeUpdate();

            if (estatus > 0) {
                // Redirigir al panel si fue exitoso
                response.sendRedirect("cpanel.jsp");
            } else {
                out.println("<h3>Error al asignar la tarea. Por favor, intente de nuevo.</h3>");
            }
        } catch (SQLException ex) {
            out.println("<h3>Error de base de datos: " + ex.getMessage() + "</h3>");
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                out.println("<h3>Error al cerrar recursos: " + ex.getMessage() + "</h3>");
            }
        }
    } else {
        out.println("<h3>Datos inválidos. Por favor, seleccione un usuario y una tarea.</h3>");
    }
%>