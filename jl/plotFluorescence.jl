"""
For plotting a fluorescence trace.

Arguments:  time_points,
            fluorescence,
            fluorescence_label="",
            has_xlabel=False,
            has_ylabel=False,
            has_xticks=true,
            colour=Green,
            alpha=1.0,
            ylims=(0,0)

Returns:    nothing
"""
function plotFluorescence(time_points::Array{Float64,1}, fluorescence::Array{Float64,1}; 
                          fluorescence_label::String="", has_xlabel::Bool=false, has_ylabel::Bool=false,
                          has_xticks::Bool=true, colour::String="green", alpha::Float64=1.0, ylims=Tuple{Int,Int}=(0,0))
  PyPlot.plot(time_points, fluorescence, color=colour, label=fluorescence_label, alpha=alpha)
  has_ylabel && PyPlot.ylabel(L"$\Delta F/F_0$", fontsize="large")
  has_xlabel && PyPlot.xlabel("Time (s)", fontsize="large")
  PyPlot.xticks(fontsize="large"); PyPlot.yticks(fontsize="large")
  if has_xticks == false
    xmarkers, xlabels = PyPlot.xticks()
    PyPlot.xticks(xmarkers, [])
  end
  PyPlot.xlim((time_points[1], time_points[end]))
  ylims != (0,0) && PyPlot.ylim(ylims)
  PyPlot.grid("on")
end
