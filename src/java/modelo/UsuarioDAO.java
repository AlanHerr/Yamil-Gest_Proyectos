package modelo;

import Interfaces.CRUD;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO implements CRUD {

    @Override
    public int agregarUsuario(Usuario u) {
        int estatus = 0;
        String q = "INSERT INTO usuarios (num_docu, nombre, apellido, email, usuario, clave, id_perfil) VALUES (?,?,?,?,?,?,?)";
        try (Connection con = new Conexion().crearConexion();
             PreparedStatement ps = con.prepareStatement(q)) {

            ps.setString(1, u.getIdentificacion());
            ps.setString(2, u.getNombre());
            ps.setString(3, u.getApellido());
            ps.setString(4, u.getEmail());
            ps.setString(5, u.getUsuario());
            ps.setString(6, u.getClave()); // Debería estar hasheada
            ps.setInt(7, u.getIdperfil());

            estatus = ps.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error al agregar el usuario: " + ex.getMessage());
        }
        return estatus;
    }

    @Override
    public int actualizarDatos(Usuario u) {
        int estatus = 0;
        String q = "UPDATE usuarios SET num_docu=?, nombre=?, apellido=?, email=?, usuario=?, clave=?, id_perfil=? WHERE idusu=?";
        try (Connection con = new Conexion().crearConexion();
             PreparedStatement ps = con.prepareStatement(q)) {

            ps.setString(1, u.getIdentificacion());
            ps.setString(2, u.getNombre());
            ps.setString(3, u.getApellido());
            ps.setString(4, u.getEmail());
            ps.setString(5, u.getUsuario());
            ps.setString(6, u.getClave());
            ps.setInt(7, u.getIdperfil());
            ps.setInt(8, u.getIdusu());

            estatus = ps.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error al actualizar los datos del usuario: " + ex.getMessage());
        }
        return estatus;
    }

    // Método específico para actualizar solo usuario y clave
    public int actualizarDatosUsuarioYCclave(Usuario u) {
        int estatus = 0;
        String q = "UPDATE usuarios SET usuario = ?, clave = ? WHERE idusu = ?";
        try (Connection con = new Conexion().crearConexion();
             PreparedStatement ps = con.prepareStatement(q)) {

            ps.setString(1, u.getUsuario());
            ps.setString(2, u.getClave());
            ps.setInt(3, u.getIdusu());

            estatus = ps.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error al actualizar usuario y clave: " + ex.getMessage());
        }
        return estatus;
    }

    @Override
    public int eliminarDatos(int id) {
        int estatus = 0;
        String q = "DELETE FROM usuarios WHERE idusu=?";
        try (Connection con = new Conexion().crearConexion();
             PreparedStatement ps = con.prepareStatement(q)) {

            ps.setInt(1, id);
            estatus = ps.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error al eliminar el usuario: " + ex.getMessage());
        }
        return estatus;
    }

    @Override
    public Usuario listarDatos_Id(int id) {
        Usuario u = null;
        String q = "SELECT * FROM usuarios WHERE idusu=?";
        try (Connection con = new Conexion().crearConexion();
             PreparedStatement ps = con.prepareStatement(q)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    u = new Usuario();
                    u.setIdusu(rs.getInt("idusu"));
                    u.setIdentificacion(rs.getString("num_docu"));
                    u.setNombre(rs.getString("nombre"));
                    u.setApellido(rs.getString("apellido"));
                    u.setEmail(rs.getString("email"));
                    u.setUsuario(rs.getString("usuario"));
                    u.setClave(rs.getString("clave"));
                    u.setIdperfil(rs.getInt("id_perfil"));
                }
            }
        } catch (SQLException ex) {
            System.err.println("Error al listar el usuario por ID: " + ex.getMessage());
        }
        return u;
    }

    // Nuevo método para listar por usuario (nombre de usuario)
    public Usuario listarDatosPorUsuario(String usuario) {
        Usuario u = null;
        String q = "SELECT * FROM usuarios WHERE usuario = ?";
        try (Connection con = new Conexion().crearConexion();
             PreparedStatement ps = con.prepareStatement(q)) {

            ps.setString(1, usuario);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    u = new Usuario();
                    u.setIdusu(rs.getInt("idusu"));
                    u.setIdentificacion(rs.getString("num_docu"));
                    u.setNombre(rs.getString("nombre"));
                    u.setApellido(rs.getString("apellido"));
                    u.setEmail(rs.getString("email"));
                    u.setUsuario(rs.getString("usuario"));
                    u.setClave(rs.getString("clave"));
                    u.setIdperfil(rs.getInt("id_perfil"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al buscar usuario por nombre: " + e.getMessage());
        }
        return u;
    }

    @Override
    public List<Usuario> listadoUsuarios() {
        List<Usuario> lista = new ArrayList<>();
        String q = "SELECT * FROM usuarios";
        try (Connection con = new Conexion().crearConexion();
             PreparedStatement ps = con.prepareStatement(q);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setIdusu(rs.getInt("idusu"));
                u.setIdentificacion(rs.getString("num_docu"));
                u.setNombre(rs.getString("nombre"));
                u.setApellido(rs.getString("apellido"));
                u.setEmail(rs.getString("email"));
                u.setUsuario(rs.getString("usuario"));
                u.setClave(rs.getString("clave"));
                u.setIdperfil(rs.getInt("id_perfil"));
                lista.add(u);
            }
        } catch (SQLException ex) {
            System.err.println("Error al listar todos los usuarios: " + ex.getMessage());
        }
        return lista;
    }
}
