using LinearSpace
using Base.Test

struct MT i::Int end

@linearspace MT Float64
x, y = MT(2), MT(3)

z = x + 3y

@test z.a == [1, 3]
@test z.v == [x, y]

z = 1x
@test z.a == [1]
@test z.v == [x]
