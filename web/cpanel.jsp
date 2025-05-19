<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="modelo.Conexion" %>

<%
    // Verificar si existe una sesión válida (no crear una nueva)
    HttpSession sesion_cli = request.getSession(false);
    
    // Verificar si el usuario está autenticado
    if (sesion_cli == null || sesion_cli.getAttribute("nUsuario") == null) {
        // Redirigir a la página de inicio si no hay sesión o usuario
        response.sendRedirect("index.jsp?mensaje=" + java.net.URLEncoder.encode("Debe iniciar sesión para acceder a esta página", "UTF-8"));
        return; // Importante para detener la ejecución del resto del JSP
    }
    
    // Continuar solo si hay sesión válida
    String nUsuario = (String) sesion_cli.getAttribute("nUsuario");

    Connection con = null;
    Statement sentencia = null;
    ResultSet resultado = null;
    String nombre = null;
    String apellido = null;
    String usu = null;
    int id_perfil = 0;
    int idusu = 0;

    try {
        Conexion cn = new Conexion();
        con = cn.crearConexion();
        sentencia = con.createStatement();
        resultado = sentencia.executeQuery("SELECT * FROM usuarios WHERE usuario ='" + nUsuario + "'");

        if (resultado.next()) {
            nombre = resultado.getString("nombre");
            apellido = resultado.getString("apellido");
            usu = resultado.getString("usuario");
            id_perfil = resultado.getInt("id_perfil");
            idusu = resultado.getInt("idusu");
        }

        if (id_perfil == 1) {
            resultado = sentencia.executeQuery("SELECT nom_actividad, id_actividad FROM actividades");
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
    <title>Panel de Control</title>
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

        .header-bar {
            background-color: #2c3e50;
            color: white;
            padding: 15px;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            border-bottom: 3px solid #34495e;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .user-links {
            font-size: 13px;
        }

        .user-links a {
            color: #ecf0f1;
            text-decoration: none;
            margin-right: 5px;
        }

        .user-links a:hover {
            text-decoration: underline;
        }

        .user-info img {
            width: 38px;
            height: 38px;
            border-radius: 50%;
        }

        .user-name {
            font-weight: bold;
        }

        .logout-btn {
            margin-left: 20px;
            color: #ecf0f1;
            text-decoration: none;
            background-color: #e74c3c;
            padding: 5px 10px;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .logout-btn:hover {
            background-color: #c0392b;
        }

        .panel-container {
            padding: 30px;
        }

        .btn {
            text-decoration: none;
            padding: 10px 15px;
            border-radius: 5px;
            margin-right: 10px;
            display: inline-block;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .btn-success {
            background-color: #27ae60;
            color: white;
        }

        .btn-success:hover {
            background-color: #1e8449;
        }

        .btn-warning {
            background-color: #f39c12;
            color: white;
        }

        .btn-warning:hover {
            background-color: #d68910;
        }

        .form-container {
            background-color: white;
            padding: 20px;
            border: 1px solid #dcdde1;
            border-radius: 6px;
            max-width: 400px;
            margin-bottom: 30px;
        }

        .form-container form {
            display: flex;
            flex-direction: column;
        }

        .form-container label {
            margin-top: 10px;
            margin-bottom: 5px;
        }

        .form-container select, 
        .form-container input[type="submit"] {
            padding: 8px;
            margin-bottom: 10px;
            border-radius: 4px;
            border: 1px solid #bdc3c7;
        }

        .form-container input[type="submit"] {
            background-color: #3498db;
            color: white;
            cursor: pointer;
        }

        .form-container input[type="submit"]:hover {
            background-color: #2980b9;
        }

        .task-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: white;
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
    </style>
</head>
<body>

<div class="header-bar">
    <div class="user-info">
        <div class="user-links">
            <a href="verPerfil.jsp">Ver perfil</a> |
            <a href="editarPerfil.jsp">Editar perfil</a>
        </div>
        <img src="https://cdn-icons-png.flaticon.com/512/847/847969.png" alt="User">
        <span class="user-name"><%= (nombre != null && apellido != null) ? nombre + " " + apellido : "Usuario" %></span>
        <a href="cerrarSesion" class="logout-btn">Cerrar sesión</a>
    </div>
</div>

<div class="panel-container">

<% if (id_perfil == 2) {
    try {
        Statement alertaStmt = con.createStatement();
        ResultSet vencidas = alertaStmt.executeQuery(
            "SELECT nom_actividad, fecha_limite, hora_limite, g.idgesActividad, g.realizada " +
            "FROM actividades a " +
            "JOIN gesActividad g ON g.id_actividad = a.id_actividad " +
            "WHERE g.idusu = " + idusu
        );

        while (vencidas.next()) {
            String nom_actividad = vencidas.getString("nom_actividad");
            String fecha_limite = vencidas.getString("fecha_limite");
            String hora_limite = vencidas.getString("hora_limite");
            boolean realizada = vencidas.getBoolean("realizada");

            boolean esVencida = false;
            String fechaCompleta = fecha_limite + " " + hora_limite;
            String fechaActual = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());

            if (fechaCompleta.compareTo(fechaActual) < 0) {
                esVencida = true;
            }

            if (!realizada && esVencida) {
%>
<div style="background-color: #ffeeba; color: #856404; padding: 12px; margin-bottom: 15px; border: 1px solid #ffeeba; border-radius: 5px;">
    ⚠ La actividad <strong><%= nom_actividad %></strong> venció el <%= fecha_limite %> a las <%= hora_limite %>.
</div>
<%      }
        }
    } catch (Exception e) {
        out.println("<div style='color:red;'>Error al comprobar fechas: " + e.getMessage() + "</div>");
    }
} %>

<% if (id_perfil == 1) { %>
<a href="actividad.jsp" class="btn btn-success">Agendar Proyecto</a>
<a href="administrarTareas.jsp" class="btn btn-warning">Administrar Tareas</a>

<div class="form-container">
    <form action="asignarTarea.jsp" method="post">
        <label for="usuario">Seleccionar usuario:</label>
        <select name="usuario">
            <%
                Statement sentenciaUsuarios = con.createStatement();
                ResultSet rsUsuarios = sentenciaUsuarios.executeQuery("SELECT idusu, nombre, apellido FROM usuarios WHERE id_perfil = 2");
                while (rsUsuarios.next()) {
            %>
            <option value="<%= rsUsuarios.getInt("idusu") %>">
                <%= rsUsuarios.getString("nombre") + " " + rsUsuarios.getString("apellido") %>
            </option>
            <% } %>
        </select><br>

        <label for="actividad">Seleccionar actividad:</label>
        <select name="actividad">
            <%
                while (resultado.next()) {
            %>
            <option value="<%= resultado.getInt("id_actividad") %>">
                <%= resultado.getString("nom_actividad") %>
            </option>
            <% } %>
        </select><br>

        <input type="submit" value="Agendar Proyecto">
    </form>
</div>

<h3>Eliminar Actividades</h3>
<table class="task-table">
    <tr>
        <th>Nombre</th>
        <th>Fecha Límite</th>
        <th>Hora Límite</th>
        <th>Acción</th>
    </tr>
    <%
        Statement stmtEliminar = con.createStatement();
        ResultSet rsActividades = stmtEliminar.executeQuery("SELECT * FROM actividades");
        while (rsActividades.next()) {
            int idActividad = rsActividades.getInt("id_actividad");
            String nombreAct = rsActividades.getString("nom_actividad");
            String fecha = rsActividades.getString("fecha_limite");
            String hora = rsActividades.getString("hora_limite");
    %>
    <tr>
        <td><%= nombreAct %></td>
        <td><%= fecha %></td>
        <td><%= hora %></td>
        <td>
            <form action="eliminarActividad.jsp" method="post" onsubmit="return confirm('¿Estás seguro de que deseas eliminar esta actividad?');">
                <input type="hidden" name="id_actividad" value="<%= idActividad %>">
                <input type="submit" value="Eliminar" style="background-color: #e74c3c; color: white; padding: 6px 10px; border: none; border-radius: 4px; cursor: pointer;">
            </form>
        </td>
    </tr>
    <% } %>
</table>
<% } else if (id_perfil == 2) { %>
<h3>Mis Tareas</h3>
<table class="task-table">
    <tr>
        <th>Proyecto</th>
        <th>Información</th>
        <th>Fecha Límite</th>
        <th>Hora Límite</th>
        <th>Acción</th>
    </tr>
    <%
        Conexion cn2 = new Conexion();
        con = cn2.crearConexion();
        sentencia = con.createStatement();
        resultado = sentencia.executeQuery(
            "SELECT a.nom_actividad, a.enlace, a.fecha_limite, a.hora_limite, g.idgesActividad, g.realizada " +
            "FROM actividades a " +
            "JOIN gesActividad g ON g.id_actividad = a.id_actividad " +
            "WHERE g.idusu = " + idusu
        );

        while (resultado.next()) {
            String nom = resultado.getString("nom_actividad");
            String enlace = resultado.getString("enlace");
            String fecha = resultado.getString("fecha_limite");
            String hora = resultado.getString("hora_limite");
            int idgesActividad = resultado.getInt("idgesActividad");
            boolean realizada = resultado.getBoolean("realizada");

            Statement checkVencida = con.createStatement();
            ResultSet vencida = checkVencida.executeQuery(
                "SELECT NOW() > CONCAT('" + fecha + "', ' ', '" + hora + "') AS vencida"
            );

            boolean esVencida = false;
            if (vencida.next()) {
                esVencida = vencida.getBoolean("vencida");
            }
    %>
    <tr>
        <td><%= nom %></td>
        <% if (esVencida && !realizada) { %>
        <td><a href="MensajeAtrasado.jsp">Actividad vencida</a></td>
        <% } else { %>
        <td><a href="<%= enlace %>" target="_blank">Ver actividad</a></td>
        <% } %>
        <td><%= fecha %></td>
        <td><%= hora %></td>
        <td>
            <% if (!realizada && !esVencida) { %>
            <form action="marcarTarea" method="post" style="display:inline;">
                <input type="hidden" name="idgesActividad" value="<%= idgesActividad %>" />
                <input type="submit" value="Marcar como realizada" />
            </form>
            <% } else if (esVencida && !realizada) { %>
            <strong>Incompleta</strong>
            <% } else { %>
            <strong>Completada</strong>
            <% } %>
        </td>
    </tr>
    <% } %>
</table>
<% } %>

</div>

</body>
</html>
