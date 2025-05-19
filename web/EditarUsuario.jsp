<%@page import="modelo.UsuarioDAO"%>
<%@page import="modelo.Usuario"%>
<%
    // Verificar si existe una sesión válida (no crear una nueva)
    HttpSession sesion = request.getSession(false);
    
    // Verificar si el usuario está autenticado
    if (sesion == null || sesion.getAttribute("nUsuario") == null) {
        // Redirigir a la página de inicio si no hay sesión o usuario
        response.sendRedirect("index.jsp?mensaje=" + java.net.URLEncoder.encode("Debe iniciar sesión para acceder a esta página", "UTF-8"));
        return; // Importante para detener la ejecución del resto del JSP
    }

    int id = Integer.parseInt(request.getParameter("id"));
    UsuarioDAO udao = new UsuarioDAO();
    Usuario u = udao.listarDatos_Id(id);
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <title>Editar Usuario</title>
    <style>
        label { display: block; margin-top: 10px; }
        input[type="text"], input[type="password"] { width: 300px; padding: 5px; }
        input[type="submit"] { margin-top: 15px; padding: 8px 15px; }
        p { margin: 5px 0; }
    </style>
</head>
<body>
    <h2>Editar Usuario (solo Usuario y Contrase�a)</h2>

    <form method="post" action="editarUsuario">
        <input type="hidden" name="cidd" value="<%= id %>" />

        <p><strong>Nombre:</strong> <%= u.getNombre() %></p>
        <p><strong>Apellido:</strong> <%= u.getApellido() %></p>
        <p><strong>Email:</strong> <%= u.getEmail() %></p>
        <p><strong>Perfil:</strong> <%= u.getIdperfil() == 1 ? "Administrador" : "Usuario" %></p>

        <label for="cusuario">Usuario:</label>
        <input type="text" name="cusuario" id="cusuario" value="<%= u.getUsuario() %>" required />

        <label for="cclave">Contrase�a:</label>
        <input type="password" name="cclave" id="cclave" placeholder="Dejar vac�o para no cambiar" />

        <input type="submit" value="Actualizar" />
    </form>

    <p><a href="listaUsuarios.jsp">Volver a lista de usuarios</a></p>
</body>
</html>
