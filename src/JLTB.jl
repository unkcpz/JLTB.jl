module JLTB

mutable struct Model
    lattice::Matrix{Float64}
    orbitals::Matrix{Float64}
    onsites::Vector{Float64}
    hoppings::Vector{Hopping}
    function Model(lattice::T, orbitals::T, onsites::Vector{Float64}) where T<:Matrix{Float64}

    end
end

function kpath(latt::Matrix{Float64}, path::Matrix{Float64}, nk::Int64=300)
    dim = size(path, 2)

    # metric tensor of k space
    metric = inv(latt⋅latt')

    nnodes = size(path, 1)
    knodes = zeros(nnodes)
    for i = 1:nnodes-1
        dk = path[i+1,:] - path[i,:]
        dklen = √(dk⋅metric⋅dk)
        knodes[i+1] = knodes[i] + dklen

    nodeIdx = zeros(nnodes)
    for i = 1:nnodes-1
        idx = round(Int,nk*knodes[i]/knodes[end])
        nodeIdx[i] = idx
    nodeIdx[end] = nk

    kvectors = zeros(nk, dim)
    kdists = zeros(nk)
    for i = eachindex(knodes)
        if i==1
            continue
        end
        idxInit = nodeIdx[i-1]
        idxFinal = nodeIdx[i]
        knodeInit = knodes[i-1]
        knodeFinal = knodes[i]
        pathInit = path[i-1]
        pathFinal = path[i]
        for j = idxInit:idxFinal
            kdists[j] = (j-idxInit)/(idxFinal-idxInit)    

    return kvectors, kdists, knodes
end

function eigenspectrum(m::Model, kvectors)
    return evals
end

end
