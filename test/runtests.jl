using LinearSpace
using Base.Test

struct MT i::Int end
#scalartype(mt::MT) = Float64

@linearspace MT #Float64
x, y = MT(2), MT(3)

z = x + 3y

@test z.a == [1, 3]
@test z.v == [x, y]

z = 1x
@test z.a == [1]
@test z.v == [x]

@test lctype(MT) == MT_LC

ts = MT[]
as = Float64[]
z = x + 3y
for (a,t) in terms(z)
    @show a, t
    push!(as,a)
    push!(ts,t)
end

@test as == [1.0, 3.0]
@test ts == [x,y]


ts = MT[]
as = Float64[]
z = x
for (a,t) in terms(z)
    @show a, t
    push!(as,a)
    push!(ts,t)
end

@test as == [1.0]
@test ts == [x]
