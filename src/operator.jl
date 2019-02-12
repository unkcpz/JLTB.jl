module Operator

export SquareOperator, eigenspectrum

using LinearAlgebra

mutable struct SquareOperator{T<:Matrix{ComplexF64}}
    data::Matrix{ComplexF64}
    function SquareOperator{T}(data::T) where {T<:Matrix{ComplexF64}}
        if !(size(data, 1) == size(data, 2))
            throw(DimensionMismatch())
        end
        new(data)
    end
end

SquareOperator(data::T) where {T<:Matrix{ComplexF64}} = SquareOperator{T}(data)
SquareOperator(data) = SquareOperator(convert(Matrix{ComplexF64}, data))

function eigenspectrum(op::SquareOperator)
    # 此处应确保Hermi，保证实数本征值
    # 此处还应该对spin=2的情况reshape矩阵
    # TODO：返回eigenvectors
    d = eigvals(op.data)
    return d
end

end # module
