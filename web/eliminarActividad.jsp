<%@ page import="java.sql.*" %>
<%@ page import="modelo.Conexion" %>

<%
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
