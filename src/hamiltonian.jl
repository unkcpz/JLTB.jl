module hamiltonian

export Hamiltonian

import Base: ==

using LinearAlgebra

mutable struct Hamiltonian
    data::Matrix{ComplexF64}
    function Hamiltonian(data::T) where T<:Matrix{ComplexF64}
        @assert ishermitian(data) "Matrix of Hamiltonian not hermitian"
        new(data)
    end
end

Hamiltonian(data) = Hamiltonian(convert(Matrix{ComplexF64}, data))

==(x::T, y::T) where T<:Hamiltonian = (x.data == y.data)

function Hamiltonian(k, onsites, hoppings, orbitals)
    data = diagm(0 => convert(Vector{ComplexF64}, onsites))
    dim = size(orbitals, 1)
    rv = zeros(Float64, dim)
    for h in hoppings
        i, j = h.indI, h.indJ
        R = h.shiftR
        amp = h.amp

        # vector from i to j+R
        rv .= orbitals[j,:] + R - orbitals[i,:]
        amp = amp*exp(2π*1im*(rv⋅k))
        data[i, j] += amp
        data[j, i] += amp'
    end
    Hamiltonian(data)
end

mutable struct Hopping
    amp::Float64
    indI::Int64
    indJ::Int64
    shiftR::Vector{Int64}
    dim::Int64
    function Hopping(amp::Float64, indI::Int64, indJ::Int64, shiftR::T) where T<:Vector{Int64}
        dim = length(shiftR)
        new(amp, indI, indJ, shiftR, dim)
    end
end

function Hopping(amp::Real,
                 indI::Integer,
                 indJ::Integer,
                 shiftR::Vector{T}) where T<:Integer
    Hopping(convert(Float64, amp),
            convert(Int64, indI),
            convert(Int64, indJ),
            convert(Vector{Int64}, shiftR))
end

end # module
