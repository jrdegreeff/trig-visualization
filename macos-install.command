#!/usr/bin/env zsh
curl -fsSL https://install.julialang.org | sh -s -- --yes
source ~/.zshrc
julia -e 'using Pkg; Pkg.add("Pluto")'

cd "$( dirname "$0" )"
julia -e 'import Pluto; Pluto.run(notebook="./sinusoid-graph-visualization.jl")'
