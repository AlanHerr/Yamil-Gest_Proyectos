<%@ page import="java.sql.*" %>
<%@ page import="modelo.Conexion" %>

<%
    // Verificar si existe una sesión válida (no crear una nueva)
    HttpSession sesion = request.getSession(false);
    
    // Verificar si el usuario está autenticado
    if (sesion == null || sesion.getAttribute("nUsuario") == null) {
        // Redirigir a la página de inicio si no hay sesión o usuario
        response.sendRedirect("index.jsp?mensaje=" + java.net.URLEncoder.encode("Debe iniciar sesión para acceder a esta página", "UTF-8"));
        return; // Importante para detener la ejecución del resto del JSP
    }

    String idActividadStr = request.getParameter("id_actividad");
    int idActividad = Integer.parseInt(idActividadStr);

    Connection con = null;
    PreparedStatement ps = null;

    try {
        Conexion cn = new Conexion();
        con = cn.crearConexion();
        ps = con.prepareStatement("DELETE FROM actividades WHERE id_actividad = ?");
        ps.setInt(1, idActividad);
        ps.executeUpdate();

        response.sendRedirect("cpanel.jsp");
    } catch (Exception e) {
        out.println("<div style='color:red;'>Error al eliminar actividad: " + e.getMessage() + "</div>");
    } finally {
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>
