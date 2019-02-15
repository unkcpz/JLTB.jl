module kpath

using LinearAlgebra
using ..hamiltonian

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
            kvectors[j, :] .= path[i,:] + μ*(path[i+1,:]-path[i,:])
        end
    end

    return kvectors, kdists, knodes
end

function eigenspectrum(onsites, hoppings, orbitals, kvectors, kdists, nk, dim)
    no = size(orbitals, 1)

    k = zeros(Float64, dim)
    eigenvals = zeros(Float64, nk, no)
    for r in 1:size(kvectors, 1)
        k .= kvectors[r, :]
        eigenvals[r, :] .= eigens(k, onsites, hoppings, orbitals)
    end
    return eigenvals', kdists
end

function eigenspectrum(onsites, hoppings, orbitals, kvectors, kdists)
    nk = length(kdists)
    dim = size(kvectors, 2)

    eigenspectrum(onsites, hoppings, orbitals, kvectors, kdists, nk, dim)
end
