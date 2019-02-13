module JLTB

mutable struct Model
    lattice::Matrix{Float64}
    orbitals::Matrix{Float64}
    onsites::Vector{Float64}
    hoppings::Vector{Hopping}
    function Model(lattice::T, orbitals::T, onsites::Vector{Float64}) where T<:Matrix{Float64}

    end
end

function kpath(rlatt::Matrix{Float64}, path::Matrix{Float64}, nk::Int64=300)
    nnodes = size(path, 1)
    dim = size(path, 2)
    kvectors = zeros(nk, dim)
    kdists = zeros(nk)
    knodes = zeros(nnodes)
    
    return kvectors, kdists, knodes
end

function eigenspectrum(m::Model, kvectors)
    return evals
end

end
