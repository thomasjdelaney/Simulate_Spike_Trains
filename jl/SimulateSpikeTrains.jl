# module for simulating spike trains given a baseline spike rate

module SimulateSpikeTrains

using ArgParse
using DifferentialEquations
using Distributions
using PyPlot

export parseParams,
  plotCalciumProportion,
  plotFluorescence,
  plotRateDynamics,
  plotRatesSpikesFluorescence,
  plotSpikesDynamics,
  plotSpikesFluorescence,
  plotSpikeTrain,
  ratesToSpikes,
  simulateRateDynamics
  
include("parseParams.jl")
include("plotCalciumProportion.jl")
include("plotFluorescence.jl")
include("plotRateDynamics.jl")
include("plotRatesSpikesFluorescence.jl")
include("plotSpikesDynamics.jl")
include("plotSpikesFluorescence.jl")
include("plotSpikeTrain.jl")
include("ratesToSpikes.jl")
include("simulateRateDynamics.jl")

end
