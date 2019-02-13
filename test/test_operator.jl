using Test
using JLTB

@testset "operator" begin

# Test creation
@test_throws DimensionMismatch SquareOperator([1 0; 0 1; 1 1])
op1 = SquareOperator([1 0; 0 1])
op2 = SquareOperator([1+0im 0+0im; 0+0im 1+0im])
@test op1 == op2

# Test eigen
op3 = SquareOperator([1 0; 0 -1])
@test 1e-12 > norm(eigenspectrum(op3) - [-1.0, 1.0])

end # testset
