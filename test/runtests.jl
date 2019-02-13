names = [
    "test_hamiltonian.jl",
]

for name in names
    if startswith(name, "test_") && endswith(name, ".jl")
        println(name)
        include(name)
    end
end
