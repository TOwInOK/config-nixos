
# ❄️ NixOS Config


---


## 🚀 Installation

To get started with this setup, follow these steps:

1. **Install NixOS**: If you haven't already installed NixOS, follow the [NixOS Installation Guide](https://nixos.org/manual/nixos/stable/#sec-installation) for detailed instructions.
2. **Clone the Repository**:

	```bash
    git clone https://github.com/TOwInOK/config-nixos.git
    cd nixos-config-reborn
    ```

2.1 **Disko your disk with disko**:

  ```bash
  # check your disks
  lsblk
  # choose your disk and change it to your needs
  vim disco.nix
  # Disko your disk with disko
  sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ./disco.nix
  ```

3. **Put your `hardware-configuration.nix` file there**:

    ```bash
    # generate hardware-configuration.nix file
    nixos-generate-config --root /mnt
    # cp it
    cp /etc/nixos/hardware-configuration.nix ./config-nixos/hosts/twk-pc/
    ```

4. **Finally, edit the `flake.nix` file**:

    ```diff
    ...
      outputs = { self, nixpkgs, home-manager, ... }@inputs: let
        system = "x86_64-linux";
    --  homeStateVersion = "24.11";
    ++  homeStateVersion = "<your_home_manager_state_version>";
    --  user = "some_user";
    ++  user = "<your_username>";
        hosts = [
    ++    { hostname = "<your_hostname>"; stateVersion = "<your_state_version>"; }
        ];
    ...
    ```

5. **Rebuilding**:

    ```bash
    cd nixos-config-reborn
    git add .
    nixos-rebuild switch --flake ./#<hostname>
    # or nixos-install --flake ./#<hostname> if you are installing on a fresh system
    home-manager switch
    ```
