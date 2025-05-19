<%@ page contentType="text/html; charset=utf-8" language="java" import="modelo.UsuarioDAO" %>
<%@ page import="modelo.Usuario" %>
<%
    // Verificar si existe una sesión válida (no crear una nueva)
    HttpSession sesion = request.getSession(false);
    
    // Verificar si el usuario está autenticado
    if (sesion == null || sesion.getAttribute("nUsuario") == null) {
        // Redirigir a la página de inicio si no hay sesión o usuario
        response.sendRedirect("index.jsp?mensaje=" + java.net.URLEncoder.encode("Debe iniciar sesión para acceder a esta página", "UTF-8"));
        return; // Importante para detener la ejecución del resto del JSP
    }

    // Obtener usuario de sesión para mostrar datos actuales
    String usuarioSesion = (String) sesion.getAttribute("nUsuario");
    UsuarioDAO udao = new UsuarioDAO();
    Usuario usuarioObj = udao.listarDatosPorUsuario(usuarioSesion);

    // Para mostrar mensaje de error (si existe)
    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <title>Editar Perfil - Usuario y Contraseña</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            width: 350px;
        }
        label {
            margin-top: 10px;
            display: block;
            font-weight: bold;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="submit"] {
            margin-top: 20px;
            padding: 10px;
            background-color: #28a745;
            border: none;
            color: white;
            cursor: pointer;
            width: 100%;
            border-radius: 5px;
        }
        input[type="submit"]:hover {
            background-color: #218838;
        }
        .btn-back {
            margin-top: 15px;
            text-align: center;
        }
        .btn-back a {
            text-decoration: none;
            color: #007bff;
        }
        .btn-back a:hover {
            text-decoration: underline;
        }
        .error-msg {
            color: red;
            font-weight: bold;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Editar Usuario y Contraseña</h2>

    <% if (error != null) { %>
        <div class="error-msg"><%= error %></div>
    <% } %>

    <% if (usuarioObj != null) { %>
    <form action="editarPerfil" method="post">
        <label for="usuario">Usuario</label>
        <input type="text" id="usuario" name="usuario" value="<%= usuarioObj.getUsuario() %>" required />

        <label for="clave">Nueva Contraseña</label>
        <input type="password" id="clave" name="clave" placeholder="Dejar vacío para no cambiar" />

        <input type="submit" value="Actualizar" />
    </form>
    <% } else { %>
        <p>Usuario no encontrado en sesión. Por favor, inicia sesión de nuevo.</p>
    <% } %>

    <div class="btn-back">
        <a href="cpanel.jsp">Volver al Panel</a>
    </div>
</div>

</body>
</html>
