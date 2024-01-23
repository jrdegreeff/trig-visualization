using Markdown
using Plots

import Base: Fix1, Fix2, ImmutableDict
import Printf.@sprintf

# Formatting

isapproxinteger = x -> abs(x - round(Int, x)) < 1e-6

round_to_hundredths(x::Float64) = replace(@sprintf("%.2f", x), "-0.00" => "0.00")
round_label(x) = string(isapproxinteger(x) ? round(Int, x) : round(x, digits=3))

destructure(x::Rational) = sign_label(x), abs(numerator(x)), denominator(x)

sign_label(x::Real) = x < 0 ? "-" : ""
coefficient_label(x::Real, f=identity) = sign_label(x) * (isone(abs(x)) ? "" : "$(f(abs(x)))")

parenthesize(s::String, ::MIME"text/plain", condition::Bool=true) = (condition ? "(" : "") * s * (condition ? ")" : "")
parenthesize(s::String, ::MIME"text/latex", condition::Bool=true) = (condition ? "\\left(" : "") * s * (condition ? "\\right)" : "")

format_fraction(n, d, ::MIME"text/plain") = isone(d) ? "$n" : "$n/$d"
format_fraction(n, d, ::MIME"text/latex") = isone(d) ? "$n" : "\\frac{$n}{$d}"

function fraction_label(x::Rational, mime::MIME)
    s, n, d = destructure(x)
    s * format_fraction(n, d, mime)
end
function π_label(x::Rational, mime::MIME)
    s, n, d = destructure(x)
    s * format_fraction(coefficient_label(n) * (iszero(x) ? "" : "π"), d, mime)
end
function reciprocal_π_label(x::Rational, mime::MIME)
    s, n, d = destructure(x)
    s * format_fraction(n, coefficient_label(d) * (iszero(x) ? "" : "π"), mime)
end
function reciprocal_π_label(x::Rational, mime::MIME"text/plain")
    s, n, d = destructure(x)
    s * format_fraction(n, parenthesize(coefficient_label(d) * (iszero(x) ? "" : "π"), mime, !isone(d)), mime)
end

D = 10080 # 2^5 * 3^2 * 5 * 7
format_label(x, mime::MIME; d=D) =
    isapproxinteger(x*d)     ? fraction_label(round(Int, x*d) // d, mime) :
    isapproxinteger((x/π)*d) ? π_label(round(Int, (x/π)*d) // d, mime) :
    isapproxinteger((x*π)*d) ? reciprocal_π_label(round(Int, (x*π)*d) // d, mime) :
                               round_label(x)

function two_way_range(base, min, max, step)
    @assert step > 0
    @assert min < max
    base = base % step
    @assert min ≤ base ≤ max
    sort(unique(vcat(base:-step:min, base:step:max)))
end
function padded_range(min, max, step, pad)
    @assert step > 0
    @assert min < max
    @assert isinteger((max - min) / step)
    sort(unique(vcat(min:-step:(min - pad), min:step:max, max:step:(max + pad))))
end

# Constants

sin_color = 1
cos_color = 2
hyp_color = 3
tan_color = 3
period_color = 4
max_min_color = 5
shift_color = :gray
fallback_color = :black

default_colors = ImmutableDict(Pair{Function, Int}(sin, sin_color), cos => cos_color, tan => tan_color)
base_period = ImmutableDict(Pair{Function, Float64}(sin, 2π), cos => 2π, tan => π)
inverse_table = ImmutableDict(Pair{Function, Function}(sin, asin), cos => acos, tan => atan, identity => identity)
reciprocal_table = ImmutableDict(Pair{Function, Function}(sin, csc), cos => sec, tan => cot)

# Sinusoid Manipulation

struct Wave{F} <: Function
    f::F
    color
    A::Real
    k::Real
    b::Real
    h::Real
    reciprocal::Bool

    function Wave(
        func=identity; color=get(default_colors, func, fallback_color),
        A=1, k=0, b=1, h=0, reciprocal=false,
        T=nothing, f=nothing, ϕ=nothing
    )
        @assert isnothing(T) || isnothing(f)
        !isnothing(T) && (b = base_period[func] / T)
        !isnothing(f) && (b = base_period[func] * f)
        !isnothing(ϕ) && (h = ϕ/b)
        
        new{typeof(func)}(func, color, A, k, b, h, reciprocal)
    end
end
reciprocal(w::Wave; color=w.color) = Wave(w.f; color, A=w.A, k=w.k, b=w.b, h=w.h, reciprocal=true)
inner(w::Wave; color=w.color) = Wave(; color, b=w.b, h=w.h)
horizontal(w::Wave) = Wave(w.f; color=w.color, b=w.b, h=w.h)
vertical(w::Wave) = Wave(w.f; color=w.color, A=w.A, k=w.k)

(w::Wave)(θ) = w.reciprocal ? reciprocal(w, θ) : apply(w, θ)
apply(w::Wave, θ) = w.A * w.f(w.b * (θ - w.h)) + w.k
reciprocal(w::Wave, θ) = w.A * reciprocal_table[w.f](w.b * (θ - w.h)) + w.k
invert(w::Wave, x) = inverse_table[w.f]((1 / w.A) * (x - w.k)) / w.b + w.h

invert_inner(w::Wave, x) = invert(inner(w), x)
invert_horizontal(w::Wave, x) = invert(horizontal(w), x)
invert_vertical(w::Wave, x) = invert(vertical(w), x)

base_function(w::Wave) = w.reciprocal ? reciprocal_table[w.f] : w.f
amplitude(w::Wave) = abs(w.A)
midline(w::Wave) = w.k
angular_frequency(w::Wave) = abs(w.b)
h_shift(w::Wave) = w.h

wave_max(w::Wave) = midline(w) + amplitude(w)
wave_min(w::Wave) = midline(w) - amplitude(w)
period(w::Wave) = base_period[w.f] / angular_frequency(w)
frequency(w::Wave) = angular_frequency(w) / base_period[w.f]
phase_shift(w::Wave) = angular_frequency(w) * h_shift(w)

asymptotes(w::Wave, min=-period(w), max=period(w)) =
    w.reciprocal              ? two_way_range(invert_horizontal(w, 0), min, max, period(w) / 2) :
    (base_function(w) == tan) ? two_way_range(invert_horizontal(w, 0) - (period(w) / 2), min, max, period(w)) :
                                []

wave_arg_max(w::Wave, mime::MIME) = base_step_label(invert_horizontal(w, 1), period(w), mime)
wave_arg_min(w::Wave, mime::MIME) = base_step_label(invert_horizontal(w, -1), period(w), mime)
wave_arg_mid(w::Wave, mime::MIME) = base_step_label(invert_horizontal(w, 0), period(w) / 2, mime)
function wave_zeros(w::Wave, mime::MIME)
    discriminant = abs(w.k / w.A)
    base = discriminant > 1 ? [] : isone(discriminant) ? [invert(w, 0)] : [invert(w, 0), 2invert_horizontal(w, 1) - invert(w, 0)]
    labeler = x -> base_step_label(x, period(w), mime)
    list_label(labeler.(base), mime)
end
wave_asymptotes(w::Wave, mime::MIME) =
    w.reciprocal              ? wave_arg_mid(w, mime) :
    (base_function(w) == tan) ? base_step_label(invert_horizontal(w, 0) - (period(w) / 2), period(w), mime) :
                                empty_label(mime)


Plots.get_series_color(w::Wave, sp::Plots.Subplot, n::Int, seriestype) = Plots.get_series_color(w.color, sp, n, seriestype)

plus_label(x, mime::MIME) = iszero(x) ? "" : " $(x > 0 ? "+" : "-") $(format_label(abs(x), mime))"
plus_label_left(x, mime::MIME) = iszero(x) ? "" : "$(format_label(x, mime)) + "
times_label(x, mime::MIME; space=true) = coefficient_label(x, x -> format_label(x, mime) * (space ? " " : ""))

function base_step_label(b, s, mime::MIME)
    @assert s > 0
    "$(plus_label_left(mod(b, s), mime))$(times_label(s, mime))k"
end
empty_label(::MIME"text/plain") = "none"
empty_label(::MIME"text/latex") = "\\emptyset"
list_label_separator(::MIME"text/plain") = ",  "
list_label_separator(::MIME"text/latex") = ",\\ \\ "
list_label(list, mime::MIME) = isempty(list) ? empty_label(mime) : join(list, list_label_separator(mime))

format_inner(mime::MIME, w::Wave) = times_label(w.b, mime, space=false) * parenthesize("θ" * plus_label(-w.h, mime), mime, !isone(w.b) && !iszero(w.h))

Base.show(io::IO, mime::MIME"text/plain", w::Wave{typeof(identity)}, prefix="") = print(io, prefix, format_inner(mime, w))
Base.show(io::IO, mime::MIME"text/plain", w::Wave, prefix="") = print(
    io, prefix, times_label(w.A, mime), base_function(w), parenthesize(format_inner(mime, w), mime), plus_label(w.k, mime)
)
Base.show(io::IO, mime::MIME"text/latex", w::Wave{typeof(identity)}, prefix="") = print(io, "\$", prefix, format_inner(mime, w), "\$")
Base.show(io::IO, mime::MIME"text/latex", w::Wave, prefix="") = print(
    io, "\$", prefix, times_label(w.A, mime), "\\", base_function(w), parenthesize(format_inner(mime, w), mime), plus_label(w.k, mime), "\$"
)

show_text(w::Wave, prefix="") = sprint(show, MIME("text/plain"), w, prefix)
show_latex(w::Wave, prefix="f(θ) = ") = sprint(show, MIME("text/latex"), w, prefix)
label_eval(w::Wave, θ, mime::MIME=MIME("text/plain")) = "$(sprint(show, mime, w)) = $(format_label(w(θ), mime))"

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
    format_label_text = Fix2(format_label, MIME("text/plain"))
    columns = [
        "θ" => adjusted_angles .|> format_label_text,
        (map(columns) do wave
            format = base_function(wave) == identity ? format_label_text : round_to_hundredths
            show_text(wave) => [adjusted_angles[1:n_angles] .|> wave .|> format; fill("", length(angles) - n_angles)]
        end)...
    ]
    format_table(columns, column_width=column_width)
end

properties_list(properties, cutoff) = Markdown.parse(join((
	"$n = $(cutoff ≥ i ? "\$$v\$" : "")" for (i, (n, v)) in enumerate(properties)
), "\\\n"))

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

	circle_start, circle_end = invert(θ_func, 0), invert(θ_func, 2π)
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
		lw=2(θ_rev + 1), color=:gray, label=label_eval(θ_func, θ)
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
		lw=3, color=sin_color, label=show_sin && label_eval(sin_func, θ)
	)
	plot!(  # horizontal edge of triangle
		[x₀, cos_func(θ)], [y₀, y₀],
		lw=3, color=cos_color, label=show_cos && label_eval(cos_func, θ)
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
    max_θ=maximum(period.(waves)), tick_θ=max_θ/4, pad_θ=true, tickstyle=:decimal,
    max_y=nothing, tick_y=nothing, pad_y=true,
    circle_resolution=tick_θ/100, θ=nothing,
    show_curve=true, show_label=true,
    show_asymptotes=false,
    n_angles=n_special_angles, critical_only=false,
    show_positive=false, show_negative=false,
    show_base_point=false, show_period_points=false, show_all_critical_points=false,
    show_max_min=false, show_period=false,
    show_v_shift=false, show_h_shift=false
)
    p = plot(
        framestyle=:origin, minorgrid=true, legend=show_label,
        xminorticks=6, yminorticks=4, minorgridlinewidth=1
    )

    @assert isinteger(max_θ / tick_θ)
    min_θ = -max_θ
    pad_θ = pad_θ ? tick_θ/6 : 0
    θ_ticks = min_θ:tick_θ:max_θ
    if tickstyle == :decimal
        θ_labels = round_label.(θ_ticks)
    elseif tickstyle == :fraction
        @assert isapproxinteger(D / tick_θ) "isinteger($D / tick_θ): tick_θ = $tick_θ"
        θ_labels = Fix2(fraction_label, MIME("text/plain")).(Fix1(round, Int).(θ_ticks .* D ./ tick_θ) .// round(Int, D / tick_θ))
    elseif tickstyle == :πfraction
        @assert isapproxinteger(D * π / tick_θ) "isinteger($D * π / tick_θ): tick_θ = $tick_θ"
        θ_labels = Fix2(π_label, MIME("text/plain")).(Fix1(round, Int).(θ_ticks .* D ./ tick_θ) .// round(Int, D * π / tick_θ))
    elseif tickstyle == :none
        θ_labels = fill("", length(θ_ticks))
    else
        error("unexpected tickstyle: $tickstyle")
    end
    plot!(xlim=(min_θ - pad_θ, max_θ + pad_θ), xticks=(collect(θ_ticks), θ_labels))

    if isnothing(max_y)
        max_y = max(maximum(wave_max.(waves)), 0)
        min_y = min(minimum(wave_min.(waves)), 0)
    else
        min_y = -max_y
    end
    pad_y = pad_y ? (any(!isempty(asymptotes(w)) for w in waves) ? (max_y - min_y) / 4 : (max_y - min_y) / 20) : 0
    isnothing(tick_y) && (tick_y = (max_y - min_y) / 4)
    y_ticks = padded_range(min_y, max_y, tick_y, pad_y)
    y_labels = tickstyle == :none ? fill("", length(y_ticks)) : round_label.(y_ticks)
    
    plot!(
        ylim=(min_y - pad_y, max_y + pad_y),
        yticks=(collect(y_ticks), y_labels)
    )

    for wave in waves
        phase_angle = [h_shift(wave)]
        period_angles = two_way_range(h_shift(wave), min_θ, max_θ, period(wave))
        all_critical_angles = two_way_range(h_shift(wave), min_θ, max_θ, period(wave) / 4)
        angles = critical_only ? critical_angles : special_angles
        n_angles = min(n_angles, length(angles))
        displayed_angles = Fix1(invert_inner, wave).(angles[1:n_angles])
        filter!(a -> a ≤ max_θ, displayed_angles)
        vasymptotes = asymptotes(wave, min_θ, max_θ)

        show_v_shift && plot!(  # midline marker
            [min_θ, max_θ], [midline(wave), midline(wave)], label=false, lw=3, color=shift_color, style=:dash
        )
        show_h_shift && vline!(  # phase marker
            phase_angle, label=false, lw=3, color=shift_color, style=:dash
        )
        show_period && vline!(  # period markers
            period_angles, label=false, lw=2, color=period_color, style=:dash
        )
        show_max_min && plot!(  # max and min markers
            [min_θ, max_θ], [wave_max(wave), wave_max(wave)], label=false, lw=2, color=max_min_color, style=:dash
        )
        show_max_min && plot!(  # max and min markers
            [min_θ, max_θ], [wave_min(wave), wave_min(wave)], label=false, lw=2, color=max_min_color, style=:dash
        )
        show_asymptotes && vline!(  # vertical asymptote markers
            vasymptotes, label=false, lw=2, color=wave, style=:dash
        )
        
        inputs = filter(θ -> !any(isapprox(θ, va, atol=1e-6) for va in vasymptotes), min_θ:circle_resolution:max_θ)
        points = sort(vcat([(θ, wave(θ)) for θ in inputs], [(θ, NaN) for θ in vasymptotes]), lt=((x, y) -> x[1] < y[1]))
        show_curve && plot!(  # the function itself
            points, label=show_text(wave), lw=3, color=wave
        )
        
        show_positive && scatter!(  # positive special angles
            displayed_angles, wave, label=false, color=wave
        )
        show_negative && scatter!(  # negative special angles
            -displayed_angles, wave, label=false, color=wave
        )

        show_all_critical_points && scatter!(  # all critical points
            all_critical_angles, wave, label=false, color=wave
        )
        show_period_points && scatter!(  # points on period boundaries
            period_angles, wave, label=false, color=period_color
        )
        show_base_point && scatter!(  # point on phase shift
            phase_angle, wave, label=false, color=shift_color
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
	max_θ=2π, tick_θ=max_θ/2, tickstyle=:πfraction,
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
