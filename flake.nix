{
  description = "A Nix-flake-based SLF development environment";

  # nixpkgs with ocaml 4.14.1
  # Read: https://lazamar.co.uk/nix-versions/
  inputs.nixpkgs.url =
    "github:NixOS/nixpkgs/c407032be28ca2236f45c49cfb2b8b3885294f7f";

  outputs = { self, nixpkgs }:
    let
      supportedSystems =
        [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f:
        nixpkgs.lib.genAttrs supportedSystems
        (system: f { pkgs = import nixpkgs { inherit system; }; });
    in {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell { buildInputs = with pkgs; [ coq_8_18 ]; };
      });
    };
}
