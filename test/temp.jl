macro mm(x)
    y = Symbol(x,:(_suffix))
    quote
        struct $y
            x
            i::Int
        end
    end
end
