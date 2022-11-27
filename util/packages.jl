current_path=@__FILE__
main_folder_path=normpath(current_path, "../..")
dir = dirname(main_folder_path)
using Pkg
Pkg.activate(dir)

using ARFFFiles
using DataFrames
using StatsPlots
using CategoricalArrays
using LinearAlgebra
using GLM
