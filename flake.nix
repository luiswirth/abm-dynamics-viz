{
  description = "iml24-projects";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;

      devShell.${system} = pkgs.mkShell rec {
        buildInputs = with pkgs; [
          (python3.withPackages(ps: with ps; [
            python-lsp-server
            numpy 
            pandas
            pyarrow
            scikit-learn
            matplotlib

            jwt
            requests
            urllib3
          ]))
          pipenv
        ];

        CPATH = pkgs.lib.makeSearchPathOutput "dev" "include" buildInputs;
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;
      };
    };
}

