package modelo;

/**
 *
 * @author Alanh
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    public static String usuario = "root";       // Usuario para la base de datos
    public static String clave = "";             // Contraseña para la base de datos
    public static String servidor = "localhost"; // Servidor donde está la base de datos (puede ser "localhost" o "127.0.0.1")
    public static String puerto = "3306";        // Puerto de MySQL (el puerto por defecto de MySQL es 3306)
    public static String BD = "parcial2";        // Nombre de la base de datos

    public Connection crearConexion() {
        Connection con = null;
        try {
            // Registra el driver JDBC
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Construir la URL de conexión
            String URL = "jdbc:mysql://" + servidor + ":" + puerto + "/" + BD;
            
            // Conectar a la base de datos
            con = DriverManager.getConnection(URL, usuario, clave);
            System.out.println("Conexión exitosa a la base de datos.");
        } catch (ClassNotFoundException | SQLException e) {
            // Mostrar mensaje de error en caso de falla
            System.out.println("Error al conectar a la base de datos: " + e.getMessage());
        }
        return con;
    }
}