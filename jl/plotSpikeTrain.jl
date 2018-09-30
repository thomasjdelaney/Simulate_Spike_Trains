"""
For plotting a spike train

Arguments:  time_points,
            spike_train,
            has_xlabel=false,
            has_ylabel=false,
            colour="Blue"

Returns:    nothing
"""
function plotSpikeTrain(time_points::Array{Float64,1}, spike_train::Array{Int64,1}; has_xlabel::Bool=false, 
                        has_ylabel::Bool=false, colour::String="blue")
  num_time_points = length(time_points)
  max_number_spikes = maximum(spike_train)
  for i in 1:max_number_spikes
    spike_indices = find(spike_train .== i)
    spike_times = time_points[spike_indices]
    PyPlot.vlines(x=spike_times, ymin=0, ymax=i, color=colour)
  end
  has_xlabel && PyPlot.xlabel("Time (s)", fontsize="large")
  has_ylabel && PyPlot.ylabel("Spikes", fontsize="large")
  PyPlot.xticks(fontsize="large"); PyPlot.yticks(fontsize="large")
  PyPlot.xlim((time_points[1], time_points[end]))
  PyPlot.ylim((0,max_number_spikes))
  max_number_spikes > 1 && PyPlot.grid("on")
end

