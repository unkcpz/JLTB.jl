using ..operator

mutable struct Hamiltonian <: SquareOperator
end

function Hamiltonian(onsites, hoppings, orbitals)
    data = diagm(0 => onsites)
    op = DenseOperator(data)
    return op
end
