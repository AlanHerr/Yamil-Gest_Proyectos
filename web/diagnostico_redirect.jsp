<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Este JSP realiza un redirect a mensaje.jsp con parámetros
    String titulo = "Prueba con Redirect";
    String mensaje = "Este mensaje fue enviado mediante redirect con parámetros de URL";
    
    // Codificar los parámetros para URL
    String tituloEncoded = java.net.URLEncoder.encode(titulo, "UTF-8");
    String mensajeEncoded = java.net.URLEncoder.encode(mensaje, "UTF-8");
    
    // Redirect a mensaje.jsp
    response.sendRedirect("mensaje.jsp?titulo=" + tituloEncoded + 
                          "&mensaje=" + mensajeEncoded + 
                          "&tipo=warning&redireccion=diagnostico_encoding.jsp");
%>
