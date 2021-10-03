module LinearSpace

macro linearspace(T)

    F = :(Any)
    LC = Symbol(T, :(_LC))
    TI = Symbol(T, :(_TI))
    xp = quote
        struct $(LC)
            a::Vector{$F}
            v::Vector{$T}
        end

        import Base: convert, promote_rule, +, *
        #convert(::Type{$LC}, u::$T) = $LC(ones($F,1),[u])
        convert(::Type{$LC}, u::$T) = $LC($F[1],[u])
        promote_rule(::Type{$T}, ::Type{$LC}) = $LC
        Base.:+(x::Union{$LC,$T}, y::Union{$LC,$T}) = Base.:+(promote(x,y)...)
        Base.:+(x::$LC, y::$LC) = $LC([x.a; y.a], [x.v; y.v])
        Base.:*(a, x::$LC) = $LC(a*x.a, x.v)
        Base.:*(a, x::$T) = a*convert($LC,x)

        struct $TI
            lc::$LC
        end

        start(ti::$TI) = 1
        next(ti::$TI, st) = ((ti.lc.a[st],ti.lc.v[st]),st+1)
        done(ti::$TI,st) = (length(ti.lc.a) < st)
        Base.length(ti::$TI) = length(ti.lc.a)
        Base.iterate(ti::$TI, st=start(ti)) = done(ti, st) ? nothing : next(ti, st) 

        terms(lc::$LC) = ($TI)(lc)
        terms(x::$T) = ($TI)(convert($LC,x))

        lctype(lc::Type{$T}) = $LC
    end

    #println(xp)

    return esc(xp)
end

export @linearspace

end
