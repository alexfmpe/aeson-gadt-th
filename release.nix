let pkgs = import ./nixpkgs/23.11 {};
    hpkgs = {
      overrides = self: super: {
        dependent-sum-template = self.callHackageDirect {
          pkg = "dependent-sum-template";
          ver = "0.2.0.1";
          sha256 = "123chg589dcp2854rfkydb8cwkvy6abjb9wp4mxazb01w4b21v5a";
        } {};
      };
    };
    ghcs = {
      "ghc8107" = pkgs.haskell.packages.ghc8107.override(hpkgs);
      "ghc902" = pkgs.haskell.packages.ghc902.override(hpkgs);
      "ghc928" = pkgs.haskell.packages.ghc928.override(hpkgs);
      "ghc948" = pkgs.haskell.packages.ghc948.override(hpkgs);
      "ghc963" = pkgs.haskell.packages.ghc963.override(hpkgs);
      "ghc981" = (import ./nixpkgs/unstable {}).haskell.packages.ghc981;
      "ghc865" = (import ./nixpkgs/reflex-platform {}).ghc8_6;
    };
in
  pkgs.lib.mapAttrs (_: ghc: ghc.callCabal2nix "aeson-gadt-th" (builtins.fetchGit ./.) {}) ghcs
