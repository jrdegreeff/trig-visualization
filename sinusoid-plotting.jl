using Plots

import Base.Fix1
import Printf.@sprintf

# Formatting

round_to_hundredths(x::Float64) = replace(@sprintf("%.2f", x), "-0.00" => "0.00")

isapproxinteger = x -> abs(x - round(Int, x)) < 1e-6

function π_label(x::Real)
    iszero(x) && return "0"
    S = x < 0 ? "-" : ""
    n = abs(isinteger(x) ? Int(x) : x)
    N = isone(n) ? "" : n
    "$(S)$(N)π"
end
function π_label(x::Rational)
    iszero(x) && return "0"
    n, d = π_label(numerator(x)), denominator(x)
    isone(d) ? n : "$(n)/$(d)"
end

round_label(x) = isapproxinteger(x) ? round(Int, x) : round(x, digits=3)

format_label(θ, d=5040) = isapproxinteger(θ/(π/d)) ?
    π_label(round(Int, θ/(π/d)) // d) :
    round_label(θ)

sin_color = 1
cos_color = 2
hyp_color = 3

# Sinusoid Manipulation

struct Wave{F} <: Function
    f::F
    color
    A::Real
    k::Real
    b::Real
    h::Real

    function Wave(
        func=identity; color=default_color(func),
        A=1, k=0, b=1, h=0, T=nothing, f=nothing
    )
        @assert isnothing(T) || isnothing(f)
        !isnothing(T) && (b = 2π/T)
        !isnothing(f) && (b = 2πf)
        
        new{typeof(func)}(func, color, A, k, b, h)
    end
end

(w::Wave)(θ) = w.A * w.f(w.b * (θ - w.h)) + w.k
invert(w::Wave) = (x) -> inverse_table[w.f]((1 / w.A) * (x - w.k)) / w.b + w.h

amplitude(w::Wave) = abs(w.A)
midline(w::Wave) = w.k
angular_frequency(w::Wave) = w.b
h_shift(w::Wave) = w.h

Base.maximum(w::Wave) = midline(w) + amplitude(w)
Base.minimum(w::Wave) = midline(w) - amplitude(w)
period(w::Wave) = 2π / angular_frequency(w)
freqeuncy(w::Wave) = angular_frequency(w) / (2π)
phase_shift(w::Wave) = -angular_frequency(w) * h_shift(w)

Plots.get_series_color(w::Wave, sp::Plots.Subplot, n::Int, seriestype) =
    Plots.get_series_color(w.color, sp, n, seriestype)

inner(w::Wave; color=w.color) = Wave(; color, b=w.b, h=w.h)
invert_inner(w::Wave, x) = invert(inner(w))(x)

plus_label(x) = iszero(x) ? "" : " $(x > 0 ? "+" : "-") $(format_label(abs(x)))"
times_label(x; space=true) = isone(x) ? "" : "$(format_label(x))$(space ? " " : "")"

function Base.show(io::IO, w::Wave{typeof(identity)})
    parenthesize = !isone(w.b) && !iszero(w.h)
    print(
        io, times_label(w.b, space=false), parenthesize ? "(θ" : "θ", plus_label(-w.h), parenthesize ? ")" : ""
    )
end
Base.show(io::IO, w::Wave) = print(
    io, times_label(w.A), w.f, "(", inner(w), ")", plus_label(w.k)
)
eval_label(w::Wave, θ) = "$(w) = $(format_label(w(θ)))"

default_colors = Dict([sin => sin_color, cos => cos_color])
default_color(func) = get(default_colors, func, 3)
inverse_table = Dict([sin => asin, cos => acos, identity => identity])

# Tables

special_angles = [
    0, π/6, π/4, π/3, π/2, 2π/3, 3π/4, 5π/6, π,
    7π/6, 5π/4, 4π/3, 3π/2, 5π/3, 7π/4, 11π/6, 2π
]
n_special_angles = length(special_angles)
critical_angles = [
    0, π/2, π, 3π/2, 2π
]

function format_table(columns; column_width)
    line_span = repeat("-", column_width)
    line = "+-" * join((line_span for _ in columns), "-+-") * "-+\n"
    
    pad(text) = lpad(text, column_width, " ")
    header = "| " * join((pad(c[1]) for c in columns), " | ") * " |\n"
    rows = ("| " * join((pad(v) for v in r), " | ") * " |\n" for r in zip([c[2] for c in columns]...))
    
    Text(line * header * line * reduce(*, rows) * line)
end

function format_special_angles_table(column::Wave; kwargs...)
    format_special_angles_table([column]; kwargs...)
end
function format_special_angles_table(
    columns::Vector{<:Wave};
    n_angles=n_special_angles, critical_only=false, column_width=6
)
    @assert length(columns) > 0
    angles = critical_only ? critical_angles : special_angles
    n_angles = min(n_angles, length(angles))
    adjusted_angles = Fix1(invert_inner, columns[1]).(angles)
    columns = ["θ" => adjusted_angles .|> format_label, (string(wave) => vcat(
        adjusted_angles[1:n_angles] .|> wave .|> (wave.f == identity ? format_label : round_to_hundredths), fill("", length(angles) - n_angles)
    ) for wave in columns)...]
    format_table(columns, column_width=column_width)
end

# Plotting

function plot_trig_circle(
	θ;
	R=1, x₀=0, y₀=0, b=1, h=0,
	max_x=nothing, max_y=nothing, R_tick=1, circle_resolution=0.01π,
	show_sin=false, show_cos=false
)
	θ_func = Wave(identity; b, h)
	sin_func = Wave(sin; A=R, k=y₀, b, h)
	cos_func = Wave(cos; A=R, k=x₀, b, h)

	sin_func_radius = Wave(sin; A=1.1R, k=y₀, b, h)
	cos_func_radius = Wave(cos; A=1.1R, k=x₀, b, h)

	angle_radius = isnothing(max_x) || isnothing(max_y) ? 0.1 : 0.1min(max_x, max_y)
	sin_func_angle = Wave(sin; A=angle_radius, k=y₀, b, h)
	cos_func_angle = Wave(cos; A=angle_radius, k=x₀, b, h)

	circle_start, circle_end = invert(θ_func)(0), invert(θ_func)(2π)
	circle_range = circle_start:circle_resolution:circle_end

	θ_rev = abs(θ) ÷ circle_end
	θ_range = 0:((θ ≥ 0 ? 1 : -1) * circle_resolution):θ

	p = plot(framestyle=:origin, aspect_ratio=:equal)

	if !isnothing(max_x)
		x_ticks = -(max_x ÷ R_tick)R_tick:R_tick:(max_x ÷ R_tick)R_tick
		plot!(
			xlim=(-max_x, max_x) .* 1.1,
			xticks=(collect(x_ticks), round_label.(x_ticks))
		)
	end
	if !isnothing(max_y)
		y_ticks = -(max_y ÷ R_tick)R_tick:R_tick:(max_y ÷ R_tick)R_tick
		plot!(
			ylim=(-max_y, max_y) .* 1.1,
			yticks=(collect(y_ticks), round_label.(y_ticks))
		)
	end

	scatter!(  # center
		[x₀], [y₀],
		ms=6, msw=0, color=:black, label=false
	)
	plot!(  # radius
		[x₀, cos_func_radius(0)], [y₀, sin_func_radius(0)],
		lw=3, color=:black, label=false
	)
	plot!(  # circle
		cos_func.(circle_range), sin_func.(circle_range),
		lw=2, color=:black, label=false
	)
	plot!(  # angle - (angle % 2π)
		cos_func_angle.(circle_range), sin_func_angle.(circle_range),
		lw=2θ_rev, color=:gray, label=false
	)
	plot!(  # angle % 2π
		cos_func_angle.(θ_range), sin_func_angle.(θ_range),
		lw=2(θ_rev + 1), color=:gray, label=eval_label(θ_func, θ)
	)
	plot!(  # vertical offset
		[x₀, x₀], [0,  y₀],
		lw=3, color=sin_color, label=false
	)
	plot!(  # horizontal offset
		[0, x₀], [0,  0],
		lw=3, color=cos_color, label=false
	)
	plot!(  # hypotenuse of triangle
		[x₀, cos_func(θ)], [y₀, sin_func(θ)],
		lw=3, color=hyp_color, label=false
	)
	plot!(  # vertical edge of triangle
		[cos_func(θ), cos_func(θ)], [y₀, sin_func(θ)],
		lw=3, color=sin_color, label=show_sin && eval_label(sin_func, θ)
	)
	plot!(  # horizontal edge of triangle
		[x₀, cos_func(θ)], [y₀, y₀],
		lw=3, color=cos_color, label=show_cos && eval_label(cos_func, θ)
	)
	scatter!(  # point on circle
		[cos_func(θ)], [sin_func(θ)],
		ms=6, msw=3, color=:white, msc=:black, label=false
	)
	p
end

function plot_trig_function(wave::Wave; kwargs...)
    plot_trig_function([wave]; kwargs...)
end
function plot_trig_function(
    waves::Vector{<:Wave};
    max_θ=maximum(period.(waves)), tick_θ=max_θ/4, tickstyle=:decimal,
    max_y=nothing, tick_y=nothing,
    circle_resolution=tick_θ/100, θ=nothing,
    show_curve=true, show_label=true,
    n_angles=n_special_angles, critical_only=false,
    show_positive=false, show_negative=false,
    show_max_min=false, show_period=false,
    show_v_shift=false, show_h_shift=false
)
    p = plot(
        framestyle=:origin, minorgrid=true, legend=show_label,
        xminorticks=6, yminorticks=4, minorgridlinewidth=1
    )

    @assert isinteger(max_θ / tick_θ)
    θ_ticks = -max_θ:tick_θ:max_θ
    if tickstyle == :decimal
        θ_labels = round_label.(θ_ticks)
    elseif tickstyle == :πmultiple
        @assert isinteger(tick_θ / π)
        θ_labels = π_label.(θ_ticks ./ π)
    elseif tickstyle == :πfraction
        @assert isinteger(π / tick_θ)
        θ_labels = π_label.(Int.(θ_ticks ./ tick_θ) .// Int(π / tick_θ))
    else
        error("unexpected tickstyle: $tickstyle")
    end
    plot!(xlim=(-1.1max_θ, 1.1max_θ), xticks=(collect(θ_ticks), θ_labels))

    if isnothing(max_y)
        max_y = maximum(maximum.(waves))
        min_y = minimum(minimum.(waves))
    else
        min_y = -max_y
    end
    pad_y = (max_y - min_y) / 20
    isnothing(tick_y) && (tick_y = (max_y - min_y) / 4)
    
    plot!(
        ylim=(min_y - pad_y, max_y + pad_y),
        yticks=(collect(min_y:tick_y:max_y), round_label.(min_y:tick_y:max_y))
    )

    for wave in waves
        show_v_shift && plot!(  # midline marker
            [-max_θ, max_θ], [midline(wave), midline(wave)],
            label=false, lw=3, color=:gray, style=:dash
        )
        show_h_shift && vline!(  # phase marker
            [h_shift(wave)],
            label=false, lw=3, color=:gray, style=:dash
        )
        show_period && vline!(  # period markers
            sort(vcat(
                h_shift(wave):-period(wave):-max_θ, h_shift(wave):period(wave):max_θ)
            ), label=false, lw=2, color=4, style=:dash
        )
        show_max_min && plot!(  # max and min markers
            [-max_θ, max_θ], [maximum(wave), maximum(wave)],
            label=false, lw=2, color=5, style=:dash
        )
        show_max_min && plot!(  # max and min markers
            [-max_θ, max_θ], [minimum(wave), minimum(wave)],
            label=false, lw=2, color=5, style=:dash
        )

        
        show_curve && plot!(  # the function itself
            -max_θ:circle_resolution:max_θ, wave, label=string(wave),
            lw=3, color=wave
        )

        angles = critical_only ? critical_angles : special_angles
        n_angles = min(n_angles, length(angles))
        displayed_angles = Fix1(invert_inner, wave).(angles[1:n_angles])
        filter!(a -> a ≤ max_θ, displayed_angles)

        show_positive && scatter!(  # positive special angles
            displayed_angles, wave, label=false, color=wave
        )
        show_negative && scatter!(  # negative special angles
            -displayed_angles, wave, label=false, color=wave
        )

        !isnothing(θ) && plot!(  # vertical line at indicated point
            [θ, θ], [0, wave(θ)], label=false, lw=3, color=wave
        )
        !isnothing(θ) && scatter!(  # indicated point
            [θ], [wave(θ)], label=round_label(wave(θ)),
            ms=6, msw=3, color=:white, msc=wave
        )
    end
    p
end

function plot_side_by_side(
	θ; R=1, x₀=0, y₀=0, b=1, h=0,
	circle_max_x=1, circle_max_y=1.5, circle_tick=0.5,
	max_θ=2π, tick_θ=max_θ/2, tickstyle=:πmultiple,
	wave_max_y=1, wave_tick_y=wave_max_y/2
)
	circle_plot = plot_trig_circle(
		θ; R, x₀, y₀, b, h,
		max_x=circle_max_x, max_y=circle_max_y, R_tick=circle_tick,
		show_sin=true, show_cos=true
	)
	sin_curve_plot = plot_trig_function(
		Wave(sin; A=R, k=y₀, b, h);
		max_θ, tick_θ, tickstyle, max_y=wave_max_y, tick_y=wave_tick_y, θ
	)
	cos_curve_plot = plot_trig_function(
		Wave(cos; A=R, k=x₀, b, h);
		max_θ, tick_θ, tickstyle, max_y=wave_max_y, tick_y=wave_tick_y, θ
	)
	plot(circle_plot, plot(sin_curve_plot, cos_curve_plot, layout=(2, 1)))
end

;
