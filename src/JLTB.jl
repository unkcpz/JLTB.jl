module JLTB

# mutable struct Model
#     lattice::Matrix{Float64}
#     orbitals::Matrix{Float64}
#     onsites::Vector{Float64}
#     hoppings::Vector{Hopping}
#     function Model(lattice::T, orbitals::T, onsites::Vector{Float64}) where T<:Matrix{Float64}
#
#     end
# end

function kpath(latt::Matrix{Float64}, path::Matrix{Float64}, nk::Int64=300)
    # metric tensor of k space
    metric = inv(latt*latt')

    nnodes = size(path, 1)
    knodes = zeros(nnodes)
    for i = 1:nnodes-1
        dk = path[i+1,:] - path[i,:]
        dklen = √(dk'*metric*dk)
        knodes[i+1] = knodes[i] + dklen
    end

    nodeIdx = zeros(Int, nnodes)
    for i = 1:nnodes-1
        idx = round(Int,nk*knodes[i]/knodes[end]) + 1
        nodeIdx[i] = idx
    end
    nodeIdx[end] = nk

    dim = size(path, 2)
    kvectors = zeros(nk, dim)
    kdists = zeros(nk)
    for i = 1:nnodes-1
        for j = nodeIdx[i]:nodeIdx[i+1]
            μ = (j-nodeIdx[i])/(nodeIdx[i+1]-nodeIdx[i])
            kdists[j] = knodes[i] + μ*(knodes[i+1]-knodes[i])
            kvectors[j, :] .= path[i] + μ*(path[i+1]-path[i])
        end
    end

    return kvectors, kdists, knodes
end

function eigenspectrum(kvectors, onsites, hoppings, orbitals)
    return evals
end

end
