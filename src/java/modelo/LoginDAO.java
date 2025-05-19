package modelo;

import java.sql.*;


public class LoginDAO {

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs;

    // Constructor de la clase LoginDAO
    public LoginDAO() {}

    // Método para validar el login de un usuario
    public Usuario Login_datos(String usuario, String clave) {
        Usuario datos = null; // Para almacenar los datos del usuario encontrado
        try {
            // Crear conexión con la base de datos
            Conexion cn = new Conexion();
            conn = cn.crearConexion();

            // Preparar la consulta SQL para verificar el usuario y la contraseña
            stmt = conn.prepareStatement("SELECT * FROM usuarios WHERE usuario=? AND clave=?");

            // Establecer los valores de usuario y clave en la consulta
            stmt.setString(1, usuario);
            stmt.setString(2, clave);

            // Ejecutar la consulta
            rs = stmt.executeQuery();

            // Si se encuentra un usuario que coincida con los datos
            if (rs.next()) {
                // Crear un nuevo objeto Usuario
                datos = new Usuario();
                
                // Establecer todos los valores en el objeto Usuario
                datos.setIdusu(rs.getInt("idusu"));  // Usar el campo idusu
                datos.setIdentificacion(rs.getString("num_docu"));
                datos.setNombre(rs.getString("nombre"));
                datos.setApellido(rs.getString("apellido"));
                datos.setEmail(rs.getString("email"));
                datos.setUsuario(rs.getString("usuario"));
                datos.setClave(rs.getString("clave"));
                datos.setIdperfil(rs.getInt("id_perfil"));
            }

            // Cerrar la conexión y recursos
            rs.close();
            stmt.close();
            conn.close();

        } catch (SQLException e) {
            System.out.println("Error al validar el login: " + e.getMessage());
        }
        return datos;  // Retorna el objeto Usuario o null si no se encontró el usuario
    }
}