<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="modelo.Conexion" %>

<%
    HttpSession sesion = request.getSession();
    String usuario = (String) sesion.getAttribute("nUsuario");

    Connection con = null;
    Statement sentencia = null;
    ResultSet resultado = null;
    String nombre = "";
    String apellido = "";
    String email = "";

    try {
        Conexion cn = new Conexion();
        con = cn.crearConexion();
        sentencia = con.createStatement();
        resultado = sentencia.executeQuery("SELECT nombre, apellido, email FROM usuarios WHERE usuario = '" + usuario + "'");

        if (resultado.next()) {
            nombre = resultado.getString("nombre");
            apellido = resultado.getString("apellido");
            email = resultado.getString("email");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ver Perfil</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
        }

        h2 {
            text-align: center;
            color: #343a40;
        }

        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }

        table th, table td {
            padding: 10px;
            text-align: left;
        }

        table th {
            background-color: #28a745;
            color: #ffffff;
            font-size: 16px;
        }

        table td {
            background-color: #f8f9fa;
            font-size: 14px;
            color: #343a40;
        }

        .btn {
            display: block;
            text-align: center;
            padding: 10px 15px;
            margin-top: 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .btn:hover {
            background-color: #0056b3;
        }

    </style>
</head>
<body>

<div class="container">
    <h2>Mi Perfil</h2>
    <table>
        <tr>
            <th>Nombre</th>
            <td><%= nombre %></td>
        </tr>
        <tr>
            <th>Apellido</th>
            <td><%= apellido %></td>
        </tr>
        <tr>
            <th>Email</th>
            <td><%= email %></td>
        </tr>
    </table>
    <br>
    <a href="cpanel.jsp" class="btn">Volver al Panel</a>
</div>

</body>
</html>