##############################################################################################################
##
##  For running the fluorescence model on the data that Anna sent to me. Both the original data and the lower
##  frequency sampled data.
##
##
##
##############################################################################################################

push!(LOAD_PATH, homedir() * "/Fluorescence_Model/jl")
using FluorescenceModel
using CSV, DataFrames
using ArgParse

function parseParams()
  s = ArgParseSettings()
  @add_arg_table s begin
    "--filepath"
      help = "The absolute path to the file containing the spike train."
      arg_type = String
      default = ENV["SPACE"] * "/Anna_Simpson/csv/10.9.14cell9.csv"
    "--frequency"
      help = "The sampling frequency in Hz if spike times are from file."
      arg_type = Float64
      default = 100.0
    "--calcium_rate"
      help = "The rate of the calcium influx at rest."
      arg_type = Float64
      default = 0.0001
    "--excitation"
      help = "The excitation rate of the BCa."
      arg_type = Float64
      default = 0.15
    "--release"
      help = "The photon release rate of the excited BCa, BCa*."
      arg_type = Float64
      default = 0.11
    "--capture_rate"
      help = "The expected proportion of photons captured at any given moment."
      arg_type = Float64
      default = 0.62
    "--debug"
      help = "To enter debug mode, or not"
      action = :store_true
  end
  p = parse_args(s)
end

function main()
  info("Starting modelling function...", prefix=string(now(), " INFO: "))
  params = parseParams()
  if params["debug"]; info("Entering debug mode.", prefix=string(now(), " INFO: ")); return nothing; end
  file_frame = CSV.read(params["filepath"])
  spike_train = file_frame[:isspike]
  info("Modelling the fluorescence...", prefix=string(now(), " INFO: "))
  fluorescence, spiking_sim, spiking_sim_time = calciumFluorescenceModel(spike_train,
    calcium_rate=params["calcium_rate"], excitation=params["excitation"], release=params["release"],
    capture_rate=params["capture_rate"], frequency=params["frequency"])
  file_frame[:fluorescence] = fluorescence
  save_name = replace(params["filepath"], ".csv", ".downsampled.csv")
  CSV.write(save_name, file_frame)
  info("File saved: $save_name", prefix=string(now(), " INFO: "))
  info("Done.", prefix=string(now(), " INFO: "))
end

main()
