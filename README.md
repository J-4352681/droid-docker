# droid-docker

- Proyecto para dockerizar droid y utilizarlo mediante gui desde fuera del contenedor.

### Cómo usar
- Construir imagen droid: `./droid.sh build`
- Ejecutar contenedor y correr droid: `./droid.sh run`
- Eliminar imagen: `./droid.sh remove`

### Aclaraciones
- Depositar los archivos a procesar en el directorio data para que se puedan acceder desde droid.

### Futuras mejoras
- Ampliar la creación de imagen para poder parametrizar versión de droid y de jre.
