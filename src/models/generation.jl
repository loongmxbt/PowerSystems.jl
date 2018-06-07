abstract type
    Generator <: PowerSystemType
end

include("generation/renewable_generation.jl")
include("generation/thermal_generation.jl")
include("generation/hydro_generation.jl")
