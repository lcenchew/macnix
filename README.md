# macOS Nix Configuration

This repository setup a new macOS using nix-darwin and [flakes](https://wiki.nixos.org/wiki/Flakes).  

## 🛠 Initial Setup/Reinstall
1. Install Nix
   ```
   curl -L https://install.determinate.systems/nix | sh -s -- install
   ```
   
2. Copy config files

   Copy is used here instead of clone since git is not included with a new Mac install.
   ```
   mkdir -p ~/.config/nix-config && cd ~/.config/nix-config
   curl -L https://github.com/lcenchew/macnix/archive/main.tar.gz | tar -xz --strip-components=1
   ```
   
3. Setup Nix config

   ```
   chmod +x apply
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
Nix: Use for shell, terminal tools (Git, Neovim, Python, Node), and system settings (Dock, Trackpad).
Homebrew (via Nix): Use for GUI "Apps" normally found /Applications folder.

## ⚠️  Notes
- **Experimental Features**: This config enables `nix-command` and `flakes` by default.
- **system.stateVersion**: Do not update this value even when updating Nixpkgs. It represents the compatibility state of the system when first installed. Changing it may result in data migration issues.
