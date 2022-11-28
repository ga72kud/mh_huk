
include("util/packages.jl")
include("src/a_explorative_data_analysis/data_container.jl")

obj=my_data_container()
initialize(obj)

# density plot
visualizing_densities(obj)
# selected scatter plot
visualizing_scatterplot(obj)
# find common indices for both datasets
idx=find_indices_id_pol(obj)
# get data matrix
filter_dataframe_for_X(obj, idx)
# get target vector
filter_dataframe_for_y(obj, idx)
# get matrix only by a subjective feature selection (:VehPower, :VehAge, :DrivAge)
getting_selected_matrix(obj)
# visualize density plot target vector
sel_idx=visualize_density_target(obj)
# analysis of target variable and selected feature set
visualize_scatter_feature_to_target(obj, sel_idx)
# make a prediction for a subset of data samples
making_prediction_for_selected_dataset(obj)
