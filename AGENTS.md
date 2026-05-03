# Project Context

This is a chezmoi-managed dotfiles repository for an Arch-based Wayland setup.

## Key Files

- `install.sh` - Main installation script (paru, SilentSDDM, zed, opencode, dotfiles)
- `.chezmoiignore` - Files excluded from chezmoi

## Important Patterns

- Config files use `private_` prefix to mark private templates
- Shell scripts use `executable_` prefix to mark them as executable
- Systemd user services are in `private_dot_config/systemd/user/`

## Commands

- `./install.sh` - Full setup (update, install deps + apply dotfiles)
- `chezmoi apply` - Apply current dotfiles
- `chezmoi edit` - Edit dotfiles

## Architecture Overview

```
private_dot_config/
├── niri/              # Window Manager
├── ghostty/           # Terminal + themes
├── waybar/            # Status bar
├── rofi/              # App launcher + scripts
├── mako/              # Notification daemon
├── hypr/              # Screen locker
├── fastfetch/         # System info
├── gtk-3.0/           # GTK3 theme
├── gtk-4.0/           # GTK4 theme
├── zed/               # Editor config
└── systemd/user/     # User services
```

---

## Component Documentation

### niri (Window Manager)

**Purpose**: Scrollable tiling Wayland window manager.

**Config**: `private_dot_config/niri/config.kdl`

**Key Bindings**:
| Key | Action |
|-----|--------|
| `Mod+Return` | Open terminal (ghostty) |
| `Mod+Space` | Open app launcher (rofi) |
| `Mod+V` | Open clipboard manager |
| `Mod+B` | Change wallpaper |
| `Mod+Shift+Escape` | Power menu |
| `Mod+1-9` | Switch workspace |
| `Mod+Q` | Close window |
| `Mod+F` | Maximize column |
| `Print` | Screenshot |

**Startup Services**:
- waybar (status bar)
- wl-paste --watch clipvault store (clipboard watcher)

**Integrations**:
- hyprlock for screen locking
- wpctl for audio control (media keys)
- playerctl for media control
- brightnessctl for backlight

---

### ghostty (Terminal)

**Purpose**: Fast, feature-rich terminal emulator.

**Config**: `private_dot_config/ghostty/config`

**Features**:
- Split panes (ctrl+h/j/k/l)
- Tab navigation (cmd+h/l)
- Resize splits (super+ctrl+h/j/k/l)
- Panda theme (dark)
- JetBrainsMono Nerd Font

**Themes**:
- panda
- stardust
- catppuccin-macchiato

---

### waybar (Status Bar)

**Purpose**: Highly customizable status bar for Wayland.

**Config**: `private_dot_config/waybar/config.jsonc`
**Style**: `private_dot_config/waybar/style.css`
**Colors**: `private_dot_config/waybar/color.css`

**Modules**:
- Clock with date/time

**Position**: Top of screen, 24px height

---

### rofi (Launcher)

**Purpose**: Application launcher, clipboard manager, powermenu.

**Scripts**:
| Script | Purpose |
|--------|---------|
| rofi-launcher | App drawer (drun mode) |
| rofi-clipboard | Clipboard history via clipvault |
| rofi-bgselector | Wallpaper selector |
| rofi-powermenu | Shutdown/reboot/lock/logout |
| rofi-confirm | Generic confirmation dialog |

**Themes**:
- appdrawer.rasi
- powermenu.rasi
- clipboard.rasi
- bgselector.rasi
- confirm.rasi

**Integrations**:
- clipvault for clipboard
- hyprlock for locking
- awww for wallpaper

---

### mako (Notifications)

**Purpose**: Lightweight Wayland notification daemon.

**Config**: `private_dot_config/mako/config`

**Features**:
- JetBrainsMono font
- Volume/mute notifications (bottom-center)
- Rounded corners, dark theme

---

### hyprlock / hypridle (Screen Locking)

**hyprlock Config**: `private_dot_config/hypr/hyprlock.conf`
**hypridle Config**: `private_dot_config/hypr/hypridle.conf`
**Lock Script**: `private_dot_config/hypr/lockbg.sh`

**Behavior**:
- Lock after 5 min idle (hypridle)
- Turn off monitors after 10 min idle
- Random wallpaper from `~/.config/niri/walls`
- User face icon from SDDM

**Integrations**:
- niri for monitor power-on after wake
- loginctl for sleep locking

---

### fastfetch (System Info)

**Config**: `private_dot_config/fastfetch/config.jsonc`
**ASCII**: `private_dot_config/fastfetch/ascii.txt`

**Modules**: OS, Shell, Memory, CPU, Colors

---

### Zed (Editor)

**Config**: `private_dot_config/zed/private_settings.json`
**Theme**: `private_dot_config/zed/themes/aura-blur.json`

**Features**:
- VSCode keybindings
- JetBrainsMono Nerd Font Mono
- Git panel, outline panel (left dock)
- Terminal (right dock)
- Dark theme (Vesper Blur)

**Integrations**:
- yaak MCP server for remote AI
- opencode agent server

---

### GTK Themes

**GTK3**: `private_dot_config/gtk-3.0/`
**GTK4**: `private_dot_config/gtk-4.0/`

**Settings**:
- Dark theme
- Rounded corners via CSS

---

### Systemd User Services

**clipvault-watcher.service**:
Watches clipboard changes and stores them via clipvault.

**awww-daemon.service**:
Wallpaper daemon (for awww wallpaper manager).

---

### Additional Configs

**EOS-greeter.conf**: Display manager greeter settings
**pavucontrol.ini**: PulseAudio volume control settings
**user-dirs.locale**: XDG user directories locale
**private_user-dirs.dirs**: XDG user directories paths
**private_mimeapps.list**: Default applications

---

### Shell (zsh)

**Config**: `dot_zshrc`

**Shell**: zsh with oh-my-zsh framework

**Plugins**:
| Plugin | Purpose |
|--------|---------|
| git | Git aliases and functions |
| fzf-tab | Fuzzy tab completion |
| zsh-autosuggestions | Fish-like autosuggestions |
| zsh-syntax-highlighting | Syntax highlighting |
| fast-syntax-highlighting | Fast syntax highlighting |

**Prompt**: Starship (starship.toml config)

**Node Version Manager**: fnm (Fast Node Manager)
- Configured with local version file strategy
- Node dist mirror: nodejs.org/dist

**Package Manager**: pnpm

**Utilities**:
- `$HOME/.config/my-utils` in PATH
- `$HOME/go` for Go projects
- GitHub CLI completion
- Docker completion
- fastfetch on shell startup

**Environment**:
- `EDITOR=zed`
- `GOPATH=$HOME/go`