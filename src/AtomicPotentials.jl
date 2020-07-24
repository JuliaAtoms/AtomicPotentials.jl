module AtomicPotentials
using AtomicLevels

abstract type AbstractPotential{T} end

# * Table of elements

include("table_of_elements.jl")

function element_number(s::Symbol)
    i = findfirst(e -> e[1] == s, table_of_elements)
    i === nothing &&
        throw(ArgumentError("Invalid element $s"))
    i
end

# * Point charge nucleus

struct PointCharge{T} <: AbstractPotential{T}
    Z::T
end

PointCharge(s::Symbol) = PointCharge(element_number(s))

macro pc_str(s)
    :(PointCharge(Symbol($s)))
end

function Base.show(io::IO, p::PointCharge{I}) where {I<:Integer}
    element = table_of_elements[p.Z]
    write(io, "Z = $(p.Z) [$(element[2][1])]")
end

Base.show(io::IO, p::PointCharge) =
    write(io, "Z = $(p.Z)")

(p::PointCharge{T})(::O, r::U) where {T,O,U} = -p.Z/r
(p::PointCharge{T})(::O, r::VU) where {T,O,U,VU<:AbstractVector{U}} = -p.Z./r

charge(p::PointCharge) = p.Z

ground_state(p::PointCharge{<:Integer}) =
    table_of_elements[p.Z][2][2]

ground_state(p::PointCharge) =
    throw(ArgumentError("Ground state configuration for nuclear charge of Z = $(p.Z) unknown"))

islocal(::PointCharge) = true

export AbstractPotential, element_number, PointCharge, @pc_str, charge, ground_state, islocal

end # module
