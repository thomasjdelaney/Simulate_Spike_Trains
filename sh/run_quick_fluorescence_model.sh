#!/bin/bash
# ./sh/run_fluorescence_model.sh 10.9.14cell9.csv 0.47

fluorescence_modelling_dir=$HOME/Fluorescence_Modelling
optimisation_dir=$SPACE/optimisation_csvs
proj_dir=$HOME/Simulate_Spike_Trains/
csv_dir=$proj_dir/csv/
filename=$1
frequency=$2

opt_file=$optimisation_dir/comp_opt_8_18_2e-2.csv
free_param_options=`$SPACE/julia/bin/julia $fluorescence_modelling_dir/jl/build_command_from_opt.jl --opt_file $opt_file`

echo `date +"%Y.%m.%d %T"` " Running model..."
$SPACE/julia/bin/julia $proj_dir/jl/run_fluorescence_model.jl --filepath $csv_dir$filename --frequency $frequency $free_param_options
