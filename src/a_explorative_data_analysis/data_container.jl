mutable struct data_container
    B::DataFrame
    C::DataFrame
    selB::DataFrame
    selC::DataFrame
    X::Matrix{Float64}
    y::Vector{Float64}

end
function my_data_container()
    return data_container(DataFrame([]), DataFrame([]),DataFrame([]), DataFrame([]), Matrix{Float64}(undef, 0, 0), Vector{Float64}(undef, 0))
end
function initialize(obj::data_container)
    load_data_set(obj)
end

function load_data_set(obj::data_container)
    current_path=@__FILE__
    main_folder_path=normpath(current_path, "../../..")
    data_matrix_path=main_folder_path*"input/freMTPL2freq.arff"
    target_vector_path=main_folder_path*"input/freMTPL2sev.arff"
    @show "Dataset path: "*data_matrix_path
    df = ARFFFiles.load(DataFrame, data_matrix_path)
    df2 = ARFFFiles.load(DataFrame, target_vector_path)
    obj.B=df
    obj.C=df2
    nothing
end


#DEAD
function getting_levels_of_symbol(obj, my_symbol)
    a=obj.B[!,my_symbol].pool #getting the  Categorical Pool
    b=levels(a) # getting a Vector{String} with all categories
    return b
end

function find_indices_id_pol(obj)
    newdf=DataFrame()
    return intersect(obj.C[!, :IDpol],obj.B[!, :IDpol])
end

function getting_only_float_matrix(obj)
    float_df=obj.selB[!, [:VehPower, :VehAge, :DrivAge]]
    obj.X=Matrix(float_df)
    nothing
end

function filter_dataframe_for_X(obj, idx)
    b=[]
    for i in idx
        a=findall(obj.B[!, :IDpol].==i)
        b=vcat(b, a)
    end
    obj.selB=obj.B[b, :]
    nothing
end

function filter_dataframe_for_y(obj, idx)
    c=[]
    count=1
    for i in idx
        a=findall(obj.C[!, :IDpol].==i)
        c=vcat(c,  sum(obj.C[a, :ClaimAmount]))
        count+=1
    end
    sel_y=c
    div_y=obj.selB[!,:Exposure]
    obj.y=Float64.(sel_y./div_y)
    nothing
end

function visualizing_densities(obj)
    sel_names=[:Exposure, :VehPower, :VehAge, :DrivAge, :BonusMalus]
    plot(layout=(length(sel_names), 1))
    for (count,i) in enumerate(sel_names)
        density!(obj.B[:, i], lab=String(i), subplot=count)
    end
    display(plot!())
end
nothing
