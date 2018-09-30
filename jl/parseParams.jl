"""
For making the parameter dictionary out of the commnad line arguments

Arguments: None

Returns:  parameter dictionary
"""
function parseParams()
  s = ArgParseSettings() 
  @add_arg_table s begin
    "--debug"
      help = "Enter debug mode."
      action = :store_true
    "--firing_rate"
      help = "The mean firing rate of the simulated data."
      arg_type = Float64
      default = 10.0
    "--trial_time"
      help = "The number of seconds that the simulated trials last."
      arg_type = Float64
      default = 5.0
    "--sampling_frequency"
      help = "The sampling frequency of the simulated trials."
      arg_type = Float64
      default = 100.0
    "--trials"
      help = "The number of trials to be simulated"
      arg_type = Int64
      default = 30
    "--rate_file"
      help = "The name and path of the file in which to save the rates."
      arg_type = String
      default = homedir() * "/Train_sim/csv/test_rates.csv"
    "--spike_file"
      help = "The name and path of the file in which to save the spikes."
      arg_type = String
      default = homedir() * "/Train_sim/csv/test_spikes.csv"
  end
  p = parse_args(s)
  return p
end
