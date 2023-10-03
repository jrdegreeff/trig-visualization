# trig-visualization
Pluto.jl visualizations for trigonometric functions. Made for Middlesex's Math 32: Trigonometry.

## macOS

### Install
To install dependencies (Julia language and Pluto.jl) on macOS, double click `install-macos.command` in Finder. This only has to be done once. If you get a security error about the script being from an unidentified developer, you can bypass this by right clicking (control-clicking) the script and select `Open` then click the `Open` button on the security warning.

This process has two steps, and in between the steps there will be a pause with no output. Depending on your internet speed and CPU this may take up to five minutes to complete.

### Run
Then each time you want to run the notebook, double click `run-macos.command` in Finder to start the notebook in your browser. The first time you run the notebook, it may take up to five minutes to compile everything in the background (in particular the plotting library takes a while). When you run it subsequent times, it should take less than thirty seconds to start up and run all of the cells. When you close the terminal window that this script opens, it will terminate the notebook.

## Windows
Note: there is probably a good way to automate this like I did for macOS, but these instructions are at least functional, if a bit more tedious.

### Install
First install Julia from the Windows Store [here](https://www.microsoft.com/store/apps/9NJNWW8PVKMN).

Now open command prompt and type
```
julia
```
to open the julia REPL where you can run julia code. In this case all you need to do is type
```
using Pkg; Pkg.add("Pluto")
```
to install the dependency. This will take a little while to download and precompile.

### Run
The instructions above only have to be run once. To start the notebook, all you need to do is open the julia REPL and type
```
import Pluto; Pluto.run(notebook="C:\\[...]\\sinusoid-graph-visualization.jl")
```
Where the [...] should be replaced the path to where you downloaded the file. Note that you need to use `\\` instead of `\` in the path because a single backslash introduces an escape character whereas the double backslash is in fact an escaped backslash literal in Julia and many other programming languages.
