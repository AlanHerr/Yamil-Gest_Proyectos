<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Este JSP realiza un forward a mensaje.jsp con parámetros
    request.setAttribute("titulo", "Prueba con Forward");
    request.setAttribute("mensaje", "Este mensaje fue enviado mediante forward con atributos de request");
    request.setAttribute("tipo", "success");
    request.setAttribute("redireccion", "diagnostico_encoding.jsp");
    
    // Forward a mensaje.jsp
    request.getRequestDispatcher("mensaje.jsp").forward(request, response);
%>
