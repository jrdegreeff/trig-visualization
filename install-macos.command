#!/usr/bin/env zsh
curl -fsSL https://install.julialang.org | sh -s -- --yes
source ~/.zshrc
julia -e 'using Pkg; Pkg.add("Pluto")'
