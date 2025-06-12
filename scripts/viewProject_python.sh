#=============================================================
#   README
#   copiar el contenido en una archivo o directamente el archivo
#   para ejecutar chmod +x viewProject_python.sh
#   ./viewProject_python.sh
#=============================================================

#!/usr/bin/env bash
# Output file
output_file="file_contents_output.txt"
# Ensure the output file is empty at the start
>"$output_file"

# Lista de carpetas o archivos que quieres ignorar
ignore_list=(
  "node_modules"
  "dist"
  ".git"
  "pycache"
  "_pycache_"
  "tree1.sh"
  "venv"
  "file_contents_output.txt"
  "README.md"
  ".gitignore"
  ".angular"
  "coverage"
  "build"
  "logs"
)

# Función para verificar si una ruta debe ser ignorada
should_ignore() {
  local path="$1"
  for ignore in "${ignore_list[@]}"; do
    if [[ "$path" == "$ignore" ]]; then
      return 0 # Devuelve verdadero si se encuentra en la lista de exclusión
    fi
  done
  return 1 # No se encontró, así que no se ignora
}

# Extensiones de archivos a procesar
process_extensions=(
  "ts" "tsx" "js" "jsx" "json"
  "html" "css" "scss" "less"
  "md" "txt" "yaml" "yml"
  "py" "sh" "env" ".env"
)

# Función para verificar si una extensión está en la lista de procesables
is_processable_extension() {
  local file="$1"
  for ext in "${process_extensions[@]}"; do
    if [[ "$file" == *."$ext" ]]; then
      return 0
    fi
  done
  return 1
}

# Busca archivos excluyendo directorios específicos
find . -type f | while read -r file; do
  # Skip if in ignored directories
  if [[ "$file" == "/node_modules" ||
    "$file" == "/.git" ||
    "$file" == "/_pycache_" ||
    "$file" == "/dist" ||
    "$file" == "/venv" ]]; then
    continue
  fi

  # Convierte la ruta del archivo a relativa
  relative_path="${file#./}"

  # Verifica si el archivo debe ser ignorado
  if should_ignore "$relative_path"; then
    continue
  fi

  # Verifica si es un archivo procesable
  if [[ -f "$file" ]] && is_processable_extension "$file"; then
    # Añade el nombre del archivo
    printf '==> %s <==\n' "$relative_path" >>"$output_file"

    # Muestra el contenido del archivo
    cat --show-nonprinting "$file" >>"$output_file"

    # Añade separador
    printf '\n---\n\n' >>"$output_file"
  fi
done

echo "Script execution complete. Output has been written to $output_file"
