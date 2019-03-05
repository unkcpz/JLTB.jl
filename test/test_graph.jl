using Test
using JLTB
using LinearAlgebra

@testset "graph" begin

# test Site struct
# s0 = Site([1//2, 1//3], [-2, 0], false)
# s0Car = toCartesian(s0, [3.0 0.0; 6.0 12.0])
# @test s0Car.cartesian == true
# @test 1e-12 > norm(s0Car.position - [-4.5, -5.0])

# test LinkGraph struct
latt = [3.0 0.0; -1.5 1.5*√3]
s1 = Site(1, [0, 0])
s2 = Site(2, [0, 0])
s3 = Site(1, [1, 0])
s4 = Site(1, [1, 1])
orbTable = Dict{Int64, Vector{Float64}}(1 => [0.0, 0.0], 2=> [2/3, 1/3])
function fn(g, sx, sy)
    if distance(sx_car, sy_car) > 2
        return 0.6
    end
    return 0.0
end

hops = Hop(g, fn)
@test size(hops) == (3, 1)
for h in hops
    @test h.amp == 0.6
end

end # testset
