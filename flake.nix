{
  description = "GitHub README.md environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        {
          pkgs,
          ...
        }:
        {
          devShells.default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              nil
              nixd
              nixfmt

              husky
              pinact
              go-task
              yamlfmt
              yamllint
              markdownlint-cli
            ];

            shellHook = ''
              husky install > /dev/null 2>&1 || true
            '';
          };
        };
    };
}
