module graph

struct Site{T<:Vector{Float64}}
    dim::Int64
    position::T
    periodic::T
    function Site{T}(position::T, periodic::T) where T<:Vector{Float64}
        dim = length(position)
        @assert dim == length(periodic)
        new(dim, position, periodic)
    end
end

Site(position::T, periodic::T) where T<:Vector{Float64} = Site{T}(position, periodic)
Site(position, periodic) = Site(convert(Vector{Float64}, position), convert(Vector{Float64}, periodic))
Site(position::Tuple{Vararg{T}}, periodic::Tuple{Vararg{T}}) where T<:Real = Site(collect(position), collect(periodic))

end # module
