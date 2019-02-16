using Test
using JLTB

@testset "bands" begin
onsites = [-1.0, 1.0]
hopping1 = Hopping(0.6, 2, 1, [0, 0])
hopping2 = Hopping(0.6, 2, 1, [1, 1])
hopping3 = Hopping(0.6, 2, 1, [1, 0])
hoppings = [hopping1, hopping2, hopping3]
orbitals = [0.0 0.0; 2//3 1//3]

latt = [3.0 0.0; -1.5 1.5*√3]
path = [0.0 0.0; 1/3 1/3; 1/2 0; 0 0]
kpath = KPath(latt, path)
kvectors, kdists, knodes = kinfo(kpath, 300)

# bands of graphene cross at K high-symmetry point
kdists, bands= eigenspectrum(onsites, hoppings, orbitals, kvectors, kdists)
idx = findfirst(kdists .== knodes[2])
@test bands[1, idx] ≈ bands[2, idx]

using Plots
plot(kdists, bands[1,:])
plot!(kdists, bands[2,:])
end # testset
