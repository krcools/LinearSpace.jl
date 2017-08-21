module LinearSpace

function lc_implementation(T::Type, F::Type{<:Number})

    LC = Symbol(T, :(_LC))
    xp = quote
        struct $(LC)
            a::Vector{$F}
            v::Vector{$T}
        end

        import Base: convert, promote_rule, +, *
        convert(::Type{$LC}, u::$T) = $LC(ones($F,1),[u])
        promote_rule(::Type{$T}, ::Type{$LC}) = $LC
        Base.:+(x::Union{$LC,$T}, y::Union{$LC,$T}) = Base.:+(promote(x,y)...)
        Base.:+(x::$LC, y::$LC) = $LC([x.a; y.a], [x.v; y.v])
        Base.:*(a, x::$LC) = $LC(a*x.a, x.v)
        Base.:*(a, x::$T) = a*convert($LC,x)
    end

    return xp
end

macro linearspace(T,F)
    :(eval(lc_implementation($(esc(T)),$(esc(F)))))
end

export @linearspace

end
