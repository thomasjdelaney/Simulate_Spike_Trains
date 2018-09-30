"""
For plotting the rates, spikes, and fluorescence all on the one figure.

Arguments:  time_points,
            rates,
            spikes,
            fluorescence,
            labels,
            has_xlabel

Returns: nothing
"""
function plotRatesSpikesFluorescence(time_points::Array{Float64,1}, rates::Array{Float64,1}, spikes::Array{Int64,1}, fluorescence::Array{Float64,1}; has_xlabel::Bool=false, has_llabel::Bool=false, has_rlabel::Bool=false)
  plotSpikeTrain(time_points, spikes, has_ylabel=false)
  plotRateDynamics(time_points, rates, rate_label="Firing Rate (Hz)", has_xlabel=has_xlabel, colour="red", alpha=0.3, has_ylabel=has_llabel)
  PyPlot.legend(fontsize="medium")
  PyPlot.twinx(); 
  has_rlabel && PyPlot.ylabel(L"$\Delta F/F_0$", fontsize="large")
  PyPlot.plot(time_points, fluorescence, label=L"$\Delta F/F_0$", color="green")
  PyPlot.xticks(fontsize="large"); PyPlot.yticks(fontsize="large")
  PyPlot.xlim((time_points[1], time_points[end]))
  PyPlot.grid("off")
  PyPlot.legend(fontsize="medium")
end
