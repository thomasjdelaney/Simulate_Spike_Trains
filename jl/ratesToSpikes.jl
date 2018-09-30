"""
For taking in a trace of spike rates and returning a spike train. The train will contain the 
number of spikes in each bin.

Arguments:  time_bin,
            rates,

Returns:    spike_train, Array{Int64,1}
"""
function ratesToSpikes(time_bin::Float64, rates::Array{Float64,1})
  num_bins = length(rates)
  spike_train = zeros(Int64, num_bins)
  rates_over_bins = rates * time_bin
  for i in 1:num_bins
    rate_over_bin = rates_over_bins[i]
    p_dist = Poisson(rate_over_bin)
    spike_train[i] = rand(p_dist)
  end
  return spike_train
end
