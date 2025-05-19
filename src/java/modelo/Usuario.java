package modelo;

public class Usuario {
    private int idusu; // id de usuario (PK)
    private String identificacion;
    private String nombre;
    private String apellido;
    private String email;
    private String usuario;
    private String clave;
    private int idperfil;

    // Constructor vacío
    public Usuario() {}

    // Constructor con todos los campos
    public Usuario(int idusu, String identificacion, String nombre, String apellido, String email, String usuario, String clave, int idperfil) {
        this.idusu = idusu;
        this.identificacion = identificacion;
        this.nombre = nombre;
        this.apellido = apellido;
        this.email = email;
        this.usuario = usuario;
        this.clave = clave;
        this.idperfil = idperfil;
    }

    // Getter y Setter para idusu
    public int getIdusu() {
        return idusu;
    }

    public void setIdusu(int idusu) {
        this.idusu = idusu;
    }

    // Alias para compatibilidad con código viejo (opcional pero útil)
    public int getIddato() {
        return getIdusu();
    }

    // Getters y Setters restantes
    public String getIdentificacion() {
        return identificacion;
    }

    public void setIdentificacion(String identificacion) {
        this.identificacion = identificacion;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public int getIdperfil() {
        return idperfil;
    }

    public void setIdperfil(int idperfil) {
        this.idperfil = idperfil;
    }
}