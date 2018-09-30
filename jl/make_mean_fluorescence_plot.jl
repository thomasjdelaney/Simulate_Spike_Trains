push!(LOAD_PATH, homedir() * "/Julia_Utils/jl")
using JuliaUtils
using CSV
using PyPlot

file_10 = homedir()*"/Simulate_Spike_Trains/csv/10_Hz_calcium.csv"
file_5 = homedir()*"/Simulate_Spike_Trains/csv/5_Hz_calcium.csv"
file_1 = homedir()*"/Simulate_Spike_Trains/csv/1_Hz_calcium.csv"

fluoro_frame_10 = CSV.read(file_10);
fluoro_frame_5 = CSV.read(file_5);
fluoro_frame_1 = CSV.read(file_1);

all_fluoro_10 = zeros(Float64, size(fluoro_frame_10));
all_fluoro_5 = zeros(Float64, size(fluoro_frame_5));
all_fluoro_1 = zeros(Float64, size(fluoro_frame_1));

time_points = collect(0:(size(fluoro_frame_10,1)-1))/100

PyPlot.figure(figsize=(4.5, 3.85));

for i in 1:30
  colname = Symbol("x"*string(i));
  fluoro_10 = fluoro_frame_10[colname];
  fluoro_5 = fluoro_frame_5[colname];
  fluoro_1 = fluoro_frame_1[colname];
  ma_fluoro_10 = ma(fluoro_10, 1000);
  ma_fluoro_5 = ma(fluoro_5, 1000);
  ma_fluoro_1 = ma(fluoro_1, 1000);
  PyPlot.plot(time_points, ma_fluoro_10, color="orange", alpha=0.1);
  PyPlot.plot(time_points, ma_fluoro_5, color="red", alpha=0.1);
  PyPlot.plot(time_points, ma_fluoro_1, color="yellow", alpha=0.1);
  all_fluoro_10[:,i] = fluoro_10;
  all_fluoro_5[:,i] = fluoro_5;
  all_fluoro_1[:,i] = fluoro_1;
end

all_mean_10 = mean(all_fluoro_10, 2);
all_mean_5 = mean(all_fluoro_5, 2);
all_mean_1 = mean(all_fluoro_1, 2);

PyPlot.plot(time_points, all_mean_10, label="10 Hz", color="orange");
PyPlot.plot(time_points, all_mean_5, label="5 Hz", color="red");
PyPlot.plot(time_points, all_mean_1, label="1 Hz", color="yellow");

PyPlot.xlabel("Time (s)", fontsize="large");
PyPlot.ylabel(L"$\Delta F/F_0$ (mean)", fontsize="large");
PyPlot.xticks(fontsize="large"); PyPlot.yticks(fontsize="large");
PyPlot.xlim((time_points[1], time_points[end]));
PyPlot.legend(fontsize="large");
PyPlot.tight_layout();
