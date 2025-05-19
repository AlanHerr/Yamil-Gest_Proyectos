<%-- 
    Document   : mensaje
    Created on : 25 mar 2025, 20:27:22
    Author     : Alanh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true"%>
<%
    // Intentar obtener variables del request attribute (más seguro)
    // Si no existe, intentar obtener de los parámetros
    String titulo = (String)request.getAttribute("titulo");
    if (titulo == null) {
        titulo = request.getParameter("titulo");
    }
    
    String mensaje = (String)request.getAttribute("mensaje");
    if (mensaje == null) {
        mensaje = request.getParameter("mensaje");
    }
    
    String tipo = (String)request.getAttribute("tipo"); // success, danger, warning, info
    if (tipo == null) {
        tipo = request.getParameter("tipo");
    }
    
    String redireccion = (String)request.getAttribute("redireccion");
    if (redireccion == null) {
        redireccion = request.getParameter("redireccion");
    }
    
    // Valores por defecto
    if (titulo == null) {
        if (exception != null) {
            titulo = "Error en la aplicación";
        } else if (response.getStatus() == 404) {
            titulo = "Página no encontrada";
        } else {
            titulo = "Mensaje del Sistema";
        }
    }
    
    if (mensaje == null) {
        if (exception != null) {
            mensaje = "Ha ocurrido un error inesperado: " + exception.getMessage();
        } else if (response.getStatus() == 404) {
            mensaje = "La página que intentas acceder no existe";
        } else {
            mensaje = "Operación completada";
        }
    }
    
    if (tipo == null) {
        if (exception != null || response.getStatus() >= 400) {
            tipo = "danger";
        } else {
            tipo = "success";
        }
    }
    
    if (redireccion == null) {
        if (exception != null || response.getStatus() >= 400) {
            redireccion = "index.jsp";
        } else {
            redireccion = "cpanel.jsp";
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= titulo %></title>
    <!-- Cargar Bootstrap desde CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="alert alert-<%= tipo %> text-center" role="alert">
            <h4 class="alert-heading"><%= titulo %></h4>
            <p><%= mensaje %></p>
            <hr>
            <p class="mb-0">Haz clic en el siguiente enlace para continuar:</p>
            <a href="<%= redireccion %>" class="btn btn-primary mt-3">Continuar</a>
        </div>
        
        <% if (exception != null && request.isUserInRole("admin")) { %>
        <div class="card mt-4">
            <div class="card-header">
                Detalles del error (solo visible para administradores)
            </div>
            <div class="card-body">
                <pre><%= exception.toString() %></pre>
            </div>
        </div>
        <% } %>
    </div>

    <!-- Incluir JS de Bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>