<%@ page import="java.util.List" %>
<%@ page import="modelo.Usuario" %>
<%@ page import="modelo.UsuarioDAO" %>

<%
    // Verificar si existe una sesión válida (no crear una nueva)
    HttpSession sesion = request.getSession(false);
    
    // Verificar si el usuario está autenticado
    if (sesion == null || sesion.getAttribute("nUsuario") == null) {
        // Redirigir a la página de inicio si no hay sesión o usuario
        response.sendRedirect("index.jsp?mensaje=" + java.net.URLEncoder.encode("Debe iniciar sesión para acceder a esta página", "UTF-8"));
        return; // Importante para detener la ejecución del resto del JSP
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Listado de Usuarios</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>

    <h2>Listado de Datos de Usuarios</h2>

    <table>
        <tr>
            <th>Identificaci�n</th>
            <th>Nombres</th>
            <th>Apellidos</th>
            <th>E-mail</th>
            <th>Usuario</th>
            <th>Contrase�a</th>
            <th>Perfil</th>
            <th>Acci�n</th>
        </tr>

        <%
            UsuarioDAO udao = new UsuarioDAO();
            List<Usuario> lista = udao.listadoUsuarios(); // Aseg�rate de usar el nombre correcto

            if (lista.isEmpty()) { 
        %>
            <tr><td colspan="8">No hay usuarios registrados.</td></tr>
        <% 
            } else {
                for (Usuario a : lista) { 
        %>
        <tr>
            <td><%=a.getIdentificacion()%></td>
            <td><%=a.getNombre()%></td>
            <td><%=a.getApellido()%></td>
            <td><%=a.getEmail()%></td>
            <td><%=a.getUsuario()%></td>
            <td>******</td> <!-- Seguridad: no mostrar la contrase�a -->
            <td><%=a.getIdperfil()%></td>
            <td>
                <a href="EditarUsuario.jsp?id=<%=a.getIddato()%>">Editar</a>
                <a href="eliminarUsuario?id=<%=a.getIddato()%>">Eliminar</a>
            </td>
        </tr>
        <% 
                }
            }
        %>
    </table>

</body>
</html>