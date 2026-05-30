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
   
4. Setup Nix config

   Refresh the env to take in changes from Nix install. Then run the setup logic.
   ```
   exec zsh
   chmod +x setup
   ./setup
   ```

## 💾 External Storage Setup
For Mac Mini with 256G drive, attempt to install Nix to an external SSD
Prepare the drive as follows **before** running above setup.

### Create an external APFS Volume

1. List available drives to identify the external storage device identifier (e.g., disk3, disk4) 

   ```
   diskutil list
   ```

2. Add an external APFS Volume named `Nix Store`

   Replace **diskX** with the actual identifier identified above.
   ```
   diskutil apfs addVolume diskX APFSX "Nix Store"
   ```

### Force macOS to create a root /nix folder

macOS protects the root directory using Signed System Volumes (SSV). Use /etc/synthetic.conf to instruct the operating system kernel to spawn an empty root-level mount point on the next launch. (see `man synthetic.conf`)

1. Update /etc/synthetic.conf

   ```
   echo "nix" | sudo tee -a /etc/synthetic.conf
   ```

2. Reboot. Check. `ls / `

### Map the External Volume in fstab

1. Get the ` Volume UUID`
   
   ```
   diskutil info "Nix Store" | grep "Volume UUID"
   ```

3. Add volume to fstab

   Replace <VOLUME UUID> with the value found above.
   ```
   echo "UUID=<VOLUME UUID> /nix apfs rw,noatime,nobrowse,nosuid,owners,failok,late" | sudo tee -a /etc/fstab
   ```

4. Reboot. Check. `df -h /nix`

## 📁 File Structure
`~/.config/nix-config` 
```
.
├── flake.nix          # Standardized to look for current-host.nix
├── common.nix         # Shared settings across all hardware type
├── macbook.nix        # Settings for macbook 
├── macmini.nix        # Settings for macmini
├── current-host.nix   # Created based on setup parameters (not committed, .gitignore)
└── setup              # The setup logic
```

## ❔ Nix vs Brew
- Nix: Use for shell, terminal tools (Git, Neovim, Python, Node), and system settings (Dock, Trackpad).
- Homebrew (via Nix): Use for GUI "Apps" normally found /Applications folder.

## ⚠️  Notes
- **Experimental Features**: This config enables `nix-command` and `flakes` by default.
- **system.stateVersion**: Do not update this value even when updating Nixpkgs. It represents the compatibility state of the system when first installed. Changing it may result in data migration issues.

## 🛠 Maintenance and Management

Some basics to maintain and manage the system after installing.

### Update

- Determinate Nix
  See https://github.com/DeterminateSystems/nix-installer#upgrading-determinate-nix
  ```
  sudo determinate-nixd upgrade
  ```
   
- flake
  ```
  cd .config/nix-config
  sudo -H nix flake update
  sudo -H darwin-rebuild switch --flake .#current-host
  ```
