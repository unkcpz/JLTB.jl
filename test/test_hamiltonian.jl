using Test
using JLTB

@testset "hamiltonian" begin

# Test creation
@test_throws AssertionError Hamiltonian([1 0; 0 1; 1 1])
@test_throws AssertionError Hamiltonian([1 0; 2 1])
op = Hamiltonian([3+0im 2+1im; 2-1im 1+0im])
op1 = Hamiltonian([1 0; 0 1])
op2 = Hamiltonian([1+0im 0+0im; 0+0im 1+0im])
@test op1 == op2

onsites = [1.0, 1.0]
hopping1 = Hopping(0.6, 2, 1, [0, 0])
hopping2 = Hopping(0.6, 2, 1, [1, 1])
hopping3 = Hopping(0.6, 2, 1, [1, 0])
hoppings = [hopping1, hopping2, hopping3]
orbitals = [0.0 0.0; 2//3 1//3]
op1 = Hamiltonian([0, 0], onsites, hoppings, orbitals)
op2 = Hamiltonian([1//3, 1//3], onsites, hoppings, orbitals)

@test 1e-12 > norm(op1.data - [1.0+0im 1.8+0im; 1.8+0im 1.0+0im])
@test 1e-12 > norm(op2.data - [1.0+0im 0+0im; 0+0im 1.0+0im])

# hopping creation
hopping4 = Hopping(6.0, 1, 0, [1, 1])
hopping5 = Hopping(6, 1, 0, [0, 0])

end # testset
