<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>

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

        .login-container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
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
        input[type="password"] {
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

        .register-link {
            text-align: center;
            margin-top: 15px;
        }

        .register-link a {
            text-decoration: none;
            color: #007BFF;
            font-size: 14px;
        }

        .register-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="login-container">
        <h2>Formulario de Ingreso</h2>

        <!-- Formulario de login -->
        <form action="CtrolValidar" method="post">
            <label for="cusuario">Usuario:</label>
            <input type="text" name="cusuario" id="cusuario" required placeholder="Introduce tu usuario"><br>

            <label for="cclave">Contraseña:</label>
            <input type="password" name="cclave" id="cclave" required placeholder="Introduce tu contraseña"><br>

            <input name="accion" value="Ingresar" type="submit">
        </form>

        <!-- Enlace al formulario de registro -->
        <div class="register-link">
            <p>¿No tienes cuenta? <a href="regUsuario.jsp">Regístrate aquí</a></p>
        </div>
    </div>

</body>
</html>