using Test
using JLTB

@testset "kpath" begin

latt = [3.0 0.0; -1.5 1.5*√3]
path = [0.0 0.0; 1/3 1/3; 1/2 0; 0 0]
nk = 300

kvectors, kdists, _= kpath(latt, path, nk)

onsites = [1.0, 1.0]
hopping1 = Hopping(0.6, 2, 1, [0, 0])
hopping2 = Hopping(0.6, 2, 1, [1, 1])
hopping3 = Hopping(0.6, 2, 1, [1, 0])
hoppings = [hopping1, hopping2, hopping3]
orbitals = [0.0 0.0; 2//3 1//3]

bands, kdists = eigenspectrum(onsites, hoppings, orbitals, kvectors, kdists)

using Plots
plot(kdists, bands[1,:])
plot!(kdists, bands[2,:])
end # testset
