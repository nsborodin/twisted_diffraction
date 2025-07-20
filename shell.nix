{ pkgs ? import <nixpkgs> {} }:

let
  pythonEnv = pkgs.python3.withPackages (ps: with ps; [
    pip
    pygraphviz
    jupyter
    ipython
    ipykernel
    # Add other packages you need here
  ]);
in

pkgs.mkShell {
  buildInputs = [ 
    pythonEnv
    pkgs.graphviz
    pkgs.gcc
 ];

  shellHook = ''
    if [ ! -d "bot" ]; then
      python3 -m venv bot
      source bot/bin/activate
      pip install -r requirements.txt
    else
      source bot/bin/activate
    fi
  '';
}