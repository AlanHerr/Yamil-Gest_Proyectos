<%@ page import="java.util.List" %>
<%@ page import="modelo.Usuario" %>
<%@ page import="modelo.UsuarioDAO" %>

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
            <th>Identificación</th>
            <th>Nombres</th>
            <th>Apellidos</th>
            <th>E-mail</th>
            <th>Usuario</th>
            <th>Contraseña</th>
            <th>Perfil</th>
            <th>Acción</th>
        </tr>

        <%
            UsuarioDAO udao = new UsuarioDAO();
            List<Usuario> lista = udao.listadoUsuarios(); // Asegúrate de usar el nombre correcto

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
            <td>******</td> <!-- Seguridad: no mostrar la contraseña -->
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