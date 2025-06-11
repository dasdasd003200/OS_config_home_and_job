#=============================================================
# README
# copiar el contenido en una archivo o directamente el archivo
#para ejecutar chmod +x viewProject_python.sh
#=============================================================

#!/usr/bin/env bash

# Output file
output_file="file_contents_output.txt"

# Ensure the output file is empty at the start
>"$output_file"

# Globs include hidden files, are null if no matches, recursive with **
shopt -s dotglob nullglob globstar

# Lista de carpetas o archivos que quieres ignorar
ignore_list=("_pycache_" "pycache" "tree1.sh" "venv" "file_contents_output.txt" ".git" "README.md" "infoGoogleLogin.md" "uploads" "Keys" ".gitignore" "requirements.txt" "Jenkinsfile" "Dockerfile" "commit_history.md")

# Función mejorada para comprobar si un archivo o carpeta debe ser ignorado
should_ignore() {
  local path="$1"

  # Ignorar cualquier ruta que contenga _pycache_
  if [[ "$path" == "_pycache_" ]]; then
    return 0
  fi

  for ignore in "${ignore_list[@]}"; do
    if [[ "$path" == "$ignore" || "$path" == "$ignore"/* || "$path" == "/$ignore"/ || "$path" == "/$ignore"/ ]]; then
      return 0 # Devuelve verdadero si se encuentra en la lista de exclusión o es un subdirectorio
    fi
  done
  return 1 # No se encontró, así que no se ignora
}

for file in **; do
  # Verifica si el archivo o carpeta debe ser ignorado
  if should_ignore "$file"; then
    continue # Salta este archivo/carpeta si está en la lista de exclusión
  fi

  # Solo procesa archivos, no directorios
  if [[ -f "$file" ]]; then
    # Solo procesa archivos con extensiones de código o texto
    # Añadimos .pyc a las extensiones a ignorar
    if [[ "$file" =~ \.(py|txt|md|json|yaml|yml|sh|js|html|css|sql)$ ]] && [[ "$file" != *.pyc ]]; then
      # Append filename to the output file
      printf '==> %s <==\n' "$file" >>"$output_file"

      # Mostrar contenido del archivo
      cat --show-nonprinting -- "$file" >>"$output_file"

      # Añadir línea en blanco entre archivos
      echo >>"$output_file"
    fi
  fi
done

echo "Script execution complete. Output has been written to $output_file"
