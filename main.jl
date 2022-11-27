
include("util/packages.jl")
include("src/a_explorative_data_analysis/data_container.jl")

obj=my_data_container()
initialize(obj)

visualizing_densities(obj)
idx=find_indices_id_pol(obj)
filter_dataframe_for_X(obj, idx)
filter_dataframe_for_y(obj, idx)
getting_only_float_matrix(obj)


pinv(obj.X)*obj.y
