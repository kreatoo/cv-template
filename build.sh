#!/bin/sh
set -e

# Run pdflatex to compile the cv.tex file using nix-shell
nix-shell --pure \
    -p "texlive.combine {
        inherit (texlive)
        scheme-small
        moderncv
        xcolor
        hyperref
        geometry
        fontawesome5
        multirow
        arydshln
        cm-super
        lm
        lm-math
        collection-fontsrecommended
        ;
      }" \
    --run "pdflatex -interaction=nonstopmode cv.tex && rm -f *.aux *.log *.out"

# Confirm successful build
if [ -f "cv.pdf" ]; then
    echo "Successfully built cv.pdf"
else
    echo "Error: Failed to build cv.pdf"
    exit 1
fi
