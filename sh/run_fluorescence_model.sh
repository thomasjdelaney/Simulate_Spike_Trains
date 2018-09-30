#!/bin/bash

fluorescence_modelling_dir=$HOME/Fluorescence_Modelling/
simulate_dir=$HOME/Simulate_Spike_Trains/
optimisation_dir=$SPACE/optimisation_csvs
spike_file_name=$1
spike_file=$simulate_dir/csv/$spike_file_name
file_root=${spike_file_name/_spikes.csv/}
tmp_file=/tmp/tmp_"$file_root"_fluorescence.csv
num_traces=$2
opt_file=$optimisation_dir/comp_opt_8_18_2e-2.csv
free_param_options=`$SPACE/julia/bin/julia $fluorescence_modelling_dir/jl/build_command_from_opt.jl --opt_file $opt_file`

for i in $(seq 1 $num_traces)
do
  echo `date +"%Y.%m.%d %T"` " Processing trace number $i..."
  save_filename=$file_root.$i.csv
  $SPACE/julia/bin/julia $simulate_dir/jl/fluorescence_simulation.jl --spike_file $spike_file --frequency 100.0 --colname x$i --title $save_filename --save_fluoro $free_param_options
  save_file=$simulate_dir/csv/$save_filename
  if [ -f $save_file ]
  then
    if [ -f $tmp_file ]
    then
      really_tmp_file=`mktemp`
      paste -d, $tmp_file <(cut -d , -f 2 $save_file) > $really_tmp_file
      mv $really_tmp_file $tmp_file
    else
      cut -d , -f 2 $save_file > $tmp_file
    fi
    column_name=x$i
    sed -i s/fluorescence/$column_name/g $tmp_file
    rm $save_file
  else
    echo "$save_file does not exist."
  fi
done

mv $tmp_file "$simulate_dir"/csv/"$file_root"_calcium.csv
