{
  description = "paperoo - browse and download wallpapers from your terminal";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    in {
      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in {
          default = pkgs.stdenvNoCC.mkDerivation {
            pname = "paperoo";
            version = "0.2.0";
            src = ./.;
            nativeBuildInputs = [ pkgs.makeWrapper ];
            buildInputs = [ pkgs.python3 ];
            installPhase = ''
              install -Dm755 paperoo $out/bin/paperoo
              patchShebangs $out/bin/paperoo
              # chafa draws thumbnails in terminals without a native image protocol
              wrapProgram $out/bin/paperoo --suffix PATH : ${pkgs.lib.makeBinPath [ pkgs.chafa ]}
            '';
            meta.mainProgram = "paperoo";
          };
        });
    };
}
