{
  description = "echoes, a kubernetes demo project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };
  
  outputs = { self, nixpkgs, flake-utils }@attrs:
    
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        
      in {
        devShells.default = pkgs.mkShell {

          packages = with pkgs; [
            # System Utils
            ## Fetching
            curl
            ## Parsing
            dasel
            jq

            kind
            k9s
            krew
            kubectl
            kubernetes-helm
            kustomize

            # Languages
            yaml-language-server

            # Policy
            open-policy-agent
            
          ];

          # Hook up local and krew bin directories.
          shellHook = ''
            export PATH="$PATH:$HOME/.local/bin"
            export PATH="$PATH:$HOME/.krew/bin"
          '';
        };
      });
}
