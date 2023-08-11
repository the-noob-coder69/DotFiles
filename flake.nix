{
    description = "Hamburgir's desktop configurations";

    inputs = {
        # Nixpkgs
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

        # Home manager
        home-manager = {
            url = "github:nix-community/home-manager/release-23.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # TODO: Add any other flake you might need
        # hardware.url = "github:nixos/nixos-hardware";

        # Shameless plug: looking for a way to nixify your themes and make
        # everything match nicely? Try nix-colors!
        # nix-colors.url = "github:misterio77/nix-colors";
    };

    outputs = { nixpkgs, home-manager, ... }@inputs: 
        #let
        #    hm = {user, pkgs? nixpkgs.legacyPackages.x86_64-linux, extraArgs}: {
        #        user
        #    };
        #in
        {
            # NixOS configuration entrypoint
            # Available through 'nixos-rebuild --flake .#your-hostname'
            nixosConfigurations = {
                # FIXME replace with your hostname
                your-hostname = nixpkgs.lib.nixosSystem {
                    specialArgs = { inherit inputs; }; # Pass flake inputs to our config
                        # > Our main nixos configuration file <
                        modules = [ ./nixos/configuration.nix ];
                };
                toaster = nixpkgs.lib.nixosSystem {
                    specialArgs = { inherit inputs; };
                    system = "x86_64-linux";
                    modules = [
                        ({...}: {
                            nixpkgs.overlays = [
                                (_: prev: {
                                    rtl8812au = prev.rtl8812au (old: {
                                        version = "${prev.version}-modified";
                                        patches = (old.patches or []) ++ [(
                                            prev.fetchpatch {
                                                url = "https://github.com/morrownr/8812au-20210629/commit/b5f4e6e894eca8fea38661e2fc22a2570e0274ad.patch";
                                                #hash = "sha256-kEH3dyGq+ErVYyUVOA4BfpPw9p3kc5mLGJUz72W4oLQ=";
                                            }
                                        )];
                                    });
                                })
                            ];
                        })
                        ./toaster/configuration.nix
                    ];
                };
            };

            # Standalone home-manager configuration entrypoint
            # Available through 'home-manager --flake .#your-username@your-hostname'
            homeConfigurations = {
                # FIXME replace with your username@hostname
                "your-username@your-hostname" = home-manager.lib.homeManagerConfiguration {
                    pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
                    extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
                    # > Our main home-manager configuration file <
                    modules = [ ./home-manager/home.nix ];
                };
                "hamburgir" = home-manager.lib.homeManagerConfiguration {
                    modules = [
                        ./users/hamburgir/home.nix
                    ];
                    pkgs = nixpkgs.legacyPackages.x86_64-linux;
                    extraSpecialArgs = { inherit inputs; };
                };
            };
        };
}
