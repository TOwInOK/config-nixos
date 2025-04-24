{
  # Описание флейка (для информации)
  description = "TOwInOK's nix config";

  # Определяем входные зависимости
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  # Определяем выходные параметры (что флейк экспортирует)
  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = ["x86_64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    packages = forAllSystems (system:
      import ./modules/custom/pkgs {
        pkgs = nixpkgs.legacyPackages.${system};
      });

    # Определяем devShells (окружение разработки, доступное через 'nix develop')
    devShells = forAllSystems (system: {
      default = nixpkgs.legacyPackages.${system}.mkShell {
        buildInputs = [nixpkgs.legacyPackages.${system}.alejandra];
      };
    });

    # Определяем кастомные оверлеи (изменения пакетов в nixpkgs)
    overlays = import ./modules/custom/overlays {inherit inputs;};

    # Определяем модули для NixOS (можно переиспользовать в разных системах)
    nixosModules = {
      default = import ./modules/nixos;
    };

    # Определяем модули для home-manager
    homeManagerModules = import ./modules/home-manager;

    # Определяем конфигурации NixOS (какие системы можно развернуть через nixos-rebuild)
    nixosConfigurations = {
      # Конфигурация для хоста 'twk'
      twk = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./config/nixos/configuration.nix
        ];
      };
    };

    # Определяем конфигурации home-manager (можно применять через 'home-manager switch')
    homeConfigurations = {
      # Конфигурация пользователя 'towinok' на хосте 'twk'
      "towinok@twk" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [./config/home-manager/home.nix];
      };
    };
  };
}
