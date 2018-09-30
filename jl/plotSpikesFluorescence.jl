"""
For plotting a fluorescence trace with a spike train underneath

Arguments:  time_points,
            spike_train,
            fluorescence,
            fluorescence_label="",
            colour="green",
            alpha=1.0,
            has_xlabel=true,
            has_ylabels=true,
            num_rows=1,
            num_columns=1,
            position_index=1

Returns:    y limits of fluorescence axis
"""
function plotSpikesFluorescence(time_points::Array{Float64,1}, spike_train::Array{Int64,1}, 
                                fluorescence::Array{Float64,1}; fluorescence_label::String="", 
                                colour::String="green", alpha::Float64=1.0, ylims::Tuple{Float64,Float64}=(0.0,0.0), 
                                has_xlabel::Bool=true, has_ylabels::Bool=true, num_rows::Int=1, num_columns::Int=1, 
                                position_index::Int=1, title::String="")
  row_position, col_position = [div(position_index-1, num_columns), mod(position_index-1, num_columns)]
  left_shift, bottom_shift = 1/num_columns, 1/num_rows
  def_left, def_bottom, def_width, def_height = [0.125/num_columns, 0.4/num_rows, 
                                                 0.8/num_columns, 0.5/num_rows] # [left, bottom, width, height]
  left = def_left + col_position*left_shift
  bottom = def_bottom + (num_rows-(1+row_position))*bottom_shift
  PyPlot.axes([left , bottom, def_width, def_height]) 
  plotFluorescence(time_points, fluorescence, has_ylabel=has_ylabels, has_xticks=false, 
                   fluorescence_label=fluorescence_label, colour=colour, alpha=alpha, ylims=ylims)
  row_position == 0 && title != "" && PyPlot.title(title)  
  fluorescence_label != "" && PyPlot.legend()
  def_bottom, def_height = [0.125/num_rows, 0.2/num_rows]
  bottom = def_bottom + (num_rows-(1+row_position))*bottom_shift
  ylims=PyPlot.ylim();
  PyPlot.axes([left, bottom, def_width, def_height]) 
  plotSpikeTrain(time_points, spike_train, has_xlabel=has_xlabel, has_ylabel=has_ylabels)
  return ylims
end
          
