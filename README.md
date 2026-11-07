# Configuración personal de Pi y dotfiles

Este repositorio sincroniza la configuración que uso con **[Pi](https://pi.dev)** (agente de coding) y mi shell.  
Los archivos se copian desde sus ubicaciones originales en `$HOME` a este repo mediante `sync.sh`.

---

## Estructura del repositorio

```
config-sync/
├── .pi/
│   ├── fallback-chains.json        # Cadenas de fallo de modelos (pi-fallback-provider)
│   └── agent/
│       └── autorouter.json         # Reglas de enrutamiento automático (pi-litellm-autorouter)
├── .zshrc                          # Configuración de Zsh
└── sync.sh                         # Script de sincronización (copia → commit)
```

---

## Qué hace cada archivo

| Archivo | Propósito |
|---|---|
| `.pi/fallback-chains.json` | Define cadenas de respaldo para modelos (p.ej. `fallback/simple` → DeepSeek, Nemotron, Luna). Si el modelo principal falla, el proveedor de fallo prueba el siguiente automáticamente. |
| `.pi/agent/autorouter.json` | Configura el **autorrouter** de Pi: clasifica cada petición en tiers (`SIMPLE`, `MEDIUM`, `COMPLEX`, `REASONING`) y la envía al modelo correspondiente. Incluye `keywordTierRules` para forzar tiers por palabras clave (p.ej. «usa terra» → `MEDIUM`, «usa sol max» → `REASONING`). |
| `.zshrc` | Mi configuración personal de Zsh (aliases, funciones, prompt, etc.). |
| `sync.sh` | Copia los tres archivos de arriba desde `$HOME` a este repo, hace `git commit` solo si hay cambios y deja listo para `git push`. |

---

## Modelos configurados en el autorrouter

| Tier | Modelo | Nivel de razonamiento |
|---|---|---|
| `SIMPLE` | `fallback/simple` (cadena) | `off` |
| `MEDIUM` | `openai/gpt-6.1-terra` | `medium` |
| `COMPLEX` | `openai/gpt-6.1-sol` | `high` |
| `REASONING` | `openai/gpt-6.1-sol` | `max` |

> `fallback/simple` incluye: `deepseek-ai/deepseek-v4.1-flash`, `github-copilot/gpt-6-luna`, `nvidia/nemotron-3-ultra-550b-a55b`.

---

## Uso

### Sincronizar y subir (una sola orden)

```bash
bash ~/Code/config-sync/sync.sh && git -C ~/Code/config-sync push
```

### Desde una sesión de Pi

```bash
bash ~/Code/config-sync/sync.sh && git -C ~/Code/config-sync push
```

El script usa rutas absolutas, así que funciona desde cualquier directorio.

---

## Restaurar en otra máquina

```bash
git clone git@github.com:daniconil/config.git ~/Code/config-sync
cd ~/Code/config-sync
# Copia manual o adapta sync.sh a la nueva $HOME
cp .pi/fallback-chains.json ~/.pi/
cp .pi/agent/autorouter.json ~/.pi/agent/
cp .zshrc ~/
```

---

## Notas

- El repo es **privado**.
- `sync.sh` solo hace commit si detecta cambios (`git diff --quiet`).
- Los cambios en `autorouter.json` se aplican en Pi con `/reload` (sin reiniciar la sesión).