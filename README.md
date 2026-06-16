# macOS Nix Configuration

Use this repository to setup a new macOS using Nix, [flakes](https://wiki.nixos.org/wiki/Flakes), [nix-darwin](https://github.com/nix-darwin/nix-darwin) and [nix-homebrew](https://github.com/zhaofengli/nix-homebrew) .  

## 🛠 Initial Setup/Reinstall

1. Install Nix 

   From https://nix.dev/manual/nix/latest/installation/installing-binary.html

   ```
   curl -L https://nixos.org/nix/install | sh
   ```

2. Install xcode-select 

   Required by Homebrew later. Manual agreement to License. 
   ```
   xcode-select --install
   softwareupdate -i -a --agree-to-license
   ```

3. Create a `flake.nix` and update accordingly. 

   Enable the "experimental-features"
   ```
   mkdir -p ~/.config/nix
   cd ~/.config/nix
   echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
   ```

   Use a template from this repo: `nix flake init -t github:lcenchew/macnix/branch#template-name`
   ```
   nix flake init -t github:lcenchew/macnix
   ```


5. For `nix-darwin`, use the latest `system.stateVersion` if start from scratch (currently 7).
   See https://github.com/nix-darwin/nix-darwin/blob/master/modules/system/version.nix

6. Run the setup

   ```
   sudo -H nix run nix-darwin -- switch --flake .#janmacbook
   ```

   Note that `.#janmacbook` should be the same value as the value of `darwinConfigurations."janmacbook"` in flake.nix. Suggested to use the hostname from `hostname -s`.
 
7. Once installation is completed, reload the shell or open another terminal to start using Nix.

   ```
   exec zsh
   ```

## 🛠 Maintenance and Management

Some basics to maintain and manage the system after installing.

### Update

- flake
  ```
  sudo -H nix flake update
  sudo -H darwin-rebuild switch --flake .#janmacbook
  ```
