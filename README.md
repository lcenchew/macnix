# macOS Nix Configuration

This repository setup a new macOS using nix-darwin and [flakes](https://wiki.nixos.org/wiki/Flakes).  

## 🛠 Initial Setup/Reinstall
1. Install Nix 

   Ref: https://github.com/DeterminateSystems/nix-installer
   ```
   curl -fsSL https://install.determinate.systems/nix | sh -s -- install
   ```
   If the first run fails, try running it again.

2. Install xcode-select 

   Required by Homebrew later. Still requires a manual agreement to License. 
   ```
   xcode-select --install
   softwareupdate -i -a --agree-to-license
   ```

3. Copy config files

   Copy is used here instead of clone. Init a repo to backup the final settings.
   ```
   mkdir -p ~/.config/nix-config && cd ~/.config/nix-config
   curl -L https://github.com/lcenchew/macnix/archive/main.tar.gz | tar -xz --strip-components=1
   ```
   
3. Setup Nix config

   Refresh the env to take in changes from Nix install. Then run the setup logic.
   ```
   exec zsh
   chmod +x setup
   ./setup
   ```

## 📁 File Structure
`~/.config/nix-config` 
```
.
├── flake.nix          # Standardized to look for current-host.nix
├── common.nix         # Shared settings
├── macbook.nix        # nix file for macbook 
├── macmini.nix        # nix file for macmini
├── current-host.nix   # created by apply (in .gitignore)
└── setup              # The setup logic
```

## ❔ Nix vs Brew
- Nix: Use for shell, terminal tools (Git, Neovim, Python, Node), and system settings (Dock, Trackpad).
- Homebrew (via Nix): Use for GUI "Apps" normally found /Applications folder.

## ⚠️  Notes
- **Experimental Features**: This config enables `nix-command` and `flakes` by default.
- **system.stateVersion**: Do not update this value even when updating Nixpkgs. It represents the compatibility state of the system when first installed. Changing it may result in data migration issues.

## Maintenance and Management

Some basics to maintain and manage the system after installing.

### Update

```
cd .config/nix-config
nix flake update
sudo darwin-rebuild switch --flake .#current-host
```
