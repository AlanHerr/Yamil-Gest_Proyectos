<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Diagnóstico de Codificación</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .box { border: 1px solid #ccc; padding: 15px; margin-bottom: 20px; }
        h3 { margin-top: 0; }
        pre { background-color: #f5f5f5; padding: 10px; border-radius: 5px; }
        .success { color: green; }
        .error { color: red; }
    </style>
</head>
<body>
    <h2>Diagnóstico de Codificación de Caracteres</h2>
    
    <div class="box">
        <h3>Información del Request</h3>
        <p>Método: <%= request.getMethod() %></p>
        <p>ContentType: <%= request.getContentType() %></p>
        <p>CharacterEncoding: <%= request.getCharacterEncoding() %></p>
    </div>

    <div class="box">
        <h3>Parámetros recibidos</h3>
        <%
        java.util.Enumeration<String> paramNames = request.getParameterNames();
        if (paramNames.hasMoreElements()) {
            while (paramNames.hasMoreElements()) {
                String name = paramNames.nextElement();
                String value = request.getParameter(name);
                out.println("<p><strong>" + name + ":</strong> " + value + "</p>");
            }
        } else {
            out.println("<p>No se recibieron parámetros.</p>");
        }
        %>
    </div>

    <div class="box">
        <h3>Prueba de codificación</h3>
        <p>Texto con acentos: áéíóúñ</p>
        <p>Texto sin acentos: abcdef</p>
    </div>

    <div class="box">
        <h3>Test de formulario</h3>
        <form action="diagnostico_encoding.jsp" method="get">
            <p><input type="text" name="titulo" value="Sesión Finalizada" /></p>
            <p><input type="text" name="mensaje" value="¡Esta es una prueba con acentos y caracteres especiales!" /></p>
            <p><input type="submit" value="Enviar por GET" /></p>
        </form>
        <br/>
        <form action="diagnostico_encoding.jsp" method="post">
            <p><input type="text" name="titulo" value="Sesión Finalizada" /></p>
            <p><input type="text" name="mensaje" value="¡Esta es una prueba con acentos y caracteres especiales!" /></p>
            <p><input type="submit" value="Enviar por POST" /></p>
        </form>
    </div>

    <div class="box">
        <h3>Forward vs. Redirect Test</h3>
        <a href="diagnostico_forward.jsp">Probar Forward</a> | 
        <a href="diagnostico_redirect.jsp">Probar Redirect</a>
    </div>
    
    <div class="box">
        <h3>Prueba de mensaje.jsp</h3>
        <p>Haz clic en los enlaces para probar mensaje.jsp:</p>
        <p>
            <a href="mensaje.jsp?titulo=Prueba&mensaje=Mensaje+sin+acentos&tipo=info&redireccion=diagnostico_encoding.jsp">Sin acentos</a> | 
            <a href="mensaje.jsp?titulo=Prueba+con+acentos&mensaje=Mensaje+con+acentos:+ñáéíóú&tipo=info&redireccion=diagnostico_encoding.jsp">Con acentos</a>
        </p>
    </div>
</body>
</html>
