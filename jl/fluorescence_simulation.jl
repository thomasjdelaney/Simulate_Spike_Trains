###################################################################################################
##
## For running the Fluorescence Model on the simulated spike trains
##
##
###################################################################################################

push!(LOAD_PATH, homedir() * "/Fluorescence_Model/jl")
push!(LOAD_PATH, homedir() * "/Fluorescence_Modelling/jl")
using FluorescenceModelling
using FluorescenceModel
using CSV, DataFrames

function main()
  info("Starting fluorescence modelling...", prefix=string(now(), " INFO: "))
  params = parseParams()
  if params["debug"]; info(" Entering debug mode."); return nothing; end
  spike_train = convert(Array{Int64,1}, CSV.read(params["spike_file"])[params["colname"]])
  info(string("Processing ", params["colname"], "..."), prefix=string(now(), " INFO: "))
  fluorescence, spiking_sim, spiking_sim_time = calciumFluorescenceModel(spike_train,
    cell_radius=params["cell_radius"], baseline=params["baseline"], calcium_rate=params["calcium_rate"],
    indicator=params["indicator"], endogeneous=params["endogeneous"], immobile=params["immobile"],
    b_i=params["b_i"], f_i=params["f_i"], b_e=params["b_e"], f_e=params["f_e"], b_im=params["b_im"],
    f_im=params["f_im"], excitation=params["excitation"], release=params["release"], peak=params["peak"],
    frequency=params["frequency"], capture_rate=params["capture_rate"])
  if params["save_fluoro"]
    file_name = saveModelFluorescence(params["title"], fluorescence, params["spike_file"], params["colname"], has_header=true)
    info("Fluorescence saved: $file_name", prefix=string(now(), " INFO: "))
  end
  info("Done.", prefix=string(now(), " INFO: "))
end

main()
