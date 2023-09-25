# trig-visualization
Pluto.jl visualizations for trigonometric functions. Made for Middlesex's Math 32: Trigonometry.

## macOS
To install dependencies (Julia language and Pluto.jl) on macOS, double click `install-macos.command` in Finder. This only has to be done once. If you get a security error about the script being from an unidentified developer, you can bypass this by right clicking (control-clicking) the script and select `Open` then click the `Open` button on the security warning.

Then each time you want to run the notebook, double click `run-macos.command` in Finder to start the notebook in your browser. The first time you run it will be a bit slower because everything will need to compile. When you close the terminal window that this script opens, it will terminate the notebook.

## Windows
I haven't bothered to learn how to write Windows scripts, but if you know how to use the command prompt, the installation process should be something like
```
winget install julia -s msstore
julia -e 'using Pkg; Pkg.add("Pluto")'
```
Then you should be able to start the notebook with something like
```
julia -e 'import Pluto; Pluto.run(notebook="./sinusoid-graph-visualization.jl")'
```
The relative path to the notebook might need to be tweaked... I am not a Windows person.
