/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package Interfaces;
import java.util.List;
import modelo.Usuario;

/**
 *
 * @author Alanh
 */
public interface CRUD {
    public int agregarUsuario(Usuario u);
    public int actualizarDatos(Usuario u);
    public int eliminarDatos(int id);
    public Usuario listarDatos_Id(int id);
    public List<Usuario> listadoUsuarios ();
}