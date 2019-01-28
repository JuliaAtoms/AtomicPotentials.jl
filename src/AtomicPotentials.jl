module AtomicPotentials

abstract type AbstractPotential{T} end

# * Table of elements

const table_of_elements = [:H, :He, :Li, :Be, :B, :C, :N, :O, :F, :Ne,
                           :Na, :Mg, :Al, :Si, :P, :S, :Cl, :Ar, :K,
                           :Ca, :Sc, :Ti, :V, :Cr, :Mn, :Fe, :Co, :Ni,
                           :Cu, :Zn, :Ga, :Ge, :As, :Se, :Br, :Kr,
                           :Rb, :Sr, :Y, :Zr, :Nb, :Mo, :Tc, :Ru, :Rh,
                           :Pd, :Ag, :Cd, :In, :Sn, :Sb, :Te, :I, :Xe,
                           :Cs, :Ba, :La, :Ce, :Pr, :Nd, :Pm, :Sm,
                           :Eu, :Gd, :Tb, :Dy, :Ho, :Er, :Tm, :Yb,
                           :Lu, :Hf, :Ta, :W, :Re, :Os, :Ir, :Pt, :Au,
                           :Hg, :Tl, :Pb, :Bi, :Po, :At, :Rn, :Fr,
                           :Ra, :Ac, :Th, :Pa, :U, :Np, :Pu, :Am, :Cm,
                           :Bk, :Cf, :Es, :Fm, :Md, :No, :Lr, :Rf,
                           :Db, :Sg, :Bh, :Hs, :Mt]

function element_number(s::Symbol)
    i = findfirst(isequal(s), table_of_elements)
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

Base.show(io::IO, p::PointCharge{I}) where {I<:Integer} =
    write(io, "Z = $(p.Z) [$(table_of_elements[p.Z])]")

Base.show(io::IO, p::PointCharge) =
    write(io, "Z = $(p.Z)")

(p::PointCharge{T})(::O, r::U) where {T,O,U} = -p.Z/r

charge(p::PointCharge) = p.Z

export AbstractPotential, element_number, PointCharge, @pc_str, charge

end # module
