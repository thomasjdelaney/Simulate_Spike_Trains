"""
For plotting the proportion of calcium concentrations during a trial

Arguments:  time_points
            spiking_sim
            has_xlabel=true
            has_ylabel=true

Returns:    nothing
"""
function plotCalciumProportion(time_points::Array{Float64,1}, spiking_sim::Array{Float64,2}; 
                               has_xlabel::Bool=true, has_ylabel::Bool=true, has_xticks::Bool=true)
  num_points = length(time_points);
  total = reshape(sum(spiking_sim, 2), num_points);
  bca_star = total - spiking_sim[:,5];
  bca = bca_star - spiking_sim[:,2];
  imca = bca - spiking_sim[:,4];
  eca = imca - spiking_sim[:,3];
  ca = eca - spiking_sim[:,1];
  PyPlot.plot(time_points, total, color="purple", label="Total Calcium")
  PyPlot.fill_between(time_points, total, bca_star, color="orange", label=L"[BCa$^*$]", alpha=0.35)
  PyPlot.fill_between(time_points, bca_star, bca, color="blue", label="[BCa]", alpha=0.35)
  PyPlot.fill_between(time_points, bca, imca, color="green", label="[ImCa]", alpha=0.35)
  PyPlot.fill_between(time_points, imca, eca, color="black", label="[ECa]", alpha=0.35)
  PyPlot.fill_between(time_points, eca, ca, color="red", label=L"[Ca$^{2+}$]", alpha=0.35)
  PyPlot.legend(fontsize="large")
  has_xlabel && PyPlot.xlabel("Time (s)", fontsize="large")
  has_ylabel && PyPlot.ylabel("Molar Concentration (M)", fontsize="large")
  PyPlot.xticks(fontsize="large"); PyPlot.yticks(fontsize="large")
  PyPlot.ticklabel_format(style="sci", axis="y", scilimits=(0,0))
  if has_xticks == false
    xmarkers, xlabels = PyPlot.xticks()
    PyPlot.xticks(xmarkers, [])
  end
  PyPlot.xlim((time_points[1], time_points[end]))
  PyPlot.grid("on")
  return nothing
end

