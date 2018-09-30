Package for simulating spike trains.

Uses the Ornstein-Uhlenbeck process in the DifferentialEquations package to simulate a noisy spike rate. Uses a Poisson distribution to convert the instantaneous rate into a number of spikes for each time bin.

Sample script for using the package contained in **jl/simulate_trains.jl**.

Dependencies:

- ArgParse
- DifferentialEquations
- Distributions
- PyPlot
- Seaborn
