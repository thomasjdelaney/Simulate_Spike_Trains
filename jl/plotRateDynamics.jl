"""
For plotting the trace of the rates over the time period

Arguments:  time_points,
            rates,
            rate_label

Returns: nothing
"""
function plotRateDynamics(time_points::Array{Float64,1}, rates::Array{Float64,1}; rate_label::String="",
                         has_xlabel::Bool=false, has_ylabel::Bool=false, colour::String="blue", 
                         alpha::Float64=1.0)
  PyPlot.plot(time_points, rates, color=colour, label=rate_label, alpha=alpha)
  has_ylabel && PyPlot.ylabel("Firing Rate (Hz)", fontsize="large")
  has_xlabel && PyPlot.xlabel("Time (s)", fontsize="large")
  PyPlot.xticks(fontsize="large"); PyPlot.yticks(fontsize="large")
  PyPlot.xlim((time_points[1], time_points[end]))
end
