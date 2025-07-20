{ pkgs ? import <nixpkgs> {} }:

let
  pythonEnv = pkgs.python3.withPackages (ps: with ps; [
    # Core Python packages
    pip
    
    # Jupyter and IPython
    jupyter
    ipython
    ipykernel
    
    # Scientific computing packages
    numpy
    matplotlib
    scipy
    
    # Additional packages
    pygraphviz
  ]);
in

pkgs.mkShell {
  buildInputs = [ 
    pythonEnv
    pkgs.graphviz
    pkgs.gcc
  ];

  shellHook = ''
    echo "Setting up Jupyter kernel for Nix environment..."
    
    # Register the current Python environment as a Jupyter kernel
    python -m ipykernel install --user --name nix-python --display-name "Python (Nix)"
    
    echo "Nix environment ready!"
    echo "Python path: $(which python)"
    echo "Jupyter kernels available:"
    jupyter kernelspec list
  '';
}
