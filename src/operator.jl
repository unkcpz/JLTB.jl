using LinearAlgebra

mutable struct DenseOperator{T<:Matrix{ComplexF64}}
    data::Matrix{ComplexF64}
    function DenseOperator{T}(data::T) where {T<:Matrix{ComplexF64}}
        if !(size(data, 1) == size(data, 2))
            throw(DimensionMismatch())
        end
        new(data)
    end
end

DenseOperator(data::T) where {T<:Matrix{ComplexF64}} = DenseOperator{T}(data)
DenseOperator(data) = DenseOperator(convert(Matrix{ComplexF64}, data))

function eigenspectrum(op::DenseOperator)
    # 此处应确保Hermi，保证实数本征值
    # 此处还应该对spin=2的情况reshape矩阵
    # TODO：返回eigenvectors
    d = eigvals(op.data)
    return d
end

function Hamiltonian(onsites, hoppings, orbitals)
end
