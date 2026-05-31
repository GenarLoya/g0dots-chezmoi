#!/bin/sh

# -e: exit on error
# -u: exit on unset variables
set -eu

if ! chezmoi="$(command -v chezmoi)"; then
	bin_dir="${HOME}/.local/bin"
	chezmoi="${bin_dir}/chezmoi"
	echo "Installing chezmoi to '${chezmoi}'" >&2
	if command -v curl >/dev/null; then
		chezmoi_install_script="$(curl -fsSL https://get.chezmoi.io)"
	elif command -v wget >/dev/null; then
		chezmoi_install_script="$(wget -qO- https://get.chezmoi.io)"
	else
		echo "To install chezmoi, you must have curl or wget installed." >&2
		exit 1
	fi
	sh -c "${chezmoi_install_script}" -- -b "${bin_dir}"
	unset chezmoi_install_script bin_dir
fi

# Install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	echo "Installing oh-my-zsh..."
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc
fi

# Install oh-my-zsh plugins
echo "Installing oh-my-zsh plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/fast-syntax-highlighting"
git clone https://github.com/Aloxaf/fzf-tab.git "${ZSH_CUSTOM}/plugins/fzf-tab"

# Sync and update system with paru
echo "Updating system..."
paru -Syu

# Install dependencies (Arch-based with paru AUR helper)
if ! command -v paru >/dev/null 2>&1; then
	echo "paru is required to install dependencies" >&2
	exit 1
fi

if ! command -v docker >/dev/null 2>&1; then
	echo "Install docker? [y/N]"
	read -r docker_install

	if [ "$docker_install" = "y" ] || [ "$docker_install" = "Y" ]; then
		echo "Installing docker..."
		paru -Sy --noconfirm docker
	fi
fi

echo "Installing packages..."
paru -Sy --noconfirm \
	niri \
	ghostty \
	hyprshot \
	waybar \
	rofi \
	mako \
	hyprlock \
	brightnessctl \
	playerctl \
	wl-clipboard \
	clipvault \
	fastfetch \
	github-cli \
	sddm \
	awww \
	starhsip

echo "Installing SilentSDDM theme..."
temp_dir="${HOME}/.temp/SilentSDDM"
mkdir -p "$(dirname "$temp_dir")"
git clone -b main --depth=1 https://github.com/uiriansan/SilentSDDM "$temp_dir"
cd "$temp_dir" && ./install.sh

echo "Set profile picture for SDDM? [y/N]"
read -r sddm_pfp
if [ "$sddm_pfp" = "y" ] || [ "$sddm_pfp" = "Y" ]; then
	echo "Enter profile picture path:"
	read -r pfpath
	if [ -f "$pfpath" ]; then
		sudo "$temp_dir/change_avatar.sh" "$USER" "$pfpath"
	fi
fi

rm -rf "$(dirname "$temp_dir")"
echo "SilentSDDM theme installed."

# Install zed via official script
if ! command -v zed >/dev/null 2>&1; then
	echo "Installing zed..."
	curl -fsSL https://zed.dev/install.sh | sh
fi

# Install opencode via official script
if ! command -v opencode >/dev/null 2>&1; then
	echo "Installing opencode..."
	curl -fsSL https://opencode.ai/install | bash
fi

echo "Applying dotfiles..."

echo "Ready, just run 'chezmoi apply' to start to use"
