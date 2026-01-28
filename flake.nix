{
  description = "A Nix-flake-based SLF development environment";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachSystem
      [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ]
      (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
          coqPkgs = pkgs.coqPackages_8_18;
        in
        {
          devShells.default = pkgs.mkShell {
            packages =
              with pkgs;
              [ python312Packages.alectryon ]
              ++ (with coqPkgs; [
                coq
                serapi # required by alectryon
              ]);
          };
        }
      );
}
