<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Solución a problemas de codificación</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .info-box { 
            border: 1px solid #ddd; 
            padding: 15px; 
            margin-bottom: 20px;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        h2 { color: #333; }
        h3 { margin-top: 0; color: #3a87ad; }
        pre { 
            background-color: #f5f5f5; 
            padding: 10px; 
            border-radius: 5px;
            overflow-x: auto;
        }
        code { background-color: #eee; padding: 2px 4px; border-radius: 4px; }
        .solution { border-left: 4px solid #5cb85c; background-color: #dff0d8; }
        .problem { border-left: 4px solid #d9534f; background-color: #f2dede; }
    </style>
</head>
<body>
    <h2>Solución a problemas de codificación en el proyecto</h2>
    
    <div class="info-box problem">
        <h3>Problema detectado</h3>
        <p>Se ha detectado un problema de codificación de caracteres al pasar parámetros con caracteres especiales (como acentos o ñ) en las URLs:</p>
        <pre>org.apache.tomcat.util.http.InvalidParameterException: Character decoding failed. 
Parameter [titulo] with value [Sesi�n Finalizada] has been ignored.</pre>
        <p>Esto ocurre cuando se utiliza <code>response.sendRedirect("mensaje.jsp?titulo=Sesión+Finalizada...")</code> sin codificar los parámetros.</p>
    </div>
    
    <div class="info-box solution">
        <h3>Solución 1: Usar forward en lugar de redirect</h3>
        <p>Esta es la solución más recomendada para este proyecto. En lugar de usar redirect con parámetros, usa forward con atributos de request:</p>
        <pre>// En el servlet o JSP que envía a mensaje.jsp
request.setAttribute("titulo", "Sesión Finalizada");
request.setAttribute("mensaje", "Has cerrado sesión correctamente. ¡Hasta pronto!");
request.setAttribute("tipo", "info");
request.setAttribute("redireccion", "index.jsp");

// Forward a la página de mensaje
request.getRequestDispatcher("mensaje.jsp").forward(request, response);</pre>
        <p>Esta solución evita problemas de codificación y mantiene la información en la misma solicitud.</p>
    </div>
    
    <div class="info-box solution">
        <h3>Solución 2: Codificar los parámetros de URL</h3>
        <p>Si necesitas usar redirect, debes codificar los parámetros con URLEncoder:</p>
        <pre>// En el servlet o JSP que redirige a mensaje.jsp
String tituloEncoded = java.net.URLEncoder.encode("Sesión Finalizada", "UTF-8");
String mensajeEncoded = java.net.URLEncoder.encode("Has cerrado sesión correctamente. ¡Hasta pronto!", "UTF-8");

// Redirigir con parámetros codificados
response.sendRedirect("mensaje.jsp?titulo=" + tituloEncoded + 
                      "&mensaje=" + mensajeEncoded + 
                      "&tipo=info&redireccion=index.jsp");</pre>
    </div>
    
    <div class="info-box">
        <h3>¿Por qué ocurre este problema?</h3>
        <p>Los navegadores y servidores web utilizan diferentes estándares para codificar caracteres 
        especiales en las URLs. Sin la codificación adecuada, los caracteres como acentos, ñ, etc., 
        pueden ser malinterpretados o rechazados, causando errores como el que estamos viendo.</p>
    </div>
    
    <div class="info-box">
        <h3>Prueba la solución</h3>
        <p>Puedes probar las soluciones usando los siguientes enlaces:</p>
        <ul>
            <li><a href="diagnostico_forward.jsp">Probar la solución con forward</a></li>
            <li><a href="diagnostico_redirect.jsp">Probar la solución con redirect codificado</a></li>
        </ul>
    </div>
</body>
</html>
