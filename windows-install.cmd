winget install julia -s msstore --accept-package-agreements
julia -e "using Pkg; Pkg.add(\"Pluto\")"
julia -e "import Pluto; Pluto.run(notebook=\"./sinusoid-graph-visualization.jl\")"
