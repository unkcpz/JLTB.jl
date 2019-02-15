using Test
using JLTB

@testset "kpath" begin

latt = [3.0 0.0; -1.5 1.5*√3]
path = [0.0 0.0; 1/3 1/3; 1/2 0; 0 0]
nk = 300

# test KPath creation
@test_throws ErrorException KPath(latt, [0.0 0.5 0.5 0.5; 0.0 0.0 0.0 0.0])
@test_throws ErrorException KPath(latt, [0.0 0.0 0.0 0.0])

kpath = KPath(latt, path)
@test 1e-12 > norm(kpath.metric - inv(latt*latt'))
@test kpath.nnodes == 4
@test kpath.dim == 2

kvectors, kdists, knodes = kinfo(kpath, nk)
@test nk == size(kvectors, 1) == length(kdists)
@test length(knodes) == 4

end # testset
