"""
For simulating a trace of the firing rate using an Ornstein-UhlenbeckProcess.

Arguments:  correlation_time,
            rate_steady,
            sigma,
            time_span,
            rate_init,
            time_bin

Returns:    sol, DiffEqNoiseProcess, solution to the Ornstein-Uhlenbeck problem
"""
function simulateRateDynamics{T <: Real}(;correlation_time::T=2.0,  rate_steady::T=10.0,  sigma::T=1.5,
                                         time_span::Tuple{T,T}=(0.0, 5.0),  rate_init::T=10.0, time_bin::T=0.01)
  W = OrnsteinUhlenbeckProcess(correlation_time, rate_steady, sigma, time_span[1], rate_init)
  prob = NoiseProblem(W, time_span)
  sol = solve(prob, dt=time_bin)
  sol.u[sol.u .< 0] = 0.0
  return sol
end
