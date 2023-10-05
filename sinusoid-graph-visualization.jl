### A Pluto.jl notebook ###
# v0.19.29

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ e503d9f6-84f0-486f-aa0f-b9cf6aa88b69
begin
	using DataStructures
	using Plots
	using PlutoUI

	import Base.Fix1
	import Printf.@sprintf
end

# ╔═╡ d55da43e-9ba9-4527-8fec-72493e7996f3
html"""<script>
document.presentAndReset = function() {
	window.present();
	window.scrollTo(0, 0);
	setTimeout(function() {  // need to wait for body update
		if(document.body.classList.contains("presentation")) {
			document.getElementsByClassName("changeslide next")[0].click();
		}
	}, 10);
}
window.addEventListener('keyup', function(e) {
	if (e.keyCode === 13 && e.altKey) {  // toggle presentation with alt + enter
		document.presentAndReset();
	}
});
</script>"""

# ╔═╡ ffa59d87-7b68-4192-a52f-6582e67f1cbd
md"""
## Periodic Functions
A **periodic** function is a function whose values repeat at regular intervals.

Below we have a periodic function called a traingle wave.
"""

# ╔═╡ a2a5e259-785a-4907-9eeb-40c3e1f4332c
md"""
The **period** (``T``) of a periodic function is how far you have to go in the domain before the function repeats.

What is the period of this function?

Display intervals: $(@bind show_triangle_period CheckBox())
"""

# ╔═╡ 16e020f3-aa07-40d9-9f8f-e461ef7b903a
let
	f(x) = mod(x, 4) < 2 ? mod(x, 4) : 2 - mod(x, 4)
	p = plot(legend=false, framestyle = :origin, xticks=-10:10, yticks=-1:1)
	plot!(-10:10, f, lw=3)
	show_triangle_period && vline!(-8:4:8, lw=2, color=4, style=:dash)
	p
end

# ╔═╡ 46ec1e5a-9d63-4f99-b35c-ac69520e7565
md"""
## Sine
Recall that ``\sin \theta`` is the **``y``-coordinate** of the point on the unit circle that intersects the ray at angle ``\theta`` from the positive ``x``-axis.

``θ:\quad`` $(θ_sin_slider = @bind θ_sin Slider(-4π:π/12:4π, default=0.0))
"""

# ╔═╡ a87effdc-0282-4a92-82b4-ae35e496e81f
md"""
Now let's plot these points. The horizontal axis is ``θ``, and the vertical axis is ``\sin θ``.

Show positive: $(@bind show_sin_positive CheckBox()) ``\quad``
Show negative: $(@bind show_sin_negative CheckBox()) ``\quad``
Show curve: $(@bind show_sin_curve CheckBox()) ``\quad``
"""

# ╔═╡ 31caf44b-cd8d-4cef-bbb3-6dd6eedf0a76
md"""
Lastly, let's look at the two plots together.

``θ:\quad`` $(θ_sin_slider)
"""

# ╔═╡ 9004bad6-b416-483a-9852-1d6ad19b2a48
md"""
## Sinusoids
We call this periodic wave shape a "sinusoid" or "sine wave."

What is the period (``T``) of this sinusoid?

Display intervals: $(@bind show_sin_period CheckBox())
"""

# ╔═╡ ad9ab2dc-9de7-4695-b6c3-29cbabc1dd8c
md"""
We also care about the **maximum** and **minimum** value of the sine wave. The **midline** is the average between the two.

What are the maximum, minimum, and midline of this sinusoid?

The **amplitude** (``A``) of the wave is the difference between the maximum and the midline (or eqivalently between the midline and the minimum).

What is the amplitude (``A``) of this sinusoid?
"""

# ╔═╡ 99384a42-6902-481c-980e-3cc469df17c2
md"""
## Cosine

Recall that ``\cos \theta`` is the **``x``-coordinate** of the point on the unit circle that intersects the ray at angle ``\theta`` from the positive ``x``-axis.

``θ:\quad`` $(θ_cos_slider = @bind θ_cos Slider(-4π:π/12:4π, default=0.0))
"""

# ╔═╡ 8d289999-bbca-4db7-9730-e62cd2822747
md"""
Now let's plot these points. The horizontal axis is ``θ``, and the vertical axis is ``\cos θ``.

Show positive: $(@bind show_cos_positive CheckBox()) ``\quad``
Show negative: $(@bind show_cos_negative CheckBox()) ``\quad``
Show curve: $(@bind show_cos_curve CheckBox()) ``\quad``
"""

# ╔═╡ 657496b6-cf0f-4f2b-a7ae-9ec89f0800e2
md"""
Lastly, let's look at the two plots together.

``θ:\quad`` $(θ_cos_slider)
"""

# ╔═╡ 7f34b696-8844-40e5-8cf0-14ceb0f56868
md"""
What are the period, maximum, minimum, midline, and amplitude of this sinusoid?
"""

# ╔═╡ f8ccdf01-abc9-4fd9-95c1-e5c77e3527ef
md"""
## Putting it Together: Sinusoids from Circles
Let's look at all three plots together. Once again, sine is in blue and cosine is in orange.

``θ:\quad`` $(@bind θ₁ Slider(-2π:π/12:2π, default=0.0))
"""

# ╔═╡ 8b95ef50-fbac-4653-8819-757fdf77a4dd
md"""
When identifying the function for a basic sinusoid, use the following steps:

1. Identify whether the sinusoid is sine or cosine (check behavior at ``0``).
2. Identify whether the sinusoid is vertically flipped (check behavior at ``0``).

If the sinusoid is vertically flipped, the sign will be ``-`` otherwise it will be ``+``.

The functional form is ``\boxed{\pm \sin \theta}`` or ``\boxed{\pm \cos \theta}``.
"""

# ╔═╡ da783d24-3ae2-4618-8eac-af1b2a32f657
md"""
# Transforming Sinusoids

We have now seen that the graphs of ``\sin \theta`` and ``\cos \theta`` come from reading lengths as we vary ``\theta`` in the unit circle.

We will now apply the same process to other circles. This will give us new sinusoids that we can write down formulas for in terms ``\sin`` and ``\cos``.

We will first look at **Vertical Transformations** which scale or shift the *output* of the wave functions. We will then look at **Horizontal Transformations** which scale or shift the *input* of the wave functions which is ``\theta``. Keep in mind that *vertical* and *horizontal* refer to graphs of the waves, not the plane of the unit circle.
"""

# ╔═╡ 618edeb0-411a-4c4f-9ddb-2497b40241aa
md"""
## Vertical Scaling
First, let's remember what happens when we scale the unit circle.

For a circle centered at the origin with radius ``R``, the coordinates of the point on the circle along the terminal ray an angle ``\theta`` from the positive ``x``-axis are ``(R\cos \theta, R\sin \theta)``.

``θ:\quad`` $(θ_t1_slider = @bind θ_t1 Slider(-4π:π/12:4π, default=0.0))

``R:\quad`` $(R_t1_slider = @bind R_t1 Slider(0.5:0.5:3.0, default=1.0, show_value=true))
"""

# ╔═╡ eaa13afa-3efd-42dd-9eb3-a41569e063dc
md"""
Now let's put the circle back in the context of the corresponding waves.

This scaling of the radius by ``R`` also scales all of the coordinates on the circle by ``R``. Since the values of the wave functions are just the ``x`` and ``y`` coordinates of the points on the circle, the values at every point on the waves are multiplied by ``R``.

``θ:\quad`` $(θ_t1_slider)

``R:\quad`` $(R_t1_slider)
"""

# ╔═╡ de7960c4-9177-4ded-b0bf-6140c10e69f0
md"""
The waves ``R \sin \theta`` and ``R \cos \theta`` have a maximum value of ``R`` and a midline of ``0``, so they both have amplitude ``R``. Thus, scaling the circle affects the **amplitude** of its coresponding waves.
"""

# ╔═╡ 53bb3aa6-a858-4040-86c3-c94d8bb6848b
md"""
### Vertical Scaling in a Table
Let's look at the transformation ``A \sin(\theta)`` in tabular form.

``A:\quad`` $(@bind A_t1 Slider(-3.0:0.5:3.0, default=1.0, show_value=true))

"critical angles" only: $(@bind critical_only_t1 CheckBox(default=true)) ``\quad``
show curve: $(@bind show_curve_t1 CheckBox(default=true)) ``\quad``
"""

# ╔═╡ e1a9cf02-5f46-4ea8-bbbe-b8f1b9224be1
md"""
### Identifying Vertical Scaling
When identifying the function for a vertically scaled sinusoid, use the following steps:

1. Identify whether the sinusoid is sine or cosine (check behavior at ``0``).
2. Identify whether the sinusoid is vertically flipped (check behavior at ``0``).
3. Find the maximum and minimum value of the sinusoid.
4. Calculate ``A = \frac{max\ -\ min}{2}``.

The functional form is ``\boxed{\pm A \sin\left(\theta\right)}`` or ``\boxed{\pm A \cos\left(\theta\right)}``.
"""

# ╔═╡ f14d6ab2-1e06-4e72-86c1-6defaedd58c3
md"""
## Vertical Shifting

What happens if we move the center of the unit circle around? Let's call the center of the circle ``(x₀, y₀)``. Then the coordinates of the point on the shifted unit circle along the terminal ray an angle ``\theta`` from the positive ``x``-axis are ``(\cos(\theta) + x₀, \sin(\theta) + y₀)``.

``θ:\quad`` $(θ_t2_slider = @bind θ_t2 Slider(-4π:π/12:4π, default=0.0))

``c_x:\quad`` $(x₀_t2_slider = @bind x₀_t2 Slider(-2:1:2, default=0, show_value=true))

``c_y:\quad`` $(y₀_t2_slider = @bind y₀_t2 Slider(-2:1:2, default=0, show_value=true))
"""

# ╔═╡ 7086d5eb-6f81-4bfc-8ba0-1ea83268059f
md"""
Now let's put the circle back in the context of the corresponding waves.

This shifting of the center to ``(x₀, y₀)`` increases all of the ``x``-coordinates on the circle by ``x₀`` and increases all of the ``y``-coordinates on the circle by ``y₀``. Since the values of the wave functions are just the ``x`` and ``y`` coordinates of the points on the circle, the values at every point on the waves are shifted up or down accordingly.

``θ:\quad`` $(θ_t2_slider)

``x₀:\quad`` $(x₀_t2_slider)

``y₀:\quad`` $(y₀_t2_slider)
"""

# ╔═╡ 81d21cce-1374-4d64-9230-8216ff71ee38
md"""
The wave ``\sin(\theta) + c_y`` has a maximum value of ``c_y + 1`` and a minimum value of ``c_y - 1``, so it has a midline of ``c_y``. Likewise, ``\cos(\theta) + c_x`` has a midline of ``c_x``. Thus, shifting the circle affects the **midline** of its coresponding waves.
"""

# ╔═╡ af6ca434-aabe-4c95-9a4f-9155c861f2e2
md"""
### Vertical Shifting in a Table
Let's look at the transformation ``\sin(\theta) + k`` in tabular form.

``k:\quad`` $(@bind k_t2 Slider(-2.0:0.5:2.0, default=0, show_value=true))

"critical angles" only: $(@bind critical_only_t2 CheckBox(default=true)) ``\quad``
show curve: $(@bind show_curve_t2 CheckBox(default=true)) ``\quad``
"""

# ╔═╡ eb96720e-1a36-4295-a68f-e087c4d8a59b
md"""
### Identifying Vertical Shifting
When identifying the function for a vertically shifted sinusoid, use the following steps:

1. Identify whether the sinusoid is sine or cosine (check behavior at ``0``).
2. Identify whether the sinusoid is vertically flipped (check behavior at ``0``).
3. Find the maximum and minimum value of the sinusoid.
4. Calculate ``k = \frac{max\ +\ min}{2}``.

The functional form is ``\boxed{\pm \sin\left(\theta\right) + k}`` or ``\boxed{\pm \cos\left(\theta\right) + k}``.
"""

# ╔═╡ 3690445c-4878-4f9c-949b-222c2e31176e
md"""
## Putting it Together: Vertical Transformations

If we combine changes in the **center** and **radius** of the circle, we see combined changes in the **midline** and **amplitude** of the waves.

``θ:\quad`` $(@bind θ_t3 Slider(-4π:π/12:4π, default=0.0))

``x₀:\quad`` $(@bind x₀_t3 Slider(-2:1:2, default=0, show_value=true))

``y₀:\quad`` $(@bind y₀_t3 Slider(-2:1:2, default=0, show_value=true))

``R:\quad`` $(@bind R_t3 Slider(0.5:0.25:2.0, default=1.0, show_value=true))
"""

# ╔═╡ 827b1c6b-e992-4135-a491-cabf39ac906c
md"""
### Combined Vertical Transformations in a Table
Let's look at the transformation ``A \sin(\theta) + k`` in tabular form.

``A:\quad`` $(@bind A_t3 Slider(-2.0:0.5:2.0, default=1.0, show_value=true))

``k:\quad`` $(@bind k_t3 Slider(-2.0:0.5:2.0, default=0.0, show_value=true))

"critical angles" only: $(@bind critical_only_t3 CheckBox(default=true)) ``\quad``
show curve: $(@bind show_curve_t3 CheckBox(default=true)) ``\quad``
"""

# ╔═╡ 1bfcc315-531b-482d-b712-14589d2489f7
md"""
### Identifying Vertical Transformations
When identifying the function for a vertically transformed sinusoid, use the following steps:

1. Identify whether the sinusoid is sine or cosine (check behavior at ``0``).
2. Identify whether the sinusoid is vertically flipped (check behavior at ``0``).
3. Find the maximum and minimum value of the sinusoid.
4. Calculate ``A = \frac{max\ -\ min}{2}``.
5. Calculate ``k = \frac{max\ +\ min}{2}``.

The functional form is ``\boxed{\pm A \sin\left(\theta\right) + k}`` or ``\boxed{\pm A \cos\left(\theta\right) + k}``.
"""

# ╔═╡ 48e3d3c0-a6f1-48a3-9ca1-c239fa15fc62
md"""
## Horizontal Scaling
Horizontal scaling decouples the rate at which we move along the ``\theta``-axis in the wave space and the rate at which we rotate around the circle.

We will call the ratio between these two rates ``b``.

If ``b`` is large we will go around the circle faster, so the wave value will go up and down more quickly. Conversely, if ``b`` is small we will go around the circle more slowly, so the wave value will go up and down more slowly.

[Side note]: in physics this quantity is sometimes called the *angular frequency* of the wave and denoted with the Greek letter omega (``\omega``) but in this class we won't use that term to avoid confusion.

``θ:\quad`` $(@bind θ_t4 Slider(-4π:π/12:4π, default=0.0))

``b:\quad`` $(@bind b_t4 Slider(0.25:0.25:2.0, default=1.0, show_value=true))
"""

# ╔═╡ 7a03612e-4116-4063-ba89-3e73028b115f
md"""
### Horiztonal Scaling in a Table
Let's look at the transformation ``\sin(b * \theta)`` in tabular form.

``b:\quad`` $(@bind b2_t4 Slider(0.5:0.5:4.0, default=1.0, show_value=true))

"critical angles" only: $(@bind critical_only_t4 CheckBox(default=true)) ``\quad``
show curve: $(@bind show_curve_t4 CheckBox(default=true)) ``\quad``
show period: $(@bind show_period_t4 CheckBox(default=true)) ``\quad``
"""

# ╔═╡ c2d7a315-56c8-4e14-9a16-219d7669e3cb
md"""
Looking at this graph, we can see that the first period is completed when ``b\theta = 2\pi``. At this point, ``\theta = T``, so rearranging we have that the **period** ``\boxed{T = \frac{2\pi}{b}}``.

Another quantity that we sometimes use when talking about waves (especially electromagnetic waves) is the **frequency** which is represented by ``f``. This is simply defined as the inverse of the period. In other words ``\boxed{ f = \frac{1}{T} = \frac{b}{2\pi}}``.
"""

# ╔═╡ b7b3afbb-5aeb-4f24-9beb-7f69a0c6629b
md"""
### Identifying Horizontal Scaling
When identifying the function for a horizontally scaled sinusoid, use the following steps:

1. Identify whether the sinusoid is sine or cosine (check behavior at ``0``).
2. Identify whether the sinusoid is vertically flipped (check behavior at ``0``).
3. Identify the period ``T``.

The functional form is ``\boxed{\pm \sin\left(\frac{2\pi}{T}\theta\right)}`` or ``\boxed{\pm \cos\left(\frac{2\pi}{T}\theta\right)}``.
"""

# ╔═╡ 21c01e95-814a-4760-bc27-b31f45eb72b2
md"""
## Horizontal Shifting
The final type of transformation is a shift along the ``\theta``-axis. This corresponds to changing the starting point of our angle measurements in the circle.

We call the shift in the wave space ``h``.

[Side note]: the shift in the starting point of the circle is called a *phase shift* and is often denoted with the Greek letter phi (``\phi``). Specifically with our sign and naming conventions, ``\phi = bh`` and it represents a change in the negative (clockwise) direction.

``θ:\quad`` $(@bind θ_t5 Slider(-4π:π/12:4π, default=0.0))

``h:\quad`` $(@bind h_t5 Slider(-2π:π/12:2π, default=0.0))
"""

# ╔═╡ ea4c2b2f-1419-4334-a545-f16dd6dd3e76
md"""
### Horiztonal Scaling in a Table
Let's look at the transformations ``\sin(\theta - h)`` and ``\cos(\theta - h)`` in tabular form.

``h:\quad`` $(@bind h2_t5 Slider(-2π:π/12:2π, default=0.0))

"critical angles" only: $(@bind critical_only_t5 CheckBox(default=true)) ``\quad``
show curve: $(@bind show_curve_t5 CheckBox(default=true)) ``\quad``
show shift: $(@bind show_shift_t5 CheckBox(default=true)) ``\quad``
"""

# ╔═╡ 49c21509-8821-4299-a725-814e54d0954d
md"""
**Observations**

1. For ``\sin`` the shift line occurs at an upward-sloping midline point.
2. For ``\cos`` the shift line occurs at a maximum point.
3. ``\sin\left(\theta + \frac{\pi}{2}\right) = \cos\left(\theta\right)``.
4. ``\cos\left(\theta - \frac{\pi}{2}\right) = \sin\left(\theta\right)``.
5. ``\sin\left(\theta - \pi\right) = -\sin\left(\theta\right)``.
6. ``\cos\left(\theta - \pi\right) = -\cos\left(\theta\right)``.
5. ``\sin\left(\theta - 2\pi k\right) = \sin\left(\theta\right)`` for all integers ``k``.
6. ``\cos\left(\theta - 2\pi k\right) = \cos\left(\theta\right)`` for all integers ``k``.

Points 1-2 help us identify values for ``h`` when looking at a graph.

Points 3-4 are interesting identities that we will explore later in the course.

Points 5-8 imply that there are many possible functions in this form that have the same graph.
"""

# ╔═╡ 6a786e0f-6ab6-4c72-aa3d-cb0eff518d6d
md"""
### Identifying Horizontal Shifting
When identifying the function for a horizontally shifted sinusoid, use the following steps:

1. Choose whether you are going to use ``\sin`` or ``\cos``.
2. If using ``\sin`` find the ``\theta``-coordinate, ``h``, of an upward-sloping midline point.
3. If using ``\cos`` find the ``\theta``-coordinate, ``h``, of a maximum point.

The functional form is ``\boxed{\sin\left(\theta - h\right)}`` or ``\boxed{\cos\left(\theta - h\right)}``.
"""

# ╔═╡ dd21e219-6c97-4f15-8fe7-803184aa6d6f
md"""
## Putting it Together: All Transformations
Finally, let's look at all four transformations together.

``θ:\quad`` $(@bind θ_t6 Slider(-4π:π/12:4π, default=0.0))

``x₀:\quad`` $(@bind x₀_t6 Slider(-2:1:2, default=0, show_value=true))

``y₀:\quad`` $(@bind y₀_t6 Slider(-2:1:2, default=0, show_value=true))

``R:\quad`` $(@bind R_t6 Slider(0.5:0.25:2.0, default=1.0, show_value=true))

``b:\quad`` $(@bind b_t6 Slider(0.25:0.25:2.0, default=1.0, show_value=true))

``h:\quad`` $(@bind h_t6 Slider(-2π:π/12:2π, default=0.0))
"""

# ╔═╡ b264e6e2-1ed9-4a01-8ca9-f0825de0482c
md"""
### Combined Transformation in a Table
Let's look at the transformation ``A\sin(b(\theta - h)) + k`` in tabular form.

``A:\quad`` $(@bind A_t6 Slider(-3:1:3, default=1, show_value=true))

``k:\quad`` $(@bind k_t6 Slider(-2:1:2, default=0, show_value=true))

``b:\quad`` $(@bind b2_t6 Slider(0.5:0.5:5, default=1.0, show_value=true))

``h:\quad`` $(@bind h2_t6 Slider(-2π:π/12:2π, default=0.0))

"critical angles" only: $(@bind critical_only_t6 CheckBox(default=true)) ``\quad``
show curve: $(@bind show_curve_t6 CheckBox(default=true)) ``\quad``
show period: $(@bind show_period_t6 CheckBox(default=true)) ``\quad``
show shift: $(@bind show_shift_t6 CheckBox(default=true)) ``\quad``
"""

# ╔═╡ bb83958a-3700-4246-8b37-c94642a88c31
md"""
### Identifying Combined Transformations
When identifying the function for an arbitrarily transformed sinusoid, use the following steps:

1. Choose whether you are going to use ``\sin`` or ``\cos``.
2. If using ``\sin`` find the ``\theta``-coordinate, ``h``, of an upward-sloping midline point.
3. If using ``\cos`` find the ``\theta``-coordinate, ``h``, of a maximum point.
4. Identify the period ``T``.
5. Find the maximum and minimum value of the sinusoid.
6. Calculate ``A = \frac{max\ -\ min}{2}``.
7. Calculate ``k = \frac{max\ +\ min}{2}``.

The functional form is ``\boxed{A\sin\left(\frac{2\pi}{T}(\theta - h)\right) + k}`` or ``\boxed{A\cos\left(\frac{2\pi}{T}(\theta - h)\right) + k}``.
"""

# ╔═╡ 1a408b82-fe7e-4930-94d2-cfa89c7340b8
# Empty header cell to be a blank end-of-presentation screen.
md"""
##
"""

# ╔═╡ 3bb2ca7f-c283-4574-a45a-bebf068dfe71
md"""
## Appendix: Elements
"""

# ╔═╡ 289f7931-8511-4650-960e-54a20a180320
presentation_mode_button = html"""
<div style="display: flex; flex-align: center; flex-direction: column;">
	<button onclick=document.presentAndReset()>
		Toggle Presentation Mode 
	</button>
</div>
""";

# ╔═╡ 178903b9-1112-4f42-8995-dab542e293fe
presentation_mode_button

# ╔═╡ 8fd2edc7-5063-4033-a9cb-5e7623467fb5
logo = Resource("https://raw.githubusercontent.com/jrdegreeff/trig-visualization/main/MX_Shield_Red.png", :height => 28);

# ╔═╡ 9a65324e-594f-11ee-3a9b-dff0ec87117f
md"""
# ``\quad`` $(logo) ``\quad`` Graphing Trig Functions``\quad`` $(logo) ``\quad``
This notebook was designed to complement Middlesex School's *Math 32 -- Pre-calculus: Trigonometry* class. Specifically, it is an interactive visual aide for PART II: Graphing Period Functions.
"""

# ╔═╡ 7e6d7f4f-e68c-41ff-8dcc-14cf326279da
md"""
## Appendix: Number Formatting
"""

# ╔═╡ 10737f1b-f132-468f-95f2-089705bd7488
begin
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
end;

# ╔═╡ 3e4e081f-d8ab-4b82-85ed-aaecc192a46b
md"""
## Appendix: Sinusoid Manipulation
"""

# ╔═╡ 1577dff0-f4b6-4c39-8d2a-f7ff6fe5b044
md"""
## Appendix: Tables
"""

# ╔═╡ 26e8e204-a74e-4bc8-8bc0-28ba4eb26620
md"""
## Appendix: Plotting
"""

# ╔═╡ 30e87a64-2d1a-4198-8039-8bb0be7632f3
begin
	sin_color = 1
	cos_color = 2
	hyp_color = 3
end;

# ╔═╡ 66af7c57-3063-448f-baef-2898cb262c22
begin
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
	period(w::Wave) = 2π / w.b
	freqeuncy(w::Wave) = w.b / (2π)
	phase_shift(w::Wave) = -w.b * w.h

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
end;

# ╔═╡ 64840f00-2529-4ad9-bf9e-33610dc4cfcc
begin
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
end;

# ╔═╡ 12e416c5-6f4e-4c84-ab04-20ba300adfc3
md"""
Let's write down the sine values for the special angles, and round to 2 decimal places.

$(@bind sin_slider Slider(0:n_special_angles))
"""

# ╔═╡ ebdbcb08-bdfa-46e4-9d20-898b25d77d15
format_special_angles_table(Wave(sin), n_angles=sin_slider)

# ╔═╡ 1159e991-073f-4e4d-88f8-c8cd0104a6e2
md"""
Let's write down the cosine values for the special angles, and round to 2 decimal places.

$(@bind cos_slider Slider(0:n_special_angles))
"""

# ╔═╡ c3550f70-8b7b-432e-aa5e-7ab5084cf69f
format_special_angles_table(Wave(cos), n_angles=cos_slider)

# ╔═╡ 8aee1e87-7b32-4f71-9685-12e15ba9b246
format_special_angles_table([Wave(sin), Wave(sin, A=A_t1)], critical_only=critical_only_t1, column_width=11)

# ╔═╡ 32e5c347-5dd3-41ab-9382-deaff3089657
format_special_angles_table([Wave(sin), Wave(sin, k=k_t2)], critical_only=critical_only_t2, column_width=12)

# ╔═╡ 9ffa7538-c969-4e7a-8bd6-6b568d7e1a03
format_special_angles_table([Wave(sin), Wave(sin, A=A_t3, k=k_t3)], critical_only=critical_only_t3, column_width=16)

# ╔═╡ 25a533c4-61dc-4ba0-8ab2-eba55f69b21f
format_special_angles_table([Wave(b=b2_t4), Wave(sin, b=b2_t4)], critical_only=critical_only_t4, column_width=11)

# ╔═╡ 050c6975-e92b-48b1-a0d5-b12f1005b611
format_special_angles_table([Wave(h=h2_t5), Wave(sin, h=h2_t5), Wave(cos, h=h2_t5)], critical_only=critical_only_t5, column_width=15)

# ╔═╡ bc101546-cb14-40e5-ba6a-1f3b084be914
format_special_angles_table([Wave(b=b2_t6, h=h2_t6), Wave(sin, A=A_t6, k=k_t6, b=b2_t6, h=h2_t6)], critical_only=critical_only_t6, column_width=26)

# ╔═╡ 279fa764-91aa-415d-86ed-47ed3ecfc720
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
end;

# ╔═╡ 7f924a27-3a75-47ba-a0e9-d5b841a49bb1
plot_trig_circle(θ_sin, max_x=1.5, max_y=1, R_tick=0.5, show_sin=true)

# ╔═╡ 0e2de8ba-3a25-4158-abc0-bed956dfe470
plot_trig_circle(θ_cos, max_x=1.5, max_y=1, R_tick=0.5, show_cos=true)

# ╔═╡ ebc4c86d-621b-4c0a-b7bd-e9ea8e87d36d
plot_trig_circle(θ_t1, R=R_t1, max_x=4, max_y=3, show_sin=true, show_cos=true)

# ╔═╡ e58f6c8b-ffcd-4f06-a1c3-6a02055ae428
plot_trig_circle(θ_t2, x₀=x₀_t2, y₀=y₀_t2, max_x=4, max_y=3, show_sin=true, show_cos=true)

# ╔═╡ 54eb2768-7b9e-442e-8818-b373f8b6d49e
begin
	function plot_trig_function(wave::Wave; kwargs...)
		plot_trig_function([wave]; kwargs...)
	end
	function plot_trig_function(
		waves::Vector{<:Wave};
		max_θ=maximum(period.(waves)), circle_resolution=0.01π,
		tick_θ=max_θ/4, tickstyle=:decimal,
		max_A=maximum(amplitude.(waves)), max_y=nothing,
		min_k=minimum(midline.(waves)), max_k=maximum(midline.(waves)),
		tick_y=isnothing(max_y) ? max_A/2 : max_y/2,
		show_curve=true, show_label=true,
		show_positive=false, show_negative=false,
		n_angles=n_special_angles, critical_only=false,
		θ=nothing, show_period=false, show_shift=false
	)
		p = plot(framestyle=:origin, minorgrid=true, legend=show_label)
	
		@assert isinteger(max_θ / tick_θ)
		θ_ticks = -max_θ:tick_θ:max_θ
		if tickstyle == :decimal
			θ_labels = round_label.(θ_ticks)
		elseif tickstyle == :πmultiple
			@assert isinteger(tick_θ / π)
			θ_labels = π_label.(θ_ticks ./ π)
		else tickstyle == :πfraction
			@assert isinteger(π / tick_θ)
			θ_labels = π_label.(Int.(θ_ticks ./ tick_θ) .// Int(π / tick_θ))
		end
		plot!(xlim=(-1.1max_θ, 1.1max_θ), xticks=(collect(θ_ticks), θ_labels), xminorticks=6)
	
		if isnothing(max_y)
			y_lim = (min_k - 1.1max_A, max_k + 1.1max_A)
			y_ticks = (min_k - max_A):tick_y:(max_k + max_A)
		else
			y_lim = (-1.1max_y, 1.1max_y)
			y_ticks = -max_y:tick_y:max_y
		end
		plot!(ylim=y_lim, yticks=(collect(y_ticks), round_label.(y_ticks)), yminorticks=4)

		for wave in waves
			show_curve && plot!(  # the function itself
				-max_θ:circle_resolution:max_θ, wave, label=string(wave),
				lw=3, color=wave.color
			)
	
			angles = critical_only ? critical_angles : special_angles
			n_angles = min(n_angles, length(angles))
			displayed_angles = Fix1(invert_inner, wave).(angles[1:n_angles])
			filter!(a -> a ≤ max_θ, displayed_angles)
	
			show_positive && scatter!(  # positive special angles
				displayed_angles, wave, label=false,
				color=wave.color
			)
			show_negative && scatter!(  # negative special angles
				-displayed_angles, wave, label=false,
				color=wave.color
			)
	
			!isnothing(θ) && plot!(  # vertical line at indicated point
				[θ, θ], [0, wave(θ)], label=false,
				lw=3, color=wave.color
			)
			!isnothing(θ) && scatter!(  # indicated point
				[θ], [wave(θ)], label=round_label(wave(θ)),
				ms=6, msw=3, color=:white, msc=wave.color
			)
	
			show_period && vline!(  # period markers
				sort(vcat(0:-period(wave):-max_θ, 0:period(wave):max_θ)), 
				label=false, lw=2, color=4, style=:dash
			)
			show_shift && vline!(  # phase marker
				[wave.h], label=false,
				lw=2, color=5, style=:dashdot
			)
		end
		p
	end
end;

# ╔═╡ f87b8e3f-4943-47e6-9317-6516a8c8a31a
plot_trig_function(Wave(sin), tickstyle=:πfraction, show_curve=show_sin_curve, show_positive=show_sin_positive, show_negative=show_sin_negative, n_angles=sin_slider)

# ╔═╡ ce0ca1d7-8ebf-4761-89e3-b53fc46216e0
let
	sin_circle_plot = plot_trig_circle(θ_sin, max_x=3, max_y=1, show_sin=true)
	sin_curve_plot = plot_trig_function(Wave(sin), max_θ=4π, θ=θ_sin,  tickstyle=:πmultiple)
	plot(sin_circle_plot, sin_curve_plot, layout=(2, 1))
end

# ╔═╡ e520ba54-bef4-44b9-a09c-feeb6519292e
plot_trig_function(Wave(sin), max_θ=4π, tickstyle=:πmultiple, show_period=show_sin_period)

# ╔═╡ 882dcccd-3c97-4bc3-9e95-014f90d7a795
plot_trig_function(Wave(cos), tickstyle=:πfraction, show_curve=show_cos_curve, show_positive=show_cos_positive, show_negative=show_cos_negative, n_angles=cos_slider)

# ╔═╡ 25408447-3e76-4bfc-94c9-4bede0a44351
let
	cos_circle_plot = plot_trig_circle(θ_cos, max_x=3, max_y=1, show_cos=true)
	cos_curve_plot = plot_trig_function(Wave(cos), max_θ=4π, θ=θ_cos, tickstyle=:πmultiple)
	plot(cos_circle_plot, cos_curve_plot, layout=(2, 1))
end

# ╔═╡ 6a031d8c-ff65-4a6b-b8b6-76203dc56f2a
let
	circle_plot = plot_trig_circle(θ₁, max_x=1, max_y=1.5, R_tick=0.5, show_sin=true, show_cos=true)
	sin_curve_plot = plot_trig_function(Wave(sin), max_θ=2π, tick_θ=π, tickstyle=:πmultiple, θ=θ₁)
	cos_curve_plot = plot_trig_function(Wave(cos), max_θ=2π, tick_θ=π, tickstyle=:πmultiple, θ=θ₁)
	plot(circle_plot, plot(sin_curve_plot, cos_curve_plot, layout=(2, 1)))
end

# ╔═╡ 8927df0f-b092-4933-b7c2-d712a1d2e8b2
let
	circle_plot = plot_trig_circle(θ_t1, R=R_t1, max_x=4, max_y=5, R_tick=2, show_sin=true, show_cos=true)
	sin_curve_plot = plot_trig_function(Wave(sin, A=R_t1), max_θ=4π, tick_θ=2π, tickstyle=:πmultiple, max_A=3, tick_y=1, θ=θ_t1)
	cos_curve_plot = plot_trig_function(Wave(cos, A=R_t1), max_θ=4π, tick_θ=2π, tickstyle=:πmultiple, max_A=3, tick_y=1, θ=θ_t1)
	plot(circle_plot, plot(sin_curve_plot, cos_curve_plot, layout=(2, 1)))
end

# ╔═╡ e29c8789-202f-4d93-ae34-7642b0b80d74
plot_trig_function(Wave(sin, A=A_t1), max_θ=2π, tickstyle=:πfraction, max_A=3, tick_y=1, show_curve=show_curve_t1, show_positive=true, critical_only=critical_only_t1)

# ╔═╡ 962cb2da-7f45-40aa-a081-468841dfa617
let
	circle_plot = plot_trig_circle(θ_t2, x₀=x₀_t2, y₀=y₀_t2, max_x=3, max_y=4, show_sin=true, show_cos=true)
	sin_curve_plot = plot_trig_function(Wave(sin, k=y₀_t2), max_θ=4π, tick_θ=2π, tickstyle=:πmultiple, max_y=3, tick_y=1, θ=θ_t2)
	cos_curve_plot = plot_trig_function(Wave(cos, k=x₀_t2), max_θ=4π, tick_θ=2π, tickstyle=:πmultiple, max_y=3, tick_y=1, θ=θ_t2)
	plot(circle_plot, plot(sin_curve_plot, cos_curve_plot, layout=(2, 1)))
end

# ╔═╡ 055c68c2-4fca-4a3e-ab26-28cf6c0cdef8
plot_trig_function(Wave(sin, k=k_t2), max_θ=2π, tickstyle=:πfraction, max_y=3, tick_y=1, show_curve=show_curve_t2, show_positive=true, critical_only=critical_only_t2)

# ╔═╡ 1c959bee-c340-41cf-a142-2d6cd3839684
let
	circle_plot = plot_trig_circle(θ_t3, R=R_t3, x₀=x₀_t3, y₀=y₀_t3, max_x=4, max_y=5, R_tick=2, show_sin=true, show_cos=true)
	sin_curve_plot = plot_trig_function(Wave(sin, A=R_t3, k=y₀_t3), max_θ=4π, tick_θ=2π, tickstyle=:πmultiple, max_y=4, θ=θ_t3)
	cos_curve_plot = plot_trig_function(Wave(cos, A=R_t3, k=x₀_t3), max_θ=4π, tick_θ=2π, tickstyle=:πmultiple, max_y=4, θ=θ_t3)
	plot(circle_plot, plot(sin_curve_plot, cos_curve_plot, layout=(2, 1)))
end

# ╔═╡ d26018da-e17d-430d-baf9-84265352cd8c
plot_trig_function(Wave(sin, A=A_t3, k=k_t3), max_θ=2π, tickstyle=:πfraction, max_y=4, tick_y=1, show_curve=show_curve_t3, show_positive=true, critical_only=critical_only_t3)

# ╔═╡ 9a34a196-0a73-4aee-a097-ad4d5b193a42
let
	circle_plot = plot_trig_circle(θ_t4, b=b_t4, max_x=1, max_y=1.5, R_tick=0.5, show_sin=true, show_cos=true)
	sin_curve_plot = plot_trig_function(Wave(sin, b=b_t4), max_θ=4π, tick_θ=2π, tickstyle=:πmultiple, θ=θ_t4)
	cos_curve_plot = plot_trig_function(Wave(cos, b=b_t4), max_θ=4π, tick_θ=2π, tickstyle=:πmultiple, θ=θ_t4)
	plot(circle_plot, plot(sin_curve_plot, cos_curve_plot, layout=(2, 1)))
end

# ╔═╡ 0112eae5-6f4c-400f-b636-9fd4e3786153
plot_trig_function(Wave(sin, b=b2_t4), max_θ=2π, tickstyle=:πfraction, tick_y=1, show_curve=show_curve_t4, show_positive=true, critical_only=critical_only_t4, show_period=show_period_t4)

# ╔═╡ 7c6ba1e8-9e6c-4fbb-aea2-493bb3b7fcd9
let
	circle_plot = plot_trig_circle(θ_t5, h=h_t5, max_x=1, max_y=1.5, R_tick=0.5, show_sin=true, show_cos=true)
	sin_curve_plot = plot_trig_function(Wave(sin, h=h_t5), max_θ=4π, tick_θ=2π, tickstyle=:πmultiple, θ=θ_t5)
	cos_curve_plot = plot_trig_function(Wave(cos, h=h_t5), max_θ=4π, tick_θ=2π, tickstyle=:πmultiple, θ=θ_t5)
	plot(circle_plot, plot(sin_curve_plot, cos_curve_plot, layout=(2, 1)))
end

# ╔═╡ c675e5ee-185e-41d1-b879-939357ffb5c7
let
	sin_plot = plot_trig_function(Wave(sin, h=h2_t5), max_θ=2π, tickstyle=:πfraction, tick_y=1, show_curve=show_curve_t5, show_positive=true, critical_only=critical_only_t5, show_shift=show_shift_t5)
	cos_plot = plot_trig_function(Wave(cos, h=h2_t5), max_θ=2π, tickstyle=:πfraction, tick_y=1, show_curve=show_curve_t5, show_positive=true, critical_only=critical_only_t5, show_shift=show_shift_t5)
	plot(sin_plot, cos_plot, layout=(2,1))
end

# ╔═╡ dc1e4c73-f7e1-4f7f-b139-0b82797da6c6
let
	circle_plot = plot_trig_circle(θ_t6, R=R_t6, x₀=x₀_t6, y₀=y₀_t6, b=b_t6, h=h_t6, max_x=4, max_y=5, R_tick=2, show_sin=true, show_cos=true)
	sin_curve_plot = plot_trig_function(Wave(sin, A=R_t6, k=y₀_t6, b=b_t6, h=h_t6), max_θ=4π, tick_θ=2π, tickstyle=:πmultiple, max_y=4, θ=θ_t6)
	cos_curve_plot = plot_trig_function(Wave(cos, A=R_t6, k=x₀_t6, b=b_t6, h=h_t6), max_θ=4π, tick_θ=2π, tickstyle=:πmultiple, max_y=4, θ=θ_t6)
	plot(circle_plot, plot(sin_curve_plot, cos_curve_plot, layout=(2, 1)))
end

# ╔═╡ f530f155-fd4e-4dae-ab85-994ea0ebe8b2
plot_trig_function(Wave(sin, A=A_t6, k=k_t6, b=b2_t6, h=h2_t6), max_θ=2π, tickstyle=:πfraction, max_y=5, tick_y=1, show_curve=show_curve_t6, show_positive=true, critical_only=critical_only_t6, show_period=show_period_t6, show_shift=show_shift_t6)

# ╔═╡ 819075e8-0058-4606-9a29-93fe169263be
md"""
## Appendix: Figures for Assessments
"""

# ╔═╡ db66a1ef-6f40-447e-8e09-1b612bd98d3b
begin
	plot_trig_function(Wave(sin, color=3, A=2, T=2), show_label=false)
	png("exports/MQ 6 - Sine Graph.png")

	plot_trig_function(Wave(A=1.5), tick_y=0.5, tickstyle=:πfraction, show_curve=false, show_label=false)
	png("exports/MQ 7 - Empty Plot.png")

	plot_trig_function(Wave(cos, color=3, A=2, k=2, T=π), tickstyle=:πfraction, show_label=false)
	png("exports/MQ 8 - Graph 1.png")

	plot_trig_function(Wave(sin, color=3, A=-3, k=-1, T=2), show_label=false)
	png("exports/MQ 8 - Graph 2.png")

	plot_trig_function(Wave(A=4), tickstyle=:πfraction, show_curve=false, show_label=false)
	png("exports/MQ 9 - Empty Plot Scaled 1.png")

	plot_trig_function(Wave(T=1), max_A=1.5, tick_y=0.5, show_curve=false, show_label=false)
	png("exports/MQ 9 - Empty Plot Scaled 2.png")
end;

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DataStructures = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[compat]
DataStructures = "~0.18.15"
Plots = "~1.39.0"
PlutoUI = "~0.7.52"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.3"
manifest_format = "2.0"
project_hash = "09deb9ef67d44b6c98d4306f01026619d7120bc6"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "91bd53c39b9cbfb5ef4b015e8b582d344532bd0a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.2.0"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BitFlags]]
git-tree-sha1 = "43b1a4a8f797c1cddadf60499a8a077d4af2cd2d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.7"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "02aa26a4cf76381be7f66e020a3eddeb27b0a092"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.2"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "67c1f244b991cad9b0aa4b7540fb758c2488b129"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.24.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "a1f44953f2382ebb937d60dafbe2deea4bd23249"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.10.0"

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.ColorVectorSpace.weakdeps]
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "fc08e5930ee9a4e03f84bfb5211cb54e7769758a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.10"

[[deps.Compat]]
deps = ["UUIDs"]
git-tree-sha1 = "e460f044ca8b99be31d35fe54fc33a5c33dd8ed7"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.9.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.5+0"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "5372dbbf8f0bdb8c700db5367132925c0771ef7e"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.2.1"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.DataAPI]]
git-tree-sha1 = "8da84edb865b0b5b0100c0666a9bc9a0b71c553c"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.15.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "3dbd312d370723b6bb43ba9d02fc36abade4518d"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.15"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8e9441ee83492030ace98f9789a654a6d0b1f643"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+0"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "e90caa41f5a86296e014e148ee061bd6c3edec96"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.9"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "4558ab818dcceaab612d1bb8c19cee87eda2b83c"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.5.0+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Pkg", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "74faea50c1d007c85837327f6775bea60b5492dd"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.2+2"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "d8db6a5a2fe1381c1ea4ef2cab7c69c2de7f9ea0"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.1+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "d972031d28c8c8d9d7b41a536ad7bb0c2579caca"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.8+0"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Preferences", "Printf", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "UUIDs", "p7zip_jll"]
git-tree-sha1 = "27442171f28c952804dede8ff72828a96f2bfc1f"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.72.10"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "025d171a2847f616becc0f84c8dc62fe18f0f6dd"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.72.10+0"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "e94c92c7bf4819685eb80186d51c43e71d4afa17"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.76.5+0"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "5eab648309e2e060198b45820af1a37182de3cce"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.0"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "d75853a0bdbfb1ac815478bacd89cd27b550ace6"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.3"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "f377670cda23b6b7c1c0b3893e37451c5c1a2185"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.5"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "7e5d6779a1e09a36db2a7b6cff50942a0a7d0fca"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.5.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6f2675ef130a300a112286de91973805fcc5ffbc"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.91+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f689897ccbe049adb19a065c495e75f372ecd42b"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "15.0.4+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Printf", "Requires"]
git-tree-sha1 = "f428ae552340899a935973270b8d98e5a31c49fe"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.1"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "f9557a255370125b405568f9767d6d195822a175"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.17.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "2da088d113af58221c52828a80378e16be7d037a"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.5.1+1"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "7d6dd4e9212aebaeed356de34ccf262a3cd415aa"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.26"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "0d097476b6c381ab7906460ef1ef1638fbce1d91"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.2"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "9ee1618cbf5240e6d4e0371d6f24065083f60c48"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.11"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "Random", "Sockets"]
git-tree-sha1 = "03a9b9718f5682ecb107ac9f7308991db4ce395b"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.7"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+0"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "f66bdc5de519e8f8ae43bdc598782d35a25b1272"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.1.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.10.11"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.21+4"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+0"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "51901a49222b09e3743c65b8847687ae5fc78eb2"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.1"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a12e56c72edee3ce6b96667745e6cbbe5498f200"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.23+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "2e73fe17cac3c62ad1aebe70d44c963c3cfdc3e3"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.2"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "716e24b21538abc91f6205fd1d8363f39b442851"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.7.2"

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "64779bc4c9784fee475689a1752ef4d5747c5e87"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.42.2+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.9.2"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "1f03a2d339f42dca4a4da149c7e15e9b896ad899"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.1.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "f92e1315dadf8c46561fb9396e525f7200cdc227"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.3.5"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Preferences", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "ccee59c6e48e6f2edf8a5b64dc817b6729f99eb5"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.39.0"

    [deps.Plots.extensions]
    FileIOExt = "FileIO"
    GeometryBasicsExt = "GeometryBasics"
    IJuliaExt = "IJulia"
    ImageInTerminalExt = "ImageInTerminal"
    UnitfulExt = "Unitful"

    [deps.Plots.weakdeps]
    FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"
    ImageInTerminal = "d8c32880-2388-543b-8c61-d9f865259254"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "e47cd150dbe0443c3a3651bc5b9cbd5576ab75b7"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.52"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "03b4c25b43cb84cee5c90aa9b5ea0a78fd848d2f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00805cd429dcb4870060ff49ef443486c262e38e"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "7c29f0e8c575428bd84dc3c72ece5178caa67336"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.5.2+2"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "90bc7a7c96410424509e4263e277e43250c05691"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.0"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "30449ee12237627992a99d5e30ae63e4d78cd24a"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "c60ec5c62180f27efea3ba2908480f8055e17cee"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.1.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.9.0"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1ff449ad350c9c4cbc756624d6f8a8c3ef56d3ed"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "75ebe04c5bed70b91614d684259b661c9e6274a4"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "Pkg", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "5.10.1+6"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "9a6ae7ed916312b41236fcef7e0af564ef934769"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.13"

[[deps.Tricks]]
git-tree-sha1 = "aadb748be58b492045b4f56166b5188aa63ce549"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.7"

[[deps.URIs]]
git-tree-sha1 = "b7a5e99f24892b6824a954199a45e9ffcc1c70f0"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "a72d22c7e13fe2de562feda8645aa134712a87ee"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.17.0"

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    InverseFunctionsUnitfulExt = "InverseFunctions"

    [deps.Unitful.weakdeps]
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "e2d817cc500e960fdbafcf988ac8436ba3208bfd"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.6.3"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Vulkan_Loader_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Wayland_jll", "Xorg_libX11_jll", "Xorg_libXrandr_jll", "xkbcommon_jll"]
git-tree-sha1 = "2f0486047a07670caad3a81a075d2e518acc5c59"
uuid = "a44049a8-05dd-5a78-86c9-5fde0876e88c"
version = "1.3.243+0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "7558e29847e99bc3f04d6569e82d0f5c54460703"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.21.0+1"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4528479aa01ee1b3b4cd0e6faef0e04cf16466da"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.25.0+0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "04a51d15436a572301b5abbb9d099713327e9fc4"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.10.4+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "cf2c7de82431ca6f39250d2fc4aacd0daa1675c0"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.4.4+0"

[[deps.Xorg_libICE_jll]]
deps = ["Libdl", "Pkg"]
git-tree-sha1 = "e5becd4411063bdcac16be8b66fc2f9f6f1e8fe5"
uuid = "f67eecfb-183a-506d-b269-f58e52b52d7c"
version = "1.0.10+1"

[[deps.Xorg_libSM_jll]]
deps = ["Libdl", "Pkg", "Xorg_libICE_jll"]
git-tree-sha1 = "4a9d9e4c180e1e8119b5ffc224a7b59d3a7f7e18"
uuid = "c834827a-8449-5923-a945-d239c165b7dd"
version = "1.2.3+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "afead5aba5aa507ad5a3bf01f58f82c8d1403495"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.6+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6035850dcc70518ca32f012e46015b9beeda49d8"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.11+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "34d526d318358a859d7de23da945578e8e8727b7"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.4+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8fdda4c692503d44d04a0603d9ac0982054635f9"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.1+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "b4bfde5d5b652e22b9c790ad00af08b6d042b97d"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.15.0+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "730eeca102434283c50ccf7d1ecdadf521a765a4"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.2+0"

[[deps.Xorg_xcb_util_cursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_jll", "Xorg_xcb_util_renderutil_jll"]
git-tree-sha1 = "04341cb870f29dcd5e39055f895c39d016e18ccd"
uuid = "e920d4aa-a673-5f3a-b3d7-f755a4d47c43"
version = "0.1.4+0"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "330f955bc41bb8f5270a369c473fc4a5a4e4d3cb"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.6+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "691634e5453ad362044e2ad653e79f3ee3bb98c3"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.39.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e92a1a012a10506618f10b7047e478403a046c77"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.5.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+0"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "49ce682769cd5de6c72dcf1b94ed7790cd08974c"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.5+0"

[[deps.eudev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "gperf_jll"]
git-tree-sha1 = "431b678a28ebb559d224c0b6b6d01afce87c51ba"
uuid = "35ca27e7-8b34-5b7f-bca9-bdc33f59eb06"
version = "3.2.9+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "868e669ccb12ba16eaf50cb2957ee2ff61261c56"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.29.0+0"

[[deps.gperf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3516a5630f741c9eecb3720b1ec9d8edc3ecc033"
uuid = "1a1c6b14-54f6-533d-8383-74cd7377aa70"
version = "3.1.1+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3a2ea60308f0996d26f1e5354e10c24e9ef905d4"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.4.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+0"

[[deps.libevdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "141fe65dc3efabb0b1d5ba74e91f6ad26f84cc22"
uuid = "2db6ffa8-e38f-5e21-84af-90c45d0032cc"
version = "1.11.0+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libinput_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "eudev_jll", "libevdev_jll", "mtdev_jll"]
git-tree-sha1 = "ad50e5b90f222cfe78aa3d5183a20a12de1322ce"
uuid = "36db933b-70db-51c0-b978-0f229ee0e533"
version = "1.18.0+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "814e154bdb7be91d78b6802843f76b6ece642f11"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.6+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "9c304562909ab2bab0262639bd4f444d7bc2be37"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+1"
"""

# ╔═╡ Cell order:
# ╟─e503d9f6-84f0-486f-aa0f-b9cf6aa88b69
# ╟─d55da43e-9ba9-4527-8fec-72493e7996f3
# ╟─9a65324e-594f-11ee-3a9b-dff0ec87117f
# ╟─178903b9-1112-4f42-8995-dab542e293fe
# ╟─ffa59d87-7b68-4192-a52f-6582e67f1cbd
# ╟─16e020f3-aa07-40d9-9f8f-e461ef7b903a
# ╟─a2a5e259-785a-4907-9eeb-40c3e1f4332c
# ╟─46ec1e5a-9d63-4f99-b35c-ac69520e7565
# ╟─7f924a27-3a75-47ba-a0e9-d5b841a49bb1
# ╟─12e416c5-6f4e-4c84-ab04-20ba300adfc3
# ╟─ebdbcb08-bdfa-46e4-9d20-898b25d77d15
# ╟─a87effdc-0282-4a92-82b4-ae35e496e81f
# ╟─f87b8e3f-4943-47e6-9317-6516a8c8a31a
# ╟─31caf44b-cd8d-4cef-bbb3-6dd6eedf0a76
# ╟─ce0ca1d7-8ebf-4761-89e3-b53fc46216e0
# ╟─9004bad6-b416-483a-9852-1d6ad19b2a48
# ╟─e520ba54-bef4-44b9-a09c-feeb6519292e
# ╟─ad9ab2dc-9de7-4695-b6c3-29cbabc1dd8c
# ╟─99384a42-6902-481c-980e-3cc469df17c2
# ╟─0e2de8ba-3a25-4158-abc0-bed956dfe470
# ╟─1159e991-073f-4e4d-88f8-c8cd0104a6e2
# ╟─c3550f70-8b7b-432e-aa5e-7ab5084cf69f
# ╟─8d289999-bbca-4db7-9730-e62cd2822747
# ╟─882dcccd-3c97-4bc3-9e95-014f90d7a795
# ╟─657496b6-cf0f-4f2b-a7ae-9ec89f0800e2
# ╟─25408447-3e76-4bfc-94c9-4bede0a44351
# ╟─7f34b696-8844-40e5-8cf0-14ceb0f56868
# ╟─f8ccdf01-abc9-4fd9-95c1-e5c77e3527ef
# ╟─6a031d8c-ff65-4a6b-b8b6-76203dc56f2a
# ╟─8b95ef50-fbac-4653-8819-757fdf77a4dd
# ╟─da783d24-3ae2-4618-8eac-af1b2a32f657
# ╟─618edeb0-411a-4c4f-9ddb-2497b40241aa
# ╟─ebc4c86d-621b-4c0a-b7bd-e9ea8e87d36d
# ╟─eaa13afa-3efd-42dd-9eb3-a41569e063dc
# ╟─8927df0f-b092-4933-b7c2-d712a1d2e8b2
# ╟─de7960c4-9177-4ded-b0bf-6140c10e69f0
# ╟─53bb3aa6-a858-4040-86c3-c94d8bb6848b
# ╟─8aee1e87-7b32-4f71-9685-12e15ba9b246
# ╟─e29c8789-202f-4d93-ae34-7642b0b80d74
# ╟─e1a9cf02-5f46-4ea8-bbbe-b8f1b9224be1
# ╟─f14d6ab2-1e06-4e72-86c1-6defaedd58c3
# ╟─e58f6c8b-ffcd-4f06-a1c3-6a02055ae428
# ╟─7086d5eb-6f81-4bfc-8ba0-1ea83268059f
# ╟─962cb2da-7f45-40aa-a081-468841dfa617
# ╟─81d21cce-1374-4d64-9230-8216ff71ee38
# ╟─af6ca434-aabe-4c95-9a4f-9155c861f2e2
# ╟─32e5c347-5dd3-41ab-9382-deaff3089657
# ╟─055c68c2-4fca-4a3e-ab26-28cf6c0cdef8
# ╟─eb96720e-1a36-4295-a68f-e087c4d8a59b
# ╟─3690445c-4878-4f9c-949b-222c2e31176e
# ╟─1c959bee-c340-41cf-a142-2d6cd3839684
# ╟─827b1c6b-e992-4135-a491-cabf39ac906c
# ╟─9ffa7538-c969-4e7a-8bd6-6b568d7e1a03
# ╟─d26018da-e17d-430d-baf9-84265352cd8c
# ╟─1bfcc315-531b-482d-b712-14589d2489f7
# ╟─48e3d3c0-a6f1-48a3-9ca1-c239fa15fc62
# ╟─9a34a196-0a73-4aee-a097-ad4d5b193a42
# ╟─7a03612e-4116-4063-ba89-3e73028b115f
# ╟─25a533c4-61dc-4ba0-8ab2-eba55f69b21f
# ╟─0112eae5-6f4c-400f-b636-9fd4e3786153
# ╟─c2d7a315-56c8-4e14-9a16-219d7669e3cb
# ╟─b7b3afbb-5aeb-4f24-9beb-7f69a0c6629b
# ╟─21c01e95-814a-4760-bc27-b31f45eb72b2
# ╟─7c6ba1e8-9e6c-4fbb-aea2-493bb3b7fcd9
# ╟─ea4c2b2f-1419-4334-a545-f16dd6dd3e76
# ╟─050c6975-e92b-48b1-a0d5-b12f1005b611
# ╟─c675e5ee-185e-41d1-b879-939357ffb5c7
# ╟─49c21509-8821-4299-a725-814e54d0954d
# ╟─6a786e0f-6ab6-4c72-aa3d-cb0eff518d6d
# ╟─dd21e219-6c97-4f15-8fe7-803184aa6d6f
# ╟─dc1e4c73-f7e1-4f7f-b139-0b82797da6c6
# ╟─b264e6e2-1ed9-4a01-8ca9-f0825de0482c
# ╟─bc101546-cb14-40e5-ba6a-1f3b084be914
# ╟─f530f155-fd4e-4dae-ab85-994ea0ebe8b2
# ╟─bb83958a-3700-4246-8b37-c94642a88c31
# ╟─1a408b82-fe7e-4930-94d2-cfa89c7340b8
# ╟─3bb2ca7f-c283-4574-a45a-bebf068dfe71
# ╠═289f7931-8511-4650-960e-54a20a180320
# ╠═8fd2edc7-5063-4033-a9cb-5e7623467fb5
# ╟─7e6d7f4f-e68c-41ff-8dcc-14cf326279da
# ╠═10737f1b-f132-468f-95f2-089705bd7488
# ╟─3e4e081f-d8ab-4b82-85ed-aaecc192a46b
# ╠═66af7c57-3063-448f-baef-2898cb262c22
# ╟─1577dff0-f4b6-4c39-8d2a-f7ff6fe5b044
# ╠═64840f00-2529-4ad9-bf9e-33610dc4cfcc
# ╟─26e8e204-a74e-4bc8-8bc0-28ba4eb26620
# ╠═30e87a64-2d1a-4198-8039-8bb0be7632f3
# ╠═279fa764-91aa-415d-86ed-47ed3ecfc720
# ╠═54eb2768-7b9e-442e-8818-b373f8b6d49e
# ╟─819075e8-0058-4606-9a29-93fe169263be
# ╠═db66a1ef-6f40-447e-8e09-1b612bd98d3b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
