include("./sinusoid-plotting.jl")

plot_trig_function(Wave(), show_curve=false, tickstyle=:none)
png("exports/Unlabeled Graph.png")

plot_trig_function(Wave(sin, color=3, A=2, T=2), show_label=false)
png("exports/MQ 6 - Sine Graph.png")

plot_trig_function(Wave(cos), max_y=1.5, tick_y=0.5, tickstyle=:πfraction, show_curve=false, show_label=false)
png("exports/MQ 7 - Empty Plot.png")

plot_trig_function(Wave(cos, color=3, A=2, k=2, T=π), tickstyle=:πfraction, show_label=false)
png("exports/MQ 8 - Graph 1.png")

plot_trig_function(Wave(sin, color=3, A=-3, k=-1, T=2), show_label=false)
png("exports/MQ 8 - Graph 2.png")

plot_trig_function(Wave(sin, A=3, h=π/2), max_y=4, tickstyle=:πfraction, show_curve=false, show_label=false)
png("exports/MQ 9 - Empty Plot Scaled 1.png")

plot_trig_function(Wave(cos, b=4π, k=0.5), max_θ=1, max_y=1.5, tick_y=0.5, show_curve=false, show_label=false)
png("exports/MQ 9 - Empty Plot Scaled 2.png")

plot_trig_function(Wave(sin, color=3, A=5, k=2, T=8, h=-1), tick_θ=2, tick_y=2, show_label=false)
png("exports/Quiz 3 - 1.2")

plot_trig_function(Wave(sin, A=12, k=8, T=π, h=π/4), max_θ=2π, tickstyle=:πfraction, show_label=false)
png("exports/Quiz 3 - 2.1")

plot_trig_function(Wave(cos, A=2.5, k=-1.5, T=3, h=1), max_θ=3, tick_θ=1, tick_y=1, show_label=false)
png("exports/Quiz 3 - 2.2")

plot_trig_function(Wave(cos, A=3, k=-1, T=4π/3, h=π/2), max_y=4, tickstyle=:πfraction, max_θ=2π, show_curve=false, show_label=false)
png("exports/Quiz 3 - 3.1")

plot_trig_function(Wave(sin, A=-2, k=0.5, T=6, h=-1), tick_θ=1, max_y=3, tick_y=0.5, show_curve=false, show_label=false)
png("exports/Quiz 3 - 3.2")

;
