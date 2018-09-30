## For looking at a few graphs of different frequencies

push!(LOAD_PATH, homedir() * "/Simulate_Spike_Trains/jl")
using ArgParse
using PyPlot 
using CSV, DataFrames 
using SimulateSpikeTrains

function parseParams()
  s = ArgParseSettings()
  @add_arg_table s begin
    "--debug"
      help = "Enter debug mode."
      action = :store_true
    "--num_figures"
      help = "The number of traces to print out for each file"
      arg_type = Int64
      default = 5
    "--file_roots"
      help = "The prefixes for the files to print"
      arg_type = String
      nargs = '+'
      default = ["10_Hz", "5_Hz", "1_Hz"]
    "--save_name"
      help = "The name of the image file to which to save."
      arg_type = String
      default = ""
  end
  return parse_args(s)
end

function getSubPlotIndex(num_cols::Int, col_index::Int, row_index::Int)
  return row_index + (num_cols-1)*(row_index - 1) + (col_index - 1)
end

function getPlotTitle(file_root::String)
  title = replace(file_root, "_", " ")
  if contains(file_root, "to")
    title = replace(title, "to", " - ")
  end
  return title
end

function saveOrShow(save_name::String)
  if save_name == ""
    save_file = save_name
    PyPlot.show(block=false)
  else
    save_file = homedir()*"/Simulate_Spike_Trains/images/$save_name"
    PyPlot.savefig(save_file)
  end
  return save_file
end

function getFileFrames(file_root::String)
  rate_file = "csv/"*file_root*"_rates.csv"
  spike_file = "csv/"*file_root*"_spikes.csv"
  calc_file = "csv/"*file_root*"_calcium.csv"
  rate_frame=CSV.read(rate_file,header=false);
  spike_frame=CSV.read(spike_file);
  calc_frame=CSV.read(calc_file);
  return [rate_frame, spike_frame, calc_frame]
end

function main()
  params = parseParams()
  if params["debug"]; info("Entering debug mode.", prefix=string(now(), " INFO: ")); return nothing; end
  num_roots = length(params["file_roots"]);
  for i in 1:num_roots
    file_root = params["file_roots"][i];
    rate_frame, spike_frame, calc_frame = getFileFrames(file_root);
    time_points = collect((0:size(rate_frame,1)-1)/100);
    for j in 1:params["num_figures"]
      colnames = [Symbol("Column"*string(j)), Symbol("x"*string(j))]
      rates = rate_frame[colnames[1]];
      spikes = spike_frame[colnames[2]];
      fluorescence = calc_frame[colnames[2]];
      position_index = getSubPlotIndex(num_roots, i, j)
      #PyPlot.subplot(params["num_figures"], num_roots, getSubPlotIndex(num_roots, i, j))
      title = j == 1 ? getPlotTitle(file_root) : ""
      PyPlot.figure(figsize=(4.5,3.85))
      plotSpikesFluorescence(time_points, spikes, fluorescence, ylims=(0,10.0),
                             has_xlabel=j==params["num_figures"], has_ylabels=i==1,
                             title = title)
      save_name = params["save_name"]*"_"*file_root*"_"*"$j"*"_"*"$position_index.svg"
      PyPlot.savefig(save_name)
      info("Figure saved: $save_name", prefix=string(now(), " INFO: "))
      PyPlot.close()
      #j==1 && PyPlot.title("Mean Firing Rate = " * getPlotTitle(file_root))
    end
  end
  #PyPlot.tight_layout()
  #save_file = saveOrShow(params["save_name"])
  #info("Figure saved: $save_file", prefix=string(now(), " INFO: "))
end

main()
