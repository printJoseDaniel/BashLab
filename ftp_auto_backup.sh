#!/bin/bash

# Crear las carpetas si no existen
mkdir -p imagenes videos documentos

# Iterar sobre cada archivo en el directorio actual
for archivo in *
do
    # Obtener el nombre base del archivo sin la ruta
    nombre_base=$(basename "$archivo")

    # Obtener la extensión del archivo usando awk
    extension=$(echo "$nombre_base" | awk -F '.' '{print $NF}')

    # Mover el archivo a la carpeta correspondiente según su extensión
    case "$extension" in
        jpg|png)
            mv "$archivo" imagenes/
            echo "Movido $archivo a la carpeta imagenes"
            ;;
        mp4|mkv)
            mv "$archivo" videos/
            echo "Movido $archivo a la carpeta videos"
            ;;
        pdf|docx)
            mv "$archivo" documentos/
            echo "Movido $archivo a la carpeta documentos"
            ;;
    esac
done

zip -r copia_seguridad.zip imagenes/ videos/ documentos/

servidor='192.168.0.25'
usuario='mario-server'
clave='password123'

ruta_archivo_local=copia_seguridad.zip
archivo_remoto='/home/mario-server/copia_seguridad.zip'

curl -u "$usuario:$clave" -T "$ruta_archivo_local" ftp://$servidor/$archivo_remoto
