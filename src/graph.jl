module graph

# struct Site{T<:Vector{Float64}}
#     dim::Int64
#     position::T
#     periodic::T
#     cartesian::Bool
#     function Site{T}(position::T, periodic::T, cartesian::Bool) where T<:Vector{Float64}
#         dim = length(position)
#         @assert dim == length(periodic)
#         new(dim, position, periodic, cartesian)
#     end
# end
#
# Site(position::T, periodic::T, cartesian::Bool) where T<:Vector{Float64} = Site{T}(position, periodic, cartesian)
# Site(position, periodic, cartesian::Bool) = Site(convert(Vector{Float64}, position), convert(Vector{Float64}, periodic), cartesian)
# Site(position::T, periodic::T) where T<:Vector{Float64} = Site{T}(position, periodic, false)
# Site(position, periodic) = Site(convert(Vector{Float64}, position), convert(Vector{Float64}, periodic), false)
#
# function toCartesian(s::Site, lattice::Matrix{Float64})
#     position = s.position + s.periodic
#     carPos = lattice * position
#     return Site(carPos, s.periodic, true)
# end
#
# struct LinkGraph
#     link::Dict{Site, Vector{Site}}
#     function LinkGraph(l::T) where T<:Dict{Site, Vector{Site}}
#         new(l)
#     end
# end

mutable struct Graph
    lattice::Matrix{Float64}
    orbTable::Dict{Int64, Vector{Float64}}
    links::Dict{Site, Vector{Site}}
end

struct Site
    idx::Int64
    periodic::Vector{Int64}
end

# Graph(lattice::Matrix{Float64}, lg::LinkGraph) = Graph(lattice, lg.link)

function Hop(g::Graph, fn::Function)
    Hoppings = Vector{Hopping}(undef, 0)
    for k, vs in g.link
        for s in vs
            indI = k.idx
            indJ = s.idx
            amp = fn(g, k, s)
            periodic = s.periodic
            push!(Hoppings, Hopping(amp, indI, indJ, periodic))
        end
    end
    return Hoppings
end

end # module
