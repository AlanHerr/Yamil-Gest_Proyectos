package modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class GesActividadDAO {

    // Método para eliminar la tarea asignada a un usuario
    public int eliminarTarea(int idgesActividad) {
        int estatus = 0;
        Connection con = null;
        PreparedStatement ps = null;
        Conexion cn = new Conexion();

        try {
            con = cn.crearConexion();
            String q = "DELETE FROM gesActividad WHERE idgesActividad=?";
            ps = con.prepareStatement(q);

            // Establecer el parámetro en la consulta
            ps.setInt(1, idgesActividad);

            // Ejecutar la consulta
            estatus = ps.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("Error al eliminar la tarea: " + ex.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                System.out.println("Error al cerrar recursos: " + ex.getMessage());
            }
        }
        return estatus;
    }
}
