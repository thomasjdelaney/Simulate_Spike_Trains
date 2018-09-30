######################################################################################################
##
## For simulating some spike trains
##
## julia jl/simulate_trains --firing_rate <mean firing rate> --trial_time <length of trial in seconds>
##    --sampling_frequency <Hz> --trials <number of trials to simulate> --rate_file 
##    <csv file path in which to save the rates> --spike_file 
##    <csv file path in which to save the spike trains> --debug <enter debug mode>
##
## julia jl/simulate_trains --firing_rate 10.0 --trial_time 5.0 --sampling_frequency 100.0
##    --trials 30 --rate_file $HOME/Simulate_Spike_Trains/csv/test_rates.csv --spike_file
##    $HOME/Simulate_Spike_Trains/csv/test_spikes.csv --debug
##
######################################################################################################

push!(LOAD_PATH, homedir() * "/Simulate_Spike_Trains/jl")
using SimulateSpikeTrains
using CSV, DataFrames

# make 30 trains for 1Hz, 5Hz, and 10Hz

function main()
  params = parseParams()
  info("Starting main function...", prefix=string(now(), " INFO: ")) 
  if params["debug"]; info("Entering debug mode.", prefix=string(now(), " INFO: ")); return nothing; end
  time_bin = 1/params["sampling_frequency"]
  time_span = (0.0, params["trial_time"])
  num_bins = length(time_span[1]:time_bin:time_span[2])+1
  rate_array = zeros(Float64, (num_bins, params["trials"]))
  trial_array = zeros(Int64, (num_bins, params["trials"]))
  info("Simulating data...", prefix=string(now(), " INFO: "))
  for t in 1:params["trials"]
    sol = simulateRateDynamics(rate_steady=params["firing_rate"], time_span=time_span, rate_init=params["firing_rate"], time_bin=time_bin)
    spike_train = ratesToSpikes(time_bin, sol.u)
    rate_array[:,t] = sol.u
    trial_array[:,t] = spike_train
  end
  CSV.write(params["rate_file"], DataFrame(rate_array), header=false)
  info("Rate data saved: " * params["rate_file"], prefix=string(now(), " INFO: "))
  CSV.write(params["spike_file"], DataFrame(trial_array), header=true)
  info("Spike trains saved: " * params["spike_file"], prefix=string(now(), " INFO: "))
  info("Done", prefix=string(now(), " INFO: "))
end

main()
  
