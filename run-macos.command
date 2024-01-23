#!/usr/bin/env zsh
cd "$( dirname "$0" )"
julia -e 'import Pluto; Pluto.run(notebook="./sinusoid-graph-visualization.jl")'
