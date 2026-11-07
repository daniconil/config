# Configuración base de ZSH

# Ngrok Token (anonimizado para repositorio)
export NGROK_AUTHTOKEN="<REDACTED>"

# NVIDIA API Key (anonimizado para repositorio)
export NVIDIA_API_KEY="<REDACTED>"

# Valores reales locales (no versionados)
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
