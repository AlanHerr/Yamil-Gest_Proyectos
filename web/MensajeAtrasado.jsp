<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Actividad vencida</title>
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
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
            max-width: 500px;
        }

        h2 {
            color: #dc3545;
            margin-bottom: 20px;
        }

        .btn {
            display: inline-block;
            margin-top: 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 5px;
        }

        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>⏰ Tiempo de ejecución cumplido</h2>
    <p>Esta actividad ha vencido y ya no está disponible para ejecución.</p>

    <a href="cpanel.jsp" class="btn">Regresar al Panel</a>
</div>

</body>
</html>