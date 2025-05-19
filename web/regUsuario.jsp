<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulario de Registro</title>
    
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

        .registration-container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        label {
            font-size: 14px;
            color: #555;
            margin-bottom: 8px;
            display: block;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        select {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            color: #333;
        }

        input[type="submit"] {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px 20px;
            width: 100%;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .back-link {
            text-align: center;
            margin-top: 15px;
        }

        .back-link a {
            text-decoration: none;
            color: #007BFF;
            font-size: 14px;
        }

        .back-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="registration-container">
        <h2>Formulario de Registro de Usuario</h2>

        <!-- Formulario de registro -->
        <form action="RegistrarUsuario" method="post">
            <label for="nombre">Nombre:</label>
            <input type="text" name="nombre" id="nombre" required placeholder="Introduce tu nombre"><br>

            <label for="apellido">Apellido:</label>
            <input type="text" name="apellido" id="apellido" required placeholder="Introduce tu apellido"><br>

            <label for="email">Email:</label>
            <input type="email" name="email" id="email" required placeholder="Introduce tu email"><br>

            <label for="usuario">Usuario:</label>
            <input type="text" name="usuario" id="usuario" required placeholder="Introduce tu usuario"><br>

            <label for="clave">Contraseña:</label>
            <input type="password" name="clave" id="clave" required placeholder="Introduce tu contraseña"><br>

            <label for="perfil">Perfil:</label>
            <select name="perfil" id="perfil" required>
                <option value="1">Administrador</option>
                <option value="2">Usuario Regular</option>
            </select><br>

            <input type="submit" value="Registrar">
        </form>

        <!-- Botón de Volver -->
        <div class="back-link">
            <a href="index.jsp">Volver al Login</a>
        </div>
    </div>

</body>
</html>