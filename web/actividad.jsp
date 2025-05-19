<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="modelo.Conexion" %>

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
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Actividad</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .form-container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        label {
            font-size: 14px;
            color: #555;
            margin-bottom: 8px;
            display: block;
        }

        input[type="text"], input[type="submit"], input[type="date"], input[type="time"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            color: #333;
        }

        input[type="submit"] {
            background-color: #28a745;
            color: white;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #218838;
        }

        a {
            text-decoration: none;
            color: #007BFF;
            display: block;
            text-align: center;
            margin-top: 20px;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Formulario para Agendar Proyectos</h2>

    <form action="agregarActividad" method="post">
        <label for="nombre">Nombre del Proyecto:</label>
        <input type="text" name="nombre" id="nombre" required>

        <label for="enlace">Informacion:</label>
        <input type="text" name="enlace" id="enlace" required>

        <label for="fecha">Fecha límite:</label>
        <input type="date" name="fecha" id="fecha" required>

        <label for="hora">Hora límite:</label>
        <input type="time" name="hora" id="hora" required>

        <input type="submit" value="Agendar Proyecto">
    </form>

    <a href="cpanel.jsp" class="btn btn-secondary">Volver al Panel</a>
</div>

<!-- Script para validar si la fecha/hora ya pasaron -->
<script>
    document.querySelector("form").addEventListener("submit", function (e) {
        const fecha = document.getElementById("fecha").value;
        const hora = document.getElementById("hora").value;

        const fechaHoraIngresada = new Date(fecha + "T" + hora);
        const ahora = new Date();

        if (fechaHoraIngresada <= ahora) {
            e.preventDefault(); // Detiene el envío del formulario
            alert("🚫 No puedes Agendar un Proyecto con tiempo ya vencido.");
        }
    });
</script>

</body>
</html>