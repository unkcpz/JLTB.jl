names = [
    "test_operator.jl",
]

for name in names
    if startswith(name, "test_") && endswith(name, ".jl")
        println(name)
        include(name)
    end
end
