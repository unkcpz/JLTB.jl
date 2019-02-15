module kpoint

export KPath, kinfo

using LinearAlgebra

struct KPath{T<:Matrix{Float64}}
    metric::T
    path::T
    nnodes::Int64
    dim::Int64
    function KPath{T}(metric::T, path::T) where T<:Matrix{Float64}
        nnodes, dim = size(path)
        if dim > 3
            error("Dimension of path = $dim, expect to 1, 2 or 3.")
        end
        if nnodes < 2
            error("path contain too less nodes")
        end
        new(metric, path, nnodes, dim)
    end
end

KPath(latt::T, path::T) where T<:Matrix{Float64} = KPath{T}(inv(latt*latt'), path)
KPath(latt, path) = KPath(convert(Matrix{Float64}, latt), convert(Matrix{Float64}, path))

function kinfo(metric::T, path::T, nk::Int64=300) where T<:Matrix{Float64}
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

kinfo(kpath::K, nk::Int64=300) where K<:KPath = kinfo(kpath.metric, kpath.path, nk)

end # module
