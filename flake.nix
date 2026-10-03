{
  description = "raylib-zig";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    zigflake = {
      url = "github:silversquirl/zig-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      zigflake,
    }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      zig = zigflake.packages.x86_64-linux.zig_0_17_0;
      zls = zigflake.packages.x86_64-linux.zig_0_16_0.zls;
    in
    {
      devShells.x86_64-linux = {
        default = pkgs.mkShell {
          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
            pkgs.alsa-lib
          ];
          packages = [
            zig
            zls
            pkgs.libGL
            pkgs.wayland-scanner
            pkgs.wayland
            pkgs.libxkbcommon
          ];
        };
      };
    };
}
