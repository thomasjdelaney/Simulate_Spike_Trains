"""
For plotting the calcium concentrations with a spike train underneath

Arguments:  time_points,
            spike_train,
            spiking_sim,
            has_xlabel=true,
            has_ylabels=true

Returns:    nothing
"""
function plotSpikesDynamics(time_points::Array{Float64,1}, spike_train::Array{Int64,1},
                            spiking_sim::Array{Float64,2}; has_xlabel::Bool=true, has_ylabels::Bool=true)
  PyPlot.axes([0.125, 0.4, 0.8, 0.5])
  plotCalciumProportion(time_points, spiking_sim, has_xlabel=false, has_ylabel=has_ylabels, 
                       has_xticks=false)
  PyPlot.axes([0.125, 0.125, 0.8, 0.2]) # [left, bottom, width, height]
  plotSpikeTrain(time_points, spike_train, has_xlabel=has_xlabel, has_ylabel=has_ylabels)
  return nothing
end
