module hamiltonian

export Hamiltonian, eigens, Hopping

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

eigens(ham::Hamiltonian)= eigvals(ham.data)

function eigens(k, onsites, hoppings, orbitals)
    ham = Hamiltonian(k, onsites, hoppings, orbitals)
    return eigens(ham)
end

struct Hopping
    amp::Float64
    indI::Int64
    indJ::Int64
    shiftR::Vector{Int64}
    dim::Int64
    function Hopping(amp::Real, indI::Integer, indJ::Integer, shiftR::T) where T<:Vector{Int64}
        dim = length(shiftR)
        new(amp, indI, indJ, shiftR, dim)
    end
end

Hopping(amp, indI, indJ, shiftR) = Hopping(amp, indI, indJ, convert(Vector{Int64}, shiftR))


end # module
