using Test
using JLTB

@testset "graph" begin

# test LinkGraph struct
linkInfo = Dict{Site, Vector{Site}}()
s1 = Site((2//3, 1//3), (0, 0))
s2 = Site((0, 0), (0, 0))
s3 = Site((0, 0.0), (1, 1))
s4 = Site((0.0, 0.0), (1, 0))
linkInfo[s1] = [s2, s3, s4]
lg = LinkGraph(linkInfo)


latt = [3.0 0.0; -1.5 1.5*√3]
g = Graph(latt, lg)

function fn(s0, s1)
    if distance(s0, s1) > 2
        return 0.6
    end
    return 0.0
end

hops = getHop(g, fn)
@test size(hops) == (3, 1)
for h in hops
    @test h.amp == 0.6
end

end # testset
