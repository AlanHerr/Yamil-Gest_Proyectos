<%-- 
    Document   : mensaje
    Created on : 25 mar 2025, 20:27:22
    Author     : Alanh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mensaje de Éxito</title>
    <!-- Cargar Bootstrap desde CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="alert alert-success text-center" role="alert">
            <h4 class="alert-heading">¡Registro Exitoso!</h4>
            <p>La información del usuario ha sido registrada correctamente.</p>
            <hr>
            <p class="mb-0">Haz clic en el siguiente enlace para regresar al formulario.</p>
            <a href="index.jsp" class="btn btn-primary mt-3">Regresar al formulario</a>
        </div>
    </div>

    <!-- Incluir JS de Bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>