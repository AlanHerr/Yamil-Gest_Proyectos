<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="modelo.Conexion" %>

<%
    HttpSession sesion_cli = request.getSession(true); 
    String nUsuario = (String) sesion_cli.getAttribute("nUsuario");

    Connection con = null; 
    Statement sentencia = null; 
    ResultSet resultado = null; 

    try {
        Conexion cn = new Conexion();
        con = cn.crearConexion();
        sentencia = con.createStatement();
        resultado = sentencia.executeQuery("SELECT a.nom_actividad, u.nombre, u.apellido, g.idgesActividad "
                + "FROM actividades a "
                + "JOIN gesActividad g ON a.id_actividad = g.id_actividad "
                + "JOIN usuarios u ON g.idusu = u.idusu");
    } catch (Exception e) {
        e.printStackTrace();
    } 
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administrar Tareas</title>
    <style>
        * {
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            margin: 0;
            padding: 0;
            background-color: #f5f6fa;
        }

        .panel-container {
            padding: 30px;
        }

        h3 {
            color: #2c3e50;
            margin-bottom: 20px;
        }

        .task-table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .task-table th,
        .task-table td {
            padding: 12px;
            border: 1px solid #dcdde1;
            text-align: center;
        }

        .task-table th {
            background-color: #2c3e50;
            color: white;
        }

        .task-table tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .task-table tr:hover {
            background-color: #e0e0e0;
        }

        input[type="submit"] {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #c0392b;
        }

        .btn {
            text-decoration: none;
            padding: 10px 15px;
            border-radius: 5px;
            display: inline-block;
            font-weight: bold;
        }

        .btn-secondary {
            background-color: #7f8c8d;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #626d70;
        }

        .center {
            text-align: center;
        }
    </style>
</head>
<body>

<div class="panel-container">

    <h3>Administrar Tareas</h3>

    <table class="task-table">
        <tr>
            <th>Actividad</th>
            <th>Usuario</th>
            <th>Eliminar</th>
        </tr>

        <%
            while (resultado.next()) {
                String nom_actividad = resultado.getString("nom_actividad");
                String nombreUsuario = resultado.getString("nombre");
                String apellidoUsuario = resultado.getString("apellido");
                int idgesActividad = resultado.getInt("idgesActividad");
        %>
        <tr>
            <td><%= nom_actividad %></td>
            <td><%= nombreUsuario + " " + apellidoUsuario %></td>
            <td>
                <form action="eliminarTarea" method="post" style="display:inline;">
                    <input type="hidden" name="idgesActividad" value="<%= idgesActividad %>" />
                    <input type="submit" value="Eliminar" />
                </form>
            </td>
        </tr>
        <% } %>
    </table>

    <!-- Botón Volver -->
    <div class="center" style="margin-top: 20px;">
        <a href="cpanel.jsp" class="btn btn-secondary">Volver al Panel</a>
    </div>

</div>

</body>
</html>
